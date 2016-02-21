//
//  CXXtbAccount.m
//  XWealth
//
//  Created by chx on 15/9/9.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXXtbAccountModel.h"

@implementation CXXtbAccountModel

- (id)init
{
    if (self = [super init]) {
        self.mid = 0;
        self.hasOpenAutoBid = 1;
        self.accountId = @"";
        self.trueName = @"";
        self.openTime = @"";
        self.bankCode = @"";
        self.cardNo = @"";
        self.bindTime = @"";
        self.addFundUrl = @"";
        self.getFundUrl = @"";
        
        self.openUrl = @"";
        self.autoBidUrl = @"";
        self.cashUrl = @"";
        self.inviteRewardUrl = @"";
        self.saleUrl=@"";
        self.gsbInvestStream=@"";
        self.gsbInvestRecord = @"";
        
        self.totalFund = 0;
        self.availableFund = 0;
        self.freezeFund = 0;
        self.dueFund = 0;
        self.addIncome = 0;
        
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    
    if (self = [self init]) {
        self.mid = [[dictionary objectForKey:@"mid"] intValue];
        self.hasOpenAutoBid = [[dictionary objectForKey:@"hasOpenAutoBid"] intValue];
        self.accountId = [dictionary objectForKey:@"accountId"];
        self.trueName = [dictionary objectForKey:@"trueName"];
        self.openTime = [dictionary objectForKey:@"openTime"];
        self.bankCode = [dictionary objectForKey:@"bankCode"];
        self.cardNo = [dictionary objectForKey:@"cardNo"];
        self.bindTime = [dictionary objectForKey:@"bindTime"];
        self.addFundUrl = [dictionary objectForKey:@"addFundUrl"];
        self.getFundUrl = [dictionary objectForKey:@"getFundUrl"];
        self.openUrl = [dictionary objectForKey:@"openUrl"];
        self.autoBidUrl = [dictionary objectForKey:@"autoBidUrl"];
        self.cashUrl = [dictionary objectForKey:@"cashUrl"];
        self.inviteRewardUrl = [dictionary objectForKey:@"inviteRewardUrl"];
        self.saleUrl = [dictionary objectForKey:@"saleUrl"];
        self.gsbInvestRecord = [dictionary objectForKey:@"gsbInvestRecord"];
        self.gsbInvestStream = [dictionary objectForKey:@"gsbInvestStream"];
        self.fundCustodyUrl = [dictionary objectForKey:@"fundCustodyUrl"];
        self.updatePayPwd = [dictionary objectForKey:@"updatePayPwd"];
        
        self.totalFund = [[dictionary objectForKey:@"totalFund"] floatValue];
        self.availableFund = [[dictionary objectForKey:@"availableFund"] floatValue];
        self.freezeFund = [[dictionary objectForKey:@"freezeFund"] floatValue];
        self.dueFund = [[dictionary objectForKey:@"dueFund"] floatValue];
        self.addIncome = [[dictionary objectForKey:@"addIncome"] floatValue];

        
    }

    return self;
}
@end
