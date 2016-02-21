//
//  CSMenuCell.h
//  eLearning
//
//  Created by watson on 14-5-22.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMenuCell : UITableViewCell

- (void)setSelected:(BOOL)selected withCompletionBlock:(void (^)())completion;

@end
