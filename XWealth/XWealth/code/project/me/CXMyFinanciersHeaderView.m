//
//  CXMyFinanciersHeaderView.m
//  XWealth
//
//  Created by gsycf on 15/11/30.
//  Copyright © 2015年 rasc. All rights reserved.
//
#define DOWNBACKVIEW_HIGHT     (90.0f)
#import "CXMyFinanciersHeaderView.h"

@implementation CXMyFinanciersHeaderView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = kControlBgColor;
        self.userInteractionEnabled=YES;
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews
{
    
    _backImageView=[[UIImageView alloc]initWithFrame:[self backImageViewRect]];
    _backImageView.userInteractionEnabled=YES;
    _backImageView.backgroundColor=kControlBgColor;
    [self addSubview:_backImageView];
    
    
    _headBgImageView = [[UIImageView alloc] initWithFrame:[self headBgImageRect]];
    _headBgImageView.contentMode = UIViewContentModeScaleAspectFill;
    _headBgImageView.clipsToBounds=YES;
    [_backImageView addSubview: _headBgImageView];
    
    UIImageView *circleImgView = [[UIImageView alloc] initWithFrame:[self circleImageRect]];
    circleImgView.image = IMAGE(@"me_head_circle");
    //circleImgView.alpha = 0.4;
    [_backImageView addSubview:circleImgView];
    
    
    _headImageView = [[UIImageView alloc] initWithFrame:[self headImageRect]];
   
    _headImageView.layer.cornerRadius = 32;
    _headImageView.layer.masksToBounds = YES;
    [_backImageView addSubview: _headImageView];
    
    _headGradeView=[[UIImageView alloc]initWithFrame:[self headGradeViewRect]];
    _headGradeView.backgroundColor=[UIColor redColor];
    [_backImageView addSubview:_headGradeView];
    
    _praiseBackView=[[UIImageView alloc]initWithFrame:[self praiseBackViewRect]];
    _praiseBackView.backgroundColor=[UIColor blackColor];
    _praiseBackView.alpha=0.5f;
    _praiseBackView.layer.borderColor=[UIColor whiteColor].CGColor;
    _praiseBackView.layer.borderWidth=1.0f;
    _praiseBackView.layer.cornerRadius=10.0f;
    _praiseBackView.clipsToBounds=YES;
    UITapGestureRecognizer *praiseTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(praiseBtnClick)];
    [_praiseBackView addGestureRecognizer:praiseTap];
    _praiseBackView.userInteractionEnabled=YES;
    [_backImageView addSubview:_praiseBackView];
    
    _praiseView=[[UIImageView alloc]initWithFrame:[self praiseViewRect]];
    _praiseView.backgroundColor=[UIColor clearColor];
    _praiseView.image=[UIImage imageNamed:@"list_good"];
    [_backImageView addSubview:_praiseView];
    
    _praiseNumLable=[[UILabel alloc]initWithFrame:[self praiseNumLableRect]];
    _praiseNumLable.font=kSmallTextFont;
    _praiseNumLable.textColor=kGrayTextColor;
    _praiseNumLable.numberOfLines=1;
    _praiseNumLable.textAlignment=NSTextAlignmentLeft;
    _praiseNumLable.backgroundColor=[UIColor clearColor];
    [_backImageView addSubview:_praiseNumLable];
    
    _blackSideView=[[UIImageView alloc]initWithFrame:[self blackSideViewRect]];
    _blackSideView.backgroundColor=[UIColor blackColor];
    _blackSideView.alpha=0.5f;
    [_backImageView addSubview:_blackSideView];
    
    _gradeView=[[UIImageView alloc]initWithFrame:[self gradeViewRect]];
    _gradeView.image=[UIImage imageNamed:@"list_good"];
    _gradeView.backgroundColor=[UIColor clearColor];
    [_backImageView addSubview:_gradeView];
    
    _nameLabel = [[UILabel alloc] initWithFrame:[self nameRect]];
    _nameLabel.font = kSmallTextFont;
    _nameLabel.textColor = kGrayTextColor;
    _nameLabel.numberOfLines = 1;
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.backgroundColor = [UIColor clearColor];
    [_backImageView addSubview:_nameLabel];
    
    
    _authenticationLabel=[[UILabel alloc]initWithFrame:[self authenticationLabelRect]];
    _authenticationLabel.layer.borderWidth=0.5;
    _authenticationLabel.layer.borderColor=kBlueColor.CGColor;
    _authenticationLabel.clipsToBounds=YES;
    _authenticationLabel.backgroundColor=kBlueColor;
    _authenticationLabel.layer.cornerRadius=7.0f;
    _authenticationLabel.textColor=kGrayTextColor;
    _authenticationLabel.font=[UIFont systemFontOfSize:10];
    _authenticationLabel.textAlignment=NSTextAlignmentCenter;
    [_backImageView addSubview:_authenticationLabel];

    _tradeLabel=[[UILabel alloc]initWithFrame:[self tradeLabelRect]];
    _tradeLabel.layer.borderWidth=0.5;
    _tradeLabel.layer.borderColor=kxintuoOrangeColor.CGColor;
    _tradeLabel.backgroundColor=kxintuoOrangeColor;
    _tradeLabel.clipsToBounds=YES;
    _tradeLabel.layer.cornerRadius=7.0f;
    _tradeLabel.textColor=kGrayTextColor;
    _tradeLabel.font=[UIFont systemFontOfSize:10];
    _tradeLabel.textAlignment=NSTextAlignmentCenter;
    [_backImageView addSubview:_tradeLabel];
    
    _distanceLabel = [[UILabel alloc] initWithFrame:[self distanceLabelRect]];
    _distanceLabel.font = kSmallTextFont;
    _distanceLabel.textColor = kGrayTextColor;
    _distanceLabel.numberOfLines = 1;
    _distanceLabel.textAlignment = NSTextAlignmentRight;
    _distanceLabel.backgroundColor = [UIColor clearColor];
    [_backImageView addSubview:_distanceLabel];
    
    //基本信息
    _downbackView=[[UIImageView alloc]initWithFrame:[self downbackViewRect]];
    _downbackView.backgroundColor=[UIColor whiteColor];
    _downbackView.layer.cornerRadius=2.0f;
    [_backImageView addSubview:_downbackView];
    
    _specialtyLabel = [[UILabel alloc] initWithFrame:[self specialtyLabelRect]];
    _specialtyLabel.font = kSmallTextFont;
    _specialtyLabel.textColor = kTextColor;
    _specialtyLabel.numberOfLines = 1;
    _specialtyLabel.textAlignment = NSTextAlignmentLeft;
    _specialtyLabel.backgroundColor = [UIColor clearColor];
    [_downbackView addSubview:_specialtyLabel];

    _recordLabel = [[UILabel alloc] initWithFrame:[self recordLabelRect]];
    _recordLabel.font = kSmallTextFont;
    _recordLabel.textColor = kTextColor;
    _recordLabel.numberOfLines = 1;
    _recordLabel.textAlignment = NSTextAlignmentLeft;
    _recordLabel.backgroundColor = [UIColor clearColor];
    [_downbackView addSubview:_recordLabel];

    _serviceLabel = [[UILabel alloc] initWithFrame:[self serviceLabelRect]];
    _serviceLabel.font = kSmallTextFont;
    _serviceLabel.textColor = kTextColor;
    _serviceLabel.numberOfLines = 1;
    _serviceLabel.textAlignment = NSTextAlignmentLeft;
    _serviceLabel.backgroundColor = [UIColor clearColor];
    [_downbackView addSubview:_serviceLabel];

    _moneyLabel = [[UILabel alloc] initWithFrame:[self moneyLabelRect]];
    _moneyLabel.font = kSmallTextFont;
    _moneyLabel.textColor = kTextColor;
    _moneyLabel.numberOfLines = 1;
    _moneyLabel.textAlignment = NSTextAlignmentLeft;
    _moneyLabel.backgroundColor = [UIColor clearColor];
    [_downbackView addSubview:_moneyLabel];

    _numberLabel = [[UILabel alloc] initWithFrame:[self numberLabelRect]];
    _numberLabel.font = kSmallTextFont;
    _numberLabel.textColor = kTextColor;
    _numberLabel.numberOfLines = 1;
    _numberLabel.textAlignment = NSTextAlignmentLeft;
    _numberLabel.backgroundColor = [UIColor clearColor];
    [_downbackView addSubview:_numberLabel];


}

