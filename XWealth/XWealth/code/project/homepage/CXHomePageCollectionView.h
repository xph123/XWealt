//
//  CXHomePageCollectionView.h
//  XWealth
//
//  Created by gsycf on 15/12/15.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CXHomePageCollectionViewDelegate <NSObject>
- (void)didSelectItemAtIndex:(id)data;
-(void)collectionViewDidScroll:(UIScrollView *)scrollView;
@end
@interface CXHomePageCollectionView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) id <CXHomePageCollectionViewDelegate> delegate;
@property (nonatomic, strong) NSArray *sourceDatas;

@property (nonatomic, strong) UIButton *promptView;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic,strong) UIView *collectionHeaderView;
@property (nonatomic,strong) UIView *collectionOneSectionView;  //collectionView的section头
@property (nonatomic,strong) UIView *collectionTwoSectionView;
@property (nonatomic,strong) UIView *collectionThreeSectionView;
@property (nonatomic,strong) UIView *collectionFourSectionView;
@property (nonatomic,strong) UIView *collectionFiveSectionView;
@property (nonatomic,strong) UIView *collectionfootView;
@property (nonatomic,strong) UIView *collectionSectionHeaderView;
@property (nonatomic,strong) UINavigationController *navigationController;
//@property (nonatomic, assign) BOOL isHaveSection;

- (void)configData:(NSArray *)sourceDatas;
@end

