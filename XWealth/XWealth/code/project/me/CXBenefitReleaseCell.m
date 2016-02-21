//
//  CXBenefitReleaseCell.m
//  XWealth
//
//  Created by gsycf on 15/8/24.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXBenefitReleaseCell.h"
#define ITEMVIEW_HEIGHT     (45.0)//(20 + kLabelHeight)
#define PROCESS_WIDTH       (68.0f)
#define ITEMVIEW_MARGIN     (2.0f)

@implementation CXBenefitReleaseCell
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
    
    CGFloat cellWidth = kScreenWidth - 2 * kDefaultMargin;
    
    _cellView = [[UIView alloc] initWithFrame:CGRectMake(kDefaultMargin, 0, cellWidth, [_layout cellHeight]-5)];
    _cellView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_cellView];
    
    // 内容
    _titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin, 0, cellWidth - 2 * kDefaultMargin, [_layout titlelabelHight])];
    _titlelabel.font = kMiddleTextFont;
    _titlelabel.textColor = kTitleTextColor;
    _titlelabel.numberOfLines = 2;
    _titlelabel.textAlignment = NSTextAlignmentLeft;
    _titlelabel.backgroundColor = [UIColor clearColor];
    [_cellView addSubview:_titlelabel];
    
//    _externLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin, kTwoLineLabelHeight, cellWidth - 2 * kDefaultMargin, kLabelHeight)];
//    _externLabel.font = kMiddleTextFont;
//    _externLabel.textColor = kTextColor;
//    _externLabel.numberOfLines = 1;
//    _externLabel.textAlignment = NSTextAlignmentLeft;
//    _externLabel.backgroundColor = [UIColor clearColor];
//    [_cellView addSubview:_externLabel];
    
    _deadlineView = [[CXProductItemView alloc] initWithFrame:CGRectMake(kDefaultMargin, [_layout titlelabelHight], [self cellWidth]/3, ITEMVIEW_HEIGHT)];
    [_cellView addSubview:_deadlineView];
    
    CGFloat moneyViewX = _deadlineView.frame.origin.x+[self cellWidth]/3;
    _verticalLine1 = [[UIView alloc] initWithFrame:CGRectMake(moneyViewX, [_layout titlelabelHight] + kDefaultMargin, 0.5, ITEMVIEW_HEIGHT-2*kDefaultMargin)];
    _verticalLine1.backgroundColor = kLineColor;
    [_cellView addSubview:_verticalLine1];

    
    
    _moneyView = [[CXProductItemView alloc] initWithFrame:CGRectMake(moneyViewX, [_layout titlelabelHight], [self cellWidth]/3, ITEMVIEW_HEIGHT)];
    [_cellView addSubview:_moneyView];
    
    CGFloat rofitViewX =_moneyView.frame.origin.x+[self cellWidth]/3;
    _verticalLine2 = [[UIView alloc] initWithFrame:CGRectMake(rofitViewX, [_layout titlelabelHight] + kDefaultMargin, 0.5, ITEMVIEW_HEIGHT-2*kDefaultMargin)];
    _verticalLine2.backgroundColor = kLineColor;
    [_cellView addSubview:_verticalLine2];

    
    
    _profitView = [[CXProductItemView alloc] initWithFrame:CGRectMake(rofitViewX, [_layout titlelabelHight], [self cellWidth]/3, ITEMVIEW_HEIGHT)];
    [_cellView addSubview:_profitView];
    
    
    
    _horizoncalLine2 = [[UIView alloc] initWithFrame:CGRectMake(0, [_layout titlelabelHight] + ITEMVIEW_HEIGHT, cellWidth, 0.5)];
    _horizoncalLine2.backgroundColor = kLineColor;
    [_cellView addSubview:_horizoncalLine2];
    
    
    _statelabel = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin, [_layout titlelabelHight] + ITEMVIEW_HEIGHT, cellWidth/2-kDefaultMargin, kLabelHeight)];
    _statelabel.font = kMiddleTextFont;
    _statelabel.textColor = kTextColor;
    _statelabel.numberOfLines = 1;
    _statelabel.textAlignment = NSTextAlignmentLeft;
    _statelabel.backgroundColor = [UIColor clearColor];
    [_cellView addSubview:_statelabel];
    
    
    
    _datelineLabel = [[UILabel alloc] initWithFrame:CGRectMake(cellWidth/2+kDefaultMargin, [_layout titlelabelHight] + ITEMVIEW_HEIGHT, cellWidth/2-2*kDefaultMargin, kLabelHeight)];
    _datelineLabel.font = kSmallTextFont;
    _datelineLabel.textColor = kAssistTextColor;
    _datelineLabel.numberOfLines = 1;
    _datelineLabel.textAlignment = NSTextAlignmentRight;
    _datelineLabel.backgroundColor = [UIColor clearColor];
    [_cellView addSubview:_datelineLabel];
}
-(void)setBenefitModel:(CXBenefitModel *)BenefitModel
{
    _BenefitModel = BenefitModel;
    
    _layout = [[CXBenefitReleaseCellFrame alloc] initWithDataModel:_BenefitModel];
    CGFloat cellWidth = kScreenWidth - 2 * kDefaultMargin;
    CGFloat moneyViewX = _deadlineView.frame.origin.x+[self cellWidth]/3;
    CGFloat rofitViewX =_moneyView.frame.origin.x+[self cellWidth]/3;
    
     _cellView.frame = CGRectMake(kDefaultMargin, 0, cellWidth, [_layout cellHeight]-5);
    _titlelabel.frame = CGRectMake(kDefaultMargin, 0, cellWidth - 2 * kDefaultMargin, [_layout titlelabelHight]);
    _deadlineView.frame = CGRectMake(kDefaultMargin, [_layout titlelabelHight], [self cellWidth]/3, ITEMVIEW_HEIGHT);
    _verticalLine1.frame = CGRectMake(moneyViewX, [_layout titlelabelHight] + kDefaultMargin, 0.5, ITEMVIEW_HEIGHT-2*kDefaultMargin);
    _moneyView.frame = CGRectMake(moneyViewX, [_layout titlelabelHight], [self cellWidth]/3, ITEMVIEW_HEIGHT);
    _verticalLine2.frame = CGRectMake(rofitViewX, [_layout titlelabelHight] + kDefaultMargin, 0.5, ITEMVIEW_HEIGHT-2*kDefaultMargin);
    _profitView.frame = CGRectMake(rofitViewX, [_layout titlelabelHight], [self cellWidth]/3, ITEMVIEW_HEIGHT);
    _horizoncalLine2.frame = CGRectMake(0, [_layout titlelabelHight] + ITEMVIEW_HEIGHT, cellWidth, 0.5);
    _statelabel.frame = CGRectMake(kDefaultMargin, [_layout titlelabelHight] + ITEMVIEW_HEIGHT, cellWidth - 2 * kDefaultMargin - 100, kLabelHeight);
    _datelineLabel.frame = CGRectMake(cellWidth - kDefaultMargin - 100, [_layout titlelabelHight] + ITEMVIEW_HEIGHT, 100, kLabelHeight);
    

    _titlelabel.text = _BenefitModel.name;
    
    _datelineLabel.text = [XDateHelper translateToDisplay: self.BenefitModel.dateline];
    
    // 发布状态，0 未处理，1 已处理，2 >购买成功 3，未购买 4，已删除
    NSString *stateStr = @"";
    if (_BenefitModel.state == 0)
    {
        stateStr = @"审核中";
        _statelabel.textColor = kRedColor;
    }
    else if (_BenefitModel.state == 1)
    {
        stateStr = @"已审核";
        _statelabel.textColor = [UIColor greenColor];
    }
    else if (_BenefitModel.state == 2)
    {
        stateStr = @"购买成功";
        _statelabel.textColor = [UIColor greenColor];
    }
    else if (_BenefitModel.state == 3)
    {
        stateStr = @"未购买";
        _statelabel.textColor = kRedColor;
    }
    else
    {
        stateStr = @"已删除";
        _statelabel.textColor = kRedColor;
    }
    
    _statelabel.text = stateStr;
    
    
    _deadlineView.titleLabel.text = @"期限";
    int deadlineInt=self.BenefitModel.deadline;
    if (deadlineInt >= 12)
    {
        if (deadlineInt % 12 == 0)
        {
            _deadlineView.valueLabel.text = [NSString stringWithFormat:@"%d年", deadlineInt / 12];
        }
        else
        {
            _deadlineView.valueLabel.text = [NSString stringWithFormat:@"%d月", deadlineInt];
        }
    }
    else
    {
        _deadlineView.valueLabel.text = [NSString stringWithFormat:@"%d月", deadlineInt];
    }

    
    _moneyView.titleLabel.text = @"金额";
    int moneyNum=self.BenefitModel.money;
    if (moneyNum >= 10000)
    {
        int remain = moneyNum % 10000;
        if (remain == 0)
        {
            int scale = moneyNum / 10000;
            _moneyView.valueLabel.text = [NSString stringWithFormat:@"%d亿", scale];
        }
        else
        {
            CGFloat dScale = moneyNum / 10000.0;
            int remain2 = remain % 1000;
            if (remain2 == 0)
            {
                _moneyView.valueLabel.text = [NSString stringWithFormat:@"%.1f亿", dScale];
            }
            else
            {
               _moneyView.valueLabel.text = [NSString stringWithFormat:@"%.2f亿", dScale];
            }
        }
    }
    else
    {
        _moneyView.valueLabel.text = [NSString stringWithFormat:@"%.1f万", self.BenefitModel.money];
    }

    
    
    _profitView.titleLabel.text = @"收益";
    _profitView.valueLabel.text =[NSString stringWithFormat:@"%.1f%%",self.BenefitModel.profit];
    
    
    
}
- (CGFloat) itemViewWidth
{
    return ([self cellWidth] - ITEMVIEW_MARGIN * 2 - kMiddleMargin - PROCESS_WIDTH) / 3 ;
}
- (CGFloat) cellWidth
{
    return kScreenWidth - 2 * kDefaultMargin;
}
@end
