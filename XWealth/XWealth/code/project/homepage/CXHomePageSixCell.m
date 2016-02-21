//
//  CXHomePageSixCell.m
//  XWealth
//
//  Created by gsycf on 15/12/15.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXHomePageSixCell.h"
#define COMMENT_BUTTON_WIDTH  (30.0f)
#define COMMENT_BUTTON_HEIGHT  (20.0f)
@implementation CXHomePageSixCell
- (id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}
- (void) initSubviews
{
    self.backgroundColor = kControlBgColor;
    
    _cellView = [[UIView alloc] initWithFrame:CGRectZero];
    _cellView.backgroundColor = kControlBgColor;
    [self addSubview:_cellView];
    
    _backView = [[UIView alloc] initWithFrame:CGRectZero];
    _backView.backgroundColor = [UIColor whiteColor];
     [_cellView addSubview:_backView];
    
    // 内容
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _nameLabel.font = kMiddleTextFont;
    _nameLabel.textColor = kTitleTextColor;
    _nameLabel.numberOfLines = 1;
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    _nameLabel.backgroundColor = [UIColor clearColor];
    [_backView addSubview:_nameLabel];
    
    
    _centreLine=[[UIView alloc]initWithFrame:CGRectZero];
    _centreLine.backgroundColor=kGrayColor;
    [_backView addSubview:_centreLine];
    
    _profitView = [[CXProductItemView alloc] initWithFrame:CGRectZero];
    [_backView addSubview:_profitView];
    
    _deadlineView = [[UILabel alloc] initWithFrame:CGRectZero];
    _deadlineView.font = kSmallTextFont;
    _deadlineView.textColor = kTextColor;
    _deadlineView.numberOfLines = 1;
    _deadlineView.textAlignment = NSTextAlignmentLeft;
    _deadlineView.backgroundColor = [UIColor clearColor];
    [_backView addSubview:_deadlineView];
    
    _deadlineValueView = [[UILabel alloc] initWithFrame:CGRectZero];
    _deadlineValueView.font = kSmallTextFont;
    _deadlineValueView.textColor = kTextColor;
    _deadlineValueView.numberOfLines = 1;
    _deadlineValueView.textAlignment = NSTextAlignmentRight;
    _deadlineValueView.backgroundColor = [UIColor clearColor];
    [_backView addSubview:_deadlineValueView];
    
    
    _twoLine=[[UIView alloc]initWithFrame:CGRectZero];
    _twoLine.backgroundColor=kGrayColor;
    [_backView addSubview:_twoLine];
    
    _scaleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _scaleLabel.font = kSmallTextFont;
    _scaleLabel.textColor = kTextColor;
    _scaleLabel.numberOfLines = 1;
    _scaleLabel.textAlignment = NSTextAlignmentLeft;
    _scaleLabel.backgroundColor = [UIColor clearColor];
    [_backView addSubview:_scaleLabel];
    
    _scaleValueLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _scaleValueLabel.font = kSmallTextFont;
    _scaleValueLabel.textColor = kTextColor;
    _scaleValueLabel.numberOfLines = 1;
    _scaleValueLabel.textAlignment = NSTextAlignmentRight;
    _scaleValueLabel.backgroundColor = [UIColor clearColor];
    [_backView addSubview:_scaleValueLabel];
    
    _upLine = [[UIView alloc] initWithFrame:CGRectZero];
    _upLine.backgroundColor = kLineColor;
    [_cellView addSubview:_upLine];
    
    
    _downLine = [[UIView alloc] initWithFrame:CGRectZero];
    _downLine.backgroundColor = kLineColor;
    [_cellView addSubview:_downLine];
    
   
    
    
    
}
//动态设置高度
-(void)setXintuoBaoModel:(CXXintuoBaoModel *)xintuoBaoModel
{
    _xintuoBaoModel = xintuoBaoModel;
    _layout = [[CXHomePageSixCellFrame alloc] initWithDataModel:_xintuoBaoModel];
    
    _cellView.frame = [_layout cellViewRect];
    _backView.frame=[_layout backViewRect];
    
    _nameLabel.frame = [_layout nameLabelRect];
    _nameLabel.text = self.xintuoBaoModel.name;
    
    if (_nameTabLabel != nil)
    {
        [_nameTabLabel removeFromSuperview];
    }
    if (_nameTabLabelBackView != nil)
    {
        [_nameTabLabelBackView removeFromSuperview];
    }
    if (self.xintuoBaoModel.isDesc!=nil&&![self.xintuoBaoModel.isDesc isEqualToString:@""]) {
        _nameTabLabelBackView=[[UIView alloc]initWithFrame:CGRectZero];
        _nameTabLabelBackView.backgroundColor=kXintuobaoRedColor;
        _nameTabLabelBackView.frame=[_layout nameTabLabelBackViewRect];
        [_backView addSubview:_nameTabLabelBackView];
        
        _nameTabLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameTabLabel.frame=[_layout nameTabLabelRect];
        _nameTabLabel.text=self.xintuoBaoModel.isDesc;
        _nameTabLabel.font = kSmallTextFont;
        _nameTabLabel.textColor = [UIColor whiteColor];
        _nameTabLabel.numberOfLines = 1;
        _nameTabLabel.textAlignment = NSTextAlignmentCenter;
        _nameTabLabel.backgroundColor = [UIColor clearColor];
        [_nameTabLabelBackView addSubview:_nameTabLabel];
        
        if (self.xintuoBaoModel.flag == 1)
        {
            _nameTabLabelBackView.backgroundColor = kXintuobaoRedColor;
        }
        else
        {
            _nameTabLabelBackView.backgroundColor = kAssistTextColor;
        }
        
        
    }
    
    _centreLine.frame=[_layout centreLineRect];
    
    _profitView.frame=[_layout profitViewRect];
    [_profitView setTitleLabelFrame:CGRectMake(0, 0, [_layout profitViewRect].size.width, 40) andSetTitlefont:kMaxTextFont];
    [_profitView setValueLabelFrame:CGRectMake(0, 40, [_layout profitViewRect].size.width, 10) andSetTitlefont:kExtralSmallTextFont];
    NSString *profit = @"0%";
    if (self.xintuoBaoModel.rate > 0)
    {
        profit = [NSString stringWithFormat:@"%.1f", self.xintuoBaoModel.rate];
    }
    
    _profitView.frame = [_layout profitViewRect];
    _profitView.valueLabel.text = @"年化收益率(%)";
    _profitView.titleLabel.text = profit;
    // 1在售;2预售;3售罄;4冻结;5已回款
    if (self.xintuoBaoModel.flag == 1)
    {
        _profitView.titleLabel.textColor = kRedColor;
    }
    else
    {
        _profitView.titleLabel.textColor = kAssistTextColor;
    }
    
    _deadlineView.frame=[_layout deadlineViewRect];
    _deadlineView.text=@"投资期限";
    
    _deadlineValueView.frame=[_layout deadlineValueViewRect];
    if (self.xintuoBaoModel.term > 0)
    {
        _deadlineValueView.text = [NSString stringWithFormat:@"%d天", self.xintuoBaoModel.term];
    }
    
    
    _twoLine.frame=[_layout twoLineRect];
    
    _scaleLabel.frame=[_layout scaleLabelRect];
    _scaleLabel.text=@"剩余可投";
    
    _scaleValueLabel.frame=[_layout scaleValueLabelRect];
    NSInteger scaleInt=self.xintuoBaoModel.issuance - self.xintuoBaoModel.progress;
    _scaleValueLabel.text=[NSString stringWithFormat:@"%ld元",scaleInt];
    
    
    
    
    
    _upLine.frame=[_layout upLineRect];
    _downLine.frame=[_layout downLineRect];

    
    
    
}

@end
