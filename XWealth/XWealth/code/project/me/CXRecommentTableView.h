//
//  CXRecommentTableView.h
//  XWealth
//
//  Created by chx on 15/7/4.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CXRecommentTableViewDelegate <NSObject>

- (void)recommentFriend:(CXRecommentModel*) model andIndex:(NSIndexPath *)indexPath;
@end


@interface CXRecommentTableView : UIView<UITableViewDataSource,UITableViewDelegate,UISearchDisplayDelegate>

@property (nonatomic, strong) UITableView *tableView;

// 所有好友的名字表
@property (nonatomic, copy) NSMutableArray *allFriendName;
// 所有好友名字与CXUserModel的对应表
@property (nonatomic, copy) NSMutableDictionary *allFriendDic;
// section和右边显示的字母
@property(nonatomic,retain)NSMutableArray *indexArray;
//设置每个字母下的名字表
@property(nonatomic,retain)NSMutableArray *LetterResultArr;

@property (nonatomic) NSInteger addFriendNum;
@property (nonatomic)int nameNum;

@property (nonatomic,strong)NSMutableArray *allSearchArr;
//搜索
@property (nonatomic,strong)UISearchBar *NameSearchBar;
@property (nonatomic,strong)UISearchDisplayController *NameSearchDisplayController;

@property (nonatomic, weak) id <CXRecommentTableViewDelegate> delegate;
@property (nonatomic,strong) UINavigationController *navigationController;
- (void)configData:(NSArray *)friendList;
//传到tableview增加搜索代理
-(void)setSearchbar:(void(^)(void))block;
@end
