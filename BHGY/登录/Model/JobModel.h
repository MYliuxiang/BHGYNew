//
//  JobModel.h
//  BHGY
//
//  Created by liuxiang on 2020/7/20.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JobModel : NSObject
@property(nonatomic,copy) NSString *name;
@property(nonatomic,strong) NSArray *items;

@end

NS_ASSUME_NONNULL_END
