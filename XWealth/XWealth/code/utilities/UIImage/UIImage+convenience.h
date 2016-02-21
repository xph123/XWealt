//
//  UIImage+convenience.h
//  xProject
//
//  Created by rasc on 14-5-14.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (convenience)
//1.等比率缩放
- (UIImage *)scaleImageToScale:(float)scaleSize;
//4.处理选择图片后旋转的问题
- (UIImage *)fixOrientation;

-(UIImage *)fitSmallImage:(CGSize)size;
@end
