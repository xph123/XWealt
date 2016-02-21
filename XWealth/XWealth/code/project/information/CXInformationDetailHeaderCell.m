//
//  CXInformationDetailHeaderCell.m
//  XWealth
//
//  Created by chx on 15-3-13.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXInformationDetailHeaderCell.h"

@implementation CXInformationDetailHeaderCell

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
    self.backgroundColor = kColorWhite;
    
    _cellView = [[UIView alloc] initWithFrame:CGRectZero];
    _cellView.backgroundColor = kColorWhite;
    [self addSubview:_cellView];
    
    // 内容
    _titlelabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titlelabel.font = kLargeTextFont;
    _titlelabel.textColor = kTitleTextColor;
    _titlelabel.numberOfLines = 0;
    _titlelabel.textAlignment = NSTextAlignmentLeft;
    _titlelabel.backgroundColor = [UIColor clearColor];
    [_cellView addSubview:_titlelabel];
    
    _sourceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _sourceLabel.font = kSmallTextFont;
    _sourceLabel.textColor = kMainStyleColor;
    _sourceLabel.numberOfLines = 1;
    _sourceLabel.textAlignment = NSTextAlignmentLeft;
    _sourceLabel.backgroundColor = [UIColor clearColor];
    [_cellView addSubview:_sourceLabel];
    
    _authorLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _authorLabel.font = kSmallTextFont;
    _authorLabel.textColor = kMainStyleColor;
    _authorLabel.numberOfLines = 1;
    _authorLabel.textAlignment = NSTextAlignmentLeft;
    _authorLabel.backgroundColor = [UIColor clearColor];
    [_cellView addSubview:_authorLabel];
    
    _datelineLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _datelineLabel.font = kSmallTextFont;
    _datelineLabel.textColor = kAssistTextColor;
    _datelineLabel.numberOfLines = 1;
    _datelineLabel.textAlignment = NSTextAlignmentLeft;
    _datelineLabel.backgroundColor = [UIColor clearColor];
    [_cellView addSubview:_datelineLabel];
    
    
    _lineView = [[UIView alloc] initWithFrame:CGRectZero];
    _lineView.backgroundColor = kTextColor;
    [_cellView addSubview:_lineView];
    
}

- (void)setInformationModel:(CXInformationModel *)informationModel
{
    _informationModel = informationModel;
    _layout = [[CXInformationDetailHeaderFrame alloc] initWithDataModel:_informationModel];
    
    _cellView.frame = [_layout cellViewRect];
    
    _titlelabel.frame = [_layout titleRect];
    _titlelabel.text = self.informationModel.name;
    
    NSString *source = [NSString stringWithFormat:@"%@:%@", @"来源", self.informationModel.source];
    _sourceLabel.frame = [_layout sourceRect];
    _sourceLabel.text = source;
    
    NSString *author = [NSString stringWithFormat:@"%@:%@", @"作者", self.informationModel.author];
    _authorLabel.frame = [_layout authorRect];
    _authorLabel.text = author;
    
    _datelineLabel.frame = [_layout datelineRect];
    if (self.informationModel.dateline.length > 0)
    {
        NSArray *array = [self.informationModel.dateline componentsSeparatedByString:@" "];
        if (array && [array count] > 0)
        {
            _datelineLabel.text = [array objectAtIndex:0];
        }
    }
    
    _lineView.frame = [_layout lineRect];
}

@end
