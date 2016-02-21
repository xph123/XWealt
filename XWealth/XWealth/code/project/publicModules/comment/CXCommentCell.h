//
//  CXCommentCell.h
//  Link
//
//  Created by chx on 14-11-14.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXCommentFrame.h"

@interface CXCommentCell : UITableViewCell

@property (nonatomic, strong) UIButton *headBtn;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *content;
@property (nonatomic, strong) UILabel *dateline;

@property (nonatomic, strong) CXCommentModel *commentModel;
@property (nonatomic, strong) CXCommentFrame *layout;

@end
