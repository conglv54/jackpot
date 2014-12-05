//
//  Machine.h
//  Jackpot
//
//  Created by Le Cong on 12/5/14.
//  Copyright (c) 2014 Lê Công. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Machine : SKSpriteNode

- (void)stepState;

- (void)update:(NSTimeInterval)deltaTime;

@end
