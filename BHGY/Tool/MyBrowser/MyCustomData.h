//
//  MyCustomData.h
//  BHGY
//
//  Created by liuxiang on 2020/7/24.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "YBIBImageData.h"
#import "MyBserCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyCustomData : YBIBImageData <YBIBDataProtocol>
@property (nonatomic, assign) int type;
@property (nonatomic, copy) NSString *imageId;
@property (nonatomic, copy) NSString *sid;
@property(nonatomic,copy) void(^updatePhoto)(MyCustomData *data);

@end

NS_ASSUME_NONNULL_END
