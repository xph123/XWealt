//
//  CXCategoryModel.h
//  eLearning
//
//  Created by watson on 14-5-22.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXCategoryModel : NSObject

@property (assign, nonatomic) int Id;
@property (strong, nonatomic) NSString *name; //
@property (strong, nonatomic) NSString *logoUrl; //
@property (assign, nonatomic) int state;
@property (assign, nonatomic) NSInteger value;
@property (assign, nonatomic) NSInteger ptypeId;
@property (strong, nonatomic) NSString *column1;
@property (strong, nonatomic) NSString *column2;
@property (strong, nonatomic) NSString *column3;
@property (assign, nonatomic) NSInteger categoryId;
@property (strong, nonatomic) NSString *dateline;
@property (strong, nonatomic) NSString *url;
- (id)initWithProductDictionary:(NSDictionary *)dictionary;
- (id)initWithInformationDictionary:(NSDictionary *)dictionary;
- (id)init:(int)Id andName:(NSString*)name andImg:(NSString*)logoUrl;

@end
