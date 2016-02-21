//
//  CXClassroomCollectionViewCell.m
//  XWealth
//
//  Created by 12345 on 15-9-9.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXClassroomCollectionViewCell.h"
#define COMMENT_BUTTON_WIDTH  (30.0f)
#define COMMENT_BUTTON_HEIGHT  (20.0f)
@implementation CXClassroomCollectionViewCell
- (id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}
- (void) initSubviews
{
    self.backgroundColor = kTabbarColor;
    
    _cellView = [[UIView alloc] initWithFrame:self.contentView.bounds];
    
    

    _imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _imgView.contentMode = UIViewContentModeScaleAspectFill;
    _imgView.layer.cornerRadius = kRadius;
    [_cellView addSubview:_imgView];
    
    // 内容

    _titlelabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titlelabel.font = kSmallTextFont;
    _titlelabel.textColor = kTitleTextColor;
    _titlelabel.numberOfLines = 2;
    _titlelabel.textAlignment = NSTextAlignmentLeft;
    _titlelabel.backgroundColor = [UIColor clearColor];
    [_cellView addSubview:_titlelabel];
    
    
    
    // 评论

    _commentsButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [_commentsButton setBackgroundColor:[UIColor clearColor]];
    [_commentsButton setTitle: @"0" forState: UIControlStateNormal];
    _commentsButton.titleLabel.font = kExtralSmallTextFont;
    [_commentsButton setTitleColor:kAssistTextColor forState:UIControlStateNormal];
    [_commentsButton setImage:[UIImage imageNamed:@"class_number"] forState:UIControlStateNormal];
    [_commentsButton setImageEdgeInsets:UIEdgeInsetsMake(0.0, -12, 0.0, 0.0)];
    _commentsButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [_cellView addSubview: _commentsButton];
    
    

    _goodsButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [_goodsButton setBackgroundColor:[UIColor clearColor]];
    [_goodsButton setTitle: @"0" forState: UIControlStateNormal];
    _goodsButton.titleLabel.font = kExtralSmallTextFont;
    [_goodsButton setTitleColor:kAssistTextColor forState:UIControlStateNormal];
    [_goodsButton setImage:[UIImage imageNamed:@"class_good"] forState:UIControlStateNormal];
    [_goodsButton setImageEdgeInsets:UIEdgeInsetsMake(0.0, -12, 0.0, 0.0)];
    _goodsButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [_cellView addSubview: _goodsButton];
    
    [self.contentView addSubview:_cellView];
}

- (void)setCourseModel:(CXCourseModel *)courseModel
{
    _courseModel = courseModel;
    
    _layout = [[CXClassroomCollectionCellFrame alloc] initWithDataModel:courseModel];
    _cellView.frame = [_layout cellViewRect];
    
    _imgView.frame = [_layout imageViewRect];
    [_imgView sd_setImageWithURL:[NSURL URLWithString:[CXURLConstants getFullSltInformationUrl: self.courseModel.sltImageUrl]] placeholderImage:[UIImage imageNamed:@"defaule_image"]];
    _titlelabel.frame = [_layout titleRect];
    _titlelabel.text = self.courseModel.name;
    
    _commentsButton.frame = [_layout commentsRect];
    [_commentsButton setTitle: [NSString stringWithFormat:@"%d", self.courseModel.comments] forState: UIControlStateNormal];
     _goodsButton.frame = [_layout goodsRect];
    [_goodsButton setTitle: [NSString stringWithFormat:@"%d", self.courseModel.goods] forState: UIControlStateNormal];
    
    
}

@end
