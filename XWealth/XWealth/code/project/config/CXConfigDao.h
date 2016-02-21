//
//  CXConfigDao.h
//  Link
//
//  Created by chx on 14-11-12.
//  Copyright (c) 2014年 rasc. All rights reserved.
//

#ifndef CXConfigDao_h
#define CXConfigDao_h

// 任务表
#pragma mark - task table
#define TASK_TABLE                      @"Task"
#define column_ID                       @"id"   // 自动生成
#define column_task_taskId              @"taskId"  // 任务ID
#define column_task_content             @"content" // 任务内容
#define column_task_imgUrl              @"imgUrl" // 任务附带的图片
#define column_task_planDate            @"planDate" // 计划完成日期
#define column_task_planTime            @"planTime" // 计划完成时间
#define column_task_createDate          @"createDate" // 创建日期时间
#define column_task_classify            @"classify" // 任务分类 （如：生活，工作）
#define column_task_grade               @"grade" // 重要等级 （重要紧急，重要不紧急，不重要紧急，不重要不紧急）
#define column_task_state               @"state" // 状态 （新建，完成，顺延一天，自动顺延）
#define column_task_userId              @"userId" // 创建者ID
#define column_task_performUserId       @"performUserId" // 执行者ID
#define column_task_groupId             @"groupId" // 团队协作时，任务属于哪个团队
#define column_task_comments            @"comments" // 交流个数
#define column_task_imgWidth            @"imgWidth" // 图片宽度
#define column_task_imgHeight           @"imgHeight" // 图片高度
#define column_task_syncState           @"syncState" // 同步状态，0 跟服务器数据是同步的，1 是新增的任务 2 是修改的任务
#define column_task_dateline            @"dateline" // 更新（新增或修改）的时间

// 好友详细表
#pragma mark - user table
#define USER_TABLE                       @"User"
#define column_user_userId               @"userId"  // 用户ID
#define column_user_userName             @"userName" // 用户名
#define column_user_nickName             @"nickName" // 姓名
#define column_user_headImg              @"headImg" // 头像
#define column_user_signature            @"signature" // 签名
#define column_user_telePhone            @"telePhone" // 手机
#define column_user_mail                 @"mail"  // 邮箱
#define column_user_address              @"address" // 所在地
#define column_user_occupation           @"occupation" // 职业
#define column_user_sex                  @"sex" // 性别
#define column_user_grade                @"grade" // 等级
#define column_user_integral             @"integral" // 积分

#define column_user_remarksName          @"remarksName" // 好友的备注名
#define column_user_remarksEmail         @"remarksEmail" // 好友的备注邮箱（用于汇报工作）

// 好友表
#pragma mark - friend table
#define FRIEND_TABLE                     @"Friend"
#define column_friend_Id                 @"Id"  // ID
#define column_friend_userId             @"userId"  // 用户ID


// 添加好友表
#pragma mark - AddFriend table
#define ADDFRIEND_TABLE                  @"AddFriend"
#define column_addFriend_userId          @"userId"  // 用户ID
#define column_addFriend_applyInfo       @"applyInfo" // 验证信息
#define column_addFriend_isFriend        @"isFriend" // 是否是好友



// 我加入的群列表
#pragma mark - group table
#define GROUP_TABLE                      @"Groups"
#define column_group_groupId             @"groupId"  // 用户ID
#define column_group_groupName           @"groupName" // 群名
#define column_group_groupDesc           @"groupDesc" // 描述
#define column_group_groupLogo           @"groupLogo" // 图标
#define column_group_createDate          @"createDate" // 创建时间
#define column_group_managerUserId       @"managerUserId" // 群主ID
#define column_group_memberCount         @"memberCount"  // 成员数
#define column_group_remain              @"remain" // 验证



// 群与成员对照表
#pragma mark - group table
#define GROUPMEMBER_TABLE                @"GroupMember"
#define column_groupMember_Id            @"Id"  //ID
#define column_groupMember_groupId       @"groupId"  // 群ID
#define column_groupMember_memberId      @"memberId" // 成员ID


// 任务评论表
#pragma mark - Comment table
#define COMMENT_TABLE                       @"Comment"
#define column_comment_commentId            @"commentId"
#define column_comment_taskId               @"taskId"
#define column_comment_commentUserId        @"commentUserId"
#define column_comment_commentUserName      @"commentUserName"
#define column_comment_commentUserHead      @"commentUserHead"
#define column_comment_content              @"content"
#define column_comment_beCommnetUserId      @"beCommnetUserId"
#define column_comment_beCommnetUserName    @"beCommnetUserName"
#define column_comment_dateline             @"dateline"


// 任务关注人对照表
#pragma mark - insperate table
#define INSPERATE_TABLE                     @"Insperate"
#define column_insperate_Id                 @"Id"  // ID
#define column_insperate_taskId             @"taskId"  // 任务ID
#define column_insperate_userId             @"userId"  // 用户ID


// 任务分类表
#pragma mark - classify table
#define CLASSIFY_TABLE                      @"Classify"
#define column_classify_id                  @"typeId"
#define column_classify_name                @"typeName"


#endif
