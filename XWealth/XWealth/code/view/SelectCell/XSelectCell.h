//
//  XSelectCell.h
//  Link
//  选择cell视图，选择按钮在左边
//  Created by chx on 14-12-5.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSelectCell : UITableViewCell

@property (nonatomic, strong) UIView *cellView;
@property (nonatomic, strong) UIImageView *selectImageView;
@property (nonatomic, strong) UIImageView *headImg;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, assign) BOOL isSelected;

- (void) setContent:(NSString *)content andImageUrl:(NSString *)imageUrl andIsSelected:(BOOL) isSelected;

@end
