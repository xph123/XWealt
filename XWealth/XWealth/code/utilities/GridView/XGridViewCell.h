//
//  CSGridViewCell.h
//  eLearning
//
//  Created by watson on 14-5-22.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIGridViewCell.h"

@interface XGridViewCell : UIGridViewCell

@property (strong, nonatomic) CXCategoryModel *projectModel;

@property (strong, nonatomic) UIImageView *projectImageView;
@property (strong, nonatomic) UILabel *projectName;
@property (strong, nonatomic) UIImageView *selectedImageView;

- (void) setProjectModel:(CXCategoryModel *)projectModel andSelected:(NSInteger) isShowSelected;

@end