- (void)setUserModel:(CXUserModel *)userModel
{
    _userModel = userModel;
    if (_userModel.statusBg && _userModel.statusBg.length > 0)
    {
        [_headBgImageView sd_setImageWithURL:[NSURL URLWithString:[CXURLConstants getFullStatusUrl: _userModel.statusBg]]
                         placeholderImage:[UIImage imageNamed:@"me_head_bg"]];
    }
    else
    {
        [_headBgImageView setImage:[UIImage imageNamed:@"me_head_bg"]];
    }
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:[CXURLConstants getFullSltHeaderUrl: _userModel.headImg]]
                   placeholderImage:[UIImage imageNamed:@"head_default"]];
    
    
    if (self.userModel.userId!=0&&self.userModel.userId)
    {
        NSString *userName = [NSString stringWithFormat:@"%@", _userModel.mid];
        _nameLabel.text = userName;
    }
    NSString *praiseNumStr=@"999+";
    NSLog(@"%ld",[praiseNumStr length]);
    _praiseNumLable.text=praiseNumStr;
    CGRect praiseFrame=_praiseBackView.frame;
    praiseFrame.origin.x-=[praiseNumStr length]*10;
    praiseFrame.size.width+=[praiseNumStr length]*10;
    _praiseBackView.frame=praiseFrame;
    
    self.praiseView.frame=[self praiseViewRect];
    self.praiseNumLable.frame=[self praiseNumLableRect];
    
    _authenticationLabel.text=@"认证";
    _tradeLabel.text=@"出单";
    _distanceLabel.text=@"距离：5km";
    _specialtyLabel.text=@"专长：新三板";
    _recordLabel.text=@"履历：从事金融行业15年";
    _serviceLabel.text=@"服务过200名客户";
    _moneyLabel.text=@"成交金额：20亿300万";
    _numberLabel.text=@"成交笔数：300笔";
}


