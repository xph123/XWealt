//
//  CXProductModel.m
//  XWealth
//
//  Created by chx on 15-3-3.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXProductModel.h"

@implementation CXProductModel

- (id)init
{
    if (self = [super init]) {
        _productId = 0;
        _title = @"";
        _proImage=@"";
        _category = 0;
        _moneyInto = @"";
        _scale = 0;
        _deadline = @"";
        _fullDeadline=@"";
        _profit = @"";
        _fullProfit=@"";
        _subscribe = @"";
        _bank = @"";
        _account = @"";
        _accountName = @"";
        _accountBank = @"";
        _assign = @"";
        _proportion = @"";
        _source = @"";
        _riskControl = @"";
        _intro = @"";
        _introPic=@"";
        _transContr=@"";
        _region = @"";
        _financing = @"";
        _guarantor = @"";
        _organization = @"";
        _dateline = @"";
        _state = 0;
        _comment = @"";
        _choice = 0;
        
        _incrementalScale = @"";
        _establishDate = @"";
        _playMomeyDate = @"";
        _earningNote = @"";
        _finacingNote = @"";
        _fundPurpose = @"";
        _brightSpot = @"";
        _contract = @"";
        _specification = @"";
        _material = @"";
        _survey = @"";
        
        _purchase = 0;
        _receipts = 0;
        
        _organizationNote = @"";
        _buyFee = 0;
        _mgrFee = 0;
        _trustteeFee = 0;
        _qdiiFee = 0;
        _reward = @"";
        _lockArea = @"";
        _progressDesc = @"";
        _cost = @"";
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [self init]) {
        _productId = [[dictionary objectForKey:@"id"] longValue];
        _title = [CXModelHelper stringValue: dictionary objectForKey:@"title"];
        _proImage = [CXModelHelper stringValue: dictionary objectForKey:@"proImage"];
        _category = [[dictionary objectForKey:@"category"] intValue];
        
        _moneyInto = [CXModelHelper stringValue: dictionary objectForKey:@"moneyInto"];
        _scale = [[dictionary objectForKey:@"scale"] intValue];
        _deadline = [CXModelHelper stringValue: dictionary objectForKey:@"deadline"];
        _fullDeadline = [CXModelHelper stringValue: dictionary objectForKey:@"fullDeadline"];
        _profit = [CXModelHelper stringValue: dictionary objectForKey:@"profit"];
        _fullProfit = [CXModelHelper stringValue: dictionary objectForKey:@"fullProfit"];
        _subscribe = [CXModelHelper stringValue: dictionary objectForKey:@"subscribe"];
        _bank = [CXModelHelper stringValue: dictionary objectForKey:@"bank"];
        _account = [CXModelHelper stringValue: dictionary objectForKey:@"account"];
        _accountName = [CXModelHelper stringValue: dictionary objectForKey:@"accountName"];
        _accountBank = [CXModelHelper stringValue: dictionary objectForKey:@"accountBank"];
        _assign = [CXModelHelper stringValue: dictionary objectForKey:@"assign"];
        _proportion = [CXModelHelper stringValue: dictionary objectForKey:@"proportion"];
        _source = [CXModelHelper stringValue: dictionary objectForKey:@"source"];
        _riskControl = [CXModelHelper stringValue: dictionary objectForKey:@"riskControl"];
        
        _intro = [CXModelHelper stringValue: dictionary objectForKey:@"intro"];
        _introPic = [CXModelHelper stringValue: dictionary objectForKey:@"introPic"];
        _transContr = [CXModelHelper stringValue: dictionary objectForKey:@"transContr"];
        
        _region = [CXModelHelper stringValue: dictionary objectForKey:@"region"];
        _financing = [CXModelHelper stringValue: dictionary objectForKey:@"financing"];
        _guarantor = [CXModelHelper stringValue: dictionary objectForKey:@"guarantor"];
        _organization = [CXModelHelper stringValue: dictionary objectForKey:@"organization"];
        _dateline = [CXModelHelper stringValue: dictionary objectForKey:@"dateline"];
        _comment = [CXModelHelper stringValue: dictionary objectForKey:@"comment"];
        _state = [[dictionary objectForKey:@"state"] intValue];
        _choice = [[dictionary objectForKey:@"choice"] intValue];
        
        _incrementalScale = [CXModelHelper stringValue: dictionary objectForKey:@"incrementalScale"];
        _establishDate = [CXModelHelper stringValue: dictionary objectForKey:@"establishDate"];
        _playMomeyDate = [CXModelHelper stringValue: dictionary objectForKey:@"playMomeyDate"];
        _earningNote = [CXModelHelper stringValue: dictionary objectForKey:@"earningNote"];
        _finacingNote = [CXModelHelper stringValue: dictionary objectForKey:@"finacingNote"];
        _fundPurpose = [CXModelHelper stringValue: dictionary objectForKey:@"fundPurpose"];
        _brightSpot = [CXModelHelper stringValue: dictionary objectForKey:@"brightSpot"];
        _contract =  [CXURLConstants getWebUrl:[CXModelHelper stringValue: dictionary objectForKey:@"contract"]];
        _specification = [CXURLConstants getWebUrl:[CXModelHelper stringValue: dictionary objectForKey:@"specification"]];
        _material = [CXURLConstants getWebUrl:[CXModelHelper stringValue: dictionary objectForKey:@"material"]];
        _survey = [CXURLConstants getWebUrl:[CXModelHelper stringValue: dictionary objectForKey:@"survey"]];
        _purchase = [[dictionary objectForKey:@"purchase"] intValue];
        _receipts = [[dictionary objectForKey:@"receipts"] intValue];
        
        _buyFee = [[dictionary objectForKey:@"buyFee"] floatValue];
        _mgrFee = [[dictionary objectForKey:@"mgrFee"] floatValue];
        _trustteeFee = [[dictionary objectForKey:@"trustteeFee"] floatValue];
        _qdiiFee = [[dictionary objectForKey:@"qdiiFee"] floatValue];
        _organizationNote = [CXModelHelper stringValue: dictionary objectForKey:@"organizationNote"];
        _reward = [CXModelHelper stringValue: dictionary objectForKey:@"reward"];
        _lockArea = [CXModelHelper stringValue: dictionary objectForKey:@"lockArea"];
        
        _progressDesc = [CXModelHelper stringValue: dictionary objectForKey:@"progressDesc"];
        _cost = [CXModelHelper stringValue: dictionary objectForKey:@"cost"];
        
    }
    return self;
}


@end
