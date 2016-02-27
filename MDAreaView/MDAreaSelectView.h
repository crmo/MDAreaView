//
//  mdAreaSelectView.h
//  MDAreaView
//
//  Created by CR.MO on 15/11/21.
//  Copyright © 2016年 CR.MO. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MDAreaSelectView;

@protocol MDAreaSelectViewDelegate <NSObject>

@required
- (void)MDAreaSelectViewDelegate:(MDAreaSelectView *)mdAreaSelectView startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;
- (void)MDAreaSelectViewDelegate:(MDAreaSelectView *)mdAreaSelectView tapPoint:(CGPoint)point;

@end

@interface MDAreaSelectView : UIView

@property (nonatomic, weak) id<MDAreaSelectViewDelegate> delegate;

@end

