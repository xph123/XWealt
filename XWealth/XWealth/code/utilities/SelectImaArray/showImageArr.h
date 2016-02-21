//
//  showImageArr.h
//  XWealth
//
//  Created by gsycf on 15/9/29.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface showImageArr : UIView<UIScrollViewDelegate>
//使用scrollerView做图片点击放大
- (void)showImageArray:(NSMutableArray *)ImageArray andImage:(UIImageView*)avatarImageView;
@end
