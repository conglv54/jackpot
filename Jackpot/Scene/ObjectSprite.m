//
//  ObjectSprite.m
//  Jackpot
//
//  Created by Le Cong on 12/1/14.
//  Copyright (c) 2014 Lê Công. All rights reserved.
//

#import "ObjectSprite.h"

static const float BG_VELOCITY = 1000;
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
        
        self.currentState = State_Idle;
        
        for (int i = 0; i < 5; i++) {
            CGPoint position = CGPointMake(145, 100 + (65*i));
            [self initNodeWithPosition:position];
        }
    }
    
    return self;
}

- (void)genareObject {
    
    if ([self.children count] >= 5)
        return;
    
    [self initNodeWithPosition:CGPointMake(145, 100 + 53*5)];
}

- (SKTexture *)genareTexture {
    
    int number = arc4random() % 4;
    
    NSString *imageName = [NSString stringWithFormat:@"jackPot%d", number];
    SKTexture *textTure = [SKTexture textureWithImageNamed:imageName];
    
    return textTure;
}

- (void)initNodeWithPosition:(CGPoint) position {
    
    SKTexture *texture = [self genareTexture];
    
    SKSpriteNode *note = [[SKSpriteNode alloc] initWithTexture:texture];
    note.position = position;
    note.name = @"node";
    
    [self addChild:note];
}

#pragma mark - State

- (void)stepState {
    switch (self.currentState) {
        case State_Idle:
            self.currentState = State_Start;
            break;
        case State_Start:
            self.currentState = State_Stop;
            break;
        case State_Stop:
            self.currentState = State_Idle;
            break;
            
        default:
            break;
    }
}

#pragma mark - Update 

- (void)update:(NSTimeInterval)deltaTime {
    if (self.currentState != State_Idle) {
        [self move:deltaTime];
    }
}

- (void)move:(NSTimeInterval)dt {
    [self enumerateChildNodesWithName:@"node" usingBlock: ^(SKNode *node, BOOL *stop)
     {
         CGPoint bgVelocity = CGPointMake(0, -BG_VELOCITY);
         CGPoint amtToMove = CGPointMultiplyScalar(bgVelocity, dt);
         node.position = CGPointAdd(node.position, amtToMove);
         
         if (node.position.y < 53)
         {
             [node removeFromParent];
             node = nil;
         }
     }];
    
    [self genareObject];
}


@end
