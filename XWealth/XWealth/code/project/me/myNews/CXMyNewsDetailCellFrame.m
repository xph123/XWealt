//
//  CXMyNewsDetailCellFrame.m
//  XWealth
//
//  Created by gsycf on 15/12/21.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXMyNewsDetailCellFrame.h"
#define kMargin 10 //间隔
#define kIconWH 40 //头像宽高
#define kContentW 180 //内容宽度

#define kTimeMarginW 15 //时间文本与边框间隔宽度方向
#define kTimeMarginH 10 //时间文本与边框间隔高度方向

//#define kContentTop 10 //文本内容与按钮上边缘间隔
//#define kContentLeft 25 //文本内容与按钮左边缘间隔
//#define kContentBottom 15 //文本内容与按钮下边缘间隔
//#define kContentRight 15 //文本内容与按钮右边缘间隔

#define kTimeFont [UIFont systemFontOfSize:12] //时间字体
#define kContentFont [UIFont systemFontOfSize:16] //内容字体
@implementation CXMyNewsDetailCellFrame
- (id)initWithDataModel:(CXNotificationModel *)notificationModel
{
    self=[super init];
    if (self) {
        self.notificationModel=notificationModel;
    }
    return self;
}
- (CGRect)timeRect
{
    if (_timeRect.size.width <= 0 && _timeRect.size.height <= 0) {
        NSString *timeStr=[XDateHelper getTimeToShowWithTimestamp:[NSString stringWithFormat:@"%d",_notificationModel.timestamp]];
        NSString *time= [XDateHelper translateToDisplay: timeStr];
        if ([time isEqualToString:@""]||time==nil) {
            return CGRectMake(0, 0, 0, 0);
        }
         CGSize timeSize = [time sizeWithFont:kTimeFont];
        CGFloat x = ([self cellWidth] - timeSize.width) / 2;;
        CGFloat y = kDefaultMargin;
        CGFloat width = timeSize.width + kTimeMarginW;
        CGFloat height = timeSize.height + kTimeMarginH;
        _timeRect = CGRectMake(x, y, width, height);
    }
    
    return _timeRect;
}
- (CGRect)iconRect
{

    if (_iconRect.size.width <= 0 && _iconRect.size.height <= 0) {
        CGFloat x = kDefaultMargin;
        CGFloat y = [self timeRect].origin.y+[self timeRect].size.height+kDefaultMargin;
        CGFloat width = kIconMoreWidth;
        CGFloat height = kIconMoreHeight;
        _iconRect = CGRectMake(x, y, width, height);
    }
    
    return _iconRect;
}


- (CGRect)contentBackViewRect
{
    if (_contentBackViewRect.size.width <= 0 && _contentBackViewRect.size.height <= 0) {
//         CGSize contentSize = [_notificationModel.content sizeWithFont:kMiddleTextFont constrainedToSize:CGSizeMake([self cellWidth]-2*kDefaultMargin-2*kIconMoreWidth-kLargeMargin*2, CGFLOAT_MAX)];
        CGFloat x = [self iconRect].size.width+[self iconRect].origin.x+kMinSmallMargin;
        CGFloat y = [self timeRect].origin.y+[self timeRect].size.height+kMiddleMargin;
        CGFloat width = [self cellWidth]-2*kDefaultMargin-2*kIconMoreWidth-kLargeMargin*2+kMessageRightMargin*2;
        CGFloat height = [self contentLableRect].origin.y+[self contentLableRect].size.height+kDefaultMargin+kSmallMargin;
        _contentBackViewRect = CGRectMake(x, y, width, height);
    }
    
    return _contentBackViewRect;
}
- (CGRect)nameLableRect
{
    if (_nameLableRect.size.width <= 0 && _nameLableRect.size.height <= 0) {
        CGFloat x = kMiddleMargin+kSmallMargin;
        CGFloat y = kMinSmallMargin;
        CGFloat width = [self cellWidth]-2*kDefaultMargin-2*kIconMoreWidth-kLargeMargin*2;
        CGFloat height = kLabelHeight;
        _nameLableRect = CGRectMake(x, y, width, height);
    }
    
    return _nameLableRect;
}
- (CGRect)rightImageRect
{
    if (_rightImageRect.size.width <= 0 && _rightImageRect.size.height <= 0) {
        CGFloat x = kMiddleMargin+kSmallMargin+[self cellWidth]-2*kDefaultMargin-2*kIconMoreWidth-kLargeMargin*2-20;
        CGFloat y = kMinSmallMargin+5;
        CGFloat width = 20;
        CGFloat height = 20;
        _rightImageRect = CGRectMake(x, y, width, height);
    }
    
    return _rightImageRect;
}

