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

#define WIDTH_SCREEN [[UIScreen mainScreen] bounds].size.width
#define HEIGHT_SCREEN [[UIScreen mainScreen] bounds].size.height

#define xScale(x) x*WIDTH_SCREEN/568
#define yScale(y) y*HEIGHT_SCREEN/320

@implementation MyScene {

    ListNode *_listNode;
    ObjectSprite *sprite;
    
    NSTimeInterval _lastUpdateTime;
    NSTimeInterval _deltaTime;
}

#pragma mark - Init

- (CGRect)scaleFrame:(CGRect)frame {
    CGRect scaleFrame = CGRectMake(xScale(frame.origin.x),
                                   yScale(frame.origin.y),
                                   xScale(frame.size.width),
                                   yScale(frame.size.height));
    
    return scaleFrame;
}

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
    bg.position = CGPointMake(xScale(285.5), yScale(163.5));
    
    [self addChild:bg];
    [self loadDataGame];
//    SKSpriteNode *bgCenter = [SKSpriteNode spriteNodeWithImageNamed:@"bgCenterMachine"];
//    bgCenter.position = CGPointMake(285.5, 170);
//    [self addChild:bgCenter];
}

- (void)loadDataGame {
//    _listNode = [[ListNode alloc]initListNode];
//    [_listNode setPosition:CGPointMake(0, 0)];
//    [self addChild:_listNode];
    sprite = [[ObjectSprite alloc] init];
    [self addChild:sprite];
}

#pragma mark - ()

- (void)spin {
    [sprite stepState];
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
    
//    [_listNode update:_deltaTime];
    
    [sprite update:_deltaTime];
}

@end
