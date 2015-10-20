//
//  TagListViewCell.m
//  TagList
//
//  Created by long on 15/10/20.
//  Copyright © 2015年 long. All rights reserved.
//

#import "TagListViewCell.h"

@implementation TagListViewCell

- (void)awakeFromNib {
    // Initialization code
    self.labTitle.layer.masksToBounds = YES;
    self.labTitle.layer.cornerRadius = 10.0f;
    self.labTitle.layer.borderWidth = 1.0f;
    self.labTitle.layer.borderColor = [UIColor darkGrayColor].CGColor;
}

@end
