//
//  imageAndLableBtn.m
//  XWealth
//
//  Created by gsycf on 15/11/19.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "imageAndLableBtn.h"

#define IMAGLE_BUTTON_WIDTH  (27.0f)
#define IMAGLE_BUTTON_HIGHT  (24.0f)

@implementation imageAndLableBtn
{
    BOOL _select;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        _select=NO;
        [self initSubviews];
    }
    return self;
}
-(void)initSubviews
{
    self.backImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _backImage.backgroundColor=[UIColor whiteColor];
    _backImage.userInteractionEnabled=YES;
//    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
//    [_backImage addGestureRecognizer:tap];
    [self addSubview:self.backImage];
    

    self.image=[[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width-IMAGLE_BUTTON_WIDTH)/2, self.frame.size.height/2-IMAGLE_BUTTON_HIGHT, IMAGLE_BUTTON_WIDTH, IMAGLE_BUTTON_HIGHT)];
    [self.backImage addSubview:_image];
    
    self.lable=[[UILabel alloc]initWithFrame:CGRectMake(0, _image.frame.origin.y+_image.frame.size.height+5, self.backImage.frame.size.width, 20)];
    _lable.textAlignment=NSTextAlignmentCenter;
    _lable.font=kSmallTextFont;
    _lable.textColor=kTitleTextColor;
    [self.backImage addSubview:_lable];
    
}
-(void)setImageName:(NSString *)image andSetLable:(NSString *)lable
{
    self.image.image=[UIImage imageNamed:image];
    self.lable.text=lable;
}
//-(void)tapClick:(UITapGestureRecognizer *)sender
//{
//    if (_select) {
//    }
//        _select=!_select;
//}
@end
