//
//  CXPullFunctionsCell.m
//  Link
//
//  Created by chx on 14-12-4.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXPullFunctionsCell.h"

@implementation CXPullFunctionsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = kColorClear;
        
        CGFloat y = (kExtMenuHeight - kIconMiddleHeight) / 2;
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(kDefaultMargin, y, kIconMiddleWidth, kIconMiddleHeight)];
        [self addSubview:icon];
        self.icon = icon;
        
        CGFloat x =kLargeMargin;
        CGFloat width = kScreenWidth / 2 - 3 * kDefaultMargin - x;
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, kIconMiddleHeight)];
        title.font = kMenuTextFont;
        title.backgroundColor = [UIColor clearColor];
        title.textColor = kTextColor;
        title.numberOfLines = 1;
        [self addSubview:title];
        self.title = title;
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(kLargeMargin, kExtMenuHeight - 0.5, kScreenWidth - kLargeMargin, 0.5)];
        line.backgroundColor = kLineColor;
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
