//
//  ZLTagListView.h
//  TagList
//
//  Created by long on 15/10/20.
//  Copyright © 2015年 long. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kDefaultFontSize 15.0f
#define kDefaultTagBgColor [UIColor lightGrayColor]
#define kDefaultTagTitleColor [UIColor blackColor]

@interface ZLTagListView : UIView

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, assign) CGFloat tagFontSize;
@property (nonatomic, strong) UIColor *tagBgColor;
@property (nonatomic, strong) UIColor *tagTitleColor;
@property (nonatomic, copy) void (^ClickAction)(NSString *title);
/**
 * @brief 初始化方法
 * @param titles tag的标题，以中文“，”或者英文“,”进行分割
 */
- (instancetype)initWithFrame:(CGRect)frame tagTitles:(NSString *)title;

/**
 * @brief 添加一个或多个tagTitle，方法内部自动过滤重复标签
 */
- (void)addTagTitle:(NSString *)title;

/**
 * @brief 删除一个或多个tagTitle
 */
- (void)deleteTagTitle:(NSString *)title;

@end
