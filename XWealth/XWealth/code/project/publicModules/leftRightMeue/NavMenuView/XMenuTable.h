//
//  CSMenuTable.h
//  eLearning
//
//  Created by watson on 14-5-22.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CSMenuDelegate <NSObject>
- (void)didBackgroundTap;
- (void)didSelectItemAtIndex:(NSUInteger)index;
@end

@interface XMenuTable : UIView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id <CSMenuDelegate> menuDelegate;

- (id)initWithFrame:(CGRect)frame items:(NSArray *)items;
- (void)show;
- (void)hide;

@end
