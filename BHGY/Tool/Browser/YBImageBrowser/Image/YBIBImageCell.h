//
//  YBIBImageCell.h
//  YBImageBrowserDemo
//
//  Created by 波儿菜 on 2019/6/5.
//  Copyright © 2019 波儿菜. All rights reserved.
//

#import "YBIBCellProtocol.h"
#import "YBIBImageScrollView.h"


NS_ASSUME_NONNULL_BEGIN

@interface YBIBImageCell : UICollectionViewCell <YBIBCellProtocol>
@property (nonatomic, strong) YBIBImageScrollView *imageScrollView;

@property (nonatomic, strong) UIImageView *tailoringImageView;

- (void)updateImageLayoutWithOrientation:(UIDeviceOrientation)orientation previousImageSize:(CGSize)previousImageSize;
@end

NS_ASSUME_NONNULL_END
