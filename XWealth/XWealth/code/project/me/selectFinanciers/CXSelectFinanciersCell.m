//
//  CXSelectFinanciersCell.m
//  XWealth
//
//  Created by gsycf on 15/12/3.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXSelectFinanciersCell.h"

@implementation CXSelectFinanciersCell

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
    
    _imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _imgView.contentMode = UIViewContentModeScaleAspectFill;
    _imgView.clipsToBounds  = YES;
    _imgView.layer.cornerRadius=30.0f;
    _imgView.backgroundColor=[UIColor clearColor];
    //_imgView.layer.cornerRadius = kRadius;
    [_cellView addSubview:_imgView];
    
    // 内容
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _nameLabel.font = kMiddleTextFont;
    _nameLabel.textColor = kTitleTextColor;
    _nameLabel.numberOfLines = 2;
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    _nameLabel.backgroundColor = [UIColor clearColor];
    [_cellView addSubview:_nameLabel];
    
    
//    _authenticationLabel=[[UILabel alloc]initWithFrame:CGRectZero];
//    _authenticationLabel.layer.borderWidth=0.5;
//    _authenticationLabel.layer.borderColor=kBlueColor.CGColor;
//    _authenticationLabel.clipsToBounds=YES;
//    _authenticationLabel.backgroundColor=kBlueColor;
//    _authenticationLabel.layer.cornerRadius=7.0f;
//    _authenticationLabel.textColor=kGrayTextColor;
//    _authenticationLabel.text=@"认证";
//    _authenticationLabel.font=[UIFont systemFontOfSize:10];
//    _authenticationLabel.textAlignment=NSTextAlignmentCenter;
//    [_cellView addSubview:_authenticationLabel];
    
