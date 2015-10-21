//
//  ZLTagListView.m
//  TagList
//
//  Created by long on 15/10/20.
//  Copyright © 2015年 long. All rights reserved.
//

#import "ZLTagListView.h"
#import "TagListViewCell.h"

@interface ZLTagListView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
{
    NSMutableArray *_arrayTitles;
}
@end

@implementation ZLTagListView

//通过xib初始化
- (void)awakeFromNib
{
    [self setDefaultValue];
}

//通过代码初始化
- (instancetype)initWithFrame:(CGRect)frame tagTitles:(NSString *)title
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"ZLTagListView" owner:self options:nil] lastObject];
    if (self) {
        self.frame = frame;
        _arrayTitles = [[NSMutableArray alloc] initWithArray:[self getFormatArrayWithTitle:title]];
        [self setDefaultValue];
    }
    return self;
}

- (void)setDefaultValue
{
    self.isNeedLayoutSubViews = YES;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"TagListViewCell" bundle:nil] forCellWithReuseIdentifier:@"TagListViewCell"];
}

- (void)layoutSubviews
{
    if (!self.isNeedLayoutSubViews) {
        return;
    }
    CGSize contentSize = self.collectionView.contentSize;
    NSLog(@"self.frame:%@, collectionView.", NSStringFromCGRect(self.frame));
    if (self.frame.size.height < contentSize.height) {
        CGRect newFrame = self.frame;
        newFrame.size.height = contentSize.height;
        self.frame = newFrame;
    }
}

#pragma mark - 添加一个tagTitle
- (void)addTagTitle:(NSString *)title
{
    NSArray *arr = [self getFormatArrayWithTitle:title];
    if (arr.count == 0) {
        return;
    }
    for (NSString *title in arr) {
        if (![_arrayTitles containsObject:title]) {
            [_arrayTitles addObject:title];
        }
    }
    [self.collectionView reloadData];
    //做一个短暂延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self layoutSubviews];
    });
}

#pragma mark - 删除一个tagTitle
- (void)deleteTagTitle:(NSString *)title
{
    NSArray *arr = [self getFormatArrayWithTitle:title];
    if (arr.count == 0) {
        return;
    }
    NSMutableArray *deleteIndexPath = [NSMutableArray array];
    for (NSString *title in arr) {
        if ([_arrayTitles containsObject:title]) {
            NSInteger index = [_arrayTitles indexOfObject:title];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
            [deleteIndexPath addObject:indexPath];
            [_arrayTitles removeObject:title];
        }
    }
    [self.collectionView deleteItemsAtIndexPaths:deleteIndexPath];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self layoutSubviews];
    });
}

- (NSArray *)getFormatArrayWithTitle:(NSString *)title
{
    title = [title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    title = [title stringByReplacingOccurrencesOfString:@"，" withString:@","];
    NSArray *arr = [title componentsSeparatedByString:@","];
    NSMutableArray *formatArr = [NSMutableArray arrayWithCapacity:arr.count];
    for (NSString *str in arr) {
        [formatArr addObject:[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    }
    
    [formatArr removeObject:@""];
    
    return formatArr;
}

#pragma mark - UICollectionView DataSource And Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _arrayTitles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TagListViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TagListViewCell" forIndexPath:indexPath];
    
    cell.labTitle.font = [UIFont systemFontOfSize:self.tagFontSize>0?self.tagFontSize:kDefaultFontSize];
    cell.labTitle.text = _arrayTitles[indexPath.row];
    cell.labTitle.textColor = self.tagTitleColor ? self.tagTitleColor : kDefaultTagTitleColor;
    cell.labTitle.backgroundColor = self.tagBgColor ? self.tagBgColor : kDefaultTagBgColor;
    cell.labTitle.layer.borderColor = self.tagBorderColor ? self.tagBorderColor.CGColor : kDefaultTagBorderColor;
    cell.labTitle.layer.borderWidth = self.tagBorderWidth ? self.tagBorderWidth : kDefaultTagBorderWidth;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.ClickAction) {
        self.ClickAction(_arrayTitles[indexPath.row]);
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = _arrayTitles[indexPath.row];
    CGSize size = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:self.tagFontSize>0?self.tagFontSize+5:kDefaultFontSize+5]} context:nil].size;
    if (size.width < kMinWidth) {
        size.width = kMinWidth;
    }
    
    if (size.width > self.collectionView.frame.size.width - 2*kLeftRightMargin) {
        size.width = self.collectionView.frame.size.width - 2*kLeftRightMargin;
    }
    return size;
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    // Override point for customization after application launch.
    return UIEdgeInsetsMake(kTopBottomMargin, kLeftRightMargin, kTopBottomMargin, kLeftRightMargin);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 2;
}

@end
