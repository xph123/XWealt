//
//  CXCommentTableView.h
//  Link
//
//  Created by chx on 14-11-14.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CXCommentTableviewDelegate <NSObject>

- (void)didSelectItemAtIndex:(id)data;

@end


@interface CXCommentTableView : UIView <UITableViewDataSource,UITableViewDelegate>

{
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *sourceDatas;
@property (nonatomic, weak) id <CXCommentTableviewDelegate> delegate;

- (void)configData:(NSArray *)sourceDatas;

@end
