//
//  CXAddFriendFrame.h
//  Link
//
//  Created by chx on 14-12-5.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXAddFriendFrame : NSObject

- (id)initWithDataModel:(CXApplyModel *)dataModel;

@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, assign) CGRect cellViewRect;
@property (nonatomic, assign) CGRect headImgRect;
@property (nonatomic, assign) CGRect nameRect;
@property (nonatomic, assign) CGRect signatureRect;
@property (nonatomic, assign) CGRect addFriendBtnRect;
@property (nonatomic, assign) CGRect lineRect;

@property (nonatomic,strong) CXApplyModel *applyModel;
@end
