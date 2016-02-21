//
//  CXMeHeaderView.m
//  Link
//
//  Created by chx on 14-12-2.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXMeHeaderView.h"

@implementation CXMeHeaderView

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
    _backImageView.backgroundColor=[UIColor whiteColor];
    [self addSubview:_backImageView];
    
    
    _headBgImageView = [[UIImageView alloc] initWithFrame:[self headBgImageRect]];
    UITapGestureRecognizer *singleFingerOne  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeHeaderBgImage)];
    singleFingerOne.numberOfTouchesRequired = 1; //手指数
    singleFingerOne.numberOfTapsRequired = 1; //tap次数
    _headBgImageView.userInteractionEnabled = YES;
    _headBgImageView.contentMode = UIViewContentModeScaleAspectFill;
    _headBgImageView.clipsToBounds=YES;
    [_headBgImageView addGestureRecognizer:singleFingerOne];
    [_backImageView addSubview: _headBgImageView];
    
    UIImageView *circleImgView = [[UIImageView alloc] initWithFrame:[self circleImageRect]];
    circleImgView.image = IMAGE(@"me_head_circle");
    //circleImgView.alpha = 0.4;
    [self addSubview:circleImgView];

    
    _headImageView = [[UIImageView alloc] initWithFrame:[self headImageRect]];
    _headImageView.layer.cornerRadius = 32;
    _headImageView.layer.masksToBounds = YES;
    UITapGestureRecognizer *singleFingerOne2  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeHeadImage)];
    singleFingerOne2.numberOfTouchesRequired = 1; //手指数
    singleFingerOne2.numberOfTapsRequired = 1; //tap次数
    _headImageView.userInteractionEnabled = YES;
    [_headImageView addGestureRecognizer:singleFingerOne2];
    [self addSubview: _headImageView];
    
    _nickNameLabel = [[UILabel alloc] initWithFrame:[self nickNameRect]];
    _nickNameLabel.font = kMenuTextFont;
    _nickNameLabel.textColor = [UIColor whiteColor];
    _nickNameLabel.numberOfLines = 1;
    _nickNameLabel.textAlignment = NSTextAlignmentLeft;
    _nickNameLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:_nickNameLabel];
    
    _nameLabel = [[UILabel alloc] initWithFrame:[self nameRect]];
    _nameLabel.font = kMiddleTextFont;
    _nameLabel.textColor = kGrayTextColor;
    _nameLabel.numberOfLines = 1;
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    _nameLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:_nameLabel];
    
    
    UIButton *infoBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [infoBtn setImage:[UIImage imageNamed:@"list_white_right"] forState:UIControlStateNormal];
    infoBtn.frame=[self infoBtnRect];
    [infoBtn addTarget:self action:@selector(minfoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:infoBtn];
    
    
    _leftBtn=[[imageAndLableBtn alloc]initWithFrame:[self leftBtnRect]];
    _leftBtn.backgroundColor=[UIColor redColor];
    [_leftBtn setImageName:@"myTransaction" andSetLable:StringTradingCenter];
    UITapGestureRecognizer *leftBtnTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leftBtnClick)];
    [_leftBtn addGestureRecognizer:leftBtnTap];
    _leftBtn.userInteractionEnabled=YES;
    [self addSubview:_leftBtn];
    
    
    
    _oneVerticalImaView=[[UIImageView alloc]initWithFrame:[self oneVerticalImaViewRect]];
    _oneVerticalImaView.backgroundColor=kLineColor;
    [self addSubview:_oneVerticalImaView];
    
    _centerBtn=[[imageAndLableBtn alloc]initWithFrame:[self centerBtnRect]];
    [_centerBtn setImageName:@"shapeApp" andSetLable:StringShareApp2];
    UITapGestureRecognizer *centerBtnTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(centerBtnClick)];
    [_centerBtn addGestureRecognizer:centerBtnTap];
    _centerBtn.userInteractionEnabled=YES;
    [self addSubview:_centerBtn];
    
    _twoVerticalImaView=[[UIImageView alloc]initWithFrame:[self twoVerticalImaViewRect]];
    _twoVerticalImaView.backgroundColor=kLineColor;
    [self addSubview:_twoVerticalImaView];
    

        _rightBtn=[[imageAndLableBtn alloc]initWithFrame:[self rightBtnRect]];
        [_rightBtn setImageName:@"myCollection" andSetLable:StringMyCollection];
        UITapGestureRecognizer *rightBtnTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(rightBtnClick)];
        [_rightBtn addGestureRecognizer:rightBtnTap];
        _rightBtn.userInteractionEnabled=YES;
        [self addSubview:_rightBtn];
    
    UIImageView *line=[[UIImageView alloc]initWithFrame:[self lineViewRect]];
    line.backgroundColor=kLineColor;
    [self addSubview:line];
}

