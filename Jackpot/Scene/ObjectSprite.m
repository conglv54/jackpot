//
//  ObjectSprite.m
//  Jackpot
//
//  Created by Le Cong on 12/1/14.
//  Copyright (c) 2014 Lê Công. All rights reserved.
//

#import "ObjectSprite.h"

static const float OBJECT_VELOCITY = 100;
static const float MAX_VELOCITY = 500;

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
            CGPoint position = CGPointMake(145, 100 + (43*i));
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
    
//    int number = arc4random() % 4;
    int number = 0;
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
    note.position = position;
    note.name = @"node";
    
    [self addChild:note];
}

#pragma mark - State

- (void)stepState {
    switch (currentState) {
        case State_Idle:
            currentState = State_Start;
            break;
        case State_Start:
            currentState = State_Stop;
            break;
        case State_Stop:
            currentState = State_Idle;
            break;
            
        default:
            break;
    }
}

#pragma mark - Update 

- (void)update:(NSTimeInterval)deltaTime {
    if (currentState != State_Idle) {
        [self move:deltaTime];
    }
}

- (void)move:(NSTimeInterval)dt {
    
    [self enumerateChildNodesWithName:@"node" usingBlock: ^(SKNode *node, BOOL *stop)
     {

        CGPoint amtToMove = CGPointMultiplyScalar(velocityY, dt);
         
        switch (currentState) {
            case State_Idle:
                break;
            case State_Start:
                
                velocityY.y = velocityY.y - 100*dt;
                
                if (velocityY.y < - MAX_VELOCITY) {
                    velocityY.y = - MAX_VELOCITY;
                }
                break;
            case State_Stop:
                
                velocityY.y = velocityY.y + 100*dt;

                if (velocityY.y > 0) {
                    velocityY.y = 0;
                    currentState = State_Idle;
                } else {
                    NSLog(@"%f", velocityY.y);
                }
                
                break;
            default:
            break;
        }
         
         node.position = CGPointAdd(node.position, amtToMove);
         
         if (node.position.y < 57)
         {
            
            [node removeFromParent];
             
             SKSpriteNode *node = self.children[3];
             
            [self genareObjectAttPosition:CGPointMake(node.position.x, node.position.y+ node.size.height)];
         }
     }];
    
}


@end
