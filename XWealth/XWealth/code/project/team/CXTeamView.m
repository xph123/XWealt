//
//  CXTeamView.m
//  Link
//
//  Created by chx on 14-12-3.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXTeamView.h"
#import "XChoiceView.h"

@interface CXTeamView ()<XChoiceViewDelegate, CXFriendTableViewDelegate, CXGroupTableViewDelegate>

@property (nonatomic, strong) XChoiceView *choiceView;
@property (nonatomic, strong) NSArray *choiceViewTitles;
@property (nonatomic, assign) NSInteger choiceIndex;

@end


@implementation CXTeamView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.choiceViewTitles = @[NSLocalizedString(@"好友",nil),
                                  NSLocalizedString(@"团队",nil)];
        
        CGRect cvFrame = self.bounds;
        cvFrame.origin.y = kIsIOS7OrLater ? kNavAndStatusBarHeight:0;
        cvFrame.size.height -= kIsIOS7OrLater ? kNavAndStatusBarHeight:0;
        
        CGRect talbeFrame = cvFrame;
        talbeFrame.origin.y = 0;
        talbeFrame.size.height -= kIsIOS7OrLater ? kTabBarHeight + kDefaultMargin + kNavAndStatusBarHeight : kTabBarHeight + kDefaultMargin;
        
        
        CXFriendTableView *friendTable = [[CXFriendTableView alloc] initWithFrame:talbeFrame];
        friendTable.delegate = self;
        self.friendTable = friendTable;
        
        CXGroupTableView *groupTable = [[CXGroupTableView alloc] initWithFrame:talbeFrame];
        groupTable.delegate = self;
        self.groupTable = groupTable;
        
        NSDictionary *dic = @{_choiceViewTitles[0]:_friendTable, _choiceViewTitles[1]:_groupTable};
        XChoiceView *mcv = [[XChoiceView alloc] initWithFrame:cvFrame mouldes:_choiceViewTitles views:dic];
        mcv.delegate = self;
        self.choiceView = mcv;
        [self addSubview:_choiceView];
        
        _choiceIndex = 0;
        
        self.backgroundColor = kControlBgColor;
        
    }
    return self;
}

- (void)configFriendData:(NSArray *)friendData
{
    _friendData = friendData;
    [self.friendTable configData:_friendData];
}

- (void)configGroupData:(NSArray *)groupData
{
    _groupData = groupData;
    [self.groupTable configData:_groupData];
}

// 新的好友的个数
- (void)configNewFriends:(NSString *)number
{
    [self.friendTable addNewFriendsTips:number];
}

#pragma mark -
#pragma mark CSModuleChoiceViewDelegate method
- (void)moduleChoiceView:(UIButton *)sender
{
    _choiceIndex = [self.choiceViewTitles indexOfObject:sender.titleLabel.text];
    
}



#pragma mark - CXFriendTableViewDelegate

- (void)didSelectItemAtIndex:(id)data
{
    [self.delegate didSelectItemAtIndex:data andChoiceIndex:_choiceIndex];
}

- (void)entryNewFriendViewControler
{
    [self.delegate entryNewFriendViewControler];
}


#pragma mark - CXGroupTableViewDelegate

- (void)groupTableDidSelectItemAtIndex:(id)data
{
    [self.delegate didSelectItemAtIndex:data andChoiceIndex:_choiceIndex];
}

@end
