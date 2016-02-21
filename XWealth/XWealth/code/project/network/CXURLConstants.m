//
//  CXURL.m
//  Link
//
//  Created by chx on 14-10-25.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#import "CXURLConstants.h"


// 服务器域名
// 资源文件下载通用域名
//NSString *const kBaseURLString = @"http://www.gsycf.com";
NSString *const kBaseURLString = @"http://192.168.1.71:8080";// 测试服：1.71，小马哥：1.239
NSString *const kFileBaseUrlString = @"/wealth/up/icon/";
// 图片URL前缀
NSString *const kHeadBaseUrlString  = @"/wealth/up/head/";     
NSString *const kGroupLogoBaseUrlString = @"/wealth/up/grouplogo/";
NSString *const kStatusBaseUrlString = @"/wealth/up/status/";



//NSString *const kBaseURLString = @"http://192.168.0.167:8080";//167,156
//NSString *const kFileBaseUrlString = @"/wealthpv/up/icon/";
//// 图片URL前缀
//NSString *const kHeadBaseUrlString  = @"/wealthpv/up/head/";
//NSString *const kGroupLogoBaseUrlString = @"/wealthpv/up/grouplogo/";
//NSString *const kStatusBaseUrlString = @"/wealthpv/up/status/";


#pragma mark - friend model
// 获取好友列表
NSString *const GET_FRIENDLIST = @"/wealth/friend/list";
// 新的好友列表
NSString *const GET_NEWFRIENDS = @"/wealth/friend/listApply"; // ！后台未实现
// 添加好友
NSString *const GET_ADDFRIEND = @"/wealth/friend/applyAddFriend";
// 拒绝添加好友
NSString *const GET_ADDFRIEND_REFUSE = @"/wealth/friend/refuse"; // ！后台未实现
// 同意添加好友
NSString *const GET_ADDFRIEND_AGREE = @"/wealth/friend/agreeAddFriend";
// 搜索好友
NSString *const GET_SEARCHFRIEND = @"/wealth/friend/search";
// 是否是好友
NSString *const GET_ISFRIEND = @"/wealth/friend/isFriend"; // 手机端未用到
// 删除好友
NSString *const GET_DELFRIEND = @"/wealth/friend/delFriend"; // 手机端未用到
// 修改备注
NSString *const GET_EDIT_REMARKSNAME = @"/wealth/friend/editRemarksName";
// 修改备注邮箱
NSString *const GET_EDIT_REMARKSEMAIL = @"/wealth/friend/editRemarksEmail";

#pragma mark - group model
// 获取自己参加的群列表
NSString *const GET_GROUPLIST = @"/wealth/group/list";
// 查看群信息
NSString *const GET_GROUP_VIEW  = @"/wealth/group/view";
// 查看群成员信息
NSString *const GET_GROUP_MEMBERS  = @"/wealth/group/groupMembers";
// 创建群
NSString *const POST_CREATE_GROUP  = @"/wealth/group/create";
// 修改群头像
NSString *const POST_GROUP_MODIFYLOGO  = @"/wealth/group/editLogo";
// 修改群名称
NSString *const POST_GROUP_MODIFYNAME  = @"/wealth/group/editName";
// 修改群介绍
NSString *const POST_GROUP_MODIFYDESC  = @"/wealth/group/editIntro";
// 添加群成员
NSString *const GET_GROUP_ADDMEMBER  = @"/wealth/group/addMember";
// 搜索群
NSString *const GET_GROUP_SEARCH  = @"/wealth/group/search";
// 申请群
NSString *const GET_GROUP_APPLY  = @"/wealth/group/join"; // 目前只让群主加入，不做申请
// 退群
NSString *const GET_GROUP_QUIT  = @"/wealth/group/quit";
// 删除群
NSString *const GET_GROUP_DEL  = @"/wealth/group/del";

#pragma mark - user model
// 查看用户信息
NSString *const GET_USERINFO  = @"/wealth/user/userInfo";
// 修改头像
NSString *const POST_ME_MODIFY_USERHEAD  = @"/wealth/user/editHead";
// 修改用户信息
NSString *const POST_ME_MODIFY_USERINFO  = @"/wealth/user/editUserInfoWithType";

// 修改背景图
NSString *const POST_ME_MODIFY_BGIMAGE  = @"/wealth/user/editStatusBg";

