//
//  CXMyRecommentCell.m
//  XWealth
//
//  Created by chx on 15/7/3.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXMyRecommentCell.h"

@implementation CXMyRecommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initSubviews];
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

- (void) initSubviews
{
    self.backgroundColor = kControlBgColor;
    
    _cellView = [[UIView alloc] initWithFrame:CGRectZero];
    _cellView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_cellView];
    
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectZero];
    name.textColor = kTextColor;
    name.backgroundColor = kColorClear;
    name.font = kLargeTextFont;
    name.numberOfLines = 1;
    [_cellView addSubview:name];
    self.name = name;
    
    UILabel *phone = [[UILabel alloc] initWithFrame:CGRectZero];
    phone.textColor = kAssistTextColor;
    phone.backgroundColor = kColorClear;
    phone.font = kMiddleTextFont;
    phone.numberOfLines = 1;
    [_cellView addSubview:phone];
    self.phone = phone;
    
    UIButton *recommentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    recommentBtn.frame = CGRectZero;
    recommentBtn.layer.masksToBounds = YES;
    recommentBtn.layer.cornerRadius = kRadius;
    recommentBtn.layer.borderColor = kLineColor.CGColor;
    recommentBtn.layer.borderWidth = 1;
    [recommentBtn setBackgroundColor:kMainStyleColor];
    [recommentBtn setTitle:StringAdd forState:UIControlStateNormal];
    recommentBtn.titleLabel.font = kMiddleTextFont;
    [recommentBtn setTitleColor:kColorWhite forState:UIControlStateNormal];
    //    [recommentBtn setImage:IMAGE(@"friend_add") forState:UIControlStateNormal];
    [recommentBtn addTarget:self action:@selector(addFriendAction:) forControlEvents:UIControlEventTouchUpInside];
    [_cellView addSubview:recommentBtn];
    self.recommentBtn = recommentBtn;
    
    UILabel *stateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    stateLabel.textColor = kTextColor;
    stateLabel.backgroundColor = kColorClear;
    stateLabel.font = kMiddleTextFont;
    stateLabel.numberOfLines = 1;
    [_cellView addSubview:stateLabel];
    self.stateLabel = stateLabel;

    
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectZero];
    line.backgroundColor = kLineColor;
    [_cellView addSubview:line];
    self.line = line;
}

- (void) setRecommentModel:(CXRecommentModel *)recommentModel
{
    _recommentModel = recommentModel;
    
    self.cellView.frame = [self cellViewRect];
    
    self.name.frame = [self nameRect];
    self.name.text = _recommentModel.name;
    
    self.phone.frame = [self phoneRect];
    self.phone.text = _recommentModel.phone;
    
    // 推荐表
    if (self.recommentModel.type == 1)
    {
        self.recommentBtn.frame = [self recommentBtnRect];
        if (self.recommentModel.state)
        {
            [self.recommentBtn setBackgroundColor:kColorGrayLight];
            [self.recommentBtn setTitle:StringRegistered forState:UIControlStateNormal];
        }
        else
        {
            [self.recommentBtn setBackgroundColor:kMainStyleColor];
            [self.recommentBtn setTitle:StringInvitation forState:UIControlStateNormal];
        }
        self.recommentBtn.hidden = NO;
        self.stateLabel.hidden = YES;
    }
    else
    {
        // 我的推荐
        self.stateLabel.frame = [self recommentBtnRect];
        if (self.recommentModel.state)
        {
            self.stateLabel.textColor = kColorGreen;
            self.stateLabel.text = StringRegistered;
        }
        else
        {
            self.stateLabel.textColor = kColorRed;
            self.stateLabel.text = StringNoRegister;
        }
        self.recommentBtn.hidden = YES;
        self.stateLabel.hidden = NO;
    }
    
    
    self.line.frame = [self lineRect];
}

- (void)addFriendAction:(UIButton *)button
{
    if (self.recommentBtnBlk) {
        self.recommentBtnBlk();
    }
}


- (CGRect)nameRect
{
    if (_nameRect.size.width <= 0 && _nameRect.size.height <= 0) {
        
        CGFloat x = kMiddleMargin;
        CGFloat width = [self cellWidth] - 80;
        
        CGFloat y = 0;
        
        CGFloat height = kLabelHeight;
        
        _nameRect = CGRectMake(x, y, width, height);
    }
    return _nameRect;
}

- (CGRect)phoneRect
{
    if (_phoneRect.size.width <= 0 && _phoneRect.size.height <= 0) {
        
        CGFloat x = kMiddleMargin;
        CGFloat width = [self cellWidth];
        
        CGFloat y = kLabelHeight;
        
        CGFloat height = kLabelHeight;
        
        _phoneRect = CGRectMake(x, y, width, height);
    }
    return _phoneRect;
}


- (CGRect)recommentBtnRect
{
    if (_recommentBtnRect.size.width <= 0 && _recommentBtnRect.size.height <= 0) {
        CGFloat width = 50;
        CGFloat x = kScreenWidth -50-kMiddleMargin;
        CGFloat y = ([self cellHeight] - 30)/2;
        
        CGFloat height = 30;
        
        _recommentBtnRect = CGRectMake(x, y, width, height);
    }
    return _recommentBtnRect;
}

- (CGRect)lineRect
{
    if (_lineRect.size.width <= 0 && _lineRect.size.height <= 0) {
        CGFloat x = 0;
        CGFloat y = [self cellHeight] - 1;
        
        CGFloat width = [self cellWidth];
        CGFloat height = 0.5;
        
        _lineRect = CGRectMake(x, y, width, height);
    }
    return _lineRect;
}

// ----------------------- cell视图
- (CGRect)cellViewRect
{
    if (_cellViewRect.size.width <= 0 && _cellViewRect.size.height <= 0) {
        CGFloat x = 0;
        CGFloat y = 0;
        
        CGFloat width = [self cellWidth];
        CGFloat height = [self cellHeight];
        
        _cellViewRect = CGRectMake(x, y, width, height);
    }
    return _cellViewRect;
}


- (CGFloat) cellWidth
{
    return kScreenWidth;
}

- (CGFloat) cellHeight
{
    if (_cellHeight <= 0) {
        
        CGFloat height =kLabelHeight * 2;
        
        _cellHeight = height;
    }
    return _cellHeight;
}


@end
