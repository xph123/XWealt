//
//  CXCommentFrame.h
//  Link
//
//  Created by chx on 14-11-24.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXCommentFrame : NSObject

- (id)initWithDataModel:(CXCommentModel *)commentModel;
@property (nonatomic, strong) CXCommentModel *commentModel;

@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, assign) CGRect headRect;
@property (nonatomic, assign) CGRect nameRect;
@property (nonatomic, assign) CGRect contentRect;
@property (nonatomic, assign) CGRect datelineRect;
@property (nonatomic, assign) CGRect lineRect;

@end
