//
//  Machine.m
//  Jackpot
//
//  Created by Le Cong on 12/5/14.
//  Copyright (c) 2014 Lê Công. All rights reserved.
//

#import "Machine.h"
#import "ObjectSprite.h"
#import "SKNode+Frame.h"

@implementation Machine

- (id)initWithImageNamed:(NSString *)name {
    self = [super initWithImageNamed:name];
    if (self) {
        for (int i = 0; i < 5; i ++) {
            ObjectSprite *sprite = [[ObjectSprite alloc] init];
            sprite.anchorPoint = CGPointMake(0, 0);
            sprite.position = CGPointMake(72*i, 0);
            sprite.size = CGSizeMake(72, 65*5);
            sprite.index = i;
            [self addChild:sprite];
        }
    }
    
    return self;
}

- (void)stepState {
    for (ObjectSprite *sprite in self.children) {
        [sprite stepState];
    }
}
    
- (void)update:(NSTimeInterval)deltaTime {
    for (ObjectSprite *sprite in self.children) {
        [sprite update:deltaTime];
    }
}
@end