// 我的推荐人
NSString *const GET_USER_RECOMMENT  = @"/wealth/user/recomment";
// 推荐通讯录好友
NSString *const GET_USER_RECOMMENT_CONTRACT  = @"/wealth/user/recommentContract";
// 推荐所有通讯录好友
NSString *const GET_USER_RECOMMENT_ALLCONTRACT  = @"/wealth/user/recommentAllContract";

// 我的推荐
NSString *const GET_USER_LISTMYRECOMMENT  = @"/wealth/user/listMyRecomment";
// 我的积分
NSString *const GET_USER_MYINTEGRAL  = @"/wealth/user/myIntegral";
// 我的积分详情
NSString *const GET_USER_LISTMYINTEGRAL  = @"/wealth/user/listMyIntegral";
//我的资讯收藏
NSString *const GET_USER_FAVORITEINFOLIST   = @"/wealth/user/findFavoriteInfoList";
// 邮件找回密码
NSString *const GET_FINDPWD_MAIL = @"/wealth/findPwdmail";


// 意见反馈
NSString *const GET_SYSTEM_FEEDBACK  = @"/wealth/system/faq";


#pragma mark - login & register model
// 登录
NSString *const GET_LOGIN = @"/wealth/user/login";
// 登出
NSString *const GET_LOGOUT = @"/wealth/user/logout";
// 邮箱注册
NSString *const GET_REGBYEMAIL = @"/wealth/regByEmail";
// 修改密码
NSString *const GET_EDITPWD = @"/wealth/user/editPwd";
// 获取验证码
NSString *const GET_AUTHCODE = @"/wealth/authcode";
// 校验 验证码
NSString *const GET_VERIFY_AUTHCODE = @"/wealth/verifyAuthcode";
// 手机注册
NSString *const GET_REGBYPHONE = @"/wealth/regByPhone";
// 找回密码，得验证码
NSString *const GET_FINDPWDSMS = @"/wealth/user/findPwdsms";
// 找回密码
NSString *const GET_EDITPWD_BYPHONE = @"/wealth/user/editPwdByPhone";
// 重置密码（唯一一次）
NSString *const GET_RESET_USERPWD = @"/wealth/user/resetUserPwd";
#pragma mark - systemUpdate
// 版本更新
NSString *const GET_SYSTEM_UPDATE = @"/wealth/system/update";
#pragma mark - StartPage
// 启动页广告
NSString *const GET_BANNER_LISTSTARTUPTPIC = @"/wealth/banner/listStartuptPic";

#pragma mark - banner
//滚动广告
NSString *const GET_BANNERS       = @"/wealth/banner/listHomepage";




#pragma mark - activity
//首页弹出广告
NSString *const GET_POPACTIVITY       = @"/wealth/activity/getPopActivity";
// 分享活动成功回调
NSString *const GET_SHAREACTIVITY       = @"/wealth/activity/sharePopActivity";
// 邀请有礼成功回调
NSString *const GET_ACTIVITY_INVITESHARE     = @"/wealth/activity/shareInvite";

//首页上证指数，深证指数等
NSString *const GET_INFORMATION_FINDSHARELIST =@"/wealth/information/findShareList";

#pragma mark - information
//资讯最新
NSString *const GET_INFORMATIONS       = @"/wealth/information/list";
//首页资讯列表
NSString *const GET_INFORMATION_RECOMMENDS       = @"/wealth/information/listRecommend";

// 资讯详情
NSString *const GET_INFORMATION_DETAIL       = @"/wealth/information/view";
// 资讯阅读者
NSString *const GET_INFORMATION_READER       = @"/wealth/information/listReaders";
// 资讯点赞者
NSString *const GET_INFORMATION_FAVORS       = @"/wealth/information/listFavors";
// 资讯点赞
NSString *const GET_INFORMATION_FAVOR       = @"/wealth/information/favor";
// 资讯收藏
NSString *const GET_INFORMATION_FAVORITEINFO       = @"/wealth/information/favoriteInfo";
//资讯筛选条件的接口(最热最新等)
NSString *const GET_INFORMATION_LISTCONDITIONCATEGORY       = @"/wealth/information/listConditionCategory";
// 资讯分类列表
//NSString *const GET_INFORMATION_LISTBYCATEGORY  = @"/wealth/information/listByCategory";

