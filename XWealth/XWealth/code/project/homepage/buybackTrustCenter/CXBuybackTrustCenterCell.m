//
//  CXBuybackTrustCenterCell.m
//  XWealth
//
//  Created by gsycf on 15/10/30.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXBuybackTrustCenterCell.h"
#define ITEMVIEW_HEIGHT     (45.0)//(20 + kLabelHeight)
#define PROCESS_WIDTH       (68.0f)
#define ITEMVIEW_MARGIN     (2.0f)
@implementation CXBuybackTrustCenterCell

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
    
    _cellView = [[UIView alloc] initWithFrame:CGRectZero];
    _cellView.backgroundColor = [UIColor clearColor];
    [self addSubview:_cellView];
    
    _backIma=[[UIImageView alloc]initWithFrame:CGRectZero];
    _backIma.image=[UIImage imageNamed:@"buy_back"];
    [_cellView addSubview:_backIma];
    
//    _upLine = [[UIView alloc] initWithFrame:CGRectZero];
//    _upLine.backgroundColor = kOrangeColor;
//    [_cellView addSubview:_upLine];
    
    // 内容
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.font = kMiddleTextFont;
    _titleLabel.textColor = kTitleTextColor;
    _titleLabel.numberOfLines = 1;
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.backgroundColor = [UIColor clearColor];
    [_cellView addSubview:_titleLabel];
    
    _identificationImage=[[UIImageView alloc]initWithFrame:CGRectZero];
    _identificationImage.image=[UIImage imageNamed:@"buy_marker"];
    [_cellView addSubview:_identificationImage];
    
    _profitView = [[CXProductItemView alloc] initWithFrame:CGRectZero];
    [_cellView addSubview:_profitView];
    
    _deadlineView = [[CXProductItemView alloc] initWithFrame:CGRectZero];
    [_cellView addSubview:_deadlineView];
    
    _investTypeView = [[CXProductItemView alloc] initWithFrame:CGRectZero];
    [_cellView addSubview:_investTypeView];

    
//    _deadlineLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//    _deadlineLabel.font = kSmallTextFont;
//    _deadlineLabel.textColor = kTextColor;
//    _deadlineLabel.numberOfLines = 1;
//    _deadlineLabel.textAlignment = NSTextAlignmentRight;
//    _deadlineLabel.backgroundColor = [UIColor clearColor];
//    [_cellView addSubview:_deadlineLabel];
//    
//    _deadlineValueLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//    _deadlineValueLabel.font = kMiddleTextFont;
//    _deadlineValueLabel.textColor = kTextColor;
//    _deadlineValueLabel.numberOfLines = 1;
//    _deadlineValueLabel.textAlignment = NSTextAlignmentLeft;
//    _deadlineValueLabel.backgroundColor = [UIColor clearColor];
//    [_cellView addSubview:_deadlineValueLabel];
//
//    
//    
//
//    
//    _profitLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//    _profitLabel.font = kSmallTextFont;
//    _profitLabel.textColor = kAssistTextColor;
//    _profitLabel.numberOfLines = 1;
//    _profitLabel.textAlignment = NSTextAlignmentLeft;
//    _profitLabel.backgroundColor = [UIColor clearColor];
//    [_cellView addSubview:_profitLabel];
//    
//    _investTypeLable = [[UILabel alloc] initWithFrame:CGRectZero];
//    _investTypeLable.font = kSmallTextFont;
//    _investTypeLable.textColor = kAssistTextColor;
//    _investTypeLable.numberOfLines = 1;
//    _investTypeLable.textAlignment = NSTextAlignmentLeft;
//    _investTypeLable.backgroundColor = [UIColor clearColor];
//    [_cellView addSubview:_investTypeLable];
    
    
   
    
}
-(void)setBuyBackModel:(CXBuyBackModel *)buyBackModel
{
    _buyBackModel = buyBackModel;
    _layout = [[CXBuybackTrustCenterCellFrame alloc] initWithDataModel:buyBackModel];
    
    _cellView.frame=[_layout cellViewRect];
    _backIma.frame=[_layout backImaRect];
    //标题名称
    _titleLabel.frame=[_layout titleRect];
    _identificationImage.frame=[_layout identificationRect];
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
    
    _titleLabel.text = [NSString stringWithFormat:@"%@求购%@%@",[CXTextFildSet getMoneyUnit:_buyBackModel.money],productMoneyType,categoryType];
    
    
    
    
    if (_firstGoalBar != nil)
    {
        [_firstGoalBar removeFromSuperview];
    }
    CGFloat purchase = (CGFloat)_buyBackModel.receipts *100 / _buyBackModel.money;
    
    _firstGoalBar = [[KDGoalSimpleBar alloc] initWithFrame:[_layout firstGoalBarRect]];
    
    [_firstGoalBar setAllowDragging:NO];
    [_firstGoalBar setAllowSwitching:NO];
    
    [_firstGoalBar setPercent:purchase andTitle:@"" andFail:@"" animated:NO];
    [_firstGoalBar setPercentLabFont:16.0f];
    [_firstGoalBar setBarColor:kOrangeColor];
    [self addSubview:_firstGoalBar];
    
    
    _profitView.frame=[_layout profitRect];
    _profitView.titleLabel.text=@"收购需求";
    
    NSString *profitStr=[NSString stringWithFormat:@"%.1f%%",_buyBackModel.profit];
    NSRange profitRangecash = [profitStr rangeOfString:[NSString stringWithFormat:@"%.1f",_buyBackModel.profit]];
    NSMutableAttributedString *profitMutableStr = [[NSMutableAttributedString alloc] initWithString:profitStr];
    [profitMutableStr addAttribute:NSForegroundColorAttributeName value:kOrangeColor range:profitRangecash];
    _profitView.valueLabel.attributedText = profitMutableStr;
    
    
    _deadlineView.frame=[_layout deadlineRect];
    _deadlineView.titleLabel.text=@"投资期限";
    int deadlineInt=self.buyBackModel.deadline;
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
    
    _investTypeView.frame=[_layout investTypeRect];
    _investTypeView.titleLabel.text=@"资金投向";
    _investTypeView.valueLabel.text = [NSString stringWithFormat:@"%@",productMoneyType];
//

    
//    _upLine.frame=[_layout upLineRect];
    if (_downLine!=nil) {
        [_downLine removeFromSuperview];
       
    }
    if (_commentLabel!=nil) {
        [_commentLabel removeFromSuperview];
    }
    if (![self.buyBackModel.comment isEqualToString:@""]&&self.buyBackModel.comment!=nil)
    {
        _downLine = [[UIView alloc] initWithFrame:CGRectZero];
        _downLine.backgroundColor = kLineColor;
        [_cellView addSubview:_downLine];
        
        _commentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _commentLabel.font = kSmallTextFont;
        _commentLabel.textColor = kTextColor;
        _commentLabel.numberOfLines = 2;
        _commentLabel.textAlignment = NSTextAlignmentLeft;
        _commentLabel.backgroundColor = [UIColor clearColor];
        [_cellView addSubview:_commentLabel];

        _downLine.frame=[_layout downLineRect];
        
        _commentLabel.frame = [_layout commentLabelRect];
        NSString *comment = [NSString stringWithFormat:@"点评：%@", self.buyBackModel.comment];
        _commentLabel.text = comment;

    }
    
    
    
    
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
