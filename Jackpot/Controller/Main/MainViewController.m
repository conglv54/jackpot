//
//  MainViewController.m
//  Jackpot
//
//  Created by Le Cong on 11/28/14.
//  Copyright (c) 2014 Lê Công. All rights reserved.
//

#import "MainViewController.h"
#import "BuyViewController.h"
#import "MyScene.h"
#import "UIView+Frame.h"

@interface MainViewController ()

@property (nonatomic, strong) MyScene *scene;
@end

@implementation MainViewController

#pragma mark - View Life Cyle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *imgBg = [UIImage imageNamed:@"bg"];
    UIImageView *imvBg = [[UIImageView alloc]initWithImage:imgBg];
    [imvBg setNewFrame:CGRectMake(0, 0, 568, 320)];
    [self.view addSubview:imvBg];
    
    UIImage *imgLeft = [UIImage imageNamed:@"bgLeft"];
    UIImageView *imvLeft = [[UIImageView alloc] initWithImage:imgLeft];
    [imvLeft setNewFrame:CGRectMake(0, 45, imgLeft.size.width, imgLeft.size.height)];
    [self.view addSubview:imvLeft];
    
    UIImage *imgHeader = [UIImage imageNamed:@"bgHeader"];
    UIImageView *imvHeader = [[UIImageView alloc]initWithImage:imgHeader];
    imvHeader.frame = CGRectMake(0, 0, imgHeader.size.width, imgHeader.size.height);
    [self.view addSubview:imvHeader];
    
    UIImage *imgLevel = [UIImage imageNamed:@"bgLevel"];
    UIImageView *imvLevel = [[UIImageView alloc]initWithImage:imgLevel];
    [imvLevel setNewFrame:CGRectMake(101, 15, imgLevel.size.width, imgLevel.size.height)];
    [self.view addSubview:imvLevel];
    
    UIImage *imgMoney = [UIImage imageNamed:@"bgMoney"];
    UIImageView *imvMoney = [[UIImageView alloc]initWithImage:imgMoney];
    [imvMoney setNewFrame:CGRectMake(242, 20, imgMoney.size.width, imgMoney.size.height)];
    [self.view addSubview:imvMoney];
    
    UIImage *imgPayout = [UIImage imageNamed:@"btnPayout"];
    UIButton *btnPayout = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnPayout setImage:imgPayout forState:UIControlStateNormal];
    [btnPayout setNewFrame:CGRectMake(388, 23, imgPayout.size.width, imgPayout.size.height)];
    [self.view addSubview:btnPayout];
    
    UIImage *imgBuy = [UIImage imageNamed:@"btnBuy"];
    UIButton *btnBuy = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnBuy setImage:imgBuy forState:UIControlStateNormal];
    [btnBuy setNewFrame:CGRectMake(484, 137, imgBuy.size.width, imgBuy.size.height)];
    [btnBuy addTarget:self action:@selector(buy) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnBuy];
    
    UIImage *imgShop = [UIImage imageNamed:@"btnShop"];
    UIButton *btnShop = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnShop setImage:imgShop forState:UIControlStateNormal];
    [btnShop setNewFrame:CGRectMake(484, 190, imgShop.size.width, imgShop.size.height)];
    [self.view addSubview:btnShop];
    
    UIImage *imgRight = [UIImage imageNamed:@"bgRight"];
    UIImageView *imvRight = [[UIImageView alloc] initWithImage:imgRight];
    [imvRight setNewFrame:CGRectMake(475, 42, imgRight.size.width, imgRight.size.height)];
    [self.view addSubview:imvRight];
    
    UIImage *imgHistory = [UIImage imageNamed:@"btnHistory"];
    UIButton *btnHistory = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnHistory setImage:imgHistory forState:UIControlStateNormal];
    [btnHistory setNewFrame:CGRectMake(102, 263, imgHistory.size.width, imgHistory.size.height)];
    [self.view addSubview:btnHistory];
    
    UIImage *imgBet = [UIImage imageNamed:@"btnBet"];
    UIButton *btnBet = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnBet setImage:imgBet forState:UIControlStateNormal];
    [btnBet setNewFrame:CGRectMake(233, 289, imgBet.size.width, imgBet.size.height)];
    [self.view addSubview:btnBet];
    
    UIImage *imgMaxBet = [UIImage imageNamed:@"btnMaxBet"];
    UIButton *btnMaxBet = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnMaxBet setImage:imgMaxBet forState:UIControlStateNormal];
    [btnMaxBet setNewFrame:CGRectMake(290, 289, imgMaxBet.size.width, imgMaxBet.size.height)];
    [self.view addSubview:btnMaxBet];
    
    UIImage *imgSpin = [UIImage imageNamed:@"btnSpin"];
    UIButton *btnSpin = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnSpin setImage:imgSpin forState:UIControlStateNormal];
    [btnSpin addTarget:self action:@selector(spin) forControlEvents:UIControlEventTouchUpInside];
    [btnSpin setNewFrame:CGRectMake(397, 289, imgSpin.size.width, imgSpin.size.height)];
    [self.view addSubview:btnSpin];
    
    UIImage *imgBgBet = [UIImage imageNamed:@"bgBet"];
    UIImageView *imvBet = [[UIImageView alloc] initWithImage:imgBgBet];
    [imvBet setNewFrame:CGRectMake(232, 263, imgBgBet.size.width, imgBgBet.size.height)];
    [self.view addSubview:imvBet];
    
    UIImage *imgBgMaxBet = [UIImage imageNamed:@"bgMaxBet"];
    UIImageView *imvMaxBet = [[UIImageView alloc] initWithImage:imgBgMaxBet];
    [imvMaxBet setNewFrame:CGRectMake(289, 263, imgBgMaxBet.size.width, imgBgMaxBet.size.height)];
    [self.view addSubview:imvMaxBet];
    
    UIImage *imgBgWin = [UIImage imageNamed:@"bgWin"];
    UIImageView *imvWin = [[UIImageView alloc] initWithImage:imgBgWin];
    [imvWin setNewFrame:CGRectMake(396, 263, imgBgWin.size.width, imgBgWin.size.height)];
    [self.view addSubview:imvWin];
    
    [self initScene];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];

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

#pragma mark - Action

- (void)spin {
    [self.scene spin];
}

- (void)buy {
    BuyViewController* buyVC =[self.storyboard instantiateViewControllerWithIdentifier:@"BuyViewController"];
    [self presentViewController:buyVC animated:YES completion:nil];
}

@end
