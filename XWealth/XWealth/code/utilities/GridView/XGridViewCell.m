//
//  CSGridViewCell.m
//  eLearning
//
//  Created by watson on 14-5-22.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "XGridViewCell.h"
#import "UIImageView+AFNetworking.h"

@implementation XGridViewCell

- (id)initWithFrame:(CGRect)frame {
	
    if (self = [super initWithFrame:frame]) {
		
        [self addSubview:self.view];
		
		[self initSubviews];
	}
	
    return self;
	
}

- (void)initSubviews
{
//    _projectName = [[UILabel alloc] initWithFrame:[self projectNameRect]];
//    _projectName.font = kMiddleTextFont;
//    _projectName.textColor = kTitleTextColor;
//    _projectName.numberOfLines = 1;
//    _projectName.textAlignment = NSTextAlignmentCenter;
//    _projectName.backgroundColor = [UIColor clearColor];
//    [self addSubview:_projectName];
    
    _projectImageView = [[UIImageView alloc] initWithFrame:[self projectImageRect]];
    _projectImageView.contentMode = UIViewContentModeScaleToFill; // UIViewContentModeScaleAspectFit;
    _projectImageView.backgroundColor = [UIColor clearColor];
    [self addSubview: _projectImageView];
    
    _selectedImageView = [[UIImageView alloc] initWithFrame:[self selectedImageRect]];
    _selectedImageView.contentMode = UIViewContentModeScaleAspectFit;
    [_selectedImageView setImage:[UIImage imageNamed:@"project_selected"]];
    [self addSubview: _selectedImageView];
}


- (void) setProjectModel:(CXCategoryModel *)projectModel  andSelected:(NSInteger) isShowSelected
{
    _projectModel = projectModel;
    
    _projectName.text = _projectModel.name;

    [_projectImageView sd_setImageWithURL:[NSURL URLWithString:_projectModel.logoUrl] placeholderImage:[UIImage imageNamed:@"catalog_default"]];

    
    if (isShowSelected == 1)
    {
        _selectedImageView.hidden = NO;
    }
    else
    {
        _selectedImageView.hidden = YES;
    }
  
}

- (CGRect) projectImageRect
{
    CGFloat x = kLargeMargin;
    CGFloat y = kMiddleMargin;
    
    CGFloat width = ProjectGridCellWidth - 2 * kLargeMargin;
    CGFloat height = ProjectGridCellHeight - 2 * kMiddleMargin;
    
    return CGRectMake(x, y, width, height);
}

- (CGRect) projectNameRect
{
    CGFloat x = kLargeMargin;
    CGFloat y = ProjectGridCellHeight - kDefaultMargin - kGridCellTextHeight;
    
    CGFloat width = ProjectGridCellWidth - 2 * kLargeMargin;
    CGFloat height = kGridCellTextHeight;
    
    return CGRectMake(x, y, width, height);
}

- (CGRect) selectedImageRect
{
    CGFloat x = ProjectGridCellWidth - kLargeMargin - 10;
    CGFloat y = kMiddleMargin - 4;
    
    CGFloat width = kIconSmallWidth;
    CGFloat height = kIconSmallHeight;
    
    return CGRectMake(x, y, width, height);
}



@end
