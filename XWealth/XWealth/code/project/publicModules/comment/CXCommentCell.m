//
//  CXCommentCell.m
//  Link
//
//  Created by chx on 14-11-14.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXCommentCell.h"

@implementation CXCommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor whiteColor]];
        UIView *line = [[UIView alloc] initWithFrame:CGRectZero];
        line.backgroundColor = kLineColor;
        [self.contentView addSubview:line];
        self.line = line;
        
        UIButton *headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        headBtn.frame = CGRectMake(kDefaultMargin, kDefaultMargin, kUserHeadImgWidth, kUserHeadImgHeight);
        [self.contentView addSubview:headBtn];
        self.headBtn = headBtn;
        
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectZero];
        name.font = kMiddleTextFont;
        name.textColor = kAssistTextColor;
        name.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:name];
        self.name = name;
        
        UILabel *content = [[UILabel alloc] initWithFrame:CGRectZero];
        content.font = kMiddleTextFont;
        content.numberOfLines = 0;
        content.textColor = kTextColor;
        content.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:content];
        self.content = content;
        
        UILabel *updateTime = [[UILabel alloc] initWithFrame:CGRectZero];
        updateTime.font = kSmallTextFont;
        updateTime.textColor = kAssistTextColor;
        updateTime.backgroundColor = [UIColor clearColor];
        updateTime.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:updateTime];
        self.dateline = updateTime;
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setCommentModel:(CXCommentModel *)commentModel
{
    _commentModel = commentModel;
    
    _layout = [[CXCommentFrame alloc] initWithDataModel:_commentModel];
    
    _name.text = commentModel.userName;
    _name.frame = [_layout nameRect];
    
    
    _content.text = self.commentModel.content;
    _content.frame = [_layout contentRect];
    
    XDateTimeHelper *dateHelper = [[XDateTimeHelper alloc] initWithDate:self.commentModel.dateline];
    
    if ([dateHelper isToday])
    {
        _dateline.text = dateHelper.time;
    }
    else
    {
        _dateline.text = dateHelper.date;
    }
    _dateline.frame = [_layout datelineRect];
    
    _headBtn.frame = [_layout headRect];
    [_headBtn setImageForState: UIControlStateNormal withURL:[NSURL URLWithString:self.commentModel.head ]placeholderImage:IMAGE(@"head_default")];
    
    _line.frame = [_layout lineRect];
}


@end
