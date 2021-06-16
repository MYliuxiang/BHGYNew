//
//  UserModer.m
//  BHGY
//
//  Created by liuxiang on 2020/7/21.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"uid":@"id"};
}
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"cityList":@"NSString"};

}
@end