NSString *const GET_INFORMATION_SEARCH       = @"/wealth/information/search";
NSString *const GET_INFORMATION_LISTCATEGORY       = @"/wealth/information/listCategory";

#pragma mark - product
NSString *const GET_PRODUCT_LIST            = @"/wealth/product/list";
NSString *const GET_PRODUCT_DETAIL          = @"/wealth/product/view";
NSString *const GET_PRODUCT_SEARCH          = @"/wealth/product/search";
NSString *const GET_PRODUCT_SEARCHCOND     = @"/wealth/product/searchCond";
NSString *const GET_PRODUCT_LISTCHOICE      = @"/wealth/product/listChoice";


NSString *const GET_PRODUCT_SUBSCRIBE       = @"/wealth/product/subscribe";
NSString *const GET_PRODUCT_SUBSCRIBE_OP     = @"/wealth/product/subOverrideOrAppend"; // 预约-替换或叠加
NSString *const GET_PRODUCT_RELEASE         = @"/wealth/product/productRelease";
//受让信托上传
NSString *const GET_BUYBACK_RELEASE         = @"/wealth/buyback/release";
//我的受让信托
NSString *const GET_BUYBACK_LISTMYBUYBACK   = @"/wealth/buyback/listMyBuyback";
//删除我的受让信托
NSString *const GET_BUYBACK_DELRELEASE    = @"/wealth/buyback/delRelease";

NSString *const GET_PRODUCT_DELSUBSCRIBE    = @"/wealth/product/delSubscribe";
NSString *const GET_PRODUCT_DELRELEASE      = @"/wealth/product/delProductRelease";
NSString *const GET_PRODUCT_LISTMYSUBSCRIBE = @"/wealth/product/listMySubscribe";
NSString *const GET_PRODUCT_LISTMYRELEASE   = @"/wealth/product/listMyRelease";
//产品进度轨迹
NSString *const GET_PRODUCT_LISTSCHEDULE   = @"/wealth/product/listSchedule";


NSString *const GET_PRODUCT_ATTENTION       = @"/wealth/product/attention";
NSString *const GET_PRODUCT_LISTATTENTION   = @"/wealth/product/listAttention";

//产品详情网页版
NSString *const GET_PRODUCT_WEBLIST   = @"/wealth/product/share?pId=";
//产品搜索的三个分类
NSString *const GET_PRODUCT_LISTCONDCATEGORY = @"/wealth/product/listCondCategory";

NSString *const GET_PRODUCT_LISTCATEGORY    = @"/wealth/product/listCategory";
//投资类型
NSString *const GET_PRODUCT_LISTINVESTCATEGORY  = @"/wealth/product/listInvestCategory";
//信托分类
NSString *const GET_PRODUCT_LISTTRUSTCATEGORY    = @"/wealth/product/listTrustCategory";
//资管分类
NSString *const GET_PRODUCT_LISTFUNDCATEGORY    = @"/wealth/product/listFundCategory";
//私募分类
NSString *const GET_PRODUCT_LISTSHIBOSAICATEGORY    = @"/wealth/product/listShibosaiCategory";
//产品分享邮件接口
NSString *const GET_USER_SENDPRODINFO    = @"/wealth/user/sendProdInfo";

#pragma mark -二手信托
//二手信托首页
NSString *const GET_PRODUCT_SCONDPROINFO   = @"/wealth/product/secondProInfo";
//二手信托广告图
NSString *const GET_BANNER_SECONDHOMEPAGE    = @"/wealth/banner/secondHomepage";

#pragma mark -信托转让
//信托转让列表
NSString *const GET_BENEFIT_LISTBENFIT         = @"/wealth/benefit/listBenefit";
// 信托转让认购详情(不调)
NSString *const GET_BENEFIT_VIEW        = @"/wealth/benefit/view";
//信托转让认购记录
NSString *const GET_BENEFIT_LISTBENFITRECORD         = @"/wealth/benefit/listBenefitRecord";
// 信托转让我要预约
NSString *const GET_BENEFIT_SUBSCRIBE        = @"/wealth/benefit/subscribe";
//信托转让取消预约
NSString *const GET_BENEFIT_CENCELSUBSCRIBE         = @"/wealth/benefit/cencelSubscribe";


