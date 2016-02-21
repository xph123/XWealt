//
//  CXTrustTransferCenterCell.m
//  XWealth
//
//  Created by gsycf on 15/10/27.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXTrustTransferCenterCell.h"
#define ITEMVIEW_HEIGHT     (45.0)//(20 + kLabelHeight)
#define PROCESS_WIDTH       (68.0f)
#define ITEMVIEW_MARGIN     (2.0f)
#define IMAGE_STATE         (44.0f)
@implementation CXTrustTransferCenterCell
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
    _cellView.backgroundColor = [UIColor clearColor];
    [self addSubview:_cellView];
    
    _backIma=[[UIImageView alloc]initWithFrame:CGRectZero];
    _backIma.image=[UIImage imageNamed:@"trust_back"];
    [_cellView addSubview:_backIma];
    
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
    
    _identificationImage=[[UIImageView alloc]initWithFrame:CGRectZero];
    _identificationImage.image=[UIImage imageNamed:@"trust_marker"];
    [_cellView addSubview:_identificationImage];

    _preProfitLable = [[UILabel alloc] initWithFrame:CGRectZero];
    _preProfitLable.font = kSmallTextFont;
    _preProfitLable.textColor = kTextColor;
    _preProfitLable.numberOfLines = 1;
    _preProfitLable.textAlignment = NSTextAlignmentRight;
    _preProfitLable.backgroundColor = [UIColor clearColor];
    [_cellView addSubview:_preProfitLable];

    _preProfitValueLable = [[UILabel alloc] initWithFrame:CGRectZero];
    _preProfitValueLable.font = kMiddleTextFont;
    _preProfitValueLable.textColor = kTextColor;
    _preProfitValueLable.numberOfLines = 1;
    _preProfitValueLable.textAlignment = NSTextAlignmentLeft;
    _preProfitValueLable.backgroundColor = [UIColor clearColor];
    [_cellView addSubview:_preProfitValueLable];

    
    _profitView = [[CXProductItemView alloc] initWithFrame:CGRectZero];
    [_cellView addSubview:_profitView];


    
    
    _deadlineView = [[CXProductItemView alloc] initWithFrame:CGRectZero];
    [_cellView addSubview:_deadlineView];

    
    _moneyView = [[CXProductItemView alloc] initWithFrame:CGRectZero];
    [_cellView addSubview:_moneyView];
    

    
    _downLine = [[UIView alloc] initWithFrame:CGRectZero];
    _downLine.backgroundColor = kLineColor;
    [_cellView addSubview:_downLine];
    
    
}
-(void)setBenefitModel:(CXBenefitModel *)BenefitModel
{
    _BenefitModel = BenefitModel;
    
    _layout = [[CXTrustTransferCenterCellFrame alloc] initWithDataModel:_BenefitModel];

    
    _cellView.frame = [_layout cellViewRect];
    _backIma.frame=[_layout backImaRect];

    
    _titlelabel.frame = [_layout titleRect];
    
    _identificationImage.frame=[_layout identificationRect];
    
    _preProfitLable.frame =[_layout preProfitRect];
    _preProfitValueLable.frame=[_layout preProfitValueRect];
    _profitView.frame =[_layout profitRect];
    
    _deadlineView.frame = [_layout deadlineRect];
    
    _moneyView.frame =[_layout moneyRect];
    
     _downLine.frame = [_layout downLineRect];
    
    
    
    _stateImageView.frame = [_layout stateImageViewRect];
    
    // 根据state 的值来定哪张图片
    switch (self.BenefitModel.recLevel) {
        case 3:
            [_stateImageView setImage:IMAGE(@"trus_newProduct")];
            _stateImageView.hidden = NO;
            break;
        case 6:
            [_stateImageView setImage:IMAGE(@"trust_recommend")];
            _stateImageView.hidden = NO;
            break;
        default:
            _stateImageView.hidden = YES;
            break;
    }

    //数据
    _titlelabel.text = [NSString stringWithFormat:@"%@",_BenefitModel.name];
    
    _preProfitLable.text=@"年化收益率：";
    NSString *profitStr=[NSString stringWithFormat:@"%.1f%%",self.BenefitModel.profit];
    NSRange profitRangecash = [profitStr rangeOfString:[NSString stringWithFormat:@"%0.1f",self.BenefitModel.profit]];
    NSMutableAttributedString *profitMutableStr = [[NSMutableAttributedString alloc] initWithString:profitStr];
    [profitMutableStr addAttribute:NSForegroundColorAttributeName value:kOrangeColor range:profitRangecash];
    _preProfitValueLable.attributedText = profitMutableStr;
    
    _deadlineView.titleLabel.text = StringProductRemainderDeadline;
    if (self.BenefitModel.days !=0) {
        _deadlineView.valueLabel.text=[NSString stringWithFormat:@"%d天",self.BenefitModel.days];
    }
    else
    {
        _deadlineView.valueLabel.text=[NSString stringWithFormat:@"无"];
    }
    
    _moneyView.titleLabel.text = StringTransferMoney;
    _moneyView.valueLabel.text=[NSString stringWithFormat:@"%@",[CXTextFildSet getMoneyUnit:self.BenefitModel.money]];
    
    
    _profitView.titleLabel.text = @"预计收益";
    _profitView.valueLabel.text =[NSString stringWithFormat:@"%0.2f万",self.BenefitModel.preProfit];

    if (_BenefitModel.state==2) {
        _profitView.valueLabel.textColor=kTextColor;
    }
    else
    {
        _profitView.valueLabel.textColor=kOrangeColor;
    }
    
    
    if (self.typeView!=nil) {
        [self.typeView removeFromSuperview];
    }
    if (_BenefitModel.state==2) {
        _typeView=[[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-IMAGE_STATE-kDefaultMargin, 0, IMAGE_STATE, IMAGE_STATE)];
        _typeView.image=[UIImage imageNamed:@"trust_state"];
        [self addSubview:_typeView];
    }
    if (_downLine!=nil) {
        [_downLine removeFromSuperview];
        
    }
    if (_commentLabel!=nil) {
        [_commentLabel removeFromSuperview];
    }
    if (![self.BenefitModel.comment isEqualToString:@""]&&self.BenefitModel.comment!=nil) {
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
        NSString *comment = [NSString stringWithFormat:@"点评：%@", self.BenefitModel.comment];
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
