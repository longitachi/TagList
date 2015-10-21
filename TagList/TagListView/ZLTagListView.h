//
//  ZLTagListView.h
//  TagList
//
//  Created by long on 15/10/20.
//  Copyright © 2015年 long. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kMinWidth 20.0f
#define kLeftRightMargin 5.0f
#define kTopBottomMargin 5.0f
#define kDefaultFontSize 15.0f
#define kDefaultTagBgColor [UIColor lightGrayColor]
#define kDefaultTagTitleColor [UIColor blackColor]
#define kDefaultTagBorderColor [UIColor darkGrayColor].CGColor
#define kDefaultTagBorderWidth 1.0f
@interface ZLTagListView : UIView

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

/**
 * 是否需要主视图跟随内容视图的contentSize做一个自动布局，默认为YES
 */
@property (nonatomic, assign) BOOL isNeedLayoutSubViews;

@property (nonatomic, assign) CGFloat tagFontSize;
@property (nonatomic, strong) UIColor *tagBgColor;
@property (nonatomic, strong) UIColor *tagTitleColor;
@property (nonatomic, strong) UIColor *tagBorderColor;
@property (nonatomic, assign) CGFloat tagBorderWidth;

/**
 * 点击回调方法
 */
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
