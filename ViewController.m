//
//  ViewController.m
//  test2
//
//  Created by CR.MO on 15/10/11.
//  Copyright (c) 2015年 CR.MO. All rights reserved.
//

#import "ViewController.h"

#import "MDAreaSelectView.h"
#import "MDAreaView.h"

@implementation ViewController
{
    MDAreaView *areaSelectView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    areaSelectView = [MDAreaView MDAreaViewWithFram:CGRectMake(20, 60, 300, 400) backgroundImage:[UIImage imageNamed:@"testPic"] row:16 column:16];
//    areaSelectView.delegate = self;
    [self.view addSubview:areaSelectView];
}

- (IBAction)selectAllArea:(id)sender {
    [areaSelectView selectAllArea];
}

- (IBAction)cancelSelectAllArea:(id)sender {
    [areaSelectView cancelSelectAllArea];
}

@end
