//
//  HttpHelp.h
//  WaiHui
//
//  Created by liuxiang on 2018/12/24.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import <Foundation/Foundation.h>


//通知
extern NSString *const HomeLoadNotice;



extern NSString *const User_token;

extern NSString *const Url_UploadFile;

extern NSString *const Url_login;

//首页
extern NSString *const Url_userInfo_find;

extern NSString *const Url_userInfo_updateLocation;

//添加收藏
extern NSString *const Url_userFavorite_add;
//取消收藏
extern NSString *const Url_userFavorite_list;
//收藏列表
extern NSString *const Url_userFavorite_remove;
//添加黑名单
extern NSString *const Url_blacklist_add;
//黑名单列表
extern NSString *const Url_blacklist_list;
//移除黑名单
extern NSString *const Url_blacklist_remove;
//动态接口
extern NSString *const Url_dynamic_find;
//动态主题接口
extern NSString *const Url_meetingSubject_findAll;
//发布动态
extern NSString *const Url_dynamic_publishDynamic;
//更新最后在线时间
extern NSString *const Url_userInfo_updateLastLoginTime;
//获取所有期望对象
extern NSString *const Url_expectationsObject_findAll;
//获取所有举报理由。
extern NSString *const Url_complaintReason_findAll;
//投诉。
extern NSString *const Url_userComplaint_complaint;
//上传新照片
extern NSString *const Url_userPhoto_add;

//我的相册
extern NSString *const Url_userPhoto_listMine;
//删除照片
extern NSString *const Url_userPhoto_remove;
//更新照片
extern NSString *const Url_userPhoto_updateType;
//设置相册状态
extern NSString *const Url_userPhoto_settingPhotoType;

//查看评价
extern NSString *const Url_userMark_view;
//查看他的动态
extern NSString *const Url_dynamic_findByUserId;
//查看我的广播
extern NSString *const Url_dynamic_findMine;
//给动态点赞
extern NSString *const Url_dynamic_praise;

extern NSString *const Url_userInfo_queryUserDetail;
//获取信息
extern NSString *const Url_userInfo_getInfo;

extern NSString *const Url_userInfo_updateSex;
//发送红包
extern NSString *const Url_hongbao_sendHongBao;


NS_ASSUME_NONNULL_BEGIN

@interface HttpHelp : NSObject

@end

NS_ASSUME_NONNULL_END
