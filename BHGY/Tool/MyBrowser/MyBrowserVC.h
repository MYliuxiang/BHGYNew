//
//  MyBrowserVC.h
//  BHGY
//
//  Created by liuxiang on 2020/7/24.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "BaseViewController.h"
#import "MyCustomData.h"

typedef NS_ENUM(NSUInteger, BrowserType)
{
    /*! 未知网络 */
    BrowserTypeMe           = 0,
    BrowserTypeOther
   
};


NS_ASSUME_NONNULL_BEGIN

@interface MyBrowserVC : BaseViewController
@property (nonatomic, copy) NSArray *dataList;
@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, assign) BrowserType type;
@property(nonatomic,copy) void(^photoBlock)(NSArray *photos);
@end

NS_ASSUME_NONNULL_END
