//
//  CXTrustTransferCenterDetailCell.m
//  XWealth
//
//  Created by gsycf on 15/10/27.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXTrustTransferCenterDetailCell.h"

@implementation CXTrustTransferCenterDetailCell

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
    
    
    
    // 姓名
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _nameLabel.font = kMiddleTextFont;
    _nameLabel.textColor = kAssistTextColor;
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    _nameLabel.backgroundColor = [UIColor clearColor];
    [_cellView addSubview:_nameLabel];
    
    // 手机号码
    _phoneLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _phoneLabel.font = kMiddleTextFont;
    _phoneLabel.textColor = kAssistTextColor;
    _phoneLabel.textAlignment = NSTextAlignmentLeft;
    _phoneLabel.backgroundColor = [UIColor clearColor];
    [_cellView addSubview:_phoneLabel];
    
    
 
    
    
    _datelineLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _datelineLabel.font = kSmallTextFont;
    _datelineLabel.textColor = kAssistTextColor;
    _datelineLabel.numberOfLines = 1;
    _datelineLabel.textAlignment = NSTextAlignmentRight;
    _datelineLabel.backgroundColor = [UIColor clearColor];
    [_cellView addSubview:_datelineLabel];
    
    

    
    _lineView = [[UIView alloc] initWithFrame:CGRectZero];
    _lineView.backgroundColor = kLineColor;
    [_cellView addSubview:_lineView];
    
}
-(void)setBenefitRecordModel:(CXBenefitRecordModel *)benefitRecordModel
{
    _benefitRecordModel = benefitRecordModel;
    _layout = [[CXTrustTransferCenterDetailCellFrame alloc] initWithDataModel:_benefitRecordModel];
    
    _cellView.frame = [_layout cellViewRect];
    
    if (_imgView != nil)
    {
        [_imgView removeFromSuperview];
    }
    if (self.benefitRecordModel.state==2) {
        _imgView = [[UIImageView alloc] initWithFrame:[_layout imageViewRect]];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        //_imgView.clipsToBounds  = YES;
        [_imgView setImage:[UIImage imageNamed:@"buy_success"]];
        //_imgView.layer.cornerRadius = kRadius;
        [_cellView addSubview:_imgView];
        
    }
    else
    {
        _imgView = [[UIImageView alloc] initWithFrame:[_layout imageViewRect]];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        //_imgView.clipsToBounds  = YES;
        [_imgView setImage:[UIImage imageNamed:@"market_examine"]];
        //_imgView.layer.cornerRadius = kRadius;
        [_cellView addSubview:_imgView];
        
    }
    
    
    
    _nameLabel.frame = [_layout nameRect];
    //姓名隐藏
    _nameLabel.text = [CXTextFildSet getNameHide:self.benefitRecordModel.userName];

    
    
    _phoneLabel.frame = [_layout phoneRect];
    //联系方式
    _phoneLabel.text=[CXTextFildSet getPhoneHide:benefitRecordModel.phone];

   

    

    
    
    _datelineLabel.frame = [_layout datelineRect];
    _datelineLabel.text = [self.benefitRecordModel.dateline substringToIndex:10];
    
    
    
    
    
    _lineView.frame=[_layout lineRect];
    
}

@end
