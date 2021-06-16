//
//  MyCommentModel.h
//  BHGY
//
//  Created by liuxiang on 2020/7/26.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyCommentModel : NSObject

@property(nonatomic,copy) NSString *label;
@property(nonatomic,assign) int num;
@property(nonatomic,copy) NSString *markId;
@property(nonatomic,assign) int marked;
@end

NS_ASSUME_NONNULL_END
