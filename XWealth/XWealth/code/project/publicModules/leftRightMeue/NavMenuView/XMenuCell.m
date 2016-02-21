//
//  CSMenuCell.m
//  eLearning
//
//  Created by watson on 14-5-22.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "XMenuCell.h"

@interface XMenuCell ()
@end


@implementation XMenuCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.textLabel.textColor = kTextColor;
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel.shadowColor = [UIColor darkGrayColor];
        self.textLabel.shadowOffset = CGSizeMake(0.0, -1.0);
        
        self.selectionStyle = UITableViewCellEditingStyleNone;

    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, 2.0f);
    
    CGContextSetRGBStrokeColor(ctx, 0.0f, 0.0f, 0.0f, 1.0f);
    CGContextMoveToPoint(ctx, 0, self.contentView.bounds.size.height);
    CGContextAddLineToPoint(ctx, self.contentView.bounds.size.width, self.contentView.bounds.size.height);
    CGContextStrokePath(ctx);
    
    CGContextSetRGBStrokeColor(ctx, 1.0f, 1.0f, 1.0f, 0.7f);
    
    CGContextMoveToPoint(ctx, 0, 0);
    CGContextAddLineToPoint(ctx, self.contentView.bounds.size.width, 0);
    CGContextStrokePath(ctx);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)setSelected:(BOOL)selected withCompletionBlock:(void (^)())completion
{
    float alpha = 0.0;
    if (selected) {
        alpha = 1.0;
    } else {
        alpha = 0.0;
    }
    [UIView animateWithDuration:0.15 animations:^{
//        self.cellSelection.alpha = alpha;
    } completion:^(BOOL finished) {
        completion();
    }];
}

@end
