//
//  CXScheduleCell.m
//  XWealth
//
//  Created by gsycf on 15/10/14.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXScheduleCell.h"

@implementation CXScheduleCell

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
    
    _roundImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
//    _roundImgView.contentMode = UIViewContentModeScaleAspectFill;
//    _imgView.layer.cornerRadius = kRadius;
    [_cellView addSubview:_roundImgView];
    
    _leftView = [[UIView alloc] initWithFrame:CGRectZero];
    _leftView.backgroundColor=kproductYellowColor;
    [_cellView addSubview:_leftView];
    
    // 内容
    _titlelabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titlelabel.font = kMiddleTextFont;
    _titlelabel.textColor = kAssistTextColor;
    _titlelabel.textAlignment = NSTextAlignmentLeft;
    _titlelabel.backgroundColor = [UIColor clearColor];
    [_cellView addSubview:_titlelabel];
    
    
    _datelineLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _datelineLabel.font = kMiddleTextFont;
    _datelineLabel.textColor = kAssistTextColor;
    _datelineLabel.numberOfLines = 1;
    _datelineLabel.textAlignment = NSTextAlignmentRight;
    _datelineLabel.backgroundColor = [UIColor clearColor];
    [_cellView addSubview:_datelineLabel];
    

    
}
-(void)setProductListScheduleModel:(CXProductListScheduleModel *)productListScheduleModel
{
    _productListScheduleModel = productListScheduleModel;
    _layout = [[CXScheduleCellFrame alloc] initWithDataModel:productListScheduleModel];
    
    _cellView.frame = [_layout cellViewRect];
    
    _roundImgView.frame = [_layout roundImgViewRect];
    [_roundImgView setImage:[UIImage imageNamed:@"product_round.png"]];
    
    
    _leftView.frame = [_layout leftViewRect];
    
    
    _titlelabel.frame = [_layout titleRect];
//    _titlelabel.text = [NSString stringWithFormat:@"打款金额：%ld 万元",self.productListScheduleModel.total];
    
    NSString *allowIncomeOther = [NSString stringWithFormat:@"%ld",self.productListScheduleModel.total];
    NSString *allowIncomeStr = [NSString stringWithFormat:@"打款金额：%ld 万",self.productListScheduleModel.total];
    NSRange allowIncomeRangeCash = [allowIncomeStr rangeOfString:allowIncomeOther];
    NSMutableAttributedString *allowIncomeMutableStr = [[NSMutableAttributedString alloc] initWithString:allowIncomeStr];
    [allowIncomeMutableStr addAttribute:NSForegroundColorAttributeName value:kMainStyleColor range:allowIncomeRangeCash];
    _titlelabel.attributedText = allowIncomeMutableStr;
    
    _datelineLabel.frame = [_layout datelineRect];
    _datelineLabel.text = [XDateHelper translateToDisplay: self.productListScheduleModel.dateline];
    
}


@end
