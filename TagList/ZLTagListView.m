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

- (instancetype)initWithFrame:(CGRect)frame tagTitles:(NSString *)title
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"ZLTagListView" owner:self options:nil] lastObject];
    if (self) {
        self.frame = frame;
        
        _arrayTitles = [[NSMutableArray alloc] initWithArray:[self getFormatArrayWithTitle:title]];
        
        self.collectionView.backgroundColor = [UIColor clearColor];
        [self.collectionView registerNib:[UINib nibWithNibName:@"TagListViewCell" bundle:nil] forCellWithReuseIdentifier:@"TagListViewCell"];
        [self setNeedsDisplay];
    }
    return self;
}

- (void)layoutSubviews
{
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
    for (NSString *title in arr) {
        if ([_arrayTitles containsObject:title]) {
            [_arrayTitles removeObject:title];
        }
    }
    [self.collectionView reloadData];
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
    
    cell.labTitle.text = _arrayTitles[indexPath.row];
    cell.labTitle.textColor = self.textColor ? self.textColor : [UIColor blackColor];
    cell.labTitle.backgroundColor = self.bgColor ? self.bgColor : [UIColor lightGrayColor];
    
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
    CGSize size = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:20]} context:nil].size;
    if (size.width < 20) {
        size.width = 20;
    }
    return size;
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    // Override point for customization after application launch.
    return UIEdgeInsetsMake(10, 5, 10, 5);
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
