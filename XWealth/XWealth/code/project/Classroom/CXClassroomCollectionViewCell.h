//
//  CXClassroomCollectionViewCell.h
//  XWealth
//
//  Created by 12345 on 15-9-9.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXClassroomCollectionCellFrame.h"
@interface CXClassroomCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) CXCourseModel *courseModel;
@property (nonatomic, strong) CXClassroomCollectionCellFrame *layout;
@property (strong, nonatomic) UIView *cellView;

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titlelabel;

@property (nonatomic, strong) UIButton *commentsButton;
@property (nonatomic, strong) UIButton *goodsButton;

@end
