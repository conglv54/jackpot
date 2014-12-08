//
//  ObjectSprite.m
//  Jackpot
//
//  Created by Le Cong on 12/1/14.
//  Copyright (c) 2014 Lê Công. All rights reserved.
//

#import "ObjectSprite.h"
#import "SKNode+Frame.h"

static const float OBJECT_VELOCITY = 500;
static const float MAX_VELOCITY = 1000;

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
            CGPoint position = CGPointMake(0, (65*i));
            [self initNodeWithPosition:position];
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

- (void)genareObjectAttPosition:(CGPoint)point {
    
    if ([self.children count] >= 5)
        return;
    
    [self initNodeWithPosition:point];
}

- (SKTexture *)genareTextureRandom {
    
    int number = arc4random() % 4;
//    number = 0;
    
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
    note.position = [self newPoint:position];
    note.anchorPoint = CGPointMake(0, 0);
    note.name = @"node";
    note.size = [self newSize:CGSizeMake(72, 65)];
    
    [self addChild:note];
}

- (void)createNode {
    SKTexture *texture = [self genareTextureWithNumber:spriteIndex];
    
    SKSpriteNode *note = [[SKSpriteNode alloc] initWithTexture:texture];
    note.position = [self newPoint:spritePosition];
    note.anchorPoint = CGPointMake(0, 0);
    note.name = @"result";
    note.size = [self newSize:CGSizeMake(72, 65)];
    
    [self addChild:note];
}

#pragma mark - State

- (void)stepState {
    switch (currentState) {
        case State_Idle:
            [self switchStartState];
//            [self performSelector:@selector(switchStartState) withObject:nil afterDelay:self.index *0.25];
            break;
        case State_Start:
//            [self switchStopState];
            [self performSelector:@selector(switchStopState) withObject:nil afterDelay:self.index *0.125];
            break;
        case State_Stop:
            currentState = State_Idle;
            break;
            
        default:
            break;
    }
}

- (void)switchStopState {
    currentState = State_Stop;
}

- (void)switchStartState {
    
    currentState = State_Start;
}

#pragma mark - Update 

- (void)update:(NSTimeInterval)deltaTime {
    if (currentState != State_Idle) {
        [self move:deltaTime];
    }
}

- (void)move:(NSTimeInterval)dt {
    
    switch (currentState) {
        case State_Idle:
            break;
        case State_Start:
        
            velocityY.y = velocityY.y - OBJECT_VELOCITY*dt;
            
            if (velocityY.y < - MAX_VELOCITY) {
                velocityY.y = - MAX_VELOCITY;
            }
            
            distance += dt;
            
            break;
        case State_Stop:
            
//            if (!isGenResult) {
                velocityY.y = velocityY.y + OBJECT_VELOCITY*dt;
//            } else {
//                velocityY.y = velocityY.y + (stopV*dt);
//            }
            
            if (isGenResult) {
                for (int i = 0; i < self.children.count; i ++) {
                    SKSpriteNode *node = self.children [i];
                    if ([node.name isEqualToString:@"result"]) {
                        if (node.position.y <= 70) {
                            
                            [node setPosition:CGPointMake(0, 70)];
                            
                            velocityY.y = 0;
                            currentState = State_Idle;
                            stopTime = 0;
                            startTime = 0;
                            current = 0;
                            isGenResult = FALSE;
                            
                            return;
                        }
                        break;
                    }
                }
            }
            
            
            if (velocityY.y > 0) {
                velocityY.y = 0;
                currentState = State_Idle;
                stopTime = 0;
                startTime = 0;
                current = 0;
                isGenResult = FALSE;
            }
//            } else {
//                NSLog(@"%f", velocityY.y);
//            }
            
            break;
        default:
            break;
    }
    
    CGPoint amtToMove = CGPointMultiplyScalar(velocityY, dt);
    
    for (int i = 0; i < self.children.count; i ++) {
        SKSpriteNode *node = self.children [i];
        node.position = CGPointAdd(node.position, amtToMove);
    }
    
    SKSpriteNode *node = self.children[0];
    if (node.position.y < - node.size.height)
    {
        [node removeFromParent];
        
        SKSpriteNode *maxNode = self.children[self.children.count -1];
        
        if (currentState == State_Stop) {
            NSLog(@"Slot %d: %f", self.index,  velocityY.y);
            
            if (velocityY.y > - 510) {
                if (!isGenResult) {
                    spritePosition = CGPointMake(0, maxNode.position.y + maxNode.size.height);
                    spriteIndex = arc4random() %4;
                    [self createNode];
                    isGenResult = TRUE;
                } else {
                    [self genareObjectAttPosition:CGPointMake(0, maxNode.position.y + maxNode.size.height)];
                }
            }else {
                [self genareObjectAttPosition:CGPointMake(0, maxNode.position.y + maxNode.size.height)];
            }

        } else {
            [self genareObjectAttPosition:CGPointMake(0, maxNode.position.y + maxNode.size.height)];
        }
    }
    
    
    
}


@end