- (void) praiseBtnClick
{
    __unsafe_unretained CXMyFinanciersHeaderView *weak_self = self;
    if (weak_self.praiseBlk) {
        weak_self.praiseBlk();
    }
    
}
#pragma mark -Rect

- (CGRect) backImageViewRect
{
    CGFloat x = 0;
    CGFloat y = 0;
    
    CGFloat width = kScreenWidth;
    CGFloat height = kScreenWidth/1.17+DOWNBACKVIEW_HIGHT+kDefaultMargin*2;
    
    return CGRectMake(x, y, width, height);
}

- (CGRect) headBgImageRect
{
    CGFloat x = 0;
    CGFloat y = 0;
    
    CGFloat width = kScreenWidth;
    CGFloat height = kScreenWidth/1.17;
    
    return CGRectMake(x, y, width, height);
}

// 圆
- (CGRect) circleImageRect
{
    CGFloat width = 64;
    CGFloat height = 64;
    
    CGFloat x = kLargeMargin;
    CGFloat y = [self headBgImageRect].size.height-114;
    
    
    return CGRectMake(x, y, width, height);
}


// 头像
- (CGRect) headImageRect
{
    CGFloat width = 62;
    CGFloat height = 62;
    
    CGFloat x =  kLargeMargin+1; //115;
    CGFloat y = [self headBgImageRect].size.height-115;
    
    return CGRectMake(x, y, width, height);
}
- (CGRect) headGradeViewRect
{
    CGFloat width = 64+12+12;
    CGFloat height = 20;
    
    CGFloat x =  kDefaultMargin; //115;
    CGFloat y = [self headImageRect].origin.y+[self headImageRect].size.height-height;
    
    return CGRectMake(x, y, width, height);
}
- (CGRect) praiseBackViewRect
{
    CGFloat width = 20;
    CGFloat height = 20;
    
    CGFloat x =  kScreenWidth-width-kDefaultMargin; //115;
    CGFloat y = [self circleImageRect].origin.y+([self circleImageRect].size.height-height)/2;
    
    return CGRectMake(x, y, width, height);
}
- (CGRect) praiseViewRect
{
    CGFloat width = 14;
    CGFloat height = 14;
    
    CGFloat x =  self.praiseBackView.frame.origin.x+kDefaultMargin;//115;
    CGFloat y = [self circleImageRect].origin.y+([self circleImageRect].size.height-height)/2;
    
    return CGRectMake(x, y, width, height);
}
- (CGRect) praiseNumLableRect
{
    CGFloat width = self.praiseBackView.frame.size.width-[self praiseViewRect].size.width-kDefaultMargin;
    CGFloat height = 20;
    
    CGFloat x =  [self praiseViewRect].origin.x+[self praiseViewRect].size.width+3; //115;
    CGFloat y =[self circleImageRect].origin.y+([self circleImageRect].size.height-height)/2;
    
    return CGRectMake(x, y, width, height);
}

