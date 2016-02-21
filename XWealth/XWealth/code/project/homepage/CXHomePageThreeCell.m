//
//  CXHomePageThreeCell.m
//  XWealth
//
//  Created by gsycf on 15/12/15.
//  Copyright © 2015年 rasc. All rights reserved.
//

#import "CXHomePageThreeCell.h"

@implementation CXHomePageThreeCell
- (id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}
- (void) initSubviews
{
    self.backgroundColor = kControlBgColor;
    
    _cellView = [[UIView alloc] initWithFrame:CGRectZero];
    _cellView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_cellView];
    
    _imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [_cellView addSubview:_imgView];

}
-(void)setProductModel:(CXProductModel *)productModel
{
    _productModel = productModel;
    _layout = [[CXHomePageThreeCellFrame alloc] initWithDataModel:_productModel];
    
    _cellView.frame = [_layout cellViewRect];
    _imgView.frame=[_layout imageViewRect];
    [_imgView sd_setImageWithURL:[NSURL URLWithString:[CXURLConstants getFullSltInformationUrl: self.productModel.proImage]] placeholderImage:[UIImage imageNamed:@"defaule_image"]];

}
@end
