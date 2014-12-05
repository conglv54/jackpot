//
//  ObjectSprite.m
//  Jackpot
//
//  Created by Le Cong on 12/1/14.
//  Copyright (c) 2014 Lê Công. All rights reserved.
//

#import "ObjectSprite.h"
#import "SKNode+Frame.h"

static const float OBJECT_VELOCITY = 500;
static const float MAX_VELOCITY = 1000;

static inline CGPoint CGPointAdd(const CGPoint a, const CGPoint b)
{
    return CGPointMake(a.x + b.x, a.y + b.y);
}

static inline CGPoint CGPointMultiplyScalar(const CGPoint a, const CGFloat b)
{
    return CGPointMake(a.x * b, a.y * b);
}

@implementation ObjectSprite

#pragma mark - Init

- (id)init {
    
    self = [super init];
    
    if (self) {
        
        currentState = State_Idle;
        velocityY = CGPointMake(0, -OBJECT_VELOCITY);
        
        for (int i = 0; i < 5; i++) {
            CGPoint position = CGPointMake(0, (65*i));
            [self initNodeWithPosition:position];
        }
    }
    
    return self;
}

- (void)genareObjectAttPosition:(CGPoint)point {
    
    if ([self.children count] >= 5)
        return;
    
    [self initNodeWithPosition:point];
}

- (SKTexture *)genareTextureRandom {
    
    int number = arc4random() % 4;
//    number = 0;
    
    SKTexture *texture = [self genareTextureWithNumber:number];
    return texture;
}

- (SKTexture *)genareTextureWithNumber:(int) number {
    
    NSString *imageName = [NSString stringWithFormat:@"jackPot%d", number];
    SKTexture *textTure = [SKTexture textureWithImageNamed:imageName];
    
    return textTure;
}

- (void)initNodeWithPosition:(CGPoint) position {
    
    SKTexture *texture = [self genareTextureRandom];
    
    SKSpriteNode *note = [[SKSpriteNode alloc] initWithTexture:texture];
    note.position = [self newPoint:position];
    note.anchorPoint = CGPointMake(0, 0);
    note.name = @"node";
    note.size = [self newSize:CGSizeMake(72, 65)];
    
    [self addChild:note];
}

#pragma mark - State

- (void)stepState {
    switch (currentState) {
        case State_Idle:
            [self performSelector:@selector(switchStartState) withObject:nil afterDelay:self.index *0.25];
            break;
        case State_Start:
            [self performSelector:@selector(switchStopState) withObject:nil afterDelay:self.index *0.25];
            break;
        case State_Stop:
            currentState = State_Idle;
            break;
            
        default:
            break;
    }
}

- (void)switchStopState {
    currentState = State_Stop;
}

- (void)switchStartState {
    currentState = State_Start;
}

#pragma mark - Update 

- (void)update:(NSTimeInterval)deltaTime {
    if (currentState != State_Idle) {
        [self move:deltaTime];
    }
}

- (void)move:(NSTimeInterval)dt {
    
    CGPoint amtToMove = CGPointMultiplyScalar(velocityY, dt);
    
    switch (currentState) {
        case State_Idle:
            break;
        case State_Start:
        
            velocityY.y = velocityY.y - OBJECT_VELOCITY*dt;
            
            if (velocityY.y < - MAX_VELOCITY) {
                velocityY.y = - MAX_VELOCITY;
            }
            break;
        case State_Stop:
            
            velocityY.y = velocityY.y + OBJECT_VELOCITY*dt;
            
            if (velocityY.y > -5) {
                
            }
            
            if (velocityY.y > 0) {
                velocityY.y = 0;
                currentState = State_Idle;
                stopTime = 0;
                startTime = 0;
            } else {
                NSLog(@"%f", velocityY.y);
            }
            
            break;
        default:
            break;
    }
    
    for (int i = 0; i < self.children.count; i ++) {
        SKSpriteNode *node = self.children [i];
        node.position = CGPointAdd(node.position, amtToMove);
    }
    
    SKSpriteNode *node = self.children[0];
    if (node.position.y < - node.size.height)
    {
        [node removeFromParent];
        SKSpriteNode *maxNode = self.children[self.children.count -1];
        [self genareObjectAttPosition:CGPointMake(0, maxNode.position.y + maxNode.size.height)];
    }
    
    
    
}


@end
