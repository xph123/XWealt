//
//  CXUserView.m
//  Link
//
//  Created by chx on 14-11-11.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXUserView.h"

@implementation CXUserView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = kColorWhite;
        
        CGFloat headImagHeight = frame.size.height - 2 * kDefaultMargin;
        CGFloat headImageWidth = headImagHeight;

        UIImageView *headImg = [[UIImageView alloc] initWithFrame:CGRectMake(kDefaultMargin, kDefaultMargin, headImageWidth, headImagHeight)];
        headImg.layer.masksToBounds = YES;
        headImg.layer.cornerRadius = 4;
        [self addSubview:headImg];
        self.headImg = headImg;
        
        CGFloat width = frame.size.width - 3 * kDefaultMargin - headImageWidth;
        CGFloat x = headImageWidth + 2 * kDefaultMargin;
        
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(x, kDefaultMargin, width, headImagHeight)];
        name.textColor = kTextColor;
        name.backgroundColor = kColorClear;
        name.font = kLargeTextFont;
        [self addSubview:name];
        self.name = name;
        
        int tipsX = kDefaultMargin + headImageWidth - (kIconSmallWidth / 2);
        UIImageView *tips = [[UIImageView alloc] initWithFrame:CGRectMake(tipsX, 2, kIconSmallWidth, kIconSmallHeight)];
        tips.image = IMAGE(@"tips");
        tips.hidden = YES;
        [self addSubview:tips];
        self.tips = tips;
        
        UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 3, 14, 11)];
        numberLabel.font = kExtralSmallTextFont;
        numberLabel.textAlignment = NSTextAlignmentCenter;
        numberLabel.textColor = kColorWhite;
        numberLabel.backgroundColor = kColorClear;
        [self.tips addSubview:numberLabel];
        self.numberLabel = numberLabel;

    }
    return self;
}

@end
