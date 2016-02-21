//
//  imageAndLableBtn.h
//  XWealth
//
//  Created by gsycf on 15/11/19.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
//上面图片下面字的按钮
@interface imageAndLableBtn : UIView

@property(nonatomic ,strong)UIImageView *backImage;
@property(nonatomic, strong)UIImageView *image;
@property(nonatomic, strong)UILabel *lable;


-(void)setImageName:(NSString *)image andSetLable:(NSString *)lable;

@end
