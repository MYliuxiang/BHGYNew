//
//  DynamicModel.m
//  BHGY
//
//  Created by liuxiang on 2020/7/8.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "DynamicModel.h"
@implementation PraiseInfo
//+(NSDictionary *)mj_replacedKeyFromPropertyName
//{
//    return @{@"Id":@"id"};
//}

//+(NSDictionary *)mj_objectClassInArray
//{
//    return @{@"globalNewsList":@"GloblNewsModel"};
//}
@end
@implementation EntryInfo
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"uid":@"id"};
}

//+(NSDictionary *)mj_objectClassInArray
//{
//    return @{@"globalNewsList":@"GloblNewsModel"};
//}
@end
@implementation CommentInfo
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"uid":@"id"};
}

//+(NSDictionary *)mj_objectClassInArray
//{
//    return @{@"globalNewsList":@"GloblNewsModel"};
//}
@end

@implementation DynamicModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"uid":@"id"};
}

+(NSDictionary *)mj_objectClassInArray
{
    
    return @{@"imageList":@"NSString",@"commentInfoList":@"CommentInfo",@"entryInfoList":@"EntryInfo",@"praiseInfoList":@"PraiseInfo"};
}
@end
