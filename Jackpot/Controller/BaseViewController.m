//
//  BaseViewController.m
//  Jackpot
//
//  Created by Le Cong on 11/28/14.
//  Copyright (c) 2014 Lê Công. All rights reserved.
//

#import "BaseViewController.h"

#define WIDTH_SCREEN [[UIScreen mainScreen] bounds].size.width
#define HEIGHT_SCREEN [[UIScreen mainScreen] bounds].size.height

#define xScale(x) x*WIDTH_SCREEN/320
#define yScale(y) y*HEIGHT_SCREEN/568

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (CGRect)scaleFrame:(CGRect)frame {
    CGRect scaleFrame = CGRectMake(xScale(frame.origin.x),
                                   yScale(frame.origin.y),
                                   xScale(frame.size.width),
                                   yScale(frame.size.height));
    
    return scaleFrame;
}
@end
