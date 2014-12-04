//
//  ObjectSprite.h
//  Jackpot
//
//  Created by Le Cong on 12/1/14.
//  Copyright (c) 2014 Lê Công. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef enum : NSUInteger {
    State_Idle,
    State_Start,
    State_Stop,
} MachineState;

@interface ObjectSprite : SKNode {

@private
    
    MachineState currentState;
    CGPoint velocityY;
    int current;
    
}



- (void)stepState;
- (void)update:(NSTimeInterval)deltaTime;

@end
