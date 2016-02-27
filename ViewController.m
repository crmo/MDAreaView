//
//  ViewController.m
//  MDAreaView
//
//  Created by CR.MO on 15/10/11.
//  Copyright (c) 2016年 CR.MO. All rights reserved.
//

#import "ViewController.h"

#import "MDAreaSelectView.h"
#import "MDAreaView.h"

@interface ViewController()<MDAreaViewDelegate>

@end

@implementation ViewController
{
    MDAreaView *areaSelectView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Init MDAreaView with frame,background image,number of rows and columns.
    areaSelectView = [MDAreaView MDAreaViewWithFram:CGRectMake(20, 60, 300, 400) backgroundImage:[UIImage imageNamed:@"testPic"] row:20 column:20];
    areaSelectView.delegate = self;
    [self.view addSubview:areaSelectView];
}

- (IBAction)selectAllArea:(id)sender {
    [areaSelectView selectAllArea];
}

- (IBAction)cancelSelectAllArea:(id)sender {
    [areaSelectView cancelSelectAllArea];
}

#pragma mark - MDAreaView Delegate

-(void)MDAreaViewDelegate:(MDAreaView *)mdAreaView areaArray:(NSArray *)array {
    // Do something.
    NSLog(@"Select View:%@", array);
}

@end
