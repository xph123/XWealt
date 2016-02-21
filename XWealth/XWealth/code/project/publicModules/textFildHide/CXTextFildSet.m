//
//  CXTextFildSet.m
//  XWealth
//
//  Created by gsycf on 15/10/30.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXTextFildSet.h"

@implementation CXTextFildSet
// 名称隐藏部分
+ (NSString *) getNameHide:(NSString *)str
{
    NSMutableString *userNameStr;
    if ([str isEqualToString:@""]||str!=nil) {
    //姓名隐藏
    userNameStr=[[NSMutableString alloc]initWithString:str];
    NSInteger len=[userNameStr length];
    if (len>1&&len<4) {
        NSRange rang2=NSMakeRange(1, len-1);
        NSMutableString *changeStr=[NSMutableString stringWithFormat:@""];
        for (int i=0; i<len-1; i++) {
            [changeStr appendString:@"*"];
        }
        [userNameStr replaceCharactersInRange:rang2 withString:changeStr];
    }
    else if (len>=4)
    {
        NSRange rang2=NSMakeRange(1, len-1);
        [userNameStr replaceCharactersInRange:rang2 withString:@"**"];
    }
    else if (len==1)
    {
        userNameStr=[NSMutableString stringWithFormat:@"%@**",str];
    }
    else if (len==0)
    {
        userNameStr=[NSMutableString stringWithFormat:@"***"];
    }
    }
    return userNameStr;
}
// 手机隐藏部分
+ (NSString *) getPhoneHide:(NSString *)str
{
    //联系方式
    NSMutableString *phoneStr;
    if ([str isEqualToString:@""]||str!=nil) {
        phoneStr=[NSMutableString stringWithFormat:@"%@",str];
    NSInteger phoneLen=[phoneStr length];
    if (phoneLen>7&&phoneLen<12) {
        NSRange rang2=NSMakeRange(3, phoneLen-7);
        NSMutableString *changeStr=[NSMutableString stringWithFormat:@""];
        for (int i=0; i<phoneLen-7; i++) {
            [changeStr appendString:@"*"];
        }
        [phoneStr replaceCharactersInRange:rang2 withString:changeStr];
    }
    else if (phoneLen>1&&phoneLen<7)
    {
        NSRange rang2=NSMakeRange(1, phoneLen-1);
        NSMutableString *changeStr=[NSMutableString stringWithFormat:@""];
        for (int i=0; i<phoneLen-1; i++) {
            [changeStr appendString:@"*"];
        }
        [phoneStr replaceCharactersInRange:rang2 withString:changeStr];
    }
    else if (phoneLen>12)
    {
        NSRange rang2=NSMakeRange(3, phoneLen-7);
        [phoneStr replaceCharactersInRange:rang2 withString:@"****"];
    }
    else if (phoneLen==1)
    {
        phoneStr=[NSMutableString stringWithFormat:@"%@***",str];
    }
    else if (phoneLen==0)
    {
        phoneStr=[NSMutableString stringWithFormat:@"***"];
    }
    }
    return phoneStr;
}
// 调整金钱单位
+ (NSString *) getMoneyUnit:(int)num
{
    int moneyNum=num;
    if (moneyNum >= 10000)
    {
        int remain = moneyNum % 10000;
        if (remain == 0)
        {
            int scale = moneyNum / 10000;
            return [NSString stringWithFormat:@"%d亿", scale];
        }
        else
        {
            CGFloat dScale = moneyNum / 10000.0;
            int remain2 = remain % 1000;
            if (remain2 == 0)
            {
                return [NSString stringWithFormat:@"%.1f亿", dScale];
            }
            else
            {
                return [NSString stringWithFormat:@"%.2f亿", dScale];
            }
        }
    }
    else
    {
        return [NSString stringWithFormat:@"%d万", num];
    }
    
}
@end
