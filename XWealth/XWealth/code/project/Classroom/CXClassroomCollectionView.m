//
//  CXClassroomCollectionView.m
//  XWealth
//
//  Created by gsycf on 15/9/14.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXClassroomCollectionView.h"
#import "CXClassroomCollectionCellFrame.h"

@implementation CXClassroomCollectionView
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
                [promptButton setTitle: @"抱歉，没有课堂消息！" forState: UIControlStateNormal];
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
         [_collectionView registerClass:[CXClassroomExpertCollectionViewCell class] forCellWithReuseIdentifier:@"classroomExpertCollectionViewCell"];
         [_collectionView registerClass:[CXClassroomCollectionViewCell class] forCellWithReuseIdentifier:@"classroomCollectionViewCell"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"onehead"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"foot"];
        [_collectionView reloadData];
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
    return [_sourceDatas[section] count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (_sourceDatas!=nil&&_sourceDatas.count>0) {
    switch (indexPath.section) {
        case 0:
        {
            CXClassroomExpertCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"classroomExpertCollectionViewCell" forIndexPath:indexPath];
            
            if ([_sourceDatas[indexPath.section] count]!=0) {
                CXExpertModel *model=[_sourceDatas[indexPath.section] objectAtIndex:indexPath.row];
                cell.expertModel=model;
            }
            return cell;
        }
            break;
        case 1:
        {
            CXClassroomCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"classroomCollectionViewCell" forIndexPath:indexPath];
            if ([_sourceDatas[indexPath.section] count]!=0) {
                CXCourseModel *model=[_sourceDatas[indexPath.section] objectAtIndex:indexPath.row];
                cell.courseModel=model;
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
                CXExpertModel *model = [_sourceDatas[indexPath.section] objectAtIndex:indexPath.row];
                CXClassroomExpertCellFrame *cellFrame = [[CXClassroomExpertCellFrame alloc] initWithDataModel:model];
                return CGSizeMake(kScreenWidth,[cellFrame cellHeight]) ;
            }
                break;
            case 1:
            {
                CXCourseModel *model = [_sourceDatas[indexPath.section] objectAtIndex:indexPath.row];
                CXClassroomCollectionCellFrame *cellFrame = [[CXClassroomCollectionCellFrame alloc] initWithDataModel:model];
                return CGSizeMake(KFCollectionViewCellWidth,[cellFrame cellHeight]) ;
            }
                break;
            default:
                break;
        }
       
    }
    return CGSizeMake(0,0);
    //    return CGSizeMake(KFCollectionViewCellWidth, KFCollectionViewCellHeight);
}
//偏移量
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if ([_sourceDatas[section] count]!=0) {
        switch (section) {
            case 0:
            {
                return UIEdgeInsetsMake(0, 0, 0, 0);
            }
                break;
            case 1:
            {
                return UIEdgeInsetsMake(8, 8, 8, 8);
            }
                break;
            default:
                break;
        }
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
     if ([_sourceDatas[section] count]>0&&_sourceDatas[section]!=nil) {
         if (_sourceDatas[0]==nil||[_sourceDatas[0] count]==0) {
             int headWith=_collectionHeaderView.frame.size.width;
             int headHeight=_collectionHeaderView.frame.size.height;
             return CGSizeMake(headWith, headHeight);
         }
         else
         {
             if (section==0) {
        int headWith=_collectionHeaderView.frame.size.width;
        int headHeight=_collectionHeaderView.frame.size.height;
        return CGSizeMake(headWith, headHeight);
        
             }
             else if (section==1)
             {
        int headWith=kScreenWidth;
        int headHeight=kFunctionBarHeight+kDefaultMargin;
        return CGSizeMake(headWith, headHeight);
             }
         }
     }
    return CGSizeMake(0, 0);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
         if (_sourceDatas[0]==nil||[_sourceDatas[0] count]==0) {
             
             UICollectionReusableView *head=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"onehead" forIndexPath:indexPath];
             for (UIView *view in [head subviews]) {
                 [view removeFromSuperview];
             }

             [head addSubview:_collectionHeaderView];
             
             return head;

         }
        else
        {
            switch (indexPath.section) {
                case 0:
                {
                    
                    UICollectionReusableView *head=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"head" forIndexPath:indexPath];
                    
                    for (UIView *view in [head subviews]) {
                        [view removeFromSuperview];
                    }

                    [head addSubview:_collectionHeaderView];
                    
                    return head;
                }
                    
                    break;
                case 1:
                {
                    if ([_sourceDatas[indexPath.section] count]>0&&_sourceDatas[indexPath.section]!=nil) {
                        
                        UICollectionReusableView *head=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"onehead" forIndexPath:indexPath];
                        for (UIView *view in [head subviews]) {
                            [view removeFromSuperview];
                        }

                        UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, kScreenWidth, kFunctionBarHeight+kDefaultMargin)];
                        customView.backgroundColor = kControlBgColor;
                        
                        UIView *flagView = [[UIView alloc] initWithFrame:CGRectZero];
                        flagView.backgroundColor = [UIColor whiteColor];
                        
                        UIView* leftView = [[UIView alloc] initWithFrame:CGRectMake(kSmallMargin, 13, 3, kIconSmallHeight-1)];
                        leftView.backgroundColor = [UIColor redColor];
                        [flagView addSubview:leftView];
                        
                        
                        //加框
                        CGFloat x = 0;
                        CGFloat y = kDefaultMargin;
                        CGFloat width = kScreenWidth;
                        CGFloat height = kFunctionBarHeight - 0.5;
                        CGRect rect = CGRectMake(x, y, width, height);
                        flagView.frame = rect;
                        [customView addSubview:flagView];
                        
                        
                        rect.origin.x=kMiddleMargin;
                        rect.origin.y=0;
                        UILabel *titleLable = [[UILabel alloc]initWithFrame:rect];
                        titleLable.text = @"推荐课程";
                        titleLable.font = kMiddleTextFontBold;
                        titleLable.textColor = [UIColor grayColor];
                        titleLable.numberOfLines = 1;
                        [flagView addSubview:titleLable];
                        
                        
                        [head addSubview:customView];
                        
                        return head;
                    }
                }
                    break;
                default:
                    break;
            }
        }
   
    }
//     else if ([kind isEqualToString:UICollectionElementKindSectionFooter])
//     {
//         //这里是尾部
//         UICollectionReusableView *foot = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"foot" forIndexPath:indexPath];
//         [foot addSubview:_collectionfootView];
//         return foot;
//     }

    return nil;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (section==1) {
        return 8;
    }
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (section==1) {
        return 8;
    }
    return 0;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate didSelectItemAtIndex:indexPath];
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
