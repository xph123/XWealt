//
//  CXProductCell.m
//  XWealth
//
//  Created by chx on 15-3-4.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXProductCell.h"

@implementation CXProductCell

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
    _backImage=[[UIImageView alloc]initWithFrame:CGRectZero];
    [_cellView addSubview:_backImage];
    [self addSubview:_cellView];
    
    _stateImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _stateImageView.contentMode = UIViewContentModeScaleAspectFill;
    _stateImageView.clipsToBounds  = YES;
    [_cellView addSubview:_stateImageView];
    
    // 内容
    _titlelabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titlelabel.font = kMiddleTextFont;
    _titlelabel.textColor = kTitleTextColor;
    _titlelabel.numberOfLines = 1;
    _titlelabel.textAlignment = NSTextAlignmentLeft;
    _titlelabel.backgroundColor = [UIColor clearColor];
    [_cellView addSubview:_titlelabel];

//    _bankLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//    _bankLabel.font = kMiddleTextFont;
//    _bankLabel.textColor = kTextColor;
//    _bankLabel.numberOfLines = 1;
//    _bankLabel.textAlignment = NSTextAlignmentLeft;
//    _bankLabel.backgroundColor = [UIColor clearColor];
//    [_cellView addSubview:_bankLabel];
    
    
    _categoryView = [[CXProductItemView alloc] initWithFrame:CGRectZero];
    [_cellView addSubview:_categoryView];
    
    _deadlineView = [[CXProductItemView alloc] initWithFrame:CGRectZero];
    [_cellView addSubview:_deadlineView];
    
    _profitView = [[CXProductItemView alloc] initWithFrame:CGRectZero];
    [_cellView addSubview:_profitView];
    
//    _moneyToLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//    _moneyToLabel.font = kSmallTextFont;
//    _moneyToLabel.textColor = kTextColor;
//    _moneyToLabel.numberOfLines = 2;
//    _moneyToLabel.textAlignment = NSTextAlignmentLeft;
//    _moneyToLabel.backgroundColor = [UIColor clearColor];
//    [_cellView addSubview:_moneyToLabel];

    
//    _verticalLine1 = [[UIView alloc] initWithFrame:CGRectZero];
//    _verticalLine1.backgroundColor = kLineColor;
//    [_cellView addSubview:_verticalLine1];
//    
//    _verticalLine2 = [[UIView alloc] initWithFrame:CGRectZero];
//    _verticalLine2.backgroundColor = kLineColor;
//    [_cellView addSubview:_verticalLine2];

    
//    _horizoncalLine1 = [[UIView alloc] initWithFrame:CGRectZero];
//    _horizoncalLine1.backgroundColor = kLineColor;
//    [_cellView addSubview:_horizoncalLine1];
    
    _horizoncalLine2 = [[UIView alloc] initWithFrame:CGRectZero];
    _horizoncalLine2.backgroundColor = kLineColor;
    [_cellView addSubview:_horizoncalLine2];
    
    _commentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _commentLabel.font = kSmallTextFont;
    _commentLabel.textColor = kTextColor;
    _commentLabel.numberOfLines = 2;
    _commentLabel.textAlignment = NSTextAlignmentLeft;
    _commentLabel.backgroundColor = [UIColor clearColor];
    [_cellView addSubview:_commentLabel];
    
