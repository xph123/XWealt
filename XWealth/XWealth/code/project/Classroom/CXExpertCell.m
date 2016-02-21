//
//  CXExpertCell.m
//  XWealth
//
//  Created by gsycf on 15/12/10.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXExpertCell.h"

@implementation CXExpertCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initSubviews];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void) initSubviews
{
    self.backgroundColor = kControlBgColor;
    
    _cellView = [[UIView alloc] initWithFrame:CGRectZero];
    _cellView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_cellView];
    
    _imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _imgView.contentMode = UIViewContentModeScaleAspectFill;
    _imgView.clipsToBounds  = YES;
    //_imgView.layer.cornerRadius = kRadius;
    [_cellView addSubview:_imgView];
    
    
    // 名称
    _namelable = [[UILabel alloc] initWithFrame:CGRectZero];
    _namelable.font = kMiddleTextFont;
    _namelable.textColor = kTitleTextColor;
    _namelable.numberOfLines = 1;
    _namelable.textAlignment = NSTextAlignmentLeft;
    _namelable.backgroundColor = [UIColor clearColor];
    [_cellView addSubview:_namelable];

    
    
    // 内容
    _titlelabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titlelabel.font = kSmallTextFont;
    _titlelabel.textColor = kTitleTextColor;
    _titlelabel.numberOfLines = 2;
    _titlelabel.textAlignment = NSTextAlignmentLeft;
    _titlelabel.backgroundColor = [UIColor clearColor];
    [_cellView addSubview:_titlelabel];
    
    
    
    _lineView = [[UIView alloc] initWithFrame:CGRectZero];
    _lineView.backgroundColor = kLineColor;
    [_cellView addSubview:_lineView];
    
}
-(void)setExpertModel:(CXExpertModel *)expertModel
{
    _expertModel = expertModel;
    _layout = [[CXExpertCellFrame alloc] initWithDataModel:expertModel];
    
    _cellView.frame = [_layout cellViewRect];
    
    _imgView.frame = [_layout imageViewRect];
    [_imgView sd_setImageWithURL:[NSURL URLWithString:[CXURLConstants getFullSltInformationUrl: self.expertModel.image]] placeholderImage:[UIImage imageNamed:@"defaule_image"]];
    
    _namelable.frame=[_layout nameRect];
    _namelable.text=self.expertModel.name;
    
    _titlelabel.frame = [_layout titleRect];
    _titlelabel.text = self.expertModel.signature;
    
    
    _lineView.frame=[_layout lineRect];
    
}
@end
