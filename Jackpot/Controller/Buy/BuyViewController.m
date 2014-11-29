//
//  BuyViewController.m
//  Jackpot
//
//  Created by Le Cong on 11/29/14.
//  Copyright (c) 2014 Lê Công. All rights reserved.
//

#import "BuyViewController.h"

@interface BuyViewController ()

@end

@implementation BuyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *imgMaxBet = [UIImage imageNamed:@"btnMaxBet"];
    UIButton *btnMaxBet = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnMaxBet setTitle:@"Dismis" forState:UIControlStateNormal];
    [btnMaxBet setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnMaxBet addTarget:self action:@selector(dismis:) forControlEvents:UIControlEventTouchUpInside];
//    [btnMaxBet setImage:imgMaxBet forState:UIControlStateNormal];
    btnMaxBet.frame = CGRectMake(0 , 0, imgMaxBet.size.width, imgMaxBet.size.height);
    [self.view addSubview:btnMaxBet];
}

- (IBAction)dismis:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
