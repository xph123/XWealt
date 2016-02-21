//
//  CXXtbBillCell.m
//  XWealth
//
//  Created by chx on 15/9/10.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXXtbBillCell.h"

@implementation CXXtbBillCell

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
    _titlelabel.font = kMiddleTextFont;
    _titlelabel.textColor = kTitleTextColor;
    _titlelabel.numberOfLines = 1;
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
    
    _desclabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _desclabel.font = kSmallTextFont;
    _desclabel.textColor = kAssistTextColor;
    _desclabel.numberOfLines = 1;
    _desclabel.textAlignment = NSTextAlignmentLeft;
    _desclabel.backgroundColor = [UIColor clearColor];
    [_cellView addSubview:_desclabel];
    
    _balanceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _balanceLabel.font = kSmallTextFont;
    _balanceLabel.textColor = kAssistTextColor;
    _balanceLabel.numberOfLines = 1;
    _balanceLabel.textAlignment = NSTextAlignmentRight;
    _balanceLabel.backgroundColor = [UIColor clearColor];
    [_cellView addSubview:_balanceLabel];
    
}

- (void)setBillModel:(CXXtbBillModel *)billModel
{
    _billModel = billModel;
    _layout = [[CXXtbBillCellFrame alloc] initWithDataModel:_billModel];
    
    _cellView.frame = [_layout cellViewRect];
    
    _imgView.frame = [_layout imageViewRect];
    
    // 1投资，2回款本金，3充值，4提现，5回款利息，7：转账（活动收益）
    switch (_billModel.type) {
        case 1:
            [_imgView setImage:IMAGE(@"bill_type1")];
            break;
        case 2:
        case 5:
            [_imgView setImage:IMAGE(@"bill_type2")];
            break;
        case 3:
            [_imgView setImage:IMAGE(@"bill_type3")];
            break;
        case 4:
            [_imgView setImage:IMAGE(@"bill_type4")];
            break;
        case 7:
            [_imgView setImage:IMAGE(@"bill_type7")];
            break;
        default:
            break;
    }
    
    NSString *title = @"";
    // 1投资，2回款本金，3充值，4提现，5回款利息，7：转账（活动收益）
    switch (_billModel.type) {
        case 1:
            title = [NSString stringWithFormat:@"投资金额：%@元", _billModel.amount];
            break;
        case 2:
            title = [NSString stringWithFormat:@"回款本金：%@元", _billModel.amount];
            break;
        case 3:
            title = [NSString stringWithFormat:@"充值金额：%@元", _billModel.amount];
            break;
        case 4:
            title = [NSString stringWithFormat:@"提现金额：%@元", _billModel.amount];
            break;
        case 5:
            title = [NSString stringWithFormat:@"回款利息：%@元", _billModel.amount];
            break;
        case 7:
            title = [NSString stringWithFormat:@"转账金额：%@元", _billModel.amount];
            break;
        default:
            break;
    }

    
    _titlelabel.frame = [_layout titleRect];
    _titlelabel.text = title;
    
    _datelineLabel.frame = [_layout datelineRect];
    _datelineLabel.text = [XDateHelper translateToXtbDisplay: self.billModel.payTime];
    
    _desclabel.frame = [_layout descRect];
    _desclabel.text = self.billModel.name;
    
    if (_billModel.type == 1)
    {
        _balanceLabel.frame = [_layout balanceRect];
        _balanceLabel.text =  [NSString stringWithFormat:@"投后余额：%@", self.billModel.balance];
        _balanceLabel.hidden = NO;
    }
    else
    {
        _balanceLabel.hidden = YES;
    }
    
}

@end
