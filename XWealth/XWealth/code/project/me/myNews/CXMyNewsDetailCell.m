//
//  CXMyNewsDetailCell.m
//  XWealth
//
//  Created by gsycf on 15/12/21.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXMyNewsDetailCell.h"

@implementation CXMyNewsDetailCell

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
    
    _cellView=[[UIView alloc]initWithFrame:CGRectZero];
    _cellView.backgroundColor=[UIColor clearColor];
    [self addSubview:_cellView];
   //创建时间按钮
    _timeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _timeBtn.frame=CGRectZero;
    _timeBtn.enabled=NO;
    _timeBtn.titleLabel.font=kSmallTextFont;
    //[_timeBtn setImage:[UIImage imageNamed:@"chat_timeline_bg.png"] forState:UIControlStateNormal];
//    [_timeBtn setBackgroundImage:[UIImage imageNamed:@"chat_timeline_bg.png"] forState:UIControlStateNormal];
    [_timeBtn setBackgroundColor:kMessageTimeBlackColor];
    _timeBtn.layer.cornerRadius=5.0f;
    [_cellView addSubview:_timeBtn];
    
    
    _iconView=[[UIImageView alloc]initWithFrame:CGRectZero];
    [_cellView addSubview:_iconView];
    
    _contentBackView=[[UIImageView alloc]initWithFrame:CGRectZero];
    _contentBackView.userInteractionEnabled=YES;
//    _contentBackView.backgroundColor=[UIColor yellowColor];
    [_cellView addSubview:_contentBackView];
    
    _nameLable=[[UILabel alloc]initWithFrame:CGRectZero];
    _nameLable.font=kMenuTextFont;
    _nameLable.textColor=kTitleTextColor;
    _nameLable.numberOfLines=1;
    _nameLable.textAlignment=NSTextAlignmentLeft;
    [_contentBackView addSubview:_nameLable];
    
    _rightImagle=[[UIImageView alloc]initWithFrame:CGRectZero];
    _rightImagle.backgroundColor=[UIColor clearColor];
    _rightImagle.image=[UIImage imageNamed:@"showmore"];
    [_contentBackView addSubview:_rightImagle];

    
    _lineView=[[UIImageView alloc]initWithFrame:CGRectZero];
    _lineView.backgroundColor=kLineColor;
    [_contentBackView addSubview:_lineView];

    
    
    
    _contentLable=[[UILabel alloc]initWithFrame:CGRectZero];
    _contentLable.font=kMiddleTextFont;
    _contentLable.textColor=kTextColor;
    _contentLable.numberOfLines=0;
    _contentLable.textAlignment=NSTextAlignmentLeft;
//    _contentLable.backgroundColor=[UIColor redColor];
    [_contentBackView addSubview:_contentLable];
    
    
}
-(void)setNotificationModel:(CXNotificationModel *)notificationModel
{
    _notificationModel = notificationModel;
    CXMyNewsDetailCellFrame *layer=[[CXMyNewsDetailCellFrame alloc]initWithDataModel:_notificationModel];
   
     _cellView.frame=[layer cellViewRect];
    // 1、设置时间
   
        NSString *timeStr=[XDateHelper getTimeToShowWithTimestamp:[NSString stringWithFormat:@"%ld",self.notificationModel.timestamp]];
        NSString *time = [XDateHelper translateToDisplay: timeStr];
        [_timeBtn setTitle:time forState:UIControlStateNormal];
        _timeBtn.frame = [layer timeRect];

    
    // 2、设置头像
     _iconView.frame = [layer iconRect];
    //![_notificationModel.senderHead isEqualToString:@""]||_notificationModel.senderHead!=nil||
    if ([_notificationModel.senderHead isEqualToString:@"(null)"]||[_notificationModel.senderHead isEqualToString:@""]) {
         _iconView.image = [UIImage imageNamed:@"icon-120"];
        
    }
    else
    {
       [_iconView sd_setImageWithURL:[NSURL URLWithString:[CXURLConstants getFullSltInformationUrl: _notificationModel.senderHead]] placeholderImage:[UIImage imageNamed:@"defaule_image"]];
    }
    
   
    UIImage *normal = [UIImage imageNamed:@"chatfrom_bg_normal"];
    normal = [normal stretchableImageWithLeftCapWidth:normal.size.width * 0.9 topCapHeight:normal.size.height * 0.9];
    //添加背景图片
    CGFloat top =30; // 顶端盖高度
    CGFloat bottom = 10 ; // 底端盖高度
    CGFloat left = 20; // 左端盖宽度
    CGFloat right = 20; // 右端盖宽度
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    UIImage *backIma=[UIImage imageNamed:@"chatfrom_bg_normal"];
    UIImage *back2Ima=[backIma resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeTile];
    _contentBackView.image=back2Ima;
    _contentBackView.frame=[layer contentBackViewRect];
    
     _nameLable.frame=[layer nameLableRect];
    switch (_notificationModel.type) {
        case 2:
            _nameLable.text=@"系统消息";
            break;
        case 3:
            _nameLable.text=@"版本更新";
            break;
        case 4:
            _nameLable.text=@"活动公告";
            break;
        case 5:
            _nameLable.text=@"产品推介";
            break;
        default:
            break;
    }
   
    
    
    _rightImagle.frame=[layer rightImageRect];
    
    _lineView.frame=[layer lineViewRect];
    
    _contentLable.frame=[layer contentLableRect];
    _contentLable.text=_notificationModel.content;
//    if (_notificationModel.status==3) {
//        _contentLable.textColor=kAssistTextColor;
//    }
    
}

- (CGFloat) cellWidth
{
    return kScreenWidth;
}

@end