//信托受让列表（信托受让中心）
NSString *const GET_BUYBACK_LISTBUYBACK         = @"/wealth/buyback/listBuyback";
// 信托受让认购详情(不调)
NSString *const GET_BUYBACK_VIEW        = @"/wealth//buyback/view";
//信托受让认购记录
NSString *const GET_BUYBACK_LISTBUYBACKRECORD         = @"/wealth/buyback/listBuybackRecord";
// 信托转让我要预约
NSString *const GET_BUYBACK_SUBSCRIBE        = @"/wealth/buyback/subscribe";
//信托转让取消预约
NSString *const GET_BUYBACK_CENCELSUBSCRIBE         = @"/wealth/buyback/cencelSubscribe";

//上传信托转让
NSString *const GET_BENEFIT_RELEASE         = @"/wealth/benefit/release";
//我的信托转让
NSString *const GET_BENEFIT_LISTMYRELEASE         = @"/wealth/benefit/listMyRelease";
//删除信托转让
NSString *const GET_BENEFIT_DELRELEASE        = @"/wealth/benefit/delRelease";
//上传理财轨迹
NSString *const GET_TRACK_RELEASE           = @"/wealth/track/release";
//我的理财轨迹
NSString *const GET_TRACK_LISTMYTRACK     = @"/wealth/track/listMyTrack";
//删除理财轨迹
NSString *const GET_TRACK_DELRELEASE    = @"/wealth/track/delRelease";

#pragma mark - 信托宝

// 信托宝列表
NSString *const GET_XINTUOBAO_PRODUCTLIST    = @"/wealth/product/productList";
// 信托宝详情
NSString *const GET_XINTUOBAO_DETAIL    = @"/wealth/product/productInfo";

// 查询用户在信托宝的信息
NSString *const GET_XINTUOBAO_FINDUSERINFO    = @"/wealth/user/findUserInfo";
// 查询用户在信托宝的账户信息
NSString *const GET_XINTUOBAO_FINDUSERFUND    = @"/wealth/user/findUserFund";
// 查询用户在信托宝的交易记录信息
NSString *const GET_XINTUOBAO_FINDINVESTLIST  = @"/wealth/user/findInvestList";
// 查询信托宝的资金流水产品
NSString *const GET_XINTUOBAO_FINDBILLLIST    = @"/wealth/user/findBillList";

#pragma mark - 理财学堂
//理财学堂轮播图
NSString *const GET_BANNER_LISTCOURSE  = @"/wealth/banner/listCourse";
//支持的模块表（最新政策等
NSString *const GET_COURSE_LISTMODULES    = @"/wealth/course/listModules";
//理财学堂首页显示资料
NSString *const GET_COURSE_LISTRECOMMENT    = @"/wealth/course/listRecomment";
//每个模块下的学习列表
NSString *const GET_COURSE_LIST    = @"/wealth/course/list";
//学习详情
NSString *const GET_COURSE_VIEW    = @"/wealth/course/view";
//搜索
NSString *const GET_COURSE_SEARCH    = @"/wealth/course/search";
//每个模块的分类
NSString *const GET_COURSE_LISTCATEGRORY    = @"/wealth/course/listCategory";
//赞
NSString *const GET_COURSE_FAVOR    = @"/wealth/course/favor";
//邀请返利
NSString *const GET_SYSTEM_RETURNPROFIT    = @"wealth/system/returnProfit";
//名家专栏
NSString *const GET_SPECIALIST_LISTRECOMMENT    = @"wealth/specialist/listRecomment";
//名家专栏列表
NSString *const GET_COURSE_LISTCOURSE    = @"wealth/course/listCourse";



#pragma mark - 理财师
//保存理财师
NSString *const GET_USER_SAVAFINANCIAL  = @"wealth/user/saveFinancial";
//获取理财师列表
NSString *const GET_USER_FINANCIALLIST  = @"wealth/user/financialList";
//获取我的专属理财师
NSString *const GET_USER_MYFINANCIAL  = @"wealth/user/myFinancial";
//理财师上传照片认证-
NSString *const GET_FINANCIAL_UPPHOTO  = @"wealth/financial/upPhoto";
//编辑理财师资料
NSString *const GET_FINANCIAL_EDITQUALITYL  = @"wealth/financial/editQualityl";
//金牌理财师列表
NSString *const GET_FINANCIAL_LIST  = @"wealth/financial/list";
//查询金牌理财师资质、积分、发布的产品
NSString *const GET_FINANCIAL_FINANCIALPRO  = @"wealth/financial/financialPro";
//查询金牌理财师详情
NSString *const GET_FINANCIAL_FINANCIAINFO  = @"wealth/financial/financialInfo";

