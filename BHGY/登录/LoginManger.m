//
//  LoginManger.m
//  BHGY
//
//  Created by liuxiang on 2020/7/16.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "LoginManger.h"

@implementation UserPhoto
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"sid":@"id"};
}
MJCodingImplementation

@end

@implementation LoginModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"uid":@"id"};
}

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"photoList":@"UserPhoto"};
}

MJCodingImplementation

@end

@interface LoginManger ()
@property (nonatomic,copy)  NSString    *filepath;
@end

@implementation LoginManger

+ (instancetype)sharedManager
{
    static LoginManger *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *filepath = [[NSString alloc]initWithFormat:@"%@/login_data",[paths objectAtIndex:0]];
        
        instance = [[LoginManger alloc] initWithPath:filepath];
    });
    return instance;
}


- (instancetype)initWithPath:(NSString *)filepath
{
    if (self = [super init])
    {
        _filepath = filepath;
        [self readData];
    }
    return self;
}

- (void)setCurrentLoginModel:(LoginModel *)currentLoginModel
{
    _currentLoginModel = currentLoginModel;
    [self saveData];
}




//从文件中读取和保存用户名密码,建议上层开发对这个地方做加密,DEMO只为了做示范,所以没加密
- (void)readData
{
    NSString *filepath = [self filepath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filepath])
    {
        id object = [NSKeyedUnarchiver unarchiveObjectWithFile:filepath];
        _currentLoginModel = [object isKindOfClass:[LoginModel class]] ? object : nil;
    }
    
}

- (void)saveData
{
    NSData *data = [NSData data];
    if (_currentLoginModel)
    {
        data = [NSKeyedArchiver archivedDataWithRootObject:_currentLoginModel];
    }
    [data writeToFile:[self filepath] atomically:YES];
  
}

//- (void)removeData{
//    
//    [[NSFileManager defaultManager] removeItemAtPath:[self filepath] error:nil];
//    [self readData];
//  
//    
//}



@end