- (void)setUserModel:(CXUserModel *)userModel
{
    _userModel = userModel;
//    if (_userModel.statusBg && _userModel.statusBg.length > 0)
//    {
//        [_headBgImageView setImageWithURL:[NSURL URLWithString:[CXURLConstants getFullStatusUrl: _userModel.statusBg]]
//                         placeholderImage:[UIImage imageNamed:@"me_head_bg"]];
//    }
//    else
//    {
        [_headBgImageView setImage:[UIImage imageNamed:@"me_head_bg"]];
//    }
    [_headImageView setImageWithURL:[NSURL URLWithString:[CXURLConstants getFullSltHeaderUrl: _userModel.headImg]]
                   placeholderImage:[UIImage imageNamed:@"head_default"]];

    
    if (self.userModel.userId!=0&&self.userModel.userId)
    {
        NSString *strName;
        if (![_userModel.nickName isEqualToString:@""]) {
            strName=@"姓名：";
        }
        else
        {
            strName=@"账号：";
        }
        NSString *name = [NSString stringWithFormat:@"%@%@",strName,[_userModel getDisplayName]];
        _nickNameLabel.text = name;
        _nickNameLabel.hidden = NO;
        
        NSString *userName = [NSString stringWithFormat:@"邀请码：%@", _userModel.mid];
        _nameLabel.text = userName;
    }
  else
  {
      NSString *name = [NSString stringWithFormat:@"未登录"];
      _nickNameLabel.text = name;
      _nickNameLabel.hidden = NO;
      
      NSString *userName = [NSString stringWithFormat:@"点击登录"];
      _nameLabel.text = userName;
  }
    
}

- (void) changeHeaderBgImage
{
    __unsafe_unretained CXMeHeaderView *weak_self = self;
    if (weak_self.changeHeaderBgImageBlk) {
        weak_self.changeHeaderBgImageBlk();
    }
}

- (void) changeHeadImage
{
    __unsafe_unretained CXMeHeaderView *weak_self = self;
    if (weak_self.changeHeadImageBlk) {
        weak_self.changeHeadImageBlk();
    }

}

- (void) minfoBtnClick
{
    __unsafe_unretained CXMeHeaderView *weak_self = self;
    if (weak_self.myInfoBlk) {
        weak_self.myInfoBlk();
    }
    
}
- (void) leftBtnClick
{
    __unsafe_unretained CXMeHeaderView *weak_self = self;
    if (weak_self.leftBlk) {
        weak_self.leftBlk();
    }
    
}
- (void) centerBtnClick
{
    __unsafe_unretained CXMeHeaderView *weak_self = self;
    if (weak_self.centerBlk) {
        weak_self.centerBlk();
    }
    
}
- (void) rightBtnClick
{
    __unsafe_unretained CXMeHeaderView *weak_self = self;
    if (weak_self.rightBlk) {
        weak_self.rightBlk();
    }
    
}
#pragma mark -Rect

- (CGRect) backImageViewRect
{
    CGFloat x = 0;
    CGFloat y = 0;
    
    CGFloat width = kScreenWidth;
    CGFloat height = kMeHeadHeight;
    
    return CGRectMake(x, y, width, height);
}

- (CGRect) headBgImageRect
{
    CGFloat x = 0;
    CGFloat y = 0;
    
    CGFloat width = kScreenWidth;
    CGFloat height = 165;
    
    return CGRectMake(x, y, width, height);
}

