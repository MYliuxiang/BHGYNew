//
//  UserModer.h
//  BHGY
//
//  Created by liuxiang on 2020/7/21.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserModel : NSObject

@property(nonatomic,copy) NSString *avatar;
@property(nonatomic,assign) int goddess;
@property(nonatomic,copy) NSString *uid;
@property(nonatomic,copy) NSString *nickName;
@property(nonatomic,assign) int realHuman;
@property(nonatomic,assign) int sex;
@property(nonatomic,assign) int vip;

@property(nonatomic,strong) NSArray *cityList;




@end

NS_ASSUME_NONNULL_END