//黑边
- (CGRect) blackSideViewRect
{
    CGFloat width = [self headBgImageRect].size.width;
    CGFloat height = 30;
    
    CGFloat x =  0;
    CGFloat y = [self headBgImageRect].size.height-30;
    
    return CGRectMake(x, y, width, height);
}
- (CGRect) gradeViewRect
{
    
    
    CGFloat x =  kDefaultMargin;
    CGFloat y = [self headBgImageRect].size.height-24;
    CGFloat width = 18;
    CGFloat height = 18;
    return CGRectMake(x, y, width, height);
}

- (CGRect) nameRect
{
    CGFloat x = [self gradeViewRect].size.width+[self gradeViewRect].origin.x+kDefaultMargin;
    CGFloat y = [self headBgImageRect].size.height-25;

    CGFloat width = 60;
    CGFloat height = kSmallLabelHeight;
    
    return CGRectMake(x, y, width, height);
}

- (CGRect) authenticationLabelRect
{
    CGFloat x =  [self nameRect].size.width+[self nameRect].origin.x+kDefaultMargin;
    CGFloat y = [self headBgImageRect].size.height-22;
    
    CGFloat width = 35;
    CGFloat height = kSmallLabelHeight-5;
    

    
    return CGRectMake(x, y, width, height);
}

- (CGRect) tradeLabelRect
{
    
    CGFloat x =  [self authenticationLabelRect].size.width+[self authenticationLabelRect].origin.x+kSmallMargin;
    CGFloat y = [self headBgImageRect].size.height-22;
    CGFloat width = 35;
    CGFloat height = kSmallLabelHeight-5;
    

    return CGRectMake(x, y, width, height);
}
- (CGRect) distanceLabelRect
{
    CGFloat width = 100;
    CGFloat height = kSmallLabelHeight;
    
    CGFloat x =  [self blackSideViewRect].size.width-width-kDefaultMargin;
    CGFloat y = [self headBgImageRect].size.height-25;

    
    return CGRectMake(x, y, width, height);
}

//详细信息
- (CGRect) downbackViewRect
{
    CGFloat width = kScreenWidth-2*kDefaultMargin;
    CGFloat height = DOWNBACKVIEW_HIGHT;
    
    CGFloat x =kDefaultMargin;
    CGFloat y = [self headBgImageRect].origin.y+[self headBgImageRect].size.height+kDefaultMargin;
    
    return CGRectMake(x, y, width, height);
}
- (CGRect) specialtyLabelRect
{
    CGFloat x =  kDefaultMargin; //115;
    CGFloat y = kSmallMargin;
    
    CGFloat width = [self downbackViewRect].size.width-2*kDefaultMargin;
    CGFloat height = kSmallLabelHeight;
    return CGRectMake(x, y, width, height);
}
- (CGRect) recordLabelRect
{
    CGFloat x =  kDefaultMargin; //115;
    CGFloat y = [self specialtyLabelRect].size.height+[self specialtyLabelRect].origin.y;
    
    CGFloat width = [self downbackViewRect].size.width-2*kDefaultMargin;
    CGFloat height = kSmallLabelHeight;
    return CGRectMake(x, y, width, height);
}
- (CGRect) serviceLabelRect
{
    CGFloat x =  kDefaultMargin; //115;
    CGFloat y = [self recordLabelRect].size.height+[self recordLabelRect].origin.y;
    
    CGFloat width = [self downbackViewRect].size.width-2*kDefaultMargin;
    CGFloat height = kSmallLabelHeight;
    return CGRectMake(x, y, width, height);
}
- (CGRect) moneyLabelRect
{
    CGFloat x =  kDefaultMargin; //115;
    CGFloat y = [self serviceLabelRect].size.height+[self serviceLabelRect].origin.y;
    
    CGFloat width = ([self downbackViewRect].size.width-2*kDefaultMargin)/2;
    CGFloat height = kSmallLabelHeight;
    return CGRectMake(x, y, width, height);
}
- (CGRect) numberLabelRect
{
    CGFloat x =  [self moneyLabelRect].size.width+[self moneyLabelRect].origin.x+kDefaultMargin;
    CGFloat y = [self serviceLabelRect].size.height+[self serviceLabelRect].origin.y;
    
    CGFloat width = ([self downbackViewRect].size.width-2*kDefaultMargin)/2;
    CGFloat height = kSmallLabelHeight;
    return CGRectMake(x, y, width, height);
}


@end
