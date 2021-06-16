//
//  HomeModel.m
//  BHGY
//
//  Created by liuxiang on 2020/7/21.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"uid":@"id"};
}
@end