// 圆
- (CGRect) circleImageRect
{
    CGFloat width = 70;
    CGFloat height = 70;
    
    CGFloat x = kLargeMargin;
    CGFloat y = 77;
    
    
    return CGRectMake(x, y, width, height);
}


// 头像
- (CGRect) headImageRect
{
    CGFloat width = 64;
    CGFloat height = 64;
    
    CGFloat x =  kLargeMargin+3; //115;
    CGFloat y = 80;
    
    return CGRectMake(x, y, width, height);
}

// 姓名
- (CGRect) nickNameRect
{
    CGFloat x = [self circleImageRect].size.width+kLargeMargin+kMiddleMargin;
    CGFloat y = 89;
    
    CGFloat width = kLabelWidth*2+50;
    CGFloat height = 20;
    
    return CGRectMake(x, y, width, height);
}

// 姓名
- (CGRect) nameRect
{
    CGFloat x = [self circleImageRect].size.width+kLargeMargin+kMiddleMargin;
    CGFloat y = 94 + 20;
    
    CGFloat width = kLabelWidth*2+50;
    CGFloat height = 20;
    
    return CGRectMake(x, y, width, height);
}
// 右箭头
- (CGRect) infoBtnRect
{
    
    CGFloat width = 30;
    CGFloat height = 70;
    CGFloat x = kScreenWidth-20-kMiddleMargin;
    CGFloat y = 77+[self circleImageRect].size.height/2-height/2 ;
    
    
    return CGRectMake(x, y, width, height);
}
// 左边按钮
- (CGRect) leftBtnRect
{
    CGFloat x =0;
    CGFloat y =[self headBgImageRect].size.height+[self headBgImageRect].origin.y +kMinSmallMargin;
    CGFloat width = (kScreenWidth-2)/3;
    CGFloat height = 70-kMinSmallMargin;

    
    
    return CGRectMake(x, y, width, height);
}
// 左边线
- (CGRect) oneVerticalImaViewRect
{
    CGFloat x = [self leftBtnRect].origin.x+[self leftBtnRect].size.width;
    CGFloat y = [self headBgImageRect].size.height+[self headBgImageRect].origin.y+([self backImageViewRect].size.height-[self headBgImageRect].size.height)/2-18;
    CGFloat width = 0.5;
    CGFloat height = 37;

    
    
    return CGRectMake(x, y, width, height);
}
// 中按钮
- (CGRect) centerBtnRect
{
    CGFloat x = [self leftBtnRect].origin.x+[self leftBtnRect].size.width+2;
    CGFloat y = [self headBgImageRect].size.height+[self headBgImageRect].origin.y+kMinSmallMargin;
    CGFloat width = (kScreenWidth-2)/3;
    CGFloat height = 70-kMinSmallMargin;

    
    
    return CGRectMake(x, y, width, height);
}
// 右边线
- (CGRect) twoVerticalImaViewRect
{
    CGFloat x =[self centerBtnRect].origin.x+[self centerBtnRect].size.width;
    CGFloat y =[self headBgImageRect].size.height+[self headBgImageRect].origin.y +([self backImageViewRect].size.height-[self headBgImageRect].size.height)/2-18;
    CGFloat width = 0.5;
    CGFloat height = 37;

    
    
    return CGRectMake(x, y, width, height);
}
// 右边按钮
- (CGRect) rightBtnRect
{
    CGFloat x = [self centerBtnRect].origin.x+[self centerBtnRect].size.width+2;
    CGFloat y = [self headBgImageRect].size.height+[self headBgImageRect].origin.y+kMinSmallMargin;
    CGFloat width =(kScreenWidth-2)/3;
    CGFloat height = 70-kMinSmallMargin;

    
    
    return CGRectMake(x, y, width, height);
}
// 边
- (CGRect) lineViewRect
{
    CGFloat x =0;
    CGFloat y =kMeHeadHeight-0.5;
    CGFloat width =kScreenWidth ;
    CGFloat height = 0.5;
    
    
    
    return CGRectMake(x, y, width, height);
}

@end
