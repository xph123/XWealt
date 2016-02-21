//
//  CXIntegralCell.m
//  XWealth
//
//  Created by chx on 15/6/23.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXIntegralCell.h"

@implementation CXIntegralCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initSubviews];
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

- (void) initSubviews
{
    self.backgroundColor = kControlBgColor;
    
    _cellView = [[UIView alloc] initWithFrame:CGRectZero];
    _cellView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_cellView];
    
    // 内容
    _titlelabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titlelabel.font = kMiddleTextFont;
    _titlelabel.textColor = kTitleTextColor;
    _titlelabel.numberOfLines = 0;
    _titlelabel.textAlignment = NSTextAlignmentLeft;
    _titlelabel.backgroundColor = [UIColor clearColor];
    [_cellView addSubview:_titlelabel];
    
    
    _datelineLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _datelineLabel.font = kSmallTextFont;
    _datelineLabel.textColor = kAssistTextColor;
    _datelineLabel.numberOfLines = 1;
    _datelineLabel.textAlignment = NSTextAlignmentLeft;
    _datelineLabel.backgroundColor = [UIColor clearColor];
    [_cellView addSubview:_datelineLabel];
    
    _lineView = [[UIView alloc] initWithFrame:CGRectZero];
    _lineView.backgroundColor = kLineColor;
    [_cellView addSubview:_lineView];
    
}

- (void)setIntegralModel:(CXIntegralModel *)integralModel
{
    _integralModel = integralModel;
    _layout = [[CXIntegralFrame alloc] initWithDataModel:_integralModel];
    
    _cellView.frame = [_layout cellViewRect];
    
    NSString *str = @"";
    if (![self.integralModel.eventName isEmpty])
    {
        if (self.integralModel.type == EXP_SUBSCRIBE)
        {
            str = [NSString stringWithFormat:@"您定购了：%@，获得%d现金劵", self.integralModel.eventName, EXP_POINT_SUBSCRIBE];
        }
        else if (self.integralModel.type == EXP_RECOMMENT)
        {
            str = [NSString stringWithFormat:@"您推荐了：%@，获得%d现金劵", self.integralModel.eventName, EXP_POINT_RECOMMENT];
        }
    }

    
    _titlelabel.frame = [_layout titleRect];
    _titlelabel.text = str;
    
    _datelineLabel.frame = [_layout datelineRect];
    _datelineLabel.text = [XDateHelper translateToDisplay: self.integralModel.dateline];
}

@end
