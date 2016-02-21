//
//  CXClassroomListCollectionView.m
//  XWealth
//
//  Created by gsycf on 15/12/10.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXClassroomListCollectionView.h"
#import "CXClassroomCollectionCellFrame.h"

@implementation CXClassroomListCollectionView

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
        layout.minimumLineSpacing=8;
        layout.minimumInteritemSpacing=8;
        layout.scrollDirection=UICollectionViewScrollDirectionVertical;
        
        self.collectionView=[[UICollectionView alloc]initWithFrame:tableVFrame collectionViewLayout:layout];
        _collectionView.showsVerticalScrollIndicator=NO;
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.backgroundColor=[UIColor whiteColor];
        
        [_collectionView registerClass:[CXClassroomCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
//        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head"];
//        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"foot"];
        [_collectionView reloadData];
        [self addSubview:_collectionView];
        
    }
    return self;
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _sourceDatas.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CXClassroomCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    if (_sourceDatas.count!=0) {
        CXCourseModel *coursemodel=_sourceDatas[indexPath.row];
        cell.courseModel=coursemodel;
    }
    return cell;
}
//cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_sourceDatas.count!=0) {
        CXCourseModel *model = [_sourceDatas objectAtIndex:indexPath.row];
        CXClassroomCollectionCellFrame *cellFrame = [[CXClassroomCollectionCellFrame alloc] initWithDataModel:model];
        return CGSizeMake(KFCollectionViewCellWidth,[cellFrame cellHeight]) ;
    }
    return CGSizeMake(0,0);
    //    return CGSizeMake(KFCollectionViewCellWidth, KFCollectionViewCellHeight);
}
//偏移量
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    //    return UIEdgeInsetsZero;
    return UIEdgeInsetsMake(8, 8, 8, 8);
}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    if (section==0) {
//        int headWith=_collectionHeaderView.frame.size.width;
//        int headHeight=_collectionHeaderView.frame.size.height;
//        return CGSizeMake(headWith, headHeight);
//        
//    }
//    return CGSizeMake(0, 0);
//}
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
//        UICollectionReusableView *head=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"head" forIndexPath:indexPath];
//        [head addSubview:_collectionHeaderView];
//        
//        return head;
//    }
//    else if ([kind isEqualToString:UICollectionElementKindSectionFooter])
//    {
//        //这里是尾部
//        UICollectionReusableView *foot = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"foot" forIndexPath:indexPath];
//        [foot addSubview:_collectionfootView];
//        return foot;
//    }
//    
//    return nil;
//}
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
