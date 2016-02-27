//
//  MDAreaView.h
//  test2
//
//  Created by CR.MO on 15/11/21.
//  Copyright © 2015年 CR.MO. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MDAreaView;

@protocol MDAreaViewDelegate <NSObject>

- (void)MDAreaViewDelegate:(MDAreaView *)mdAreaView areaArray:(NSArray *)array;

@end

@interface MDAreaView : UIView

/**
 *  Init 
 *
 *  @param frame  <#frame description#>
 *  @param image  <#image description#>
 *  @param row    <#row description#>
 *  @param column <#column description#>
 *
 *  @return <#return value description#>
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
