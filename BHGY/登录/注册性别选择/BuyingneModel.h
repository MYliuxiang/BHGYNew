//
//  BuyingneModel.h
//  BHGY
//
//  Created by 小呗出行 on 2020/7/27.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BuyingneModel : NSObject
@property (nonatomic,copy) NSString *avgCurrencyNum; //平均每月花费花园币数量
@property (nonatomic,copy) NSString *avgRmbNum; //平均每月人民币数量
@property (nonatomic,copy) NSString *createTime; //创建时间
@property (nonatomic,copy) NSString *currencyNum; //花园币数量
@property (nonatomic,copy) NSString *recommend; //是否推荐 0 不推荐 1推荐
@property (nonatomic,copy) NSString *status; //0正常 1停用
@property (nonatomic,copy) NSString *updateTime; //修改时间
@property (nonatomic,copy) NSString *vipMonths; //月数
@property (nonatomic,assign) BOOL isselect; // 是否选中
@end

NS_ASSUME_NONNULL_END
