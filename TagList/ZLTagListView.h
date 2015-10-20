//
//  ZLTagListView.h
//  TagList
//
//  Created by long on 15/10/20.
//  Copyright © 2015年 long. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLTagListView : UIView

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


@property (nonatomic, strong) UIColor *bgColor;
@property (nonatomic, strong) UIColor *textColor;
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
