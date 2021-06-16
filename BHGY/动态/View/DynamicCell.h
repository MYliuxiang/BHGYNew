//
//  DynamicCell.h
//  BHGY
//
//  Created by liuxiang on 2020/7/8.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentView.h"
#import "DynamicModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface DynamicCell : UITableViewCell<MenuViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UIImageView *stateI;
@property (weak, nonatomic) IBOutlet UIButton *btn4;

@property (weak, nonatomic) IBOutlet UIImageView *sexI;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIImageView *iconI;
@property(nonatomic,strong) DynamicModel *model;
@property(nonatomic,strong) ContentView *cView;
- (IBAction)moreAC:(id)sender;
@property(nonatomic,copy) void(^blackNameBlock)(void);
@property(nonatomic,copy) void(^cancleBlock)(void);
@property (weak, nonatomic) IBOutlet UIButton *menuB;


@end

NS_ASSUME_NONNULL_END
