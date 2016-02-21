//
//  CXModifyInfoCell.h
//  Link
//  修改个人资料的cell  格式：" 标题 内容  > "
//  Created by chx on 14-12-3.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TitleWidth          72
#define ContentWidth        190
#define UserHeadWidth       64
#define UserHeadHeight      64
#define HeadCellHeight      (UserHeadHeight + 2 * kDefaultMargin)

@interface XModifyInfoCell : UITableViewCell

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *content;

@property (strong, nonatomic) UIView *menuView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *contentLabel;
@property (strong, nonatomic) UIImageView *headImageView; // 头像
@property (strong, nonatomic) UIImageView *headBgImgView;
@property (strong, nonatomic) UIImageView *rightImageView;
@property (strong, nonatomic) UIView *line;

- (void)setTitle:(NSString *)title andContent:(NSString*)content;
- (void)setTitle:(NSString *)title andImageUrl:(NSString*)imageUrl;

@property (strong, nonatomic) ActionClickBlk imgViewBlk;

@end
