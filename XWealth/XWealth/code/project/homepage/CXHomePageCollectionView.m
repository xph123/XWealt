//
//  CXHomePageCollectionView.m
//  XWealth
//
//  Created by gsycf on 15/12/15.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXHomePageCollectionView.h"
#import "CXHomePageOneCell.h"
#import "CXHomePageOneCellFrame.h"
#import "CXHomePageTwoCell.h"
#import "CXHomePageTwoCellFrame.h"
#import "CXHomePageThreeCell.h"
#import "CXHomePageThreeCellFrame.h"
#import "CXHomePageFourCell.h"
#import "CXHomePagefourCellFrame.h"
#import "CXHomePageFiveCell.h"
#import "CXHomePageFiveCellFrame.h"
#import "CXHomePageSixCell.h"
#import "CXHomePageSixCellFrame.h"
#import "CXClassroomCollectionViewCell.h"
#import "CXClassroomCollectionCellFrame.h"
@implementation CXHomePageCollectionView

- (id)initWithFrame:(CGRect)frame
{
    self = [self initWithFrame:frame style:UITableViewStylePlain];
    if (self) {
        _sourceDatas=[[NSMutableArray alloc]init];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame];
    if (self)
    {
        CGRect textFrame = self.bounds;
        textFrame.origin.x += kDefaultMargin;
        textFrame.size.width -= 2 * kDefaultMargin;
        textFrame.size.height = kLabelHeight;
        
        UIButton * promptButton = [[UIButton alloc] initWithFrame:textFrame];
        [promptButton setBackgroundColor:kColorClear];
        [promptButton setTitle: @"抱歉，没有资讯！" forState: UIControlStateNormal];
        promptButton.titleLabel.font = kLargeTextFont;
        [promptButton setTitleColor:kAssistTextColor forState:UIControlStateNormal];
        [promptButton setImage:[UIImage imageNamed:@"error_prompt"] forState:UIControlStateNormal];
        [promptButton setImageEdgeInsets:UIEdgeInsetsMake(0.0, -20, 0.0, 0.0)];
        promptButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview: promptButton];
        self.promptView = promptButton;
        
        
        
        
        CGRect tableVFrame = self.bounds;
        tableVFrame.origin.y=0;
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing=0;
        layout.minimumInteritemSpacing=0;
        layout.scrollDirection=UICollectionViewScrollDirectionVertical;
        
        self.collectionView=[[UICollectionView alloc]initWithFrame:tableVFrame collectionViewLayout:layout];
        _collectionView.showsVerticalScrollIndicator=NO;
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.backgroundColor=[UIColor whiteColor];
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        [_collectionView registerClass:[CXHomePageOneCell class] forCellWithReuseIdentifier:@"homePageOneCell"];
        [_collectionView registerClass:[CXHomePageTwoCell class] forCellWithReuseIdentifier:@"homePageTwoCell"];
        [_collectionView registerClass:[CXHomePageThreeCell class] forCellWithReuseIdentifier:@"homePageThreeCell"];
        [_collectionView registerClass:[CXClassroomCollectionViewCell class] forCellWithReuseIdentifier:@"classroomCollectionViewCell"];
        [_collectionView registerClass:[CXHomePageFourCell class] forCellWithReuseIdentifier:@"homePageFourCell"];
        [_collectionView registerClass:[CXHomePageFiveCell class] forCellWithReuseIdentifier:@"homePageFiveCell"];
        [_collectionView registerClass:[CXHomePageSixCell class] forCellWithReuseIdentifier:@"homePageSixCell"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"onehead"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"twohead"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"threehead"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"fourhead"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"fivehead"];
        [_collectionView reloadData];
        
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"foot"];
        [self addSubview:_collectionView];
        
    }
    return self;
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _sourceDatas.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section==1&&[_sourceDatas[section] count]>0) {
        return 1;
    }
    return [_sourceDatas[section] count];
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (_sourceDatas!=nil&&_sourceDatas.count>0) {
        switch (indexPath.section) {
            case 0:
            {
                CXHomePageOneCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"homePageOneCell" forIndexPath:indexPath];
                
                if ([_sourceDatas[indexPath.section] count]!=0) {
                    CXInformationModel *model=[_sourceDatas[indexPath.section] objectAtIndex:indexPath.row];
                    cell.informationModel=model;
                }
                return cell;
            }
                break;
            case 1:
            {
                CXHomePageTwoCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"homePageTwoCell" forIndexPath:indexPath];
                if ([_sourceDatas[indexPath.section] count]!=0) {
                    if ([_sourceDatas[indexPath.section] count]!=[cell.arrData count]) {
                        cell.navigationController=self.navigationController;
                        [cell addData:_sourceDatas[indexPath.section]];
                        return cell;
                    }
                    else
                    {
                        for (int i=0; i<[_sourceDatas[indexPath.section] count]; i++) {
                            if (_sourceDatas[indexPath.section][i]!=cell.arrData[i]) {
                                [cell.scrollView removeFromSuperview];
                                [cell.pageControl removeFromSuperview];
                                cell.navigationController=self.navigationController;
                                [cell addData:_sourceDatas[indexPath.section]];
                                return cell;
                            }
                        }
                    }
                }
                return cell;
            }
                 break;
            case 2:
            {
                CXHomePageThreeCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"homePageThreeCell" forIndexPath:indexPath];
                if ([_sourceDatas[indexPath.section] count]!=0) {
                    CXProductModel *model=[_sourceDatas[indexPath.section] objectAtIndex:indexPath.row];
                    cell.productModel=model;
                }
                return cell;
            }
                 break;
            case 3:
            {
                CXClassroomCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"classroomCollectionViewCell" forIndexPath:indexPath];
                if ([_sourceDatas[indexPath.section] count]!=0) {
                    CXCourseModel *model=[_sourceDatas[indexPath.section] objectAtIndex:indexPath.row];
                    cell.courseModel=model;
                }
                return cell;

            }
                 break;
            case 4:
            {
                CXHomePageFourCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"homePageFourCell" forIndexPath:indexPath];
                if ([_sourceDatas[indexPath.section] count]!=0) {
                    CXBenefitModel *model=[_sourceDatas[indexPath.section] objectAtIndex:indexPath.row];
                    cell.BenefitModel=model;
                }
                return cell;
            }
                 break;
            case 5:
            {
                CXHomePageFiveCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"homePageFiveCell" forIndexPath:indexPath];
                if ([_sourceDatas[indexPath.section] count]!=0) {
                    CXBuyBackModel *model=[_sourceDatas[indexPath.section] objectAtIndex:indexPath.row];
                    cell.buyBackModel=model;
                }
                return cell;
            }
                break;
            case 6:
            {
                CXHomePageSixCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"homePageSixCell" forIndexPath:indexPath];
                if ([_sourceDatas[indexPath.section] count]!=0) {
                    CXXintuoBaoModel *model=[_sourceDatas[indexPath.section] objectAtIndex:indexPath.row];
                    cell.xintuoBaoModel=model;
                }
                return cell;
            }
                break;
            default:
                break;
        }
    }
    return cell;
}
//cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([_sourceDatas[indexPath.section] count]!=0) {
        switch (indexPath.section) {
            case 0:
            {
                CXInformationModel *model = [_sourceDatas[indexPath.section] objectAtIndex:indexPath.row];
                CXHomePageOneCellFrame *cellFrame = [[CXHomePageOneCellFrame alloc] initWithDataModel:model];
                return CGSizeMake(kScreenWidth,[cellFrame cellHeight]) ;
            }
                break;
            case 1:
            {
                if (indexPath.row==0) {
                    CXHomePageTwoCellFrame *cellFrame = [[CXHomePageTwoCellFrame alloc] init];
                    return CGSizeMake(kScreenWidth,[cellFrame cellHeight]) ;
                }
                return CGSizeMake(0,0) ;

 
            }
                break;
            case 2:
            {
                CXProductModel *model = [_sourceDatas[indexPath.section] objectAtIndex:indexPath.row];
                CXHomePageThreeCellFrame *cellFrame = [[CXHomePageThreeCellFrame alloc] initWithDataModel:model];
                return CGSizeMake(kScreenWidth,[cellFrame cellHeight]) ;
            }
                break;
            case 3:
            {
                CXCourseModel *model = [_sourceDatas[indexPath.section] objectAtIndex:indexPath.row];
                CXClassroomCollectionCellFrame *cellFrame = [[CXClassroomCollectionCellFrame alloc] initWithDataModel:model];
                return CGSizeMake(KFCollectionViewCellWidth,[cellFrame cellHeight]) ;

            }
                break;
            case 4:
            {
                CXBenefitModel *model = [_sourceDatas[indexPath.section] objectAtIndex:indexPath.row];
                CXHomePagefourCellFrame *cellFrame = [[CXHomePagefourCellFrame alloc] initWithDataModel:model];
                return CGSizeMake(kScreenWidth,[cellFrame cellHeight]+kDefaultMargin) ;
            }
                break;
            case 5:
            {
 
                CXBuyBackModel *model = [_sourceDatas[indexPath.section] objectAtIndex:indexPath.row];
                CXHomePageFiveCellFrame *cellFrame = [[CXHomePageFiveCellFrame alloc] initWithDataModel:model];
                if (indexPath.row==[_sourceDatas[indexPath.section] count]-1) {
                     return CGSizeMake(kScreenWidth,[cellFrame cellHeight]) ;
                }
                else
                {
                     return CGSizeMake(kScreenWidth,[cellFrame cellHeight]+kDefaultMargin) ;
                }
               
            }
                break;
            case 6:
            {
                CXXintuoBaoModel *model = [_sourceDatas[indexPath.section] objectAtIndex:indexPath.row];
                CXHomePageSixCellFrame *cellFrame = [[CXHomePageSixCellFrame alloc] initWithDataModel:model];
                return CGSizeMake(kScreenWidth,[cellFrame cellHeight]) ;
            }
                break;
            default:
                break;
        }
        
    }
    return CGSizeMake(0,0);
}
//偏移量
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if ([_sourceDatas[section] count]!=0) {
        switch (section) {
            case 3:
            {
                 return UIEdgeInsetsMake(8, 8, 8, 8);
            }
                break;
            default:
                 return UIEdgeInsetsMake(0, 0, 0, 0);
                break;
        }
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        int headWith=_collectionHeaderView.frame.size.width;
        int headHeight=_collectionHeaderView.frame.size.height;
        return CGSizeMake(headWith, headHeight);
        
    }

    
 if (_sourceDatas!=nil&&[_sourceDatas count]!=0) {
    if (([_sourceDatas[section] count]>0&&_sourceDatas[section]!=nil)||section==0) {
//        if (section==0) {
//            int headWith=_collectionHeaderView.frame.size.width;
//            int headHeight=_collectionHeaderView.frame.size.height;
//            return CGSizeMake(headWith, headHeight);
//            
//        }
        if (section==3)
        {
            int headWith=_collectionThreeSectionView.frame.size.width;
            int headHeight=_collectionThreeSectionView.frame.size.height;
            return CGSizeMake(headWith, headHeight);

        }
        else if (section==5)
        {
            return CGSizeMake(0, 0);
            
        }
        else if (section==6)
        {
            int headWith=_collectionFiveSectionView.frame.size.width;
            int headHeight=_collectionFiveSectionView.frame.size.height;
            return CGSizeMake(headWith, headHeight);

        }
        
        else
        {
            int headWith=_collectionOneSectionView.frame.size.width;
            int headHeight=_collectionOneSectionView.frame.size.height;
            return CGSizeMake(headWith, headHeight);
        }
    }
 }
    return CGSizeMake(0, 0);
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section==0) {
        int headWith=_collectionfootView.frame.size.width;
        int headHeight=_collectionfootView.frame.size.height;
        return CGSizeMake(headWith, headHeight);
        
    }
    return CGSizeMake(0, 0);

}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        if (indexPath.section==0) {
            UICollectionReusableView *head=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"head" forIndexPath:indexPath];
            for (UIView *view in [head subviews]) {
                [view removeFromSuperview];
            }
            [head addSubview:_collectionHeaderView];
            return head;
        }
        if (_sourceDatas!=nil&&[_sourceDatas count]!=0) {
        if (([_sourceDatas[indexPath.section] count]>0&&_sourceDatas[indexPath.section]!=nil)||indexPath.section==0) {
        switch (indexPath.section) {
//            case 0:
//            {
//                
//                UICollectionReusableView *head=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"head" forIndexPath:indexPath];
//                [head addSubview:_collectionHeaderView];
//                return head;
//            }
//                break;
            case 1:
            {
                UICollectionReusableView *head=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"onehead" forIndexPath:indexPath];
                for (UIView *view in [head subviews]) {
                    [view removeFromSuperview];
                }
                [head addSubview:_collectionOneSectionView];
                return head;
            }
                break;
            case 2:
            {
                UICollectionReusableView *head=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"twohead" forIndexPath:indexPath];
                for (UIView *view in [head subviews]) {
                    [view removeFromSuperview];
                }
                [head addSubview:_collectionTwoSectionView];
                return head;
            }
                break;
            case 3:
            {
                UICollectionReusableView *head=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"threehead" forIndexPath:indexPath];
                for (UIView *view in [head subviews]) {
                    [view removeFromSuperview];
                }
                [head addSubview:_collectionThreeSectionView];
                return head;
            }
                break;
            case 4:
            {
                UICollectionReusableView *head=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"fourhead" forIndexPath:indexPath];
                for (UIView *view in [head subviews]) {
                    [view removeFromSuperview];
                }
                [head addSubview:_collectionFourSectionView];
                return head;
            }
                break;
            case 5:
            {

                
            }
                break;
            case 6:
            {
                UICollectionReusableView *head=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"fivehead" forIndexPath:indexPath];
                for (UIView *view in [head subviews]) {
                    [view removeFromSuperview];
                }
                [head addSubview:_collectionFiveSectionView];
                return head;
            }
                break;
            default:
            {
                UICollectionReusableView *head=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"head" forIndexPath:indexPath];
                for (UIView *view in [head subviews]) {
                    [view removeFromSuperview];
                }

                [head addSubview:_collectionHeaderView];
                return head;
            }
                break;
        }
    }
    }
    }
         else if ([kind isEqualToString:UICollectionElementKindSectionFooter])
         {
             if (indexPath.section==0) {
                 
                 UICollectionReusableView *foot = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"foot" forIndexPath:indexPath];
                 for (UIView *view in [foot subviews]) {
                     [view removeFromSuperview];
                 }
                [foot addSubview:_collectionfootView];
                 return foot;

             }
    }

    UICollectionReusableView *head=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"head" forIndexPath:indexPath];
    return head;

}
//左右间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (section==3) {
        return 8;
    }
    return 0;
}
//上下间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (section==3) {
        return 8;
    }
    else if (section==2)
    {
        return 4;
    }
    else if (section==6)
    {
        return 1;
    }
    return 0;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        
    }
    else
    {
        [self.delegate didSelectItemAtIndex:indexPath];
    }
    
}
#pragma mark - data

- (void) configData:(NSArray *)sourceDatas
{
    _sourceDatas = sourceDatas;
    
    if ([self.sourceDatas count] == 0&&self.collectionHeaderView==nil)
    {
        self.promptView.hidden = NO;
        self.collectionView.hidden = YES;
    }
    else
    {
        self.promptView.hidden = YES;
        self.collectionView.hidden = NO;
        
        [self.collectionView reloadData];
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.delegate collectionViewDidScroll:scrollView];
}

@end
