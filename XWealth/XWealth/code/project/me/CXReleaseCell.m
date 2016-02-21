//
//  CXReleaseCell.m
//  XWealth
//
//  Created by chx on 15-3-20.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXReleaseCell.h"
#define ITEMVIEW_HEIGHT     (45.0)//(20 + kLabelHeight)
#define PROCESS_WIDTH       (68.0f)
#define ITEMVIEW_MARGIN     (2.0f)


@implementation CXReleaseCell

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
    
    
    _classifyView = [[CXProductItemView alloc] initWithFrame:CGRectMake(kDefaultMargin, [_layout titlelabelHight], [self cellWidth]/3, ITEMVIEW_HEIGHT)];
    [_cellView addSubview:_classifyView];
    
    CGFloat scaleViewX = _classifyView.frame.origin.x+[self cellWidth]/3;
    _verticalLine1 = [[UIView alloc] initWithFrame:CGRectMake(scaleViewX, [_layout titlelabelHight] + kDefaultMargin, 0.5, ITEMVIEW_HEIGHT-2*kDefaultMargin)];
    _verticalLine1.backgroundColor = kLineColor;
    [_cellView addSubview:_verticalLine1];
    
    
    _scaleView = [[CXProductItemView alloc] initWithFrame:CGRectMake(scaleViewX, [_layout titlelabelHight], [self cellWidth]/3, ITEMVIEW_HEIGHT)];
    [_cellView addSubview:_scaleView];

    
    CGFloat deadlineViewX =_scaleView.frame.origin.x+[self cellWidth]/3;
    _verticalLine2 = [[UIView alloc] initWithFrame:CGRectMake(deadlineViewX, [_layout titlelabelHight] + kDefaultMargin, 0.5, ITEMVIEW_HEIGHT-2*kDefaultMargin)];
    _verticalLine2.backgroundColor = kLineColor;
    [_cellView addSubview:_verticalLine2];
    
    
    _deadlineView = [[CXProductItemView alloc] initWithFrame:CGRectMake(deadlineViewX, [_layout titlelabelHight], [self cellWidth]/3, ITEMVIEW_HEIGHT)];
    [_cellView addSubview:_deadlineView];


    
    
    _horizoncalLine2 = [[UIView alloc] initWithFrame:CGRectMake(0, [_layout titlelabelHight] + ITEMVIEW_HEIGHT, cellWidth, 0.5)];
    _horizoncalLine2.backgroundColor = kLineColor;
    [_cellView addSubview:_horizoncalLine2];
    
    _statelabel = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultMargin, [_layout titlelabelHight] + ITEMVIEW_HEIGHT, cellWidth/2 -kDefaultMargin, kLabelHeight)];
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

- (void)setReleaseModel:(CXProductReleaseModel *)releaseModel
{
    _layout = [[CXReleaseCellFrame alloc] initWithDataModel:releaseModel];
   CGFloat cellWidth = kScreenWidth - 2 * kDefaultMargin;
    CGFloat scaleViewX = _classifyView.frame.origin.x+[self cellWidth]/3;
    CGFloat deadlineViewX =_scaleView.frame.origin.x+[self cellWidth]/3;
    _cellView.frame = CGRectMake(kDefaultMargin, 0, cellWidth, [_layout cellHeight]-5);
    _titlelabel.frame = CGRectMake(kDefaultMargin, 0, cellWidth - 2 * kDefaultMargin, [_layout titlelabelHight]);
    _classifyView.frame = CGRectMake(kDefaultMargin, [_layout titlelabelHight], [self cellWidth]/3, ITEMVIEW_HEIGHT);
    _verticalLine1.frame = CGRectMake(scaleViewX, [_layout titlelabelHight] + kDefaultMargin, 0.5, ITEMVIEW_HEIGHT-2*kDefaultMargin);
    _scaleView.frame = CGRectMake(scaleViewX, [_layout titlelabelHight], [self cellWidth]/3, ITEMVIEW_HEIGHT);
    _verticalLine2.frame = CGRectMake(deadlineViewX, [_layout titlelabelHight] + kDefaultMargin, 0.5, ITEMVIEW_HEIGHT-2*kDefaultMargin);
     _deadlineView.frame = CGRectMake(deadlineViewX, [_layout titlelabelHight], [self cellWidth]/3, ITEMVIEW_HEIGHT);
    _horizoncalLine2.frame = CGRectMake(0, [_layout titlelabelHight] + ITEMVIEW_HEIGHT, cellWidth, 0.5);
    _statelabel.frame = CGRectMake(kDefaultMargin, [_layout titlelabelHight] + ITEMVIEW_HEIGHT, cellWidth - 2 * kDefaultMargin - 100, kLabelHeight);
    _datelineLabel.frame =CGRectMake(cellWidth - kDefaultMargin - 100, [_layout titlelabelHight] + ITEMVIEW_HEIGHT, 100, kLabelHeight);

    
    
    _releaseModel = releaseModel;
    
    if ([_releaseModel.name isEqual:@""]) {
       _titlelabel.text = _releaseModel.intro;
    }
    else
    {
        _titlelabel.text = _releaseModel.name;
    }
    
    _datelineLabel.text = [XDateHelper translateToDisplay: self.releaseModel.dateline];
    
    // 发布状态，0 等待审核，1 审核通过，2 审核不通过
    NSString *stateStr = @"";
    if (_releaseModel.state == 1)
    {
        stateStr = @"审核通过";
        _statelabel.textColor = kBlueColor;
    }
    else if (_releaseModel.state == 2)
    {
        stateStr = @"审核不通过";
        _statelabel.textColor = kButtonColor;
    }
    else
    {
        stateStr = @"待审核";
        _statelabel.textColor = kTextColor;
    }
    
    _statelabel.text = stateStr;
    
    NSArray *categoryList = kAppDelegate.productCategoryList;
    
    if (self.releaseModel.category>0) {
        CXCategoryModel *categoryModel = [categoryList objectAtIndex:self.releaseModel.category - 1];
        
        _classifyView.titleLabel.text = @"分类";
        _classifyView.valueLabel.text = categoryModel.name;
        
        _scaleView.titleLabel.text = @"规模";
        
        int moneyNum=[self.releaseModel.scale intValue];
        if (moneyNum >= 10000)
        {
            int remain = moneyNum % 10000;
            if (remain == 0)
            {
                int scale = moneyNum / 10000;
                 _scaleView.valueLabel.text = [NSString stringWithFormat:@"%d亿", scale];
            }
            else
            {
                CGFloat dScale = moneyNum / 10000.0;
                int remain2 = remain % 1000;
                if (remain2 == 0)
                {
                     _scaleView.valueLabel.text = [NSString stringWithFormat:@"%.1f亿", dScale];
                }
                else
                {
                     _scaleView.valueLabel.text = [NSString stringWithFormat:@"%.2f亿", dScale];
                }
            }
        }
        else
        {
             _scaleView.valueLabel.text = [NSString stringWithFormat:@"%@万", self.releaseModel.scale ];
        }
        
        _deadlineView.titleLabel.text = @"期限";
        int deadlineInt=[self.releaseModel.deadline intValue];
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