//    _lineView = [[UIView alloc] initWithFrame:CGRectZero];
//    _lineView.backgroundColor = kLineColor;
//    [_cellView addSubview:_lineView];
    
}
//动态设置高度
- (void)setSProductModel:(CXProductSimplyModel *)sProductModel
{
    _sProductModel = sProductModel;
    _layout = [[CXProductCellFrame alloc] initWithDataModel:_sProductModel];
    
    _cellView.frame = [_layout cellViewRect];
    //添加背景图片
    CGFloat top = 25; // 顶端盖高度
    CGFloat bottom = 25 ; // 底端盖高度
    CGFloat left = 10; // 左端盖宽度
    CGFloat right = 10; // 右端盖宽度
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    UIImage *backIma=[UIImage imageNamed:@"product_cell"];
    UIImage *back2Ima=[backIma resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    
    _backImage.image=back2Ima;
    _backImage.frame=CGRectMake(-4, 0, _cellView.frame.size.width+8, _cellView.frame.size.height+4);
    //_backImage.layer.borderWidth=1.0f;
    _stateImageView.frame = [_layout stateImageViewRect];
    
    // 根据state 的值来定哪张图片
    switch (self.sProductModel.state) {
        case 8:
            [_stateImageView setImage:IMAGE(@"hot_sale")];
            _stateImageView.hidden = NO;
            break;
        case 11:
            [_stateImageView setImage:IMAGE(@"baoxiao")];
            _stateImageView.hidden = NO;
            break;
        case 15:
            [_stateImageView setImage:IMAGE(@"zongbao")];
            _stateImageView.hidden = NO;
            break;
        default:
            _stateImageView.hidden = YES;
            break;
    }
    
    _titlelabel.frame = [_layout titlelabelRect];
    _titlelabel.text = self.sProductModel.title;
    
    if (_RoundIma != nil)
    {
        [_RoundIma removeFromSuperview];
    }
    if (_firstGoalBar != nil)
    {
        [_firstGoalBar removeFromSuperview];
    }
    
    // 根据state 的值来定哪张图片
    switch (self.sProductModel.state) {
        case 2:
            _RoundIma=[[UIImageView alloc]initWithFrame:[_layout ProgressImageRect]];
            _RoundIma.image=[UIImage imageNamed:@"product_end"];
            [self addSubview:_RoundIma];
            break;
        case 5:
            _RoundIma=[[UIImageView alloc]initWithFrame:[_layout ProgressImageRect]];
            _RoundIma.image=[UIImage imageNamed:@"product_booking"];
            [self addSubview:_RoundIma];
            break;
        default:
        {
            CGFloat purchase = (CGFloat)self.sProductModel.receipts * 100 / self.sProductModel.scale;
            
            _firstGoalBar = [[KDGoalSimpleBar alloc] initWithFrame:[_layout ProgressImageRect]];
            
            [_firstGoalBar setAllowDragging:NO];
            [_firstGoalBar setAllowSwitching:NO];
            
            [_firstGoalBar setPercent:purchase andTitle:@"" andFail:@"" animated:NO];
            
            [self addSubview:_firstGoalBar];
        }
            
            break;
    }


    
    _categoryView.frame = [_layout categoryViewRect];
    _categoryView.titleLabel.text = @"产品类型";
    _categoryView.valueLabel.text = [self getCategoryDesc:self.sProductModel.category];
    
    _deadlineView.frame = [_layout deadlineViewRect];
    _deadlineView.titleLabel.text = @"产品期限";
    if (![self.sProductModel.fullDeadline isEmpty]) {
         _deadlineView.valueLabel.text = self.sProductModel.fullDeadline;
    }
    else
    {
        int deadlineInt=[self.sProductModel.deadline intValue];
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
    }


    
    NSString *profit = @"浮收";
    if (![self.sProductModel.fullProfit isEmpty])
    {
        profit = self.sProductModel.fullProfit;
    }
    else
    {
        if (![self.sProductModel.profit isEmpty])
        {
        profit = [NSString stringWithFormat:@"%@%@", self.sProductModel.profit, @"%"];
        }
    }
    
    _profitView.frame = [_layout profitViewRect];
    _profitView.titleLabel.text = @"预期收益";
    _profitView.valueLabel.text = profit;
    if (self.sProductModel.state == 2)
    {
        _profitView.valueLabel.textColor = kTextColor;
    }
    else
    {
         _profitView.valueLabel.textColor = kRedColor;
    }

    
//    _moneyToLabel.frame = [_layout moneyToLabelRect];
//    _moneyToLabel.text = [NSString stringWithFormat:@"%@:%@", @"资金投向", self.sProductModel.moneyInto];
    
    _commentLabel.frame = [_layout commentLabelRect];
    NSString *comment = [NSString stringWithFormat:@"点评：%@", self.sProductModel.comment];
    _commentLabel.text = comment;
    
//    _verticalLine1.frame = [_layout verticalLine1Rect];
//    _verticalLine2.frame = [_layout verticalLine2Rect];
//    _horizoncalLine1.frame = [_layout horizoncalLine1Rect];
    _horizoncalLine2.frame = [_layout horizoncalLine2Rect];
    
//    _lineView.frame = [_layout lineViewRect];
    
}

- (NSString *) getCategoryDesc:(int)category
{
    NSString *strCategory = @"";

    for (CXCategoryModel *model in kAppDelegate.productCategoryList)
    {
        if (model.Id == category)
        {
            strCategory = model.name;
            break;
        }
    }
    
    return strCategory;
}

@end
