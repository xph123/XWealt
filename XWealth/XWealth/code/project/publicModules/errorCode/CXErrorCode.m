//
//  CXErrorCode.m
//  Link
//
//  Created by chx on 15-1-9.
//  Copyright (c) 2015年 rasc. All rights reserved.
//

#import "CXErrorCode.h"

@implementation CXErrorCode

+ (NSString*) getErrorCode:(NSInteger)retCode
{
    NSString *ret;
    
    switch (retCode) {
        case SUCCESS:
            ret = StringSuccess;
            break;
        case UNKNOWN_ERROR:
            ret = StringUnknowError;
            break;
        case UNLOGINED:
            ret = StringUnLogined;
            break;
        case PARAMETER_ERROR:
            ret = StringParameterError;
            break;
        case UTIL_ILLEGAL:
            ret = StringUtilIllegal;
            break;
        case UTIL_AUTHCODE:
            ret = StringUtilAuthcode;
            break;
        case ERROR_PASSWORD:
            ret = StringErrorPassword;
            break;
        case REG_USER_PARAMETER_ERROR:
            ret = StringRegUserParameterError;
            break;
        case REG_EMPTY_EMAIL:
            ret = StringRegEmptyEmal;
            break;
        case REG_FORMAT_ERROR_EMAIL:
            ret = StringRegFormatErrorEmail;
            break;
        case REG_EXIST_EMAIL:
            ret = StringRegExistEmail;
            break;
        case REG_EMPTY_USER_NAME:
            ret = StringRegEmptyUserName;
            break;
        case REG_EXIST_USER_NAME:
            ret = StringRegExistUserName;
            break;
        case REG_EMPTY_PASSWORD:
            ret = StringEmptyPassword;
            break;
        case REG_EMPTY_PHONENUM:
            ret = StringRegEmptyPhoneNum;
            break;
        case REG_FORMAT_ERROR_PHONENUM:
            ret = StringRegFormatErrorPhoneNum;
            break;
        case REG_EXIST_PHONENUM:
            ret = StringRegExistPhoneNum;
            break;
        case REG_EMPTY_AUTHENTICATED_CODE:
            ret = StringRegEmptyAuthenticatedCode;
            break;
        case REG_AUTHENTICATED_CODE_ERROR:
            ret = StringAuthenticatedCodeError;
            break;
        case REG_EMPTY_ORGANIZATION:
            ret = StringRegEmptyOrganiation;
            break;
        case REG_EMPTY_RECOMMENT:
            ret = StringEmptyRecomment;
            break;
        case REG_EXIST_RECOMMENT:
            ret = StringExistRecomment;
            break;
        case LOG_EMPTY_USER_NAME:
            ret = StringLogEmptyUserName;
            break;
        case LOG_EMTPY_PASSWORD:
            ret = StringLogEmptyPassword;
            break;
        case LOG_USERNAME_OR_PASSWOLD_ERROR:
            ret = StringLogUserNameOrPasswordError;
            break;
        case LOG_EMTPY_EMAIL:
            ret = StringLogEmptyEmail;
            break;
        case LOG_EMPTY_PHONENUM:
            ret = StringLogEmptyPhoneNum;
            break;
        case LOG_BEEN_BIND:
            ret = StringLogBeenBind;
            break;
        case LOG_ACCOUNT_BLOCKED:
            ret = StringLogAccountBlocked;
            break;
        case LOG_BEEN_BIND_PARAM:
            ret = StringLogBeenBindParam;
            break;
        case BIND_QQ_YES:
            ret = StringBindQQYes;
            break;
        case BIND_SINA_YES:
            ret = StringBindSinaYes;
            break;
        case ACTIVITY_PRASIED:
            ret = StringActivityPrasied;
            break;
        case ACTIVITY_NOT_PRASIED:
            ret = StringActivityNotPrasied;
            break;
        case ACTIVITY_JOINED:
            ret = StringActivityJoined;
            break;
        case ORGAN_NOT_EXISTS:
            ret = StringOrganNotExists;
            break;
        case ORGAN_PRASIED:
            ret = StringOrganPrasied;
            break;
        case ORGAN_NOT_PRASIED:
            ret = StringOrganNotPrasied;
            break;
        case STATUS_PRASIED:
            ret = StringStatusPrasied;
            break;
        case AUTHEN_NO:
            ret = StringAuthedNo;
            break;
        case AUTHEN_ING:
            ret = StringAuthedIng;
            break;
        case FIND_USERNAME_NOEXIT:
            ret = StringFindUsernameNoExist;
            break;
        case FIND_MAIL_NOBIND:
            ret = StringFindMailNoBind;
            break;
        case FIND_USERNAME_ERROR:
            ret = StringFindUsernameError;
            break;
        case FIND_PHONE_ERROR:
            ret = StringFindPhoneError;
            break;
        case FIND_PHONE_NOBIND:
            ret = StringFindPhoneNoBind;
            break;
        case PAY_ERROR:
            ret = StringPayError;
            break;
        case APPROVED_USER_EXIST:
            ret = StringApprovedUserExist;
            break;
        case FOLLOW_EXISTS:
            ret = StringFollowExists;
            break;
        case UPLOAD_EXCEPTION:
            ret = StringUploadException;
            break;
        case INFORMATION_ISDELETE:
            ret = StringInformDeleted;
            break;
        case INFORMATION_FAVORED:
            ret = StringInformFavored;
            break;
        
        case PRODUCT_ISDELETE:
            ret = StringProductIsDelete;
            break;
        case PRODUCT_ATTENTIONED:
            ret = StringProductAttentioned;
            break;
        case PRODUCT_RELEASE_NOEXIST:
            ret = StringProductReleaseNoExist;
            break;
        case PRODUCT_SUBSCRIBE_NOEXIST:
            ret = StringProductSubscribeNoExist;
            break;
        case RECOMMENT_USER_REGED:
            ret = StringRecommentUserReged;
            break;
        case RECOMMENT_USER_BERECOMMENTED:
            ret = StringUserBeRecommented;
            break;
        case RECOMMENT_USER_RECOMMENTED:
            ret = StringUserRecommented;
            break;
        case LAW_ISDELETE:
            ret = StringLawIsdelete;
            break;
        case LAW_FAVORED:
            ret = StringLawFavored;
            break;
        case COURSE_ISDELETE:
            ret = StringCourseIsdelete;
            break;
        case COURSE_FAVORED:
            ret = StringCourseFavored;
            break;
        case BENEFIT_RELEASE_NOEXIST:
            ret = StringBenefitReleaseNoexist;
            break;
        case TRACK_RELEASE_NOEXIST:
            ret = StringTrackReleaseNoexist;
            break;
            
        case PRODUCT_OVER_LIMIT:
            ret = StringProductOverLimit;
            break;
        case PRODUCT_ALREADY_SUBSCRIBE:
            ret = StringProductSubscribed;
            break;
        case PRODUCT_SUBSCRIBE_BY_OTHERS:
            ret = StringProductAnotherSubscribe;
            break;
        case INFORMATION_FAVORITEINFO:
            ret = StringInformCollection;
            break;
        case PRODUCT_PRODUCT_NAME_REPEAT:
            ret = StringProductNameRepeat;
            break;
        case REGISTERED_MANY:
            ret = StringRegisteredMany;
            break;
        case ERROR_NO_NEWVERSION:
            ret = StringNoNewVersion;
            break;
        case BENEFIT_SUBSCRIBED:
            ret = StringtrustTransferExist;
            break;
        case BUYBACK_SUBSCRIBED:
            ret = StringBuybackTrustExist;
            break;
        default:
            ret = StringDefaultError;
            break;
    }

    return ret;
}

@end
