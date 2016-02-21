//
//  CXGroupMemberView.m
//  Link
//
//  Created by chx on 14-12-8.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXGroupMemberView.h"
#import "CXGroupMemberCell.h"

@interface CXGroupMemberView ()
{
}

@end

@implementation CXGroupMemberView

- (id)initWithItems:(NSArray *)items
{
    self = [super init];
    if (self) {
        _userList = items;
        
        //[self numberOfRows] *ProjectGridCellHeight;
        
        //        self.table = [[UIGridView alloc] initWithFrame:startFrame style:UITableViewStylePlain];
        self.table = [[UIGridView alloc] init];
        self.table.frame = CGRectZero;
        self.table.uiGridViewDelegate = self;
        self.table.backgroundColor = [UIColor clearColor];
        self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self addSubview:self.table];
    }
    return self;
}

- (int) numberOfRows
{
    int rows = (self.userList.count / kGridColumns);
    if ((self.userList.count % kGridColumns) > 0)
    {
        rows += 1;
    }
    
    return rows;
}


- (CGFloat) gridView:(UIGridView *)grid widthForColumnAt:(int)columnIndex
{
    return kGridCellWidth;
}

- (CGFloat) gridView:(UIGridView *)grid heightForRowAt:(int)rowIndex
{
    return kGridCellHeight;
}

- (NSInteger) numberOfColumnsOfGridView:(UIGridView *) grid
{
    return kGridColumns;
}


- (NSInteger) numberOfCellsOfGridView:(UIGridView *) grid
{
    return [_userList count];
}

- (UIGridViewCell *) gridView:(UIGridView *)grid cellForRowAt:(int)rowIndex AndColumnAt:(int)columnIndex
{
    CXGroupMemberCell *cell = (CXGroupMemberCell *)[grid dequeueReusableCell];
    
    if (cell == nil) {
        cell = [[CXGroupMemberCell alloc] init];
    }
    
    [cell setUserModel:[_userList objectAtIndex:rowIndex * kGridColumns + columnIndex]];
    
    return cell;
}

- (void) gridView:(UIGridView *)grid didSelectRowAt:(int)rowIndex AndColumnAt:(int)colIndex
{
    NSLog(@"%d, %d clicked", rowIndex, colIndex);
    [self.grideDelegate gridView:grid didSelectRowAt:rowIndex AndColumnAt:colIndex];
}

- (void) reloadData
{
    [self.table reloadData];
};

@end
