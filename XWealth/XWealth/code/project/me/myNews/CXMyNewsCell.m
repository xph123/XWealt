//
//  CXMyNewsCell.m
//  XWealth
//
//  Created by gsycf on 15/12/9.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXMyNewsCell.h"

@implementation CXMyNewsCell

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
    
    // 内容
    _titlelabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titlelabel.font = kMiddleTextFont;
    _titlelabel.textColor = kTitleTextColor;
    _titlelabel.numberOfLines = 1;
    _titlelabel.textAlignment = NSTextAlignmentLeft;
    _titlelabel.backgroundColor = [UIColor clearColor];
    [_cellView addSubview:_titlelabel];
    
    
    
    _datelineLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _datelineLabel.font = kSmallTextFont;
    _datelineLabel.textColor = kAssistTextColor;
    _datelineLabel.numberOfLines = 1;
    _datelineLabel.textAlignment = NSTextAlignmentRight;
    _datelineLabel.backgroundColor = [UIColor clearColor];
    [_cellView addSubview:_datelineLabel];
    
    _contentlabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _contentlabel.font = kSmallTextFont;
    _contentlabel.textColor = kAssistTextColor;
    _contentlabel.numberOfLines = 1;
    _contentlabel.textAlignment = NSTextAlignmentLeft;
    _contentlabel.backgroundColor = [UIColor clearColor];
    [_cellView addSubview:_contentlabel];

    
    _lineView = [[UIView alloc] initWithFrame:CGRectZero];
    _lineView.backgroundColor = kLineColor;
    [_cellView addSubview:_lineView];
    
}
-(void)setNotificationModel:(CXNotificationModel *)notificationModel
{
    _notificationModel=notificationModel;
    _layout = [[CXMyNewsCellFrame alloc] initWithDataModel:_notificationModel];
    
    _cellView.frame = [_layout cellViewRect];
    
    _imgView.frame = [_layout imageViewRect];
   _titlelabel.frame = [_layout titleRect];
    if (notificationModel.type==2) {
        _imgView.image=[UIImage imageNamed:@"message_systemAnnouncement"];
        _titlelabel.text = StringMessageSystem;
    }
    else if (notificationModel.type==3) {
        _imgView.image=[UIImage imageNamed:@"message_update"];
        _titlelabel.text = StringMessageEdition;
    }
    else if (notificationModel.type==4) {
        _imgView.image=[UIImage imageNamed:@"message_activity"];
        _titlelabel.text = StringMessageCtivity;
    }
    else if (notificationModel.type==5) {
        _imgView.image=[UIImage imageNamed:@"message_recommend"];
        _titlelabel.text = StringMessageRecommend;
    }
    else
    {
        [_imgView sd_setImageWithURL:[NSURL URLWithString:[CXURLConstants getFullSltInformationUrl: self.notificationModel.senderHead]] placeholderImage:[UIImage imageNamed:@"defaule_image"]];
    }
    BOOL rightBool=NO;
    if (kAppDelegate.hasLogined) {
       rightBool= [CXReceiveMessages querytableState:kAppDelegate.currentUserModel.userName andType:_notificationModel.type];
    }
    else
    {
       rightBool= [CXReceiveMessages querytableState:@"publicFile" andType:_notificationModel.type];
        
    }
    if (_rightBtn!=nil) {
        [_rightBtn removeFromSuperview];
    }
    if (rightBool) {
        _rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame=[_layout rightBtnRect];
        _rightBtn.backgroundColor=[UIColor redColor];
        _rightBtn.layer.cornerRadius=6.0f;
        //    _rightBtn.titleLabel.font=[UIFont fontWithName:@"" size:3];
        //    [_rightBtn setTitle:@"12" forState:UIControlStateNormal];
        [_cellView addSubview:_rightBtn];

    }
    
    
    
    
    _datelineLabel.frame = [_layout datelineRect];
    if (self.notificationModel.timestamp !=0) {
        NSString *timeStr=[XDateHelper getTimeToShowWithTimestamp:[NSString stringWithFormat:@"%ld",self.notificationModel.timestamp]];
        NSString *time = [XDateHelper translateToDisplay: timeStr];
         _datelineLabel.text = time;
    }
    
   
    
    _contentlabel.frame = [_layout contentRect];
    _contentlabel.text = self.notificationModel.content;

    
    _lineView.frame=[_layout lineRect];
    
}

@end
