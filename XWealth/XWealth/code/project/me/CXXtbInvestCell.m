//
//  CXXtbInvestCell.m
//  XWealth
//
//  Created by chx on 15/9/10.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXXtbInvestCell.h"

@implementation CXXtbInvestCell

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
    _imgView.layer.cornerRadius = kRadius;
    [_cellView addSubview:_imgView];
    
    // 内容
    _titlelabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titlelabel.font = kLargeTextFont;
    _titlelabel.textColor = kTitleTextColor;
    _titlelabel.numberOfLines = 2;
    _titlelabel.textAlignment = NSTextAlignmentLeft;
    _titlelabel.backgroundColor = [UIColor clearColor];
    [_cellView addSubview:_titlelabel];
    
    
    _intstRatelabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _intstRatelabel.font = kSmallTextFont;
    _intstRatelabel.textColor = kAssistTextColor;
    _intstRatelabel.numberOfLines = 1;
    _intstRatelabel.textAlignment = NSTextAlignmentLeft;
    _intstRatelabel.backgroundColor = [UIColor clearColor];
    [_cellView addSubview:_intstRatelabel];
    
    _stateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _stateBtn.frame = CGRectZero;
    _stateBtn.layer.masksToBounds = YES;
    _stateBtn.layer.cornerRadius = kRadius;
    _stateBtn.layer.borderWidth = 1;
    _stateBtn.layer.borderColor = kLineColor.CGColor;
    [_stateBtn setTitle:@"回款中" forState:UIControlStateNormal];
    _stateBtn.titleLabel.font = kSmallTextFont;
    _stateBtn.backgroundColor = kGrayColor;
    [_stateBtn setTitleColor:kTextColor forState:UIControlStateNormal];
    [_cellView addSubview:_stateBtn];

    
    _inTimeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _inTimeLabel.font = kMiddleTextFont;
    _inTimeLabel.textColor = kTextColor;
    _inTimeLabel.numberOfLines = 1;
    _inTimeLabel.textAlignment = NSTextAlignmentLeft;
    _inTimeLabel.backgroundColor = [UIColor clearColor];
    [_cellView addSubview:_inTimeLabel];
    
    _intstLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _intstLabel.font = kMiddleTextFont;
    _intstLabel.textColor = kTextColor;
    _intstLabel.numberOfLines = 1;
    _intstLabel.textAlignment = NSTextAlignmentRight;
    _intstLabel.backgroundColor = [UIColor clearColor];
    [_cellView addSubview:_intstLabel];
    
    
    _investTimeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _investTimeLabel.font = kSmallTextFont;
    _investTimeLabel.textColor = kAssistTextColor;
    _investTimeLabel.numberOfLines = 1;
    _investTimeLabel.textAlignment = NSTextAlignmentLeft;
    _investTimeLabel.backgroundColor = [UIColor clearColor];
    [_cellView addSubview:_investTimeLabel];
    
    _invAmtLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _invAmtLabel.font = kSmallTextFont;
    _invAmtLabel.textColor = kAssistTextColor;
    _invAmtLabel.numberOfLines = 1;
    _invAmtLabel.textAlignment = NSTextAlignmentRight;
    _invAmtLabel.backgroundColor = [UIColor clearColor];
    [_cellView addSubview:_invAmtLabel];
}

- (void)setInvestModel:(CXXtbInvestModel *)investModel
{
    _investModel = investModel;
    _layout = [[CXXtbInvestCellFrame alloc] initWithDataModel:_investModel];
    
    _cellView.frame = [_layout cellViewRect];
    
    _imgView.frame = [_layout imageViewRect];
    
    //30 :  预售  25 :  已回款  20 :  售罄  15 :  冻结  10 :  在售
    switch (_investModel.prodStatus) {
        case 30:
            [_imgView setImage:IMAGE(@"invest_type3")];
            break;
        case 25:
            [_imgView setImage:IMAGE(@"invest_type2")];
            break;
        case 20:
            [_imgView setImage:IMAGE(@"invest_type1")];
            break;
        case 15:
            [_imgView setImage:IMAGE(@"invest_type5")];
            break;
        case 10:
            [_imgView setImage:IMAGE(@"invest_type4")];
            break;
        default:
            break;
    }

    _titlelabel.frame = [_layout titleRect];
    _titlelabel.text = _investModel.prodName;
    
    NSString *intstRate = [NSString stringWithFormat:@"（年化%0.1f%@）", self.investModel.intstRate, @"%"];
    
    _intstRatelabel.frame = [_layout intstRateRect];
    _intstRatelabel.text = intstRate;
    
    _stateBtn.frame = [_layout stateRect];
    //30 :  预售  25 :  已回款  20 :  售罄  15 :  冻结  10 :  在售
    switch (_investModel.prodStatus) {
        case 30:
            [_stateBtn setTitle:@"预售" forState:UIControlStateNormal];
            break;
        case 25:
            [_stateBtn setTitle:@"已回款" forState:UIControlStateNormal];
            break;
        case 20:
            [_stateBtn setTitle:@"售罄" forState:UIControlStateNormal];
            break;
        case 15:
            [_stateBtn setTitle:@"冻结" forState:UIControlStateNormal];
            break;
        case 10:
            [_stateBtn setTitle:@"在售" forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    
    NSString *inTime = [NSString stringWithFormat:@"回款时间 %@", self.investModel.inTime];
    _inTimeLabel.frame = [_layout inTimeRect];
    _inTimeLabel.text = inTime;
    
    NSString *intst = [NSString stringWithFormat:@"预计收益 %0.2f", self.investModel.intst];
    _intstLabel.frame = [_layout intstRect];
    _intstLabel.text = intst;
    
     NSString *investTime = [NSString stringWithFormat:@"投资时间 %@", self.investModel.investTime];
    _investTimeLabel.frame = [_layout investTimeRect];
    _investTimeLabel.text = investTime;
    
    NSString *invAmt = [NSString stringWithFormat:@"投资金额 %0.2f", self.investModel.invAmt];
    _invAmtLabel.frame = [_layout invAmtRect];
    _invAmtLabel.text = invAmt;
    
}

@end
