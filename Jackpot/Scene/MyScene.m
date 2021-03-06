//
//  MyScene.m
//  Jackpot
//
//  Created by Le Cong on 11/28/14.
//  Copyright (c) 2014 Lê Công. All rights reserved.
//

#import "MyScene.h"
#import "ListNode.h"
#import "ObjectSprite.h"
#import "SKNode+Frame.h"
#import "Machine.h"

@implementation MyScene {

    ListNode *_listNode;
    ObjectSprite *sprite;
    Machine *machine;
    
    NSTimeInterval _lastUpdateTime;
    NSTimeInterval _deltaTime;
}

#pragma mark - Init

- (id)initWithSize:(CGSize)size {
    self = [super initWithSize:size];
    if (self) {
        [self initSceneSize:size];
    }
    return self;
}

- (void)initSceneSize:(CGSize)size {
    self.backgroundColor = [UIColor colorWithRed:0.3451 green:0.3373 blue:0.8392 alpha:1.0];
    
//    SKSpriteNode *bg = [SKSpriteNode spriteNodeWithImageNamed:@"bgMachine"];
//    bg.anchorPoint = CGPointMake(0, 0);
//    bg.position = [self newPoint:CGPointMake(102.5, 62)];
//    bg.size = [self newSize:CGSizeMake(366, 204.5)];
//    
//    [self addChild:bg];
    
    [self loadDataGame];
//    SKSpriteNode *bgCenter = [SKSpriteNode spriteNodeWithImageNamed:@"bgCenterMachine"];
//    bgCenter.position = CGPointMake(285.5, 170);
//    [self addChild:bgCenter];
}

- (void)loadDataGame {
    machine = [[Machine alloc] initWithImageNamed:@"bgMachine"];
    machine.position = [self newPoint:CGPointMake(102.5, 62)];
    machine.anchorPoint = CGPointMake(0, 0);
    machine.size = [self newSize:CGSizeMake(366, 204.5)];
    [self addChild:machine];
//    _listNode = [[ListNode alloc]initListNode];
//    [_listNode setPosition:CGPointMake(0, 0)];
//    [self addChild:_listNode];
    
    
//    sprite = [[ObjectSprite alloc] init];
//    [self addChild:sprite];
}

#pragma mark - ()

- (void)spin {
    [machine stepState];
}

#pragma mark - Update

- (void)update:(NSTimeInterval)currentTime {
    if(_lastUpdateTime)
    {
        _deltaTime = currentTime - _lastUpdateTime;
    }
    else
    {
        _deltaTime = 0;
    }
    _lastUpdateTime = currentTime;
    
//    [_listNode update:_deltaTime];
    
    [machine update:_deltaTime];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    for (UITouch *touch in touches)
    {
        CGPoint location  = [touch locationInNode:self];
        SKNode *node = [self nodeAtPoint:location];
        
        
        if ([node.name isEqualToString:@"node"] )
        {
            CGPoint previousLocation = [touch previousLocationInNode:self];
            float diff = location.y - previousLocation.y;
            CGPoint newPosition = CGPointMake(node.position.x, node.position.y + diff);
            node.position = newPosition;
            
            for (SKSpriteNode *spriteNode in self.children) {
                if ([spriteNode.name isEqualToString:@"node"]) {
                    CGPoint newPosition = CGPointMake(node.position.x, node.position.y + diff);
                    node.position = newPosition;
                }
            }
        }
    }
}

@end
