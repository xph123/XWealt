//
//  CXErrorCode.h
//  Link
//
//  Created by chx on 15-1-9.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SUCCESS                         0 //成功
#define UNKNOWN_ERROR                   1 //未知错误
#define UNLOGINED                       2 //未登录
#define PARAMETER_ERROR                 3 //参数错误
#define UTIL_ILLEGAL                    4 //非法操作,当前登录用户操作了其他用户数据
#define UTIL_AUTHCODE                   5 //验证码错误
#define ERROR_PASSWORD                  6
#define ERROR_NO_NEWVERSION             7 //没有新版本

//注册相关返回码,以REG_开头
#define REG_USER_PARAMETER_ERROR		 101 //用户参数错误
#define REG_EMPTY_EMAIL					 102 //邮箱为空
#define REG_FORMAT_ERROR_EMAIL			 103 //邮箱格式不正确
#define REG_EXIST_EMAIL					 104 //邮箱已经存在
#define REG_EMPTY_USER_NAME				 105 //用户名为空
#define REG_EXIST_USER_NAME				 106 //用户名已存在
#define REG_EMPTY_PASSWORD				 107 //密码为空
#define REG_EMPTY_PHONENUM				 108 //手机号为空
#define REG_FORMAT_ERROR_PHONENUM		 109 //手机格式不正确
#define REG_EXIST_PHONENUM				 110 //手机号已存在
#define REG_EMPTY_AUTHENTICATED_CODE	 111 //验证码为空
#define REG_AUTHENTICATED_CODE_ERROR	 112  //验证码错误

#define REG_EMPTY_ORGANIZATION           113 //机构不存在
#define REG_EMPTY_RECOMMENT				 114 //推荐人不存在
#define REG_EXIST_RECOMMENT				 115 //已填写这个推荐人

//登录相关返回码,以LOG_开头
#define LOG_EMPTY_USER_NAME				 201 //用户名为空
#define LOG_EMTPY_PASSWORD				 202 //密码为空
#define LOG_USERNAME_OR_PASSWOLD_ERROR 	 203 //用户名或密码错误
#define LOG_EMTPY_EMAIL					 204 //邮箱为空
#define LOG_EMPTY_PHONENUM				 205 //手机为空
#define LOG_BEEN_BIND                    206 //用户已经被绑定
#define LOG_ACCOUNT_BLOCKED              207 //账户违规操作，被封
#define LOG_BEEN_BIND_PARAM              208 //参数已经被绑定

#define BIND_QQ_YES 					 209
#define BIND_SINA_YES                    210
#define REGISTERED_MANY             	 211 //手机注册次数太多

#define ACTIVITY_PRASIED             	 300 //活动已赞
#define ACTIVITY_NOT_PRASIED             301 //活动已赞
#define ACTIVITY_JOINED             	 302 //活动已参加


#define ORGAN_NOT_EXISTS             	 310 //机构不存在

#define ORGAN_PRASIED             		 311 //已赞
#define ORGAN_NOT_PRASIED             	 312 //未赞

#define STATUS_PRASIED             		 400 //微博已赞

//认证
#define AUTHEN_NO						 500 // 未认证
#define AUTHEN_ING						 501 // 认证中或已认证成功

//找回密码
#define FIND_USERNAME_NOEXIT             600 //用户名不存在
#define FIND_MAIL_NOBIND                 601 //邮箱未绑定
#define FIND_USERNAME_ERROR              602 //用户名错误
#define FIND_PHONE_ERROR                 603 //手机错误
#define FIND_PHONE_NOBIND                604 //S手机未绑定

// 手机支付
#define PAY_ERROR						 700 // 订单推送失败

//赞用户存在
#define APPROVED_USER_EXIST	 			 900 // 表示已经 "赞" 过此用户


// 关注
#define FOLLOW_EXISTS		        	 1000 // 已经关注过该用户

// 图片
#define UPLOAD_EXCEPTION				 1100 // 图片上传异常

// 资讯
#define INFORMATION_ISDELETE			 1200 // 资讯已被删除
#define INFORMATION_FAVORED 			 1201 // 资讯已赞
#define INFORMATION_FAVORITEINFO 		 1202 // 已经收藏

// 产品
#define PRODUCT_ISDELETE				 1300 // 产品已删除
#define PRODUCT_ATTENTIONED				 1301 // 产品已关注
#define PRODUCT_RELEASE_NOEXIST		     1302 // 发布的产品不存在
#define PRODUCT_SUBSCRIBE_NOEXIST	     1303 // 订购的产品不存在
#define PRODUCT_OVER_LIMIT		         1306 	// 预约超额
#define PRODUCT_ALREADY_SUBSCRIBE		 1307 	// 您已经预约
#define PRODUCT_SUBSCRIBE_BY_OTHERS		 1308 	// 这个客户已经被其她理财师预约了
#define PRODUCT_PRODUCT_NAME_REPEAT		 1309 	// 产品名称重复


#define RECOMMENT_USER_REGED			 1400  // 邀请的用户已经注册过这个应用
#define RECOMMENT_USER_BERECOMMENTED	 1401  // 邀请的用户已经被邀请了
#define RECOMMENT_USER_RECOMMENTED		 1402  // 你已邀请过这个用户，3天后再试


//法律法规
#define LAW_ISDELETE		             1500      // 法律法规已被删除
#define LAW_FAVORED		                 1501      // 法律法规已赞

//知识点
#define COURSE_ISDELETE		             1600      // 知识点已被删除
#define COURSE_FAVORED		             1601      // 知识点已赞

//理财轨迹
#define BENEFIT_RELEASE_NOEXIST		     1304       // 发布的信托受益权转让不存在
#define TRACK_RELEASE_NOEXIST		     1305       // 理财轨迹不存在

//二手信托预约
#define BENEFIT_SUBSCRIBED		         1311      // 您已经预约过这个信托转让
#define BUYBACK_SUBSCRIBED		         1312      // 您已经预约过这个受让信托
@interface CXErrorCode : NSObject

+ (NSString*) getErrorCode:(NSInteger)retCode;

@end
