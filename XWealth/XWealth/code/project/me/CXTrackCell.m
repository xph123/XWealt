//
//  CXTrackCell.m
//  XWealth
//
//  Created by gsycf on 15/8/24.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXTrackCell.h"

@implementation CXTrackCell

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
    
    CGFloat cellWidth = kScreenWidth - 2 * kMiddleMargin;
    
    _cellView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _cellView.backgroundColor = [UIColor clearColor];
    [self addSubview:_cellView];
    
    // 内容
    _titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin, kDefaultMargin, cellWidth - 2 * kDefaultMargin-kMessageLeftMargin, kLabelHeight)];
    _titlelabel.font = kMenuTextFont;
    _titlelabel.textColor = kTitleTextColor;
    _titlelabel.numberOfLines = 1;
    _titlelabel.textAlignment = NSTextAlignmentLeft;
    _titlelabel.backgroundColor = [UIColor clearColor];
    [_cellView addSubview:_titlelabel];
    
    
    _rightImage=[[UIImageView alloc]initWithFrame:CGRectMake(cellWidth -  kDefaultMargin-kMessageLeftMargin, kLabelHeight, 25, 25)];
    _rightImage.image=[UIImage imageNamed:@"myTrack_icon"];
    [_cellView addSubview:_rightImage];
    
    _externLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin, _titlelabel.frame.origin.y+_titlelabel.frame.size.height, cellWidth - 2 * kDefaultMargin, kSmallLabelHeight)];
    _externLabel.font = kSmallTextFont;
    _externLabel.textColor = kTextColor;
    _externLabel.numberOfLines = 1;
    _externLabel.textAlignment = NSTextAlignmentLeft;
    _externLabel.backgroundColor = [UIColor clearColor];
    [_cellView addSubview:_externLabel];
    
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin, _externLabel.frame.origin.y+_externLabel.frame.size.height, cellWidth - 2 * kDefaultMargin, kSmallLabelHeight)];
    _contentLabel.font = kSmallTextFont;
    _contentLabel.textColor = kTextColor;
    _contentLabel.numberOfLines = 1;
    _contentLabel.textAlignment = NSTextAlignmentLeft;
    _contentLabel.backgroundColor = [UIColor clearColor];
    [_cellView addSubview:_contentLabel];
    
    
    _payerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _payerLabel.font = kSmallTextFont;
    _payerLabel.textColor = kTextColor;
    _payerLabel.numberOfLines = 1;
    _payerLabel.textAlignment = NSTextAlignmentLeft;
    _payerLabel.backgroundColor = [UIColor clearColor];
    [_cellView addSubview:_payerLabel];
    
    
    _statelabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _statelabel.font = kSmallTextFont;
    _statelabel.textColor = kTextColor;
    _statelabel.numberOfLines = 1;
    _statelabel.textAlignment = NSTextAlignmentLeft;
    _statelabel.backgroundColor = [UIColor clearColor];
    [_cellView addSubview:_statelabel];
    
    
    
    _datelineLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _datelineLabel.font = kExtralSmallTextFont;
    _datelineLabel.textColor = kAssistTextColor;
    _datelineLabel.numberOfLines = 1;
    _datelineLabel.textAlignment = NSTextAlignmentLeft;
    _datelineLabel.backgroundColor = [UIColor clearColor];
    [_cellView addSubview:_datelineLabel];
    
    
    
    
}
-(void)setTrackModel:(CXTrackModel *)trackModel
{
    _trackModel = trackModel;
     _layout = [[CXTrackCellFrame alloc] initWithDataModel:trackModel];
    _cellView.frame = [_layout cellViewRect];
    //添加背景图片
    CGFloat top = 25; // 顶端盖高度
    CGFloat bottom = 25 ; // 底端盖高度
    CGFloat left = 10; // 左端盖宽度
    CGFloat right = 10; // 右端盖宽度
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    UIImage *backIma=[UIImage imageNamed:@"myTrack_back"];
    UIImage *back2Ima=[backIma resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    _cellView.image=back2Ima;
                       
     _payerLabel.frame = [_layout payerLabelRect];
    _statelabel.frame = [_layout statelabelRect];
    _datelineLabel.frame = [_layout datelineLabelRect];
    
    
    _titlelabel.text = _trackModel.name;
    NSLog(@"%@",self.trackModel.dateline);

    _datelineLabel.text = [NSString stringWithFormat:@"创建日期：%@",[XDateHelper translateToDisplay: self.trackModel.dateline]];
    
    //0 未到期，1 已到期。 2. 已删除
    NSString *stateStr = @"";
    if (_trackModel.state == 0)
    {
        stateStr = @"未到期";
        _statelabel.textColor = kBlueColor;
    }
    else if (_trackModel.state == 1)
    {
        stateStr = @"已到期";
        _statelabel.textColor = [UIColor greenColor];
    }
    else if (_trackModel.state == 2)
    {
        stateStr = @"已删除";
        _statelabel.textColor = kTextColor;
    }
    
    _statelabel.text = stateStr;
    
    
    NSString *categoryStr;
    if (self.trackModel.category>0) {
        CXCategoryModel *categoryModel = [kAppDelegate.productCategoryList objectAtIndex:self.trackModel.category - 1];
        categoryStr=categoryModel.name;
        
    }
   
    
    if ([_trackModel.payer isEqualToString:@""]) {
         NSString *myPayDate=[_trackModel.payDate substringToIndex:10];
         _externLabel.text = [NSString stringWithFormat:@"认购时间：%@ ",myPayDate];
    }
    else
    {
         NSString *myPayDate=[_trackModel.payDate substringToIndex:10];
        _externLabel.text = [NSString stringWithFormat:@"购买人：%@ | 认购时间：%@ ",_trackModel.payer,myPayDate];
    }
    _contentLabel.text =[NSString stringWithFormat:@"分类：%@ | 金额：%.1f万 | 收益：%.1f%%",categoryStr, _trackModel.amount,_trackModel.profit];

    NSString *payTypeStr=@"";
    if (kAppDelegate.productPayTypeList && kAppDelegate.productPayTypeList.count > 2)
    {
        for (int i = 0; i < kAppDelegate.productPayTypeList.count; i++)
        {
            CXListInvestCategoryModel *ListInvestCategory = [kAppDelegate.productPayTypeList objectAtIndex:i];
            
            if (ListInvestCategory.Id==self.trackModel.payType) {
                payTypeStr=[NSString stringWithFormat:@" %@",ListInvestCategory.name];
            }
            
            
        }
        
    }


    if ([payTypeStr isEqualToString:@""]) {
         _payerLabel.text=[NSString stringWithFormat:@"期限：% d月 ",_trackModel.lockArea];
    }
    else
    {
         _payerLabel.text=[NSString stringWithFormat:@"期限：%d月 | 付息方式: %@",_trackModel.lockArea,payTypeStr];
    }
    
    
    
    if (_lineView!=nil) {
         [_lineView removeFromSuperview];
    }
    if (_remarkLabel!=nil) {
        [_remarkLabel removeFromSuperview];
    }
    if (![_trackModel.remark isEqualToString:@""]) {
       
        _lineView=[[UIImageView alloc]initWithFrame:CGRectZero];
        _lineView.frame=[_layout lineRect];
        _lineView.backgroundColor=kControlBgColor;
        [_cellView addSubview:_lineView];
        
        
        // 说明
        _remarkLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _remarkLabel.font = kSmallTextFont;
        _remarkLabel.textColor = kAssistTextColor;
        _remarkLabel.numberOfLines = 0;
        _remarkLabel.textAlignment = NSTextAlignmentLeft;
        _remarkLabel.backgroundColor = [UIColor clearColor];
        [_cellView addSubview:_remarkLabel];
        _remarkLabel.frame=[_layout remarkLabelRect];
        _remarkLabel.text=_trackModel.remark;
    }
   

    
}

@end
