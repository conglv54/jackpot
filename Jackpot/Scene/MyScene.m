//
//  MyScene.m
//  Jackpot
//
//  Created by Le Cong on 11/28/14.
//  Copyright (c) 2014 Lê Công. All rights reserved.
//

#import "MyScene.h"
#import "ListNode.h"

@implementation MyScene {
    ListNode *_listNode;
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
    self.backgroundColor = [UIColor blackColor];
    SKSpriteNode *bg = [SKSpriteNode spriteNodeWithImageNamed:@"bgMachine"];
    bg.position = CGPointMake(285.5, 163.5);
    [self addChild:bg];
    [self loadDataGame];
//    SKSpriteNode *bgCenter = [SKSpriteNode spriteNodeWithImageNamed:@"bgCenterMachine"];
//    bgCenter.position = CGPointMake(285.5, 170);
//    [self addChild:bgCenter];
}

- (void)loadDataGame {
    _listNode = [[ListNode alloc]initListNode];
    [_listNode setPosition:CGPointMake(0, 0)];
    [self addChild:_listNode];
}

#pragma mark - ()

- (void)start {
    
}

- (void)stop {
    
}

#pragma mark - Update

- (void)update:(NSTimeInterval)currentTime {
    if (_lastUpdateTime)
    {
        _deltaTime = currentTime - _lastUpdateTime;
    }
    else
    {
        _deltaTime = 0;
    }
    _lastUpdateTime = currentTime;
    
    [_listNode update:_deltaTime];
}

@end
