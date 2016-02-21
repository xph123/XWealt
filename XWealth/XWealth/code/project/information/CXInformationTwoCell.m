//
//  CXInformationTwoCell.m
//  XWealth
//
//  Created by gsycf on 15/10/8.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXInformationTwoCell.h"

@implementation CXInformationTwoCell
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
    
    _imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _imgView.contentMode = UIViewContentModeScaleAspectFill;
    _imgView.clipsToBounds  = YES;
    //_imgView.layer.cornerRadius = kRadius;
    [_cellView addSubview:_imgView];
    
    // 内容
    _titlelabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titlelabel.font = kMiddleTextFont;
    _titlelabel.textColor = kTitleTextColor;
    _titlelabel.numberOfLines = 2;
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
    
    // 评论
    _commentsButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [_commentsButton setBackgroundColor:[UIColor clearColor]];
    [_commentsButton setTitle: @"0" forState: UIControlStateNormal];
    _commentsButton.titleLabel.font = kMiddleTextFont;
    [_commentsButton setTitleColor:kAssistTextColor forState:UIControlStateNormal];
    [_commentsButton setImage:[UIImage imageNamed:@"view_number"] forState:UIControlStateNormal];
    [_commentsButton setImageEdgeInsets:UIEdgeInsetsMake(0.0, -12, 0.0, 0.0)];
    _commentsButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [_cellView addSubview: _commentsButton];
    
    
    _goodsButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [_goodsButton setBackgroundColor:[UIColor clearColor]];
    [_goodsButton setTitle: @"0" forState: UIControlStateNormal];
    _goodsButton.titleLabel.font = kMiddleTextFont;
    [_goodsButton setTitleColor:kAssistTextColor forState:UIControlStateNormal];
    [_goodsButton setImage:[UIImage imageNamed:@"list_good"] forState:UIControlStateNormal];
    [_goodsButton setImageEdgeInsets:UIEdgeInsetsMake(0.0, -12, 0.0, 0.0)];
    _goodsButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [_cellView addSubview: _goodsButton];
    
    _lineView = [[UIView alloc] initWithFrame:CGRectZero];
    _lineView.backgroundColor = kLineColor;
    [_cellView addSubview:_lineView];
    
}

- (void)setInformationModel:(CXInformationModel *)informationModel
{
    _informationModel = informationModel;
    _layout = [[CXInformationTwoCellFrame alloc] initWithDataModel:_informationModel];
    
    _cellView.frame = [_layout cellViewRect];
    
    _imgView.frame = [_layout imageViewRect];
    [_imgView sd_setImageWithURL:[NSURL URLWithString:[CXURLConstants getFullSltInformationUrl: self.informationModel.sltImageUrl]] placeholderImage:[UIImage imageNamed:@"defaule_image"]];
    
    
    _titlelabel.frame = [_layout titleRect];
    _titlelabel.text = self.informationModel.name;
    
    _datelineLabel.frame = [_layout datelineRect];
    _datelineLabel.text = [XDateHelper translateToDisplay: self.informationModel.dateline];
    
    _commentsButton.frame = [_layout commentsRect];
    [_commentsButton setTitle: [NSString stringWithFormat:@"%d", self.informationModel.comments] forState: UIControlStateNormal];
    
    _goodsButton.frame = [_layout goodsRect];
    [_goodsButton setTitle: [NSString stringWithFormat:@"%d", self.informationModel.goods] forState: UIControlStateNormal];
    
    _lineView.frame=[_layout lineRect];
    
}


@end