//    _tradeLabel=[[UILabel alloc]initWithFrame:CGRectZero];
//    _tradeLabel.layer.borderWidth=0.5;
//    _tradeLabel.layer.borderColor=kxintuoOrangeColor.CGColor;
//    _tradeLabel.backgroundColor=kxintuoOrangeColor;
//    _tradeLabel.clipsToBounds=YES;
//    _tradeLabel.layer.cornerRadius=7.0f;
//    _tradeLabel.textColor=kGrayTextColor;
//    _tradeLabel.text=@"出单";
//    _tradeLabel.font=[UIFont systemFontOfSize:10];
//    _tradeLabel.textAlignment=NSTextAlignmentCenter;
//    [_cellView addSubview:_tradeLabel];
    
    
    _specialtyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _specialtyLabel.font = kSmallTextFont;
    _specialtyLabel.textColor = kTextColor;
    _specialtyLabel.numberOfLines = 1;
    _specialtyLabel.textAlignment = NSTextAlignmentLeft;
    _specialtyLabel.backgroundColor = [UIColor clearColor];
    [_cellView addSubview:_specialtyLabel];
    
    _recordLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _recordLabel.font = kSmallTextFont;
    _recordLabel.textColor = kTextColor;
    _recordLabel.numberOfLines = 1;
    _recordLabel.textAlignment = NSTextAlignmentLeft;
    _recordLabel.backgroundColor = [UIColor clearColor];
    [_cellView addSubview:_recordLabel];
    
    _serviceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _serviceLabel.font = kSmallTextFont;
    _serviceLabel.textColor = kAssistTextColor;
    _serviceLabel.numberOfLines = 1;
    _serviceLabel.textAlignment = NSTextAlignmentLeft;
    _serviceLabel.backgroundColor = [UIColor clearColor];
    [_cellView addSubview:_serviceLabel];
    
    _moneyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _moneyLabel.font = kSmallTextFont;
    _moneyLabel.textColor = kAssistTextColor;
    _moneyLabel.numberOfLines = 1;
    _moneyLabel.textAlignment = NSTextAlignmentLeft;
    _moneyLabel.backgroundColor = [UIColor clearColor];
    [_cellView addSubview:_moneyLabel];
    
    _numberLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _numberLabel.font = kSmallTextFont;
    _numberLabel.textColor = kAssistTextColor;
    _numberLabel.numberOfLines = 1;
    _numberLabel.textAlignment = NSTextAlignmentLeft;
    _numberLabel.backgroundColor = [UIColor clearColor];
    [_cellView addSubview:_numberLabel];

    
    
    
    
    _lineView = [[UIView alloc] initWithFrame:CGRectZero];
    _lineView.backgroundColor = kLineColor;
    [_cellView addSubview:_lineView];
    
}
-(void)setFinanciersModel:(CXFinanciersModel *)financiersModel
{
    _financiersModel = financiersModel;
    _layout = [[CXSelectFinanciersCellFrame alloc] initWithDataModel:_financiersModel];
    
    _cellView.frame = [_layout cellViewRect];
    
    _imgView.frame = [_layout imageViewRect];
    NSLog(@"%@",[CXURLConstants getFullSltHeaderUrl: self.financiersModel.headImg]);
    [_imgView setImageWithURL:[NSURL URLWithString:[CXURLConstants getFullSltHeaderUrl: self.financiersModel.headImg]]
                   placeholderImage:[UIImage imageNamed:@"head_default"]];
    
    _nameLabel.frame = [_layout nameRect];
    _nameLabel.text = self.financiersModel.name;
    
    if (_authenticationLabel!=nil) {
        [_authenticationLabel removeFromSuperview];
    }
    if (_tradeLabel!=nil) {
        [_tradeLabel removeFromSuperview];
    }
    if (self.financiersModel.state==2&&self.financiersModel.orderCount!=0) {
        _authenticationLabel=[[UILabel alloc]initWithFrame:[_layout authenticationRect]];
        _authenticationLabel.layer.borderWidth=0.5;
        _authenticationLabel.layer.borderColor=kBlueColor.CGColor;
        _authenticationLabel.clipsToBounds=YES;
        _authenticationLabel.backgroundColor=kBlueColor;
        _authenticationLabel.layer.cornerRadius=7.0f;
        _authenticationLabel.textColor=kGrayTextColor;
        _authenticationLabel.text=@"认证";
        _authenticationLabel.font=[UIFont systemFontOfSize:10];
        _authenticationLabel.textAlignment=NSTextAlignmentCenter;
        [_cellView addSubview:_authenticationLabel];
        
        _tradeLabel=[[UILabel alloc]initWithFrame:[_layout tradeRect]];
        _tradeLabel.layer.borderWidth=0.5;
        _tradeLabel.layer.borderColor=kxintuoOrangeColor.CGColor;
        _tradeLabel.backgroundColor=kxintuoOrangeColor;
        _tradeLabel.clipsToBounds=YES;
        _tradeLabel.layer.cornerRadius=7.0f;
        _tradeLabel.textColor=kGrayTextColor;
        _tradeLabel.text=@"出单";
        _tradeLabel.font=[UIFont systemFontOfSize:10];
        _tradeLabel.textAlignment=NSTextAlignmentCenter;
        [_cellView addSubview:_tradeLabel];

    }
    else if (self.financiersModel.state==2)
    {
        _authenticationLabel=[[UILabel alloc]initWithFrame:[_layout authenticationRect]];
        _authenticationLabel.layer.borderWidth=0.5;
        _authenticationLabel.layer.borderColor=kBlueColor.CGColor;
        _authenticationLabel.clipsToBounds=YES;
        _authenticationLabel.backgroundColor=kBlueColor;
        _authenticationLabel.layer.cornerRadius=7.0f;
        _authenticationLabel.textColor=kGrayTextColor;
        _authenticationLabel.text=@"认证";
        _authenticationLabel.font=[UIFont systemFontOfSize:10];
        _authenticationLabel.textAlignment=NSTextAlignmentCenter;
        [_cellView addSubview:_authenticationLabel];
    }
    else if (self.financiersModel.orderCount!=0)
    {
        _tradeLabel=[[UILabel alloc]initWithFrame:[_layout authenticationRect]];
        _tradeLabel.layer.borderWidth=0.5;
        _tradeLabel.layer.borderColor=kxintuoOrangeColor.CGColor;
        _tradeLabel.backgroundColor=kxintuoOrangeColor;
        _tradeLabel.clipsToBounds=YES;
        _tradeLabel.layer.cornerRadius=7.0f;
        _tradeLabel.textColor=kGrayTextColor;
        _tradeLabel.text=@"出单";
        _tradeLabel.font=[UIFont systemFontOfSize:10];
        _tradeLabel.textAlignment=NSTextAlignmentCenter;
        [_cellView addSubview:_tradeLabel];

    }
        _nameLabel.frame = [_layout nameRect];
    _nameLabel.text = self.financiersModel.name;
    
    _specialtyLabel.frame = [_layout specialtyRect];
    _specialtyLabel.text = [NSString stringWithFormat:@"专长：%@",self.financiersModel.special];
    
    _recordLabel.frame = [_layout recordRect];
    _recordLabel.text = [NSString stringWithFormat:@"履历：%@",self.financiersModel.record];
    
    _serviceLabel.frame = [_layout serviceRect];
    _serviceLabel.text =[NSString stringWithFormat:@"服务过：%d名客户",self.financiersModel.clientCount];
    
    _moneyLabel.frame = [_layout moneyRect];
    _moneyLabel.text =[NSString stringWithFormat:@"成交金额：%d",self.financiersModel.moneyCount];
    
    _numberLabel.frame = [_layout numberRect];
    _numberLabel.text = [NSString stringWithFormat:@"成交笔数：%d笔",self.financiersModel.orderCount];
    
    _lineView.frame=[_layout lineRect];
    
}

@end
