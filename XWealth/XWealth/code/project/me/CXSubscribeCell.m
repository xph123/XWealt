//
//  CXSubscribeCell.m
//  XWealth
//
//  Created by chx on 15-3-20.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXSubscribeCell.h"
#define ITEMVIEW_HEIGHT     (45.0)//(20 + kLabelHeight)
#define PROCESS_WIDTH       (68.0f)
#define ITEMVIEW_MARGIN     (2.0f)

@implementation CXSubscribeCell

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
    
    _cellView = [[UIView alloc] initWithFrame:CGRectMake(kDefaultMargin, 0, cellWidth, kSubscribeCellHeight-5)];
    _cellView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_cellView];
    
    // 内容
    _titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin, 0, cellWidth - 2 * kDefaultMargin, kTwoLineLabelHeight)];
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
    
    
    _moneyView = [[CXProductItemView alloc] initWithFrame:CGRectMake(kDefaultMargin, kTwoLineLabelHeight, [self cellWidth]/3, ITEMVIEW_HEIGHT)];
    [_cellView addSubview:_moneyView];
    
    CGFloat scaleViewX = _moneyView.frame.origin.x+[self cellWidth]/3;
    _verticalLine1 = [[UIView alloc] initWithFrame:CGRectMake(scaleViewX, kTwoLineLabelHeight + kDefaultMargin, 0.5, ITEMVIEW_HEIGHT-2*kDefaultMargin)];
    _verticalLine1.backgroundColor = kLineColor;
    [_cellView addSubview:_verticalLine1];
    
    
    _nameView = [[CXProductItemView alloc] initWithFrame:CGRectMake(scaleViewX, kTwoLineLabelHeight, [self cellWidth]/3, ITEMVIEW_HEIGHT)];
    [_cellView addSubview:_nameView];
    
    
    CGFloat deadlineViewX =_nameView.frame.origin.x+[self cellWidth]/3;
    _verticalLine2 = [[UIView alloc] initWithFrame:CGRectMake(deadlineViewX, kTwoLineLabelHeight + kDefaultMargin, 0.5, ITEMVIEW_HEIGHT-2*kDefaultMargin)];
    _verticalLine2.backgroundColor = kLineColor;
    [_cellView addSubview:_verticalLine2];
    
    
    _paymentView = [[CXProductItemView alloc] initWithFrame:CGRectMake(deadlineViewX, kTwoLineLabelHeight, [self cellWidth]/3, ITEMVIEW_HEIGHT)];
    [_cellView addSubview:_paymentView];
    
    
    
    
    _horizoncalLine2 = [[UIView alloc] initWithFrame:CGRectMake(0, kTwoLineLabelHeight + ITEMVIEW_HEIGHT, cellWidth, 0.5)];
    _horizoncalLine2.backgroundColor = kLineColor;
    [_cellView addSubview:_horizoncalLine2];

    
    
    
    _statelabel = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin, kTwoLineLabelHeight + ITEMVIEW_HEIGHT, cellWidth/2-kDefaultMargin, kLabelHeight)];
    _statelabel.font = kMiddleTextFont;
    _statelabel.textColor = kTextColor;
    _statelabel.numberOfLines = 1;
    _statelabel.textAlignment = NSTextAlignmentLeft;
    _statelabel.backgroundColor = [UIColor clearColor];
    [_cellView addSubview:_statelabel];

    
    
    _datelineLabel = [[UILabel alloc] initWithFrame:CGRectMake(cellWidth/2+kDefaultMargin, kTwoLineLabelHeight + ITEMVIEW_HEIGHT, cellWidth/2-2*kDefaultMargin, kLabelHeight)];
    _datelineLabel.font = kSmallTextFont;
    _datelineLabel.textColor = kAssistTextColor;
    _datelineLabel.numberOfLines = 1;
    _datelineLabel.textAlignment = NSTextAlignmentRight;
    _datelineLabel.backgroundColor = [UIColor clearColor];
    [_cellView addSubview:_datelineLabel];
}

- (void)setSubscribeModel:(CXSubscribeModel *)subscribeModel
{
    _subscribeModel = subscribeModel;
    
    NSString *title = _subscribeModel.productName;
    
    if ([title isEmpty])
    {
        title = _subscribeModel.requirement;
    }
    _titlelabel.text = title;
    
    _datelineLabel.text = [XDateHelper translateToDisplay: self.subscribeModel.dateline];
    // 发布状态，0 未处理，1 已处理，2 >购买成功 3，未购买 4，已删除
    NSString *stateStr = @"";
    if (_subscribeModel.state == 0)
    {
        stateStr = @"未处理";
        _statelabel.textColor = kRedColor;
    }
    else if (_subscribeModel.state == 1)
    {
        stateStr = @"已处理";
        _statelabel.textColor = [UIColor greenColor];
    }
    else if (_subscribeModel.state == 2)
    {
        stateStr = @"购买成功";
        _statelabel.textColor = [UIColor greenColor];
    }
    else if (_subscribeModel.state == 3)
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
    
    NSArray *timeArray = [[NSArray alloc] initWithObjects:@"随时", @"三天内", @"三天以上", nil];
    
    
    _moneyView.titleLabel.text = @"金额";
    _moneyView.valueLabel.text = [NSString stringWithFormat:@"%0.f万",self.subscribeModel.money];
    
    _nameView.titleLabel.text = @"姓名";
    _nameView.valueLabel.text = self.subscribeModel.name;
    
    _paymentView.titleLabel.text = @"时间";
    _paymentView.valueLabel.text =[NSString stringWithFormat:@"%@",[timeArray objectAtIndex:self.subscribeModel.payment ]] ;


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
