//
//  CXClassroomCollectionView.h
//  XWealth
//
//  Created by gsycf on 15/9/14.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXClassroomCollectionViewCell.h"
#import "CXClassroomExpertCollectionViewCell.h"
#import "CXClassroomExpertCellFrame.h"
@protocol CXClassroomCollectionViewDelegate <NSObject>
- (void)didSelectItemAtIndex:(id)data;
-(void)collectionViewDidScroll:(UIScrollView *)scrollView;
@end
@interface CXClassroomCollectionView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) id <CXClassroomCollectionViewDelegate> delegate;
@property (nonatomic, strong) NSArray *sourceDatas;

@property (nonatomic, strong) UIButton *promptView;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic,strong) UIView *collectionHeaderView;  //collectionView的section头
@property (nonatomic,strong) UIView *collectionfootView;
@property (nonatomic,strong) UIView *collectionSectionHeaderView;
//@property (nonatomic, assign) BOOL isHaveSection;

- (void)configData:(NSArray *)sourceDatas;
@end

