//
//  MDAreaView.h
//  MDAreaView
//
//  Created by CR.MO on 15/11/21.
//  Copyright © 2016年 CR.MO. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MDAreaView;

@protocol MDAreaViewDelegate <NSObject>

/**
 *  When you change the select view,this function will be called.
 *
 *  @param mdAreaView The MDAreaView you changed.
 *  @param array      This is a Double Dimensional Array(the index are row number and column number) 
                      that storage the area`s state,selected(1) or not selected(0).
 */
- (void)MDAreaViewDelegate:(MDAreaView *)mdAreaView areaArray:(NSArray *)array;

@end

@interface MDAreaView : UIView

@property (nonatomic, weak) id<MDAreaViewDelegate> delegate;

/**
 *  Init MDAreaView
 *
 *  @param frame  The select area view`s fram.
 *  @param image  The background image.
 *  @param row    The number of rows.
 *  @param column The number of coumns.
 *
 */
+ (instancetype)MDAreaViewWithFram:(CGRect)frame backgroundImage:(UIImage *)image row:(NSInteger)row column:(NSInteger)column;

/**
 *  Select all.
 */
- (void)selectAllArea;

/**
 *  Cancel select all.
 */
- (void)cancelSelectAllArea;

@end
