//
//  CXModifyGroupDescViewController.h
//  Link
//
//  Created by chx on 14-12-9.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXModifyGroupDescViewController : UIViewController<UITextViewDelegate>

@property (strong, nonatomic) UITextView *textView;
@property (strong, nonatomic) NSString *text;
@property (assign, nonatomic) NSString *type;

@property (nonatomic, strong) CXGroupModel *groupModel;

- (id) initWithGroupModel:(CXGroupModel*)groupModel;

@end
