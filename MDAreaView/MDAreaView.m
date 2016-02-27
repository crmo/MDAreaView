//
//  MDAreaView.m
//  MDAreaView
//
//  Created by CR.MO on 15/11/21.
//  Copyright © 2016年 CR.MO. All rights reserved.
//

#import "MDAreaView.h"
#import "MDAreaSelectView.h"
#import "MDAreaViewCell.h"

#define INTERITEM_SPACING   2
#define LINE_SPACING        1
#define AREA_SELECTED       YES
#define AREA_NO_SELECTED    NO

#define DEBUG_SWITCH        0

static NSString *MDAreaViewCellId = @"MDAreaViewCell";

@interface MDAreaView()<MDAreaSelectViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic) NSInteger row;
@property (nonatomic) NSInteger column;
@property (nonatomic, strong) UIImage *backgroundImage;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) MDAreaSelectView *areaSelectView;

@property (nonatomic, strong) NSMutableArray *areas;

@end

@implementation MDAreaView
{
    CGFloat itemWidth;
    CGFloat itemHeight;
}

- (instancetype)init {
    if (self = [super init]) {

    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

    }
    return self;
}

- (void)commonInit {
    _backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _backgroundImageView.image = _backgroundImage;
    [self addSubview:_backgroundImageView];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = INTERITEM_SPACING;
    flowLayout.minimumLineSpacing = LINE_SPACING;
    itemWidth = (self.bounds.size.width - (INTERITEM_SPACING * (_column - 1))) / _column;
    itemHeight = (self.bounds.size.height - (LINE_SPACING * (_row - 1))) / _row;
    flowLayout.itemSize = CGSizeMake(itemWidth, itemHeight);
    // miss spacing effect
    itemWidth = itemWidth + INTERITEM_SPACING;
    itemHeight = itemHeight + LINE_SPACING;
    _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[MDAreaViewCell class] forCellWithReuseIdentifier:MDAreaViewCellId];
    [_collectionView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_collectionView];
    
    _areaSelectView = [[MDAreaSelectView alloc] initWithFrame:self.bounds];
    _areaSelectView.delegate = self;
    [self addSubview:_areaSelectView];
    
    _areas = [NSMutableArray array];
    for (int num = 0; num < _row * _column; num++) {
        [_areas addObject:@AREA_NO_SELECTED];
    }
}

+ (instancetype)MDAreaViewWithFram:(CGRect)frame backgroundImage:(UIImage *)image row:(NSInteger)row column:(NSInteger)column {
    MDAreaView *view = [[MDAreaView alloc] initWithFrame:frame];
    view.backgroundImage = image;
    view.row = row;
    view.column = column;
    [view commonInit];
    return view;
}


#pragma mark -mdAreaSelectViewDelegate
- (void)MDAreaSelectViewDelegate:(MDAreaSelectView *)mdAreaSelectView startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    CGFloat startX = (startPoint.x < endPoint.x ? startPoint.x : endPoint.x);
    CGFloat endX = (startPoint.x > endPoint.x ? startPoint.x : endPoint.x);
    CGFloat startY = (startPoint.y < endPoint.y ? startPoint.y : endPoint.y);
    CGFloat endY = (startPoint.y > endPoint.y ? startPoint.y : endPoint.y);
#if DEBUG_SWITCH
    NSLog(@"startX=%f,startY=%f,endX=%f,endY=%f", startX, startY, endX, endY);
#endif
    
    if (itemWidth == 0 || itemHeight == 0) {
#if DEBUG_SWITCH
        NSLog(@"MDAreaSelectViewDelegate err:itemWidth or itemHeight is zero");
#endif
    }
    
    int startColumn = (((int)startX % (int)itemWidth) < (itemWidth / 3 * 2) ? startX / itemWidth : (startX / itemWidth + 1));
    int endColumn = (((int)endX % (int)itemWidth) > (itemWidth / 3) ? endX / itemWidth : endX / itemWidth - 1);
    int startRow = (((int)startY % (int)itemHeight) < (itemHeight / 3 * 2) ? startY / itemHeight : (startY / itemHeight + 1));
    int endRow = (((int)endY % (int)itemHeight) > (itemHeight / 3) ? endY / itemHeight : (endY / itemHeight - 1));
    
    if (startRow > endRow) {
        endRow = endY / itemHeight;
        startRow = endRow;
    }
    
    if (startColumn > endColumn) {
        endColumn = endX / itemWidth;
        startColumn = endColumn;
    }
    
#if DEBUG_SWITCH
    NSLog(@"startColumn=%d,endColumn=%d,startRow=%d,endRow=%d",startColumn, endColumn, startRow, endRow);
#endif
    
    NSInteger noSelectedNum = 0;
    for (int row = startRow; row <= endRow; row++) {
        for (int column = startColumn; column <= endColumn; column++) {
            NSInteger index = row * _column + column;
            if ([(NSNumber *)_areas[index] boolValue] == AREA_NO_SELECTED) {
                _areas[index] = @AREA_SELECTED;
                noSelectedNum ++;
            }
        }
    }
    
    if (noSelectedNum == 0) {
        for (int row = startRow; row <= endRow; row++) {
            for (int column = startColumn; column <= endColumn; column++) {
                NSInteger index = row * _row + column;
                _areas[index] = @AREA_NO_SELECTED;
            }
        }
    }
    
    [_collectionView reloadData];
    if (_delegate && [_delegate respondsToSelector:@selector(MDAreaViewDelegate:areaArray:)]) {
        [_delegate MDAreaViewDelegate:self areaArray:_areas];
    }
}

- (void)MDAreaSelectViewDelegate:(MDAreaSelectView *)mdAreaSelectView tapPoint:(CGPoint)point {
#if DEBUG_SWITCH
    NSLog(@"Tappoint:%@", NSStringFromCGPoint(point));
#endif
    NSInteger row = point.y / (itemHeight);
    NSInteger column = point.x / (itemWidth);
    _areas[row * _column + column] = @(![(NSNumber *)_areas[row * _column + column] boolValue]);
    [_collectionView reloadData];
    if (_delegate && [_delegate respondsToSelector:@selector(MDAreaViewDelegate:areaArray:)]) {
        [_delegate MDAreaViewDelegate:self areaArray:_areas];
    }
}

#pragma mark -CollectionView delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return (_column * _row);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MDAreaViewCellId forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor grayColor]];
    BOOL isSelected = [(NSNumber *)_areas[indexPath.row] boolValue];
    if (isSelected) {
        cell.alpha = 0;
    } else {
        cell.alpha = 0.5;
    }
    return cell;
}

#pragma mark -API
- (void)selectAllArea {
    for (int count = 0; count < _row * _column; count++) {
        _areas[count] = @AREA_SELECTED;
    }
    [_collectionView reloadData];
    if (_delegate && [_delegate respondsToSelector:@selector(MDAreaViewDelegate:areaArray:)]) {
        [_delegate MDAreaViewDelegate:self areaArray:_areas];
    }
}

- (void)cancelSelectAllArea {
    for (int count = 0; count < _row * _column; count++) {
        _areas[count] = @AREA_NO_SELECTED;
    }
    [_collectionView reloadData];
    if (_delegate && [_delegate respondsToSelector:@selector(MDAreaViewDelegate:areaArray:)]) {
        [_delegate MDAreaViewDelegate:self areaArray:_areas];
    }
}

@end