#pragma mark - 通知消息
//获取云端通知数据
NSString *const GET_USER_LISTMESSAGE  = @"wealth/user/listMessage";

#pragma mark - web url

NSString *const WEB_ABOUT =  @"/wealth/console/about.html";
NSString *const WEB_XTB_FAQ =  @"/wealth/console/about.html"; // 信托宝，常见问题

@implementation CXURLConstants

+ (NSString *)getFullImageUrl:(NSString *)imageName
{
    if (imageName && [imageName length] > 0)
    {
        return [NSString stringWithFormat:@"%@%@%@", kBaseURLString, kFileBaseUrlString, imageName];
    }
    else
    {
        return @"";
    }
}

+ (NSString *)getFullHeaderUrl:(NSString *)headerImageName
{
    if (headerImageName && [headerImageName length] > 0)
    {
        return [NSString stringWithFormat:@"%@%@%@", kBaseURLString, kHeadBaseUrlString, headerImageName];
    }
    else
    {
        return @"";
    }
}

+ (NSString *)getFullSltHeaderUrl:(NSString *)headerImageName
{
    if (headerImageName && [headerImageName length] > 0)
    {
        return [NSString stringWithFormat:@"%@%@slt%@", kBaseURLString, kHeadBaseUrlString, headerImageName];
    }
    else
    {
        return @"";
    }
}

+ (NSString *)getFullStatusUrl:(NSString *)imageName
{
    if (imageName && [imageName length] > 0)
    {
        return [NSString stringWithFormat:@"%@%@%@", kBaseURLString, kStatusBaseUrlString, imageName];
    }
    else
    {
        return @"";
    }
}


+ (NSString *)getGroupLogoImageUrl:(NSString *)imageName
{
    if (imageName && [imageName length] > 0)
    {
        return [NSString stringWithFormat:@"%@%@%@", kBaseURLString, kGroupLogoBaseUrlString, imageName];
    }
    else
    {
        return @"";
    }
}

+ (NSString *)getFullSltGroupLogoImageUrl:(NSString *)imageName
{
    if (imageName && [imageName length] > 0)
    {
        return [NSString stringWithFormat:@"%@%@slt%@", kBaseURLString, kGroupLogoBaseUrlString, imageName];
    }
    else
    {
        return @"";
    }
}


+ (NSString *)getBannerImageUrl:(NSString *)imageName
{
    if (imageName && [imageName length] > 0)
    {
        return [NSString stringWithFormat:@"%@%@", kBaseURLString, imageName];
    }
    else
    {
        return @"";
    }
}

+ (NSString *)getFullInformationUrl:(NSString *)imageName
{
    if (imageName && [imageName length] > 0)
    {
        return [NSString stringWithFormat:@"%@%@", kBaseURLString, imageName];
    }
    else
    {
        return @"";
    }
}

+ (NSString *)getFullSltInformationUrl:(NSString *)imageName
{
    if (imageName && [imageName length] > 0)
    {
        return [NSString stringWithFormat:@"%@%@", kBaseURLString, imageName];
    }
    else
    {
        return @"";
    }
}

+ (NSString *)getFullAudioUrl:(NSString *)audioFileName
{
    return nil; 
}

+ (NSString *)getFullInformationCategoryUrl:(NSString *)imageName
{
    if (imageName && [imageName length] > 0)
    {
        return [NSString stringWithFormat:@"%@%@", kBaseURLString, imageName];
    }
    else
    {
        return @"";
    }
}

+ (NSString *)getFullProductCategoryUrl:(NSString *)imageName
{
    if (imageName && [imageName length] > 0)
    {
        return [NSString stringWithFormat:@"%@%@", kBaseURLString, imageName];
    }
    else
    {
        return @"";
    }

}


+ (NSString *)getWebUrl:(NSString *)urlString
{
    if (urlString && [urlString length] > 0)
    {
        return [NSString stringWithFormat:@"%@%@", kBaseURLString, urlString];
    }
    else
    {
        return @"";
    }

}

@end