- (CGRect)lineViewRect
{
    if (_lineViewRect.size.width <= 0 && _lineViewRect.size.height <= 0) {
        CGFloat x = kMiddleMargin+kSmallMargin;
        CGFloat y = [self nameLableRect].size.height+[self nameLableRect].origin.y;
        CGFloat width = [self cellWidth]-2*kDefaultMargin-2*kIconMoreWidth-kLargeMargin*2;
        CGFloat height = 0.5;
        _lineViewRect = CGRectMake(x, y, width, height);
    }
    
    return _lineViewRect;
}

- (CGRect)contentLableRect
{
    if (_contentLableRect.size.width <= 0 && _contentLableRect.size.height <= 0) {
        CGSize contentSize = [_notificationModel.content sizeWithFont:kMiddleTextFont constrainedToSize:CGSizeMake([self cellWidth]-2*kDefaultMargin-2*kIconMoreWidth-kLargeMargin*2, CGFLOAT_MAX)];
        CGFloat x = kMiddleMargin+kSmallMargin;
        CGFloat y = [self lineViewRect].size.height+[self lineViewRect].origin.y+kDefaultMargin;
        CGFloat width = [self cellWidth]-2*kDefaultMargin-2*kIconMoreWidth-kLargeMargin*2;
        CGFloat height = contentSize.height;
        _contentLableRect = CGRectMake(x, y, width, height);
    }
    
    return _contentLableRect;
}

//- (CGRect)firstBtnRect
//{
//    if (_firstBtnRect.size.width <= 0 && _firstBtnRect.size.height <= 0) {
//        CGFloat x = kDefaultMargin;
//        CGFloat y = 0;
//        CGFloat width = [self contentBackViewRect].size.width-kSmallMargin*2;
//        CGFloat height = kLabelHeight;
//        _firstBtnRect = CGRectMake(x, y, width, height);
//    }
//    
//    return _firstBtnRect;
//}
//
//- (CGRect)secondBtnRect
//{
//    if (_secondBtnRect.size.width <= 0 && _secondBtnRect.size.height <= 0) {
//        CGFloat x = kDefaultMargin;
//        CGFloat y = 0;
//        CGFloat width = [self cellWidth]-2*kDefaultMargin;
//        CGFloat height = kLabelHeight;
//        _secondBtnRect = CGRectMake(x, y, width, height);
//    }
//    
//    return _secondBtnRect;
//}



// ----------------------- cell视图

- (CGRect)cellViewRect
{
    if (_cellViewRect.size.width <= 0 && _cellViewRect.size.height <= 0) {
        CGFloat x = 0;
        CGFloat y = 0;
        
        CGFloat width = [self cellWidth];
        CGFloat height = [self cellHeight];
        
        _cellViewRect = CGRectMake(x, y, width, height);
    }
    return _cellViewRect;
}

- (CGFloat) cellWidth
{
    return kScreenWidth;
}

- (CGFloat) cellHeight
{
    if (_cellHeight <= 0) {
        
        CGFloat height = 0;
        
        height=[self contentBackViewRect].origin.y+[self contentBackViewRect].size.height+kDefaultMargin+kSmallMargin;
        _cellHeight = height;
    }
    return _cellHeight;
}
@end
