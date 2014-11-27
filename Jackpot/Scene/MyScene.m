//
//  MyScene.m
//  Jackpot
//
//  Created by Le Cong on 11/28/14.
//  Copyright (c) 2014 Lê Công. All rights reserved.
//

#import "MyScene.h"

@implementation MyScene

#pragma mark - Init

- (id)initWithSize:(CGSize)size {
    self = [super initWithSize:size];
    if (self) {
        [self initSceneSize:size];
    }
    return self;
}

- (void)initSceneSize:(CGSize)size {
    self.backgroundColor = [UIColor yellowColor];
    [self loadDataGame];
}

- (void)loadDataGame {
    
}

#pragma mark - ()

- (void)start {
    
}

- (void)stop {
    
}

#pragma mark - Update



@end
