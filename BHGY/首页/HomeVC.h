//
//  HomeVC.h
//  BHGY
//
//  Created by liuxiang on 2020/7/2.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "BaseViewController.h"
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeVC : BaseViewController<JXCategoryViewDelegate,JXCategoryListContainerViewDelegate,CLLocationManagerDelegate>{

    CLLocationManager*locationmanager;//定位服务

    NSString*strlatitude;//经度

    NSString*strlongitude;//纬度

}

@end

NS_ASSUME_NONNULL_END
