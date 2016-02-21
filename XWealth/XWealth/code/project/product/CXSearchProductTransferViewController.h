//
//  CXSearchProductTransferViewController.h
//  XWealth
//
//  Created by gsycf on 15/10/27.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXProductTableView.h"
#import "CXSearchProductTransferView.h"
#import "CXSelectTableViewController.h"

typedef void (^ActionProductBlk)(NSInteger, NSString*);
@interface CXSearchProductTransferViewController : XViewController<UISearchBarDelegate, UIAlertViewDelegate, CXProductTableViewDelegate,CXSearchProductTransferViewDelegate,CXSelectTableViewControllerDelegate,UIAlertViewDelegate>
{
    BOOL _reload;
    BOOL _hasMore;
    BOOL _isLoadingMore;
    void(^modelBlk)(CXProductModel *model);
}

@property (nonatomic, strong) CXProductTableView *tableView;
@property (nonatomic, strong) CXSearchProductTransferView *conditionView;
@property (nonatomic, strong) UIButton *loadMoreBtn;
@property (nonatomic, strong) UILabel *noFriend;
//三个按钮的要上传的id
@property(nonatomic,assign)NSInteger subscribeCategory;
@property(nonatomic,assign)NSInteger deadlineCategory;
@property(nonatomic,assign)NSInteger profitCategory;

@property (nonatomic, strong) NSMutableArray *productList;


@property (nonatomic, strong) NSIndexPath *currentIndexPath;
@property (nonatomic, strong)CXProductModel *productModel;

@property (nonatomic, copy) ActionProductBlk selectProductBlk;

-(void)getModel:(void(^)(CXProductModel *model))blk;

@end
