//
//  CXMyBuybackCell.m
//  XWealth
//
//  Created by gsycf on 15/10/16.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXMyBuybackCell.h"
#define ITEMVIEW_HEIGHT     (45.0)//(20 + kLabelHeight)
#define PROCESS_WIDTH       (68.0f)
#define ITEMVIEW_MARGIN     (2.0f)

@implementation CXMyBuybackCell

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
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.font = kMenuTextFont;
    _titleLabel.textColor = kTitleTextColor;
    _titleLabel.numberOfLines = 1;
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.backgroundColor = [UIColor clearColor];
    [_cellView addSubview:_titleLabel];
    
    _deadlineLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _deadlineLabel.font = kMiddleTextFont;
    _deadlineLabel.textColor = kTitleTextColor;
    _deadlineLabel.numberOfLines = 1;
    _deadlineLabel.textAlignment = NSTextAlignmentLeft;
    _deadlineLabel.backgroundColor = [UIColor clearColor];
    [_cellView addSubview:_deadlineLabel];
    
    _profitLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _profitLabel.font = kMiddleTextFont;
    _profitLabel.textColor = kTitleTextColor;
    _profitLabel.numberOfLines = 1;
    _profitLabel.textAlignment = NSTextAlignmentLeft;
    _profitLabel.backgroundColor = [UIColor clearColor];
    [_cellView addSubview:_profitLabel];
    
    
    
    
    
    _line = [[UIView alloc] initWithFrame:CGRectZero];
    _line.backgroundColor = kLineColor;
    [_cellView addSubview:_line];
    
    _stateLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    _stateLabel.font = kMiddleTextFont;
    _stateLabel.textColor = kTextColor;
    _stateLabel.numberOfLines = 1;
    _stateLabel.textAlignment = NSTextAlignmentLeft;
    _stateLabel.backgroundColor = [UIColor clearColor];
    [_cellView addSubview:_stateLabel];
    
    
    
    _datelineLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _datelineLabel.font = kSmallTextFont;
    _datelineLabel.textColor = kAssistTextColor;
    _datelineLabel.numberOfLines = 1;
    _datelineLabel.textAlignment = NSTextAlignmentRight;
    _datelineLabel.backgroundColor = [UIColor clearColor];
    [_cellView addSubview:_datelineLabel];
}
-(void)setBuyBackModel:(CXBuyBackModel *)buyBackModel
{
    _buyBackModel = buyBackModel;
    _layout = [[CXMyBuybackCellFrame alloc] initWithDataModel:buyBackModel];
    
    _cellView.frame=[_layout cellViewRect];
    
    _titleLabel.frame=[_layout titleRect];
    //资金投向
    NSString *productMoneyType=@"";
    for (int i=0; i<kAppDelegate.productMoneyIntoList.count; i++) {
        CXListInvestCategoryModel *listInvestCategory=[kAppDelegate.productMoneyIntoList objectAtIndex:i];
        
        if (_buyBackModel.investTypeId==listInvestCategory.Id) {
            productMoneyType=[NSString stringWithFormat:@"%@类",listInvestCategory.name];
        }
    }
    //产品类型
    NSString *categoryType=@"信托";
    for (int i=0; i<kAppDelegate.productCategoryList.count; i++) {
        CXCategoryModel *category=[kAppDelegate.productCategoryList objectAtIndex:i];
        if (_buyBackModel.categoryId==category.Id) {
            categoryType=category.name;
        }
    }
    
    NSString *titleStr=[NSString stringWithFormat:@"%@求购%@%@",[CXTextFildSet getMoneyUnit:_buyBackModel.money],productMoneyType,categoryType];
    NSRange rangecash = [titleStr rangeOfString:productMoneyType];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:titleStr];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:rangecash];
    _titleLabel.attributedText = str;
    
    
   
    
    _deadlineLabel.frame=[_layout deadlineRect];
    int deadlineInt=self.buyBackModel.deadline;
    if (deadlineInt >= 12)
    {
        if (deadlineInt % 12 == 0)
        {
            _deadlineLabel.text = [NSString stringWithFormat:@"投资期限: %d年", deadlineInt / 12];
        }
        else
        {
            _deadlineLabel.text = [NSString stringWithFormat:@"投资期限: %d月", deadlineInt];
        }
    }
    else
    {
        _deadlineLabel.text = [NSString stringWithFormat:@"投资期限: %d月", deadlineInt];
    }
   
    _profitLabel.frame=[_layout profitRect];
    _profitLabel.text=[NSString stringWithFormat:@"收益需求: %.1f%%",_buyBackModel.profit];
    
    _line.frame=[_layout lineRect];
    
    _stateLabel.frame=[_layout stateRect];
    // 发布状态，0 等待审核，1 审核通过，2 审核不通过
    NSString *stateStr = @"";
    if (_buyBackModel.state == 0)
    {
        stateStr = @"审核中";
        _stateLabel.textColor = kRedColor;
    }
    else if (_buyBackModel.state == 1)
    {
        stateStr = @"已审核";
        _stateLabel.textColor = [UIColor greenColor];
    }
    else if (_buyBackModel.state == 2)
    {
        stateStr = @"购买成功";
        _stateLabel.textColor = [UIColor greenColor];
    }
    else if (_buyBackModel.state == 3)
    {
        stateStr = @"未购买";
        _stateLabel.textColor = kRedColor;
    }
    else
    {
        stateStr = @"已删除";
        _stateLabel.textColor = kRedColor;
    }
    
    _stateLabel.text = stateStr;
    
    _datelineLabel.frame=[_layout datelineRect];
    _datelineLabel.text = [XDateHelper translateToDisplay: _buyBackModel.dateline];
        
    
    
    
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
