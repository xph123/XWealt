//
//  CXProductDetailCell.m
//  XWealth
//
//  Created by chx on 15-3-18.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXProductDetailCell.h"
#import "showImageArr.h"
@implementation CXProductDetailCell

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
    
    _title1View = [[UIView alloc] initWithFrame:CGRectZero];
    _title1View.backgroundColor = [UIColor colorFromHexRGB:@"F7F7F7"];
    [_cellView addSubview:_title1View];
    
    _title1Label = [[UILabel alloc] initWithFrame:CGRectZero];
    _title1Label.font = kMiddleTextFont;
    _title1Label.textColor = kTitleTextColor;
    _title1Label.numberOfLines = 1;
    _title1Label.textAlignment = NSTextAlignmentLeft;
    _title1Label.backgroundColor = [UIColor clearColor];
    [_title1View addSubview:_title1Label];
    
    _value1Label = [[UILabel alloc] initWithFrame:CGRectZero];
    _value1Label.font = kMiddleTextFont;
    _value1Label.textColor = kTextColor;
    _value1Label.numberOfLines = 2;
    _value1Label.textAlignment = NSTextAlignmentLeft;
    _value1Label.backgroundColor = [UIColor clearColor];
    [_cellView addSubview:_value1Label];
    
    

    
    
    
    
    
    _title2View = [[UIView alloc] initWithFrame:CGRectZero];
    _title2View.backgroundColor = kControlBgColor;
    [_cellView addSubview:_title2View];
    
    _title2Label = [[UILabel alloc] initWithFrame:CGRectZero];
    _title2Label.font = kMiddleTextFont;
    _title2Label.textColor = kTitleTextColor;
    _title2Label.numberOfLines = 1;
    _title2Label.textAlignment = NSTextAlignmentLeft;
    _title2Label.backgroundColor = [UIColor clearColor];
    [_title2View addSubview:_title2Label];
    
    _value2Label = [[UILabel alloc] initWithFrame:CGRectZero];
    _value2Label.font = kMiddleTextFont;
    _value2Label.textColor = kTextColor;
    _value2Label.numberOfLines = 2;
    _value2Label.textAlignment = NSTextAlignmentLeft;
    _value2Label.backgroundColor = [UIColor clearColor];
    [_cellView addSubview:_value2Label];

}

-(void) setValue1:(CXTitleValueModel*)value1 andValue2:(CXTitleValueModel*)value2
{
    _firstValueModel = value1;
    _secondValueModel = value2;
    
    int col = 1;
    if (_secondValueModel != nil)
    {
        col = 2;
    }
    
    _layout = [[CXProductDetailCellFrame alloc] initWithDataModel:_firstValueModel andValue2:_secondValueModel andCol:col];
    
    _cellView.frame = [_layout cellRect];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:_firstValueModel.value];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:4];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, _firstValueModel.value.length)];
    
    _value1Label.attributedText = attributedString;
    
    _title1View.frame = [_layout titleView1Rect];
    
    _title1Label.frame = [_layout titleLabel1Rect];
    _title1Label.text = _firstValueModel.title;
    
    _value1Label.frame = [_layout value1Rect];
    _value1Label.attributedText = attributedString;
    
    if (_valueImage != nil)
    {
        [_valueImage removeFromSuperview];
    }
    if (_firstValueModel.imageValue!=nil&&![_firstValueModel.imageValue isEqualToString:@""]) {
        _valueImage=[[UIImageView alloc]initWithFrame:CGRectZero];
        _valueImage.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageClick:)];
       
        _valueImage.frame=[_layout valueImageRect];
        [_valueImage sd_setImageWithURL:[NSURL URLWithString:[CXURLConstants getFullSltInformationUrl: self.firstValueModel.imageValue]] placeholderImage:[UIImage imageNamed:@"defaule_image"]];
        [_valueImage addGestureRecognizer:tap];
         [_cellView addSubview:_valueImage];
    }
    
//    _value1Label.text = _firstValueModel.value;
    if (col == 1)
    {
        _value1Label.numberOfLines = 0;
    }
    
    if (col == 2)
    {
        _title2View.frame = [_layout titleView2Rect];
        _title2Label.frame = [_layout titleLabel2Rect];
        _title2Label.text = _secondValueModel.title;
        _value2Label.frame = [_layout value2Rect];
        _value2Label.text = _secondValueModel.value;
        
        _title2View.hidden = NO;
        _value2Label.hidden = NO;
    }
    else
    {
        _title2View.hidden = YES;
        _value2Label.hidden = YES;
    }
    
}
#pragma mark - imageClick
-(void)imageClick:(UITapGestureRecognizer *)sender
{
    UIImageView *image=(UIImageView *)sender.view;
    showImageArr *showAmage=[[showImageArr alloc]init];
    [showAmage showImageArray:nil andImage:image];
}
@end
