//
//  MainViewController.m
//  Jackpot
//
//  Created by Le Cong on 11/28/14.
//  Copyright (c) 2014 Lê Công. All rights reserved.
//

#import "MainViewController.h"
#import "MyScene.h"

@interface MainViewController ()

@property (nonatomic, strong) MyScene *scene;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self initScene];
}

#pragma mark - Init

- (void)initScene {
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    self.scene = [[MyScene alloc] initWithSize:skView.bounds.size];
    self.scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:self.scene];
}


@end
