//
//  HomeModel.h
//  BHGY
//
//  Created by liuxiang on 2020/7/21.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeModel : NSObject
@property(nonatomic,assign) int age;
@property(nonatomic,copy) NSString *avatar;
@property(nonatomic,copy) NSString *city;
@property(nonatomic,copy) NSString *constellation;
@property(nonatomic,assign) int distance;
@property(nonatomic,assign) int goddess;
@property(nonatomic,copy) NSString *uid;
@property(nonatomic,copy) NSString *nickName;
@property(nonatomic,assign) int online;
@property(nonatomic,assign) int photoFlag;

@property(nonatomic,strong) NSArray *photoList;
@property(nonatomic,copy) NSString *profession;
@property(nonatomic,assign) int realHuman;
@property(nonatomic,assign) int sex;
@property(nonatomic,assign) int vip;
@property(nonatomic,assign) int iscollection;


@end

NS_ASSUME_NONNULL_END
