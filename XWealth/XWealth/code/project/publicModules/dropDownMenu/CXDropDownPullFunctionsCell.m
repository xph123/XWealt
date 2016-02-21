//
//  CXDropDownPullFunctionsCell.m
//  XWealth
//
//  Created by gsycf on 15/9/11.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXDropDownPullFunctionsCell.h"

@implementation CXDropDownPullFunctionsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //self.backgroundColor = kColorClear;
        
        CGFloat y = (kExtMenuHeight - 24) / 2;
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(kDefaultMargin*2, y, 24, 24)];
        [self addSubview:icon];
        self.icon = icon;
        
        CGFloat x =24+kDefaultMargin*3 ;
        CGFloat width = kScreenWidth / 2 - 3 * kDefaultMargin - x;
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, 24)];
        title.textAlignment=NSTextAlignmentLeft;
        title.font = [UIFont boldSystemFontOfSize:16];
        //title.textColor = [UIColor whiteColor];
        title.backgroundColor = [UIColor clearColor];
        title.numberOfLines = 1;
        [self addSubview:title];
        self.title = title;
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(kDefaultMargin*2, kExtMenuHeight, kPullFunctionViewWidth - 4 * kDefaultMargin, 0.3)];
        line.backgroundColor = kDropDownColor;
        [self addSubview:line];
        self.line = line;
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}



@end
