//
//  UIViewController+Swizzling.m
//  NIM
//
//  Created by chris on 15/6/15.
//  Copyright (c) 2015年 Netease. All rights reserved.
//

#import "UIViewController+Swizzling.h"
#import "SwizzlingDefine.h"

@implementation UIViewController (Swizzling)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        swizzling_exchangeMethod([UIViewController class], @selector(initWithNibName:bundle:), @selector(swizzling_initWithNibName:bundle:));

    });
    
   
    
}

#pragma mark - ViewDidLoad


#pragma mark - InitWithNibName:bundle:
//如果希望vchidesBottomBarWhenPushed为NO的话，请在vc init方法之后调用vc.hidesBottomBarWhenPushed = NO;
- (instancetype)swizzling_initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    id instance = [self swizzling_initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (instance) {
        self.hidesBottomBarWhenPushed = YES;
        if (@available(iOS 13.0, *)) {
               [self setOverrideUserInterfaceStyle:UIUserInterfaceStyleLight];
           } else {
               // Fallback on earlier versions
           }if (@available(iOS 12.0, *)) {
               if (@available(iOS 13.0, *)) {
                   [self setOverrideUserInterfaceStyle:UIUserInterfaceStyleLight];
               } else {
                   // Fallback on earlier versions
               }
           } else {
               // Fallback on earlier versions
           }
    }
    return instance;
}





@end
