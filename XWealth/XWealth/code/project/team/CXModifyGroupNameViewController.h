//
//  CXModifyGroupNameViewController.h
//  Link
//
//  Created by chx on 14-12-9.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXModifyGroupNameViewController : UIViewController

@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) NSString *text;
@property (nonatomic, strong) CXGroupModel *groupModel;

- (id) initWithGroupModel:(CXGroupModel*)groupModel;

@end
