//
//  CSJsonDataParsing.m
//  xProject
//
//  Created by yi.chen on 14-4-28.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXJsonDataParsing.h"

#import "CXDataCenter.h"

@implementation CXJsonDataParsing

+ (id)parsingServiceJsonData:(id)data stringURL:(NSString *)strURL
{
    if(!data || ![data isKindOfClass:[NSDictionary class]])
    {
        return nil;
    }
    
    NSDictionary *dicJson = (NSDictionary *)data;
    CXMainPlate *mPlate = [CXMainPlate new];
    mPlate.service = [dicJson objectForKey:@"service"];
    mPlate.code = [dicJson objectForKey:@"ret"];
    mPlate.anyModels = [[NSMutableArray alloc] init];
    mPlate.additionalModels = [[NSMutableArray alloc] init];
    
    
    // -----------------我------------------
    if ([strURL isEqualToString:POST_ME_MODIFY_USERHEAD])
    {
        // 修改头像 
        NSString *headImg = [CXURLConstants getFullHeaderUrl:[CXModelHelper stringValue: dicJson objectForKey:@"head"]];
        [(NSMutableArray *)mPlate.anyModels addObject:headImg];
    }
    else if ([strURL isEqualToString:POST_ME_MODIFY_BGIMAGE])
    {
        // 修改背景图片
        NSString *headImg = [CXModelHelper stringValue: dicJson objectForKey:@"statusBg"];
        [(NSMutableArray *)mPlate.anyModels addObject:headImg];
    }

    // -----------------系统----------------
    else if ([strURL isEqualToString:GET_LOGIN])
    {
        // 登录 登录成功，返回的用户数据不解析，直接返回用于保存到文件 
        NSDictionary *userDic = [dicJson objectForKey:@"user"];
        CXUserModel *model = [[CXUserModel alloc] initWithDictionary:userDic];
        [(NSMutableArray *)mPlate.anyModels addObject:model];
//        [(NSMutableArray *)mPlate.anyModels addObject:userDic];
    }
    else if ([strURL isEqualToString:GET_AUTHCODE])
    {
        // 得到验证码
//        NSString *authcode = [dicJson objectForKey:@"authcode"];
//        [(NSMutableArray *)mPlate.anyModels addObject:authcode];
        //        [(NSMutableArray *)mPlate.anyModels addObject:userDic];
    }
    else if ([strURL isEqualToString:GET_REGBYEMAIL] || [strURL isEqualToString:GET_REGBYPHONE])
    {
        // 注册，返回的用户数据不解析，直接返回用于保存到文件 
        NSDictionary *userDic = [dicJson objectForKey:@"user"];
        CXUserModel *model = [[CXUserModel alloc] initWithDictionary:userDic];
        [(NSMutableArray *)mPlate.anyModels addObject:model];
//        [(NSMutableArray *)mPlate.anyModels addObject:userDic];
    }
    else if ([strURL isEqualToString:GET_SYSTEM_UPDATE])
    {
        // 注册，返回的用户数据不解析，直接返回用于保存到文件
        NSDictionary *userDic = [dicJson objectForKey:@"user"];
        CXUserModel *model = [[CXUserModel alloc] initWithDictionary:userDic];
        [(NSMutableArray *)mPlate.anyModels addObject:model];
        //        [(NSMutableArray *)mPlate.anyModels addObject:userDic];
    }
    // -----------------好友----------------
    else if ([strURL isEqualToString:GET_FRIENDLIST])
    {
        // 好友列表
        NSArray *arrCamp = [dicJson objectForKey:@"list"];
        int index = 0;
        while (index < arrCamp.count) {
            CXUserModel *model = [[CXUserModel alloc] initWithDictionary:arrCamp[index]];
            [(NSMutableArray *)mPlate.anyModels addObject:model];
            index++;
        }
    }
    else if ([strURL isEqualToString:GET_SEARCHFRIEND])
    {
        // 搜索好友列表
        NSArray *arrCamp = [dicJson objectForKey:@"list"];
        int index = 0;
        while (index < arrCamp.count) {
            CXUserModel *model = [[CXUserModel alloc] initWithDictionary:arrCamp[index]];
            [(NSMutableArray *)mPlate.anyModels addObject:model];
            index++;
        }
    }
    else if ([strURL isEqualToString:GET_NEWFRIENDS])
    {
        // 好友列表
        NSArray *arrCamp = [dicJson objectForKey:@"list"];
        int index = 0;
        while (index < arrCamp.count) {
            CXAddFriendModel *model = [[CXAddFriendModel alloc] initWithDictionary:arrCamp[index]];
            [(NSMutableArray *)mPlate.anyModels addObject:model];
            index++;
        }

    }
    else if ([strURL isEqualToString:GET_ADDFRIEND_REFUSE] || [strURL isEqualToString:GET_ADDFRIEND_AGREE])
    {
        // code：0 为成功，不需要处理其它数据
    }
    else if ([strURL isEqualToString:GET_ADDFRIEND])
    {
        NSString *isFriends = [dicJson objectForKey:@"isFriends"];
        [(NSMutableArray *)mPlate.anyModels addObject:isFriends];
    }
    else if ([strURL isEqualToString:GET_USERINFO])
    {
        NSDictionary *userDic = [dicJson objectForKey:@"user"];
        CXUserModel *model = [[CXUserModel alloc] initWithDictionary:userDic];
        [(NSMutableArray *)mPlate.anyModels addObject:model];
    }
    // 群
    else if ([strURL isEqualToString:GET_GROUPLIST])
    {
        // 好友列表
        NSArray *arrCamp = [dicJson objectForKey:@"list"];
        int index = 0;
        while (index < arrCamp.count) {
            CXGroupModel *model = [[CXGroupModel alloc] initWithDictionary:arrCamp[index]];
            [(NSMutableArray *)mPlate.anyModels addObject:model];
            index++;
        }
    }
    else if ([strURL isEqualToString:POST_CREATE_GROUP] || [strURL isEqualToString:POST_GROUP_MODIFYLOGO])
    {
        NSDictionary *groupDic = [dicJson objectForKey:@"group"];
        CXGroupModel *model = [[CXGroupModel alloc] initWithDictionary:groupDic];
        [(NSMutableArray *)mPlate.anyModels addObject:model];
    }
    else if ([strURL isEqualToString:GET_GROUP_SEARCH])
    {
        // 搜索好友列表
        NSArray *arrCamp = [dicJson objectForKey:@"list"];
        int index = 0;
        while (index < arrCamp.count) {
            CXGroupModel *model = [[CXGroupModel alloc] initWithDictionary:arrCamp[index]];
            [(NSMutableArray *)mPlate.anyModels addObject:model];
            index++;
        }
    }
    else if ([strURL isEqualToString:GET_GROUP_MEMBERS])
    {
        // 搜索好友列表
        NSArray *arrCamp = [dicJson objectForKey:@"list"];
        int index = 0;
        while (index < arrCamp.count) {
            CXUserModel *model = [[CXUserModel alloc] initWithDictionary:arrCamp[index]];
            [(NSMutableArray *)mPlate.anyModels addObject:model];
            index++;
        }
    }
    else if ([strURL isEqualToString:GET_BANNERS]||[strURL isEqualToString:GET_BANNER_LISTCOURSE]||[strURL isEqualToString:GET_BANNER_SECONDHOMEPAGE])
    {
        // banner列表
        NSArray *arrCamp = [dicJson objectForKey:@"list"];
        int index = 0;
        while (index < arrCamp.count) {
            CXBannerModel *model = [[CXBannerModel alloc] initWithDictionary:arrCamp[index]];
            [(NSMutableArray *)mPlate.anyModels addObject:model];
            index++;
        }
    }
    else if ([strURL isEqualToString:GET_POPACTIVITY])
    {
        NSDictionary *activityDic = [dicJson objectForKey:@"activity"];
        CXPopActivityModel *model = [[CXPopActivityModel alloc] initWithDictionary:activityDic];
        [(NSMutableArray *)mPlate.anyModels addObject:model];
    }
    else if ([strURL isEqualToString:GET_INFORMATIONS] || [strURL isEqualToString:GET_INFORMATION_SEARCH]||[strURL isEqualToString:GET_USER_FAVORITEINFOLIST])
    {
        // 资讯列表，推荐资讯
        NSArray *arrCamp = [dicJson objectForKey:@"list"];
        int index = 0;
        while (index < arrCamp.count) {
            CXInformationModel *model = [[CXInformationModel alloc] initWithDictionary:arrCamp[index]];
            [(NSMutableArray *)mPlate.anyModels addObject:model];
            index++;
        }
    }
    else if ( [strURL isEqualToString:GET_INFORMATION_RECOMMENDS])
    {
        // 首页资讯内容
        NSArray *listArrCamp = [dicJson objectForKey:@"list"];
        NSArray *fireHostArrCamp = [dicJson objectForKey:@"fireHostList"];
        NSArray *hotProArrCamp = [dicJson objectForKey:@"hotProList"];
        NSArray *classroomArrCamp = [dicJson objectForKey:@"courseList"];
        NSArray *benefitArrCamp = [dicJson objectForKey:@"benefitList"];
        NSArray *buybackArrCamp = [dicJson objectForKey:@"buybackList"];
        NSArray *xtbArrCamp = [dicJson objectForKey:@"xtbList"];
        NSMutableArray *listArr=[[NSMutableArray alloc]init];;
         NSMutableArray *fireHostArr=[[NSMutableArray alloc]init];
         NSMutableArray *hotProArr=[[NSMutableArray alloc]init];
        NSMutableArray *classroomArr=[[NSMutableArray alloc]init];
        NSMutableArray *benefitArr=[[NSMutableArray alloc]init];
        NSMutableArray *buybackArr=[[NSMutableArray alloc]init];
         NSMutableArray *xtbArr=[[NSMutableArray alloc]init];
        int index = 0;
        while (index < listArrCamp.count) {
            CXInformationModel *model = [[CXInformationModel alloc] initWithDictionary:listArrCamp[index]];
            [listArr addObject:model];
            index++;
        }
         [(NSMutableArray *)mPlate.anyModels addObject:listArr];
        
        index = 0;
        while (index < fireHostArrCamp.count) {
            CXProductModel *model = [[CXProductModel alloc] initWithDictionary:fireHostArrCamp[index]];
            [fireHostArr addObject:model];
            index++;
        }
         [(NSMutableArray *)mPlate.anyModels addObject:fireHostArr];
        
        index = 0;
        while (index < hotProArrCamp.count) {
            CXProductModel *model = [[CXProductModel alloc] initWithDictionary:hotProArrCamp[index]];
            [hotProArr addObject:model];
            index++;
        }
        [(NSMutableArray *)mPlate.anyModels addObject:hotProArr];
        
        index = 0;
        while (index < classroomArrCamp.count) {
            CXCourseModel *model = [[CXCourseModel alloc] initWithDictionary:classroomArrCamp[index]];
            [classroomArr addObject:model];
            index++;
        }
        [(NSMutableArray *)mPlate.anyModels addObject:classroomArr];
        
        index = 0;
        while (index < benefitArrCamp.count) {
            CXBenefitModel *model = [[CXBenefitModel alloc] initWithDictionary:benefitArrCamp[index]];
            [benefitArr addObject:model];
            index++;
        }
        [(NSMutableArray *)mPlate.anyModels addObject:benefitArr];
        
        index = 0;
        while (index < buybackArrCamp.count) {
            CXBuyBackModel *model = [[CXBuyBackModel alloc] initWithDictionary:buybackArrCamp[index]];
            [buybackArr addObject:model];
            index++;
        }
        [(NSMutableArray *)mPlate.anyModels addObject:buybackArr];
        index = 0;
        while (index < xtbArrCamp.count) {
            CXXintuoBaoModel *model = [[CXXintuoBaoModel alloc] initWithDictionary:xtbArrCamp[index]];
            [xtbArr addObject:model];
            index++;
        }
        [(NSMutableArray *)mPlate.anyModels addObject:xtbArr];
    }

    else if ([strURL isEqualToString:GET_INFORMATION_READER] || [strURL isEqualToString:GET_INFORMATION_FAVORS])
    {
        NSArray *arrCamp = [dicJson objectForKey:@"list"];
        int index = 0;
        while (index < arrCamp.count) {
            CXUserModel *model = [[CXUserModel alloc] initWithDictionary:arrCamp[index]];
            [(NSMutableArray *)mPlate.anyModels addObject:model];
            index++;
        }
    }
    else if ([strURL isEqualToString:GET_INFORMATION_DETAIL])
    {
        NSString *favor = [dicJson objectForKey:@"favor"];
        NSDictionary *inforDic = [dicJson objectForKey:@"information"];
        CXInformationModel *model = [[CXInformationModel alloc] initWithDictionary:inforDic];
        [(NSMutableArray *)mPlate.anyModels addObject:model];
        mPlate.service = favor;
    }
    else if ([strURL isEqualToString:GET_INFORMATION_LISTCATEGORY]||[strURL isEqualToString:GET_INFORMATION_LISTCONDITIONCATEGORY])
    {
        NSArray *arrCamp = [dicJson objectForKey:@"list"];
        int index = 0;
        while (index < arrCamp.count) {
            CXCategoryModel *model = [[CXCategoryModel alloc] initWithInformationDictionary:arrCamp[index]];
            [(NSMutableArray *)mPlate.anyModels addObject:model];
            index++;
        }
    }
    else if ([strURL isEqualToString:GET_PRODUCT_LISTCATEGORY]||[strURL isEqualToString:GET_PRODUCT_LISTTRUSTCATEGORY]||[strURL isEqualToString:GET_PRODUCT_LISTFUNDCATEGORY]||[strURL isEqualToString:GET_PRODUCT_LISTSHIBOSAICATEGORY])
    {
        NSArray *arrCamp = [dicJson objectForKey:@"list"];
        int index = 0;
        while (index < arrCamp.count) {
            CXCategoryModel *model = [[CXCategoryModel alloc] initWithProductDictionary:arrCamp[index]];
            [(NSMutableArray *)mPlate.anyModels addObject:model];
            index++;
        }
    }
    else if ([strURL isEqualToString:GET_PRODUCT_LIST] || [strURL isEqualToString:GET_PRODUCT_SEARCH] || [strURL isEqualToString:GET_PRODUCT_LISTCHOICE]
         || [strURL isEqualToString:GET_PRODUCT_LISTATTENTION]||[strURL isEqualToString:GET_PRODUCT_SEARCHCOND])
    {
        // 产品列表
        NSArray *arrCamp = [dicJson objectForKey:@"list"];
        int index = 0;
        while (index < arrCamp.count) {
            CXProductModel *model = [[CXProductModel alloc] initWithDictionary:arrCamp[index]];
            [(NSMutableArray *)mPlate.anyModels addObject:model];
            index++;
        }
    }
    else if ([strURL isEqualToString:GET_PRODUCT_DETAIL])
    {
        NSString *attention = [dicJson objectForKey:@"attention"];
        NSDictionary *productDic = [dicJson objectForKey:@"product"];
        CXProductModel *model = [[CXProductModel alloc] initWithDictionary:productDic];
        [(NSMutableArray *)mPlate.anyModels addObject:model];
        mPlate.service = attention;
    }
    else if ([strURL isEqualToString:GET_PRODUCT_SUBSCRIBE])
    {
        NSDictionary *subscribeDic = [dicJson objectForKey:@"subscribe"];
        CXSubscribeModel *model = [[CXSubscribeModel alloc] initWithDictionary:subscribeDic];
        [(NSMutableArray *)mPlate.anyModels addObject:model];
    }
    else if ([strURL isEqualToString:GET_PRODUCT_RELEASE])
    {
        NSDictionary *productDic = [dicJson objectForKey:@"product"];
        CXProductReleaseModel *model = [[CXProductReleaseModel alloc] initWithDictionary:productDic];
        [(NSMutableArray *)mPlate.anyModels addObject:model];
    }
    else if ([strURL isEqualToString:GET_BUYBACK_RELEASE])
    {
        NSArray *arrCamp = [dicJson objectForKey:@"list"];
        int index = 0;
        while (index < arrCamp.count) {
            CXBenefitModel *model = [[CXBenefitModel alloc] initWithDictionary:arrCamp[index]];
            [(NSMutableArray *)mPlate.anyModels addObject:model];
            index++;
        }
    }
    else if ([strURL isEqualToString:GET_BENEFIT_RELEASE])
    {
//        NSDictionary *productDic = [dicJson objectForKey:@"benefit"];
//        CXBenefitModel *model = [[CXBenefitModel alloc] initWithDictionary:productDic];
//        [(NSMutableArray *)mPlate.anyModels addObject:model];
        NSArray *arrCamp = [dicJson objectForKey:@"list"];
        int index = 0;
        while (index < arrCamp.count) {
            CXBuyBackModel *model = [[CXBuyBackModel alloc] initWithDictionary:arrCamp[index]];
            [(NSMutableArray *)mPlate.anyModels addObject:model];
            index++;
        }
    }
    else if ([strURL isEqualToString:GET_PRODUCT_LISTMYRELEASE])
    {
        NSArray *arrCamp = [dicJson objectForKey:@"list"];
        int index = 0;
        while (index < arrCamp.count) {
            CXProductReleaseModel *model = [[CXProductReleaseModel alloc] initWithDictionary:arrCamp[index]];
            [(NSMutableArray *)mPlate.anyModels addObject:model];
            index++;
        }
    }
    else if ([strURL isEqualToString:GET_PRODUCT_LISTMYSUBSCRIBE])
    {
        NSArray *arrCamp = [dicJson objectForKey:@"list"];
        int index = 0;
        while (index < arrCamp.count) {
            CXSubscribeModel *model = [[CXSubscribeModel alloc] initWithDictionary:arrCamp[index]];
            [(NSMutableArray *)mPlate.anyModels addObject:model];
            index++;
        }
    }
    else if ([strURL isEqualToString:GET_USER_LISTMYINTEGRAL])
    {
        NSArray *arrCamp = [dicJson objectForKey:@"list"];
        int index = 0;
        while (index < arrCamp.count) {
            CXIntegralModel *model = [[CXIntegralModel alloc] initWithDictionary:arrCamp[index]];
            [(NSMutableArray *)mPlate.anyModels addObject:model];
            index++;
        }
    }
    else if ([strURL isEqualToString:GET_USER_MYINTEGRAL])
    {
        NSString *integral = [dicJson objectForKey:@"integral"];
        
        [(NSMutableArray *)mPlate.anyModels addObject:integral];
     
    }
    
    else if ([strURL isEqualToString:GET_USER_LISTMYRECOMMENT])
    {
        // 好友列表
        NSArray *arrCamp = [dicJson objectForKey:@"list"];
        int index = 0;
        while (index < arrCamp.count) {
            CXRecommentModel *model = [[CXRecommentModel alloc] initWithDictionary:arrCamp[index]];
            [(NSMutableArray *)mPlate.anyModels addObject:model];
            index++;
        }
    }
    else if ([strURL isEqualToString:GET_PRODUCT_LISTINVESTCATEGORY])
    {
        //投资类型
        NSArray *arrCamp=[dicJson objectForKey:@"list"];
        int index=0;
        while (index<arrCamp.count) {
            CXListInvestCategoryModel *model=[[CXListInvestCategoryModel alloc]initWithDictionary:arrCamp[index]];
            [(NSMutableArray *)mPlate.anyModels addObject:model];
            index++;
        }
        //投资类型
        NSArray *arr2Camp=[dicJson objectForKey:@"list2"];
        int index2=0;
        while (index2<arr2Camp.count) {
            CXListInvestCategoryModel *model=[[CXListInvestCategoryModel alloc]initWithDictionary:arr2Camp[index2]];
            [(NSMutableArray *)mPlate.additionalModels addObject:model];
            index2++;
        }
        
    }
    else if ([strURL isEqualToString:GET_TRACK_RELEASE])
    {
        NSDictionary *productDic = [dicJson objectForKey:@"track"];
        CXTrackModel *model = [[CXTrackModel alloc] initWithDictionary:productDic];
        [(NSMutableArray *)mPlate.anyModels addObject:model];
    }
    else if ([strURL isEqualToString:GET_TRACK_LISTMYTRACK])
    {
        NSArray *arrCamp = [dicJson objectForKey:@"list"];
        int index = 0;
        while (index < arrCamp.count) {
            CXTrackModel *model = [[CXTrackModel alloc] initWithDictionary:arrCamp[index]];
            [(NSMutableArray *)mPlate.anyModels addObject:model];
            index++;
        }
    }
    else if ([strURL isEqualToString:GET_BENEFIT_LISTMYRELEASE])
    {
        NSArray *arrCamp = [dicJson objectForKey:@"list"];
        int index = 0;
        while (index < arrCamp.count) {
            CXBenefitModel *model = [[CXBenefitModel alloc] initWithDictionary:arrCamp[index]];
            [(NSMutableArray *)mPlate.anyModels addObject:model];
            index++;
        }
    }
    else if ([strURL isEqualToString:GET_XINTUOBAO_PRODUCTLIST])
    {
        // 信托宝列表
        NSArray *arrCamp = [dicJson objectForKey:@"list"];
        int index = 0;
        while (index < arrCamp.count) {
            CXXintuoBaoModel *model = [[CXXintuoBaoModel alloc] initWithDictionary:arrCamp[index]];
            [(NSMutableArray *)mPlate.anyModels addObject:model];
            index++;
        }
    }
    else if ([strURL isEqualToString:GET_XINTUOBAO_DETAIL])
    {
        // 信托宝详情
        NSString *url = [dicJson objectForKey:@"url"];
        
        [(NSMutableArray *)mPlate.anyModels addObject:url];
    }
    else if ([strURL isEqualToString:GET_XINTUOBAO_FINDUSERFUND])
    {
        // 查询用户在信托宝的账户信息
        NSDictionary *dic = [dicJson objectForKey:@"list"];
        CXXtbAccountModel *model = [[CXXtbAccountModel alloc] initWithDictionary:dic];
        [(NSMutableArray *)mPlate.anyModels addObject:model];
    }
    else if ([strURL isEqualToString:GET_XINTUOBAO_FINDINVESTLIST])
    {
        // 查询用户在信托宝的交易记录信息
        NSArray *arrCamp = [dicJson objectForKey:@"list"];
        int index = 0;
        while (index < arrCamp.count) {
            CXXtbInvestModel *model = [[CXXtbInvestModel alloc] initWithDictionary:arrCamp[index]];
            [(NSMutableArray *)mPlate.anyModels addObject:model];
            index++;
        }

    }
    else if ([strURL isEqualToString:GET_XINTUOBAO_FINDBILLLIST])
    {
        // 查询信托宝的资金流水产品
        NSArray *arrCamp = [dicJson objectForKey:@"list"];
        int index = 0;
        while (index < arrCamp.count) {
            CXXtbBillModel *model = [[CXXtbBillModel alloc] initWithDictionary:arrCamp[index]];
            [(NSMutableArray *)mPlate.anyModels addObject:model];
            index++;
        }
    }
    
    else if ([strURL isEqualToString:GET_COURSE_LIST] || [strURL isEqualToString:GET_COURSE_SEARCH])
    {
        // 理财学堂列表
        NSArray *arrCamp = [dicJson objectForKey:@"list"];
        int index = 0;
        while (index < arrCamp.count) {
            CXCourseModel *model = [[CXCourseModel alloc] initWithDictionary:arrCamp[index]];
            [(NSMutableArray *)mPlate.anyModels addObject:model];
            index++;
        }
    }
    else if ([strURL isEqualToString:GET_COURSE_LISTRECOMMENT])
    {
        // 理财学堂首页列表
        NSArray *arrCamp = [dicJson objectForKey:@"list"];
        NSArray *speciaArrCamp = [dicJson objectForKey:@"specialist"];
        NSMutableArray *listArr=[[NSMutableArray alloc]init];
        NSMutableArray *speciaArr=[[NSMutableArray alloc]init];
        int index = 0;
        while (index < speciaArrCamp.count) {
            CXExpertModel *model = [[CXExpertModel alloc] initWithDictionary:speciaArrCamp[index]];
           [speciaArr addObject:model];
            index++;
        }
         [(NSMutableArray *)mPlate.anyModels addObject:speciaArr];
        
        index = 0;
        while (index < arrCamp.count) {
            CXCourseModel *model = [[CXCourseModel alloc] initWithDictionary:arrCamp[index]];
            [listArr addObject:model];
            index++;
        }
         [(NSMutableArray *)mPlate.anyModels addObject:listArr];

    }
    else if ([strURL isEqualToString:GET_COURSE_VIEW])
    {
        NSString *favor = [dicJson objectForKey:@"favor"];
        NSDictionary *inforDic = [dicJson objectForKey:@"course"];
        CXCourseModel *model = [[CXCourseModel alloc] initWithDictionary:inforDic];
        [(NSMutableArray *)mPlate.anyModels addObject:model];
        mPlate.service = favor;
    }
    else if ([strURL isEqualToString:GET_COURSE_LISTMODULES]||[strURL isEqualToString:GET_COURSE_LISTCATEGRORY] )
    {
        //理财学堂模块列表
        NSArray *arrCamp = [dicJson objectForKey:@"list"];
        int index = 0;
        while (index < arrCamp.count) {
            CXCategoryModel *model = [[CXCategoryModel alloc] initWithProductDictionary:arrCamp[index]];
            [(NSMutableArray *)mPlate.anyModels addObject:model];
            index++;
        }
    }
    else if ([strURL isEqualToString:GET_PRODUCT_LISTCONDCATEGORY])
    {
        //产品搜索的三个分类
        NSArray *deadlineArr = [dicJson objectForKey:@"deadline"];
        NSArray *profitArr = [dicJson objectForKey:@"profit"];
        NSArray *subscribeArr = [dicJson objectForKey:@"subscribe"];
        NSMutableArray *deadlineArrMiddle=[[NSMutableArray alloc]init];
        NSMutableArray *profitArrMiddle=[[NSMutableArray alloc]init];
        NSMutableArray *subscribeArrMiddle=[[NSMutableArray alloc]init];
        int subscribeIndex = 0;
        while (subscribeIndex < subscribeArr.count) {
            CXCategoryModel *model = [[CXCategoryModel alloc] initWithProductDictionary:subscribeArr[subscribeIndex]];
            [subscribeArrMiddle addObject:model];
            subscribeIndex++;
        }
        int inforIndex = 0;
        while (inforIndex < deadlineArr.count) {
            CXCategoryModel *model = [[CXCategoryModel alloc] initWithProductDictionary:deadlineArr[inforIndex]];
            [deadlineArrMiddle addObject:model];
            inforIndex++;
        }
        int profitIndex = 0;
        while (profitIndex < profitArr.count) {
            CXCategoryModel *model = [[CXCategoryModel alloc] initWithProductDictionary:profitArr[profitIndex]];
            [profitArrMiddle addObject:model];
            profitIndex++;
        }
        [(NSMutableArray *)mPlate.anyModels addObject:@[subscribeArrMiddle,deadlineArrMiddle,profitArrMiddle]];
        
    }
    else if ([strURL isEqualToString:GET_BANNER_LISTSTARTUPTPIC])
    {
        // banner列表
        NSArray *arrCamp = [dicJson objectForKey:@"list"];
        int index = 0;
        while (index < arrCamp.count) {
            CXBannerModel *model = [[CXBannerModel alloc] initWithDictionary:arrCamp[index]];
            [(NSMutableArray *)mPlate.anyModels addObject:model];
            index++;
        }
    }
    else if ([strURL isEqualToString:GET_PRODUCT_LISTSCHEDULE])
    {
        NSArray *arrCamp = [dicJson objectForKey:@"list"];
        int index = 0;
        while (index < arrCamp.count) {
            CXProductListScheduleModel *model = [[CXProductListScheduleModel alloc] initWithDictionary:arrCamp[index]];
            [(NSMutableArray *)mPlate.anyModels addObject:model];
            index++;
        }
    }
    else if ([strURL isEqualToString:GET_BUYBACK_LISTMYBUYBACK])
    {
        NSArray *arrCamp = [dicJson objectForKey:@"list"];
        int index = 0;
        while (index < arrCamp.count) {
            CXBuyBackModel *model = [[CXBuyBackModel alloc] initWithDictionary:arrCamp[index]];
            [(NSMutableArray *)mPlate.anyModels addObject:model];
            index++;
        }
    }
    else if ([strURL isEqualToString:GET_SYSTEM_RETURNPROFIT])
    {


         NSDictionary *arrCamp = [dicJson objectForKey:@"map"];
            CXMyshareModel *model = [[CXMyshareModel alloc] initWithDictionary:arrCamp];
            [(NSMutableArray *)mPlate.anyModels addObject:model];


   
    }
    else if ([strURL isEqualToString:GET_BENEFIT_LISTBENFIT])
    {
        NSArray *arrCamp = [dicJson objectForKey:@"list"];
        int index = 0;
        while (index < arrCamp.count) {
            CXBenefitModel *model = [[CXBenefitModel alloc] initWithDictionary:arrCamp[index]];
            [(NSMutableArray *)mPlate.anyModels addObject:model];
            index++;
        }
    }
    else if ([strURL isEqualToString:GET_BENEFIT_LISTBENFITRECORD])
    {
        NSString *countStr=[dicJson objectForKey:@"totalNum"];
        mPlate.code=countStr;
        
        NSArray *arrCamp = [dicJson objectForKey:@"list"];
        int index = 0;
        while (index < arrCamp.count) {
            CXBenefitRecordModel *model = [[CXBenefitRecordModel alloc] initWithDictionary:arrCamp[index]];
            [(NSMutableArray *)mPlate.anyModels addObject:model];
            index++;
        }
        
    }
    else if ([strURL isEqualToString:GET_BUYBACK_LISTBUYBACK])
    {
        NSArray *arrCamp = [dicJson objectForKey:@"list"];
        int index = 0;
        while (index < arrCamp.count) {
            CXBuyBackModel *model = [[CXBuyBackModel alloc] initWithDictionary:arrCamp[index]];
            [(NSMutableArray *)mPlate.anyModels addObject:model];
            index++;
        }
    }
    else if ([strURL isEqualToString:GET_BUYBACK_LISTBUYBACKRECORD])
    {
        NSArray *arrCamp = [dicJson objectForKey:@"list"];
        int index = 0;
        while (index < arrCamp.count) {
            CXBuybackRecordModel *buybackRecordmModel = [[CXBuybackRecordModel alloc] initWithDictionary:arrCamp[index][0]];
            CXUserModel *userModel = [[CXUserModel alloc] initWithDictionary:arrCamp[index][1]];
            buybackRecordmModel.userHead=userModel.headImg;
            CXBenefitModel *benefitModel = [[CXBenefitModel alloc] initWithDictionary:arrCamp[index][2]];
            buybackRecordmModel.productName=benefitModel.name;
            if (![benefitModel.userName isEqualToString:@""]||benefitModel.userName!=nil) {
                buybackRecordmModel.userName=benefitModel.userName;
            }
            else if (![userModel.nickName isEqualToString:@""]||userModel.nickName!=nil) {
                buybackRecordmModel.userName=userModel.nickName;
            }
            else
            {
                buybackRecordmModel.userName=@"XXX";
            }
            buybackRecordmModel.phone=benefitModel.phone;
            buybackRecordmModel.money=benefitModel.money;
            [(NSMutableArray *)mPlate.anyModels addObject:buybackRecordmModel];
            index++;
        }
        
    }
    else if ([strURL isEqualToString:GET_BENEFIT_VIEW])
    {
       NSDictionary *inforDic = [dicJson objectForKey:@"benefit"];

        CXBenefitModel *model = [[CXBenefitModel alloc] initWithDictionary:inforDic];
      
        
        NSString *days = [dicJson objectForKey:@"days"];
        model.days=[days intValue];
        
        NSString *preProfit = [dicJson objectForKey:@"preProfit"];
        model.preProfit=[preProfit doubleValue];
          [(NSMutableArray *)mPlate.anyModels addObject:model];
    }
    else if ([strURL isEqualToString:GET_BUYBACK_VIEW])
    {
        NSDictionary *inforDic = [dicJson objectForKey:@"buyback"];
        
        CXBuyBackModel *model = [[CXBuyBackModel alloc] initWithDictionary:inforDic];
        
        
        [(NSMutableArray *)mPlate.anyModels addObject:model];
    }

    else if ([strURL isEqualToString:GET_USER_FINANCIALLIST])
    {
        // 选择理财师的列表
        NSArray *arrCamp = [dicJson objectForKey:@"list"];
        int index = 0;
        while (index < arrCamp.count) {
            CXFinanciersModel *model = [[CXFinanciersModel alloc] initWithDictionary:arrCamp[index]];
            [(NSMutableArray *)mPlate.anyModels addObject:model];
            index++;
        }
    }
    else if ([strURL isEqualToString:GET_USER_MYFINANCIAL])
    {
        // 选择理财师的列表
        NSArray *arrCamp = [dicJson objectForKey:@"list"];
        int index = 0;
        while (index < arrCamp.count) {
            CXFinanciersModel *model = [[CXFinanciersModel alloc] initWithDictionary:arrCamp[index]];
            [(NSMutableArray *)mPlate.anyModels addObject:model];
            index++;
        }
    }
    else if ([strURL isEqualToString:GET_SPECIALIST_LISTRECOMMENT])
    {
        // 名家专栏
        NSArray *arrCamp = [dicJson objectForKey:@"specialist"];
        int index = 0;
        while (index < arrCamp.count) {
            CXExpertModel *model = [[CXExpertModel alloc] initWithDictionary:arrCamp[index]];
            [(NSMutableArray *)mPlate.anyModels addObject:model];
            index++;
        }
    }
    else if ([strURL isEqualToString:GET_COURSE_LISTCOURSE] )
    {
        // 理财学堂列表
        NSArray *arrCamp = [dicJson objectForKey:@"listCourse"];
        int index = 0;
        while (index < arrCamp.count) {
            CXCourseModel *model = [[CXCourseModel alloc] initWithDictionary:arrCamp[index]];
            [(NSMutableArray *)mPlate.anyModels addObject:model];
            index++;
        }
    }
    else if ( [strURL isEqualToString:GET_PRODUCT_SCONDPROINFO])
    {
        // 首页资讯内容
        NSArray *buybackListArrCamp = [dicJson objectForKey:@"buybackList"];
        NSArray *benefitArrCamp = [dicJson objectForKey:@"benefitList"];
        NSArray *fotProArrCamp = [dicJson objectForKey:@"fotProList"];
        NSArray *xtbArrCamp = [dicJson objectForKey:@"xtbList"];
        
        NSMutableArray *buybackListArr=[[NSMutableArray alloc]init];;
        NSMutableArray *benefitArr=[[NSMutableArray alloc]init];
        NSMutableArray *fotProArr=[[NSMutableArray alloc]init];
        NSMutableArray *xtbArr=[[NSMutableArray alloc]init];
        int index = 0;
        while (index < buybackListArrCamp.count) {
            CXBuyBackModel *model = [[CXBuyBackModel alloc] initWithDictionary:buybackListArrCamp[index]];
            [buybackListArr addObject:model];
            index++;
        }
        [(NSMutableArray *)mPlate.anyModels addObject:buybackListArr];
        
        index = 0;
        while (index < benefitArrCamp.count) {
            CXBenefitModel *model = [[CXBenefitModel alloc] initWithDictionary:benefitArrCamp[index]];
            [benefitArr addObject:model];
            index++;
        }
        [(NSMutableArray *)mPlate.anyModels addObject:benefitArr];
        
        index = 0;
        while (index < fotProArrCamp.count) {
            CXProductModel *model = [[CXProductModel alloc] initWithDictionary:fotProArrCamp[index]];
            [fotProArr addObject:model];
            index++;
        }
        [(NSMutableArray *)mPlate.anyModels addObject:fotProArr];
        
        index = 0;
        while (index < xtbArrCamp.count) {
            CXXintuoBaoModel *model = [[CXXintuoBaoModel alloc] initWithDictionary:xtbArrCamp[index]];
            [xtbArr addObject:model];
            index++;
        }
        [(NSMutableArray *)mPlate.anyModels addObject:xtbArr];
        
    }
    else if ([strURL isEqualToString:GET_USER_LISTMESSAGE])
    {
        // 通知更新
        NSArray *arrCamp = [dicJson objectForKey:@"messageList"];
        int index = 0;
        while (index < arrCamp.count) {
            NSDictionary *otherDataDictionary=[arrCamp[index] objectForKey:@"otherData"];
            CXNotificationModel *model = [[CXNotificationModel alloc] initWithDictionary:otherDataDictionary];
            [(NSMutableArray *)mPlate.anyModels addObject:model];
            index++;
        }
    }
    else if ([strURL isEqualToString:GET_INFORMATION_FINDSHARELIST])
    {
        // 获取上证指数和深证指数
        NSArray *arrCamp = [dicJson objectForKey:@"sharesList"];
        int index = 0;
        while (index < arrCamp.count) {
            CXShareIndexModel *model = [[CXShareIndexModel alloc] initWithDictionary:arrCamp[index]];
            [(NSMutableArray *)mPlate.anyModels addObject:model];
            index++;
        }
        
    }


     return mPlate;
}


@end
