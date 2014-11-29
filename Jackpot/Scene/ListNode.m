//
//  ListNode.m
//  Jackpot
//
//  Created by Le Cong on 11/28/14.
//  Copyright (c) 2014 Lê Công. All rights reserved.
//

#import "ListNode.h"

static const float BG_VELOCITY = 100;
static inline CGPoint CGPointAdd(const CGPoint a, const CGPoint b)
{
    return CGPointMake(a.x + b.x, a.y + b.y);
}

static inline CGPoint CGPointMultiplyScalar(const CGPoint a, const CGFloat b)
{
    return CGPointMake(a.x * b, a.y * b);
}

@implementation ListNode

- (id)initListNode {
    self = [super init];
    if (self) {
        for (int i = 0 ; i < 5; i++) {
            for (int j = 0; j < 4; j++) {
                NSString *imageIamge = [NSString stringWithFormat:@"jackPot%d", j];
                SKSpriteNode *node = [SKSpriteNode spriteNodeWithImageNamed:imageIamge];
                node.position = CGPointMake(145+(70*i), 53*(j+1));
                node.name = @"node";
                [self addChild:node];
            }
            
        }
    }
    return self;
}

- (void)update:(NSTimeInterval)deltaTime {
    [self move:deltaTime];
}

- (void)move:(NSTimeInterval)dt {
    [self enumerateChildNodesWithName:@"node" usingBlock: ^(SKNode *node, BOOL *stop)
     {
         CGPoint bgVelocity = CGPointMake(0, -BG_VELOCITY);
         CGPoint amtToMove = CGPointMultiplyScalar(bgVelocity, dt);
         node.position = CGPointAdd(node.position, amtToMove);
         
         if (node.position.y <= 0)
         {
             CGPoint position = node.position;
             position.y = 320;
             node.position = position;
         }
     }];
}

@end
