//
//  DynamicModel.h
//  BHGY
//
//  Created by liuxiang on 2020/7/8.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PraiseInfo : NSObject

@property(nonatomic,strong) UserModel *userInfo;
@property(nonatomic,copy) NSString *createTime;
@property(nonatomic,copy) NSString *uid;

@end

@interface EntryInfo : NSObject

@property(nonatomic,strong) UserModel *userInfo;
@property(nonatomic,copy) NSString *createTime;
@property(nonatomic,copy) NSString *uid;
@property(nonatomic,copy) NSString *imageId;
@property(nonatomic,assign) int status;

@end

@interface CommentInfo : NSObject

@property(nonatomic,strong) UserModel *userInfo;
@property(nonatomic,copy) NSString *createTime;
@property(nonatomic,copy) NSString *uid;
@property(nonatomic,copy) NSString *content;

@end



@interface DynamicModel : NSObject


@property(nonatomic,copy) NSString *address;
@property(nonatomic,copy) NSString *city;
@property(nonatomic,copy) NSString *uid;
@property(nonatomic,assign) int commentNum;
@property(nonatomic,copy) NSString *content;
@property(nonatomic,copy) NSString *createTime;
@property(nonatomic,assign) int entryNum;
@property(nonatomic,copy) NSString *expectation;
@property(nonatomic,copy) NSString *meetingTime;
@property(nonatomic,assign) int praiseNum;
@property(nonatomic,copy) NSString *subject;
@property(nonatomic,assign) int type;
@property(nonatomic,strong) NSArray *commentInfoList;
@property(nonatomic,strong) NSArray *entryInfoList;
@property(nonatomic,strong) NSArray *imageList;
@property(nonatomic,strong) NSArray *praiseInfoList;

@property(nonatomic,strong) UserModel *userInfo;

@property(nonatomic,assign) int iscollection;


@end



NS_ASSUME_NONNULL_END
