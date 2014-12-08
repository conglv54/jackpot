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
            sprite.name = @"sprite";
            sprite.anchorPoint = CGPointMake(0, 0);
            sprite.position = CGPointMake(72*i, 0);
            sprite.size = CGSizeMake(72, 65*5);
            sprite.index = i;
            [self addChild:sprite];
        }
    }
    
    return self;
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
            
            
            if (newPosition.y > 230) {
                newPosition.y = 230;
            }
            node.position = newPosition;
        }
    }
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
