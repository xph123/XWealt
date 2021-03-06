//
//  CXClassroomListCollectionView.h
//  XWealth
//
//  Created by gsycf on 15/12/10.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXClassroomCollectionViewCell.h"
@protocol CXClassroomListCollectionViewDelegate <NSObject>
- (void)didSelectItemAtIndex:(id)data;
-(void)collectionViewDidScroll:(UIScrollView *)scrollView;
@end
@interface CXClassroomListCollectionView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) id <CXClassroomListCollectionViewDelegate> delegate;
@property (nonatomic, strong) NSArray *sourceDatas;

@property (nonatomic, strong) UIButton *promptView;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic,strong) UIView *collectionHeaderView;  //collectionView的section头
@property (nonatomic,strong) UIView *collectionfootView;

//@property (nonatomic, assign) BOOL isHaveSection;

- (void)configData:(NSArray *)sourceDatas;

@end
