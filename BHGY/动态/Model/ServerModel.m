//
//  ServerModel.m
//  BHGY
//
//  Created by liuxiang on 2020/7/22.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "ServerModel.h"

@implementation ServerModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"sid":@"id"};
}
@end
