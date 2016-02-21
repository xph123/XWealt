//
//  CXCofigNotification.h
//  Education
//
//  Created by yi.chen on 14-6-3.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#pragma mark - friend model
// 别人同意我的加好友请求后，需要更新好友列表
#define NOTIFICATION_AGREE_MYREQUEST    @"NOTIFICATION_AGREE_MYREQUEST"
// 同意, 拒绝别人的加好友请求后，需要更新“新的朋友”和“团队”上面的标记
#define NOTIFICATION_ACTION_ON_REQUEST  @"NOTIFICATION_ACTION_ON_REQUEST"
// 有人要加我为好友，需要在“新的朋友”和“团队”上面标记
#define NOTIFICATION_ADD_FRIEND         @"NOTIFICATION_ADD_FRIEND"
// 我申请加别人为好友，需要更新搜索的好友列表
#define NOTIFICATION_ADDFRIEND_MYREQUEST    @"NOTIFICATION_ADDFRIEND_MYREQUEST"
// 修改好友备注
#define NOTIFICATION_EDIT_REMARKSNAME    @"NOTIFICATION_EDIT_REMARKSNAME"
// 修改好友备注邮箱
#define NOTIFICATION_EDIT_REMARKSEMAIL    @"NOTIFICATION_EDIT_REMARKSEMAIL"

// 创建群
#define NOTIFICATION_CREATE_GROUP        @"NOTIFICATION_CREATE_GROUP"
// 修改群头像
#define NOTIFICATION_GROUP_MODIFYLOGO    @"NOTIFICATION_GROUP_MODIFYLOGO"
// 修改群名称
#define NOTIFICATION_GROUP_MODIFYNAME    @"NOTIFICATION_GROUP_MODIFYNAME"
// 修改群介绍
#define NOTIFICATION_GROUP_MODIFYDESC    @"NOTIFICATION_GROUP_MODIFYDESC"
// 申请加群
#define NOTIFICATION_GROUP_APPLY         @"NOTIFICATION_GROUP_APPLY"

#pragma mark - me model
// 修改头像
#define NOTIFICATION_ME_MODIFY_USERHEAD    @"NOTIFICATION_ME_MODIFY_USERHEAD"
// 修改用户资料
#define NOTIFICATION_ME_MODIFY_USERINFO    @"NOTIFICATION_ME_MODIFY_USERINFO"

// 从后台进入前台
#define NOTIFICATION_ENTRY_FOREGROUND  @"NOTIFICATION_ENTRY_FOREGROUND"

// 首页中点产品分类
#define NOTIFICATION_HOMEPAGE_PRODUCT  @"NOTIFICATION_HOMEPAGE_PRODUCT"
// 首页中点产品分类
#define NOTIFICATION_HOMEPAGE_PRODUCTTWO  @"NOTIFICATION_HOMEPAGE_PRODUCTTWO"

// 首页中点产品分类
#define NOTIFICATION_ME_RECOMMENT      @"NOTIFICATION_ME_RECOMMENT"
// 首页中点产品分类FOT
#define NOTIFICATION_ME_RECOMMENT_FOT      @"NOTIFICATION_ME_RECOMMENT_FOT"
// 资讯浏览和点赞
#define NOTIFICATION_INFORMATION_VIEW      @"NOTIFICATION_INFORMATION_VIEW"

// 理财学堂浏览和点赞
#define NOTIFICATION_COURSE_VIEW      @"NOTIFICATION_COURSE_VIEW"
//理财轨迹更新
#define NOTIFICATION_TRACK_UPDATA      @"NOTIFICATION_TRACK_UPDATA"

//在线推送消息
#define NOTIFION_ONFLINE_NEW            @"NOTIFION_ONFLINE_NEW"
//在线推送消息提示红点
#define NOTIFION_OFFLINE_NEW_PROMPT            @"NOTIFION_OFFLINE_NEW_PROMPT"