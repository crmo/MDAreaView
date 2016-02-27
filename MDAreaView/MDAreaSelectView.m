//
//  mdAreaSelectView.m
//  MDAreaView
//
//  Created by CR.MO on 15/11/21.
//  Copyright © 2016年 CR.MO. All rights reserved.
//

#import "mdAreaSelectView.h"

#define SELECT_RECTANGLE_COLOR [[UIColor redColor] CGColor]

@interface MDAreaSelectView ()

@end

@implementation MDAreaSelectView
{
    CGPoint startPoint;
    CGPoint endPoint;
    CGPoint currentPoint;
}

- (instancetype)init {
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    startPoint = CGPointZero;
    endPoint = CGPointZero;
    currentPoint = CGPointZero;
    
    UIPanGestureRecognizer *panGestureRecongnizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    UITapGestureRecognizer *tapGestureRecongnizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    [self addGestureRecognizer:panGestureRecongnizer];
    [self addGestureRecognizer:tapGestureRecongnizer];
    [self setBackgroundColor:[UIColor clearColor]];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(ctx, SELECT_RECTANGLE_COLOR);
    CGContextSetLineWidth(ctx, 1.0);
    CGPoint poins[] = {CGPointMake(startPoint.x, startPoint.y),CGPointMake(currentPoint.x, startPoint.y),CGPointMake(currentPoint.x, currentPoint.y),CGPointMake(startPoint.x, currentPoint.y)};
    CGContextAddLines(ctx,poins,4);
    CGContextClosePath(ctx);
    CGContextStrokePath(ctx);
}

#pragma mark -Gesture Handle
- (void)handlePanGesture:(UIGestureRecognizer *)gestureRecognizer {
    currentPoint = [gestureRecognizer locationInView:self];
    currentPoint.x = (currentPoint.x >= (self.bounds.size.width - 5) ? (self.bounds.size.width - 5) : currentPoint.x);
    currentPoint.y = (currentPoint.y >= (self.bounds.size.height - 5) ? (self.bounds.size.height - 5) : currentPoint.y);
    currentPoint.x = (currentPoint.x <= 5 ? 5 : currentPoint.x);
    currentPoint.y = (currentPoint.y <= 5 ? 5 : currentPoint.y);
    
    switch(gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            startPoint = currentPoint;
            endPoint = currentPoint;
            [self setNeedsDisplay];
            break;
        case UIGestureRecognizerStateChanged:
            [self setNeedsDisplay];
            break;
        case UIGestureRecognizerStateEnded:
            endPoint = currentPoint;
            currentPoint = startPoint;
            if (_delegate) {
                [_delegate MDAreaSelectViewDelegate:self startPoint:startPoint endPoint:endPoint];
            }
            [self setNeedsDisplay];
            break;
        default:
            NSLog(@"can not handle this gesture!!!");
            break;
    }
}

- (void)handleTapGesture:(UIGestureRecognizer *)gestureRecognizer {
    CGPoint tapPoint = [gestureRecognizer locationInView:self];
    if (_delegate) {
        [_delegate MDAreaSelectViewDelegate:self tapPoint:tapPoint];
    }
}

@end
