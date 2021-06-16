//
//  SendRedVC.m
//  BHGY
//
//  Created by liuxiang on 2020/7/12.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "SendRedVC.h"

@interface SendRedVC ()
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIButton *doneB;
@property (weak, nonatomic) IBOutlet TXLimitedTextField *countF;
@property (weak, nonatomic) IBOutlet TXLimitedTextField *titleF;
@property (weak, nonatomic) IBOutlet UILabel *countLab;

@end

@implementation SendRedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.title = @"发百花币红包";

    self.view1.layer.cornerRadius = 7.5;
    self.view1.layer.masksToBounds = YES;
    
    self.view2.layer.cornerRadius = 7.5;
    self.view2.layer.masksToBounds = YES;
    
    self.doneB.layer.cornerRadius = 7.5;
    self.doneB.layer.masksToBounds = YES;
    [self creatBar];
    self.customNavBar.leftButton.hidden = YES;
    
}

- (void)creatBar{
    
    UIButton *sexBtn = [UIButton buttonWithType:UIButtonTypeCustom];
       sexBtn.frame = CGRectMake(0, Height_StatusBar, 44, 44);
    sexBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [sexBtn setTitle:@"取消" forState:UIControlStateNormal];
       [sexBtn addTarget:self action:@selector(cancle:) forControlEvents:UIControlEventTouchUpInside];
       [self.customNavBar addSubview:sexBtn];
}

- (void)cancle:(UIButton *)semder{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)sendAC:(id)sender {
    
    if ([_countF.text intValue] <= 0) {
        [MBProgressHUD showError:@"请输入金额" toView:lxWindow];
        return;
    }
    
    
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = [NSString stringWithFormat:@"%@%@",MainUrl,Url_hongbao_sendHongBao];
    entity.needCache = NO;
    entity.parameters = @{@"num":self.countF.text,@"targetId":self.senderId};
    [MBProgressHUD showHUDAddedTo:lxWindow animated:YES];
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *result = response;
        if ([result[@"code"] intValue] == 0) {
            if (self.sendBlock) {
                self.sendBlock(@{@"num":self.countF.text,@"title":self.titleF.placeholder});
                
            }
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            
        }
        
    } failureBlock:^(NSError *error) {
        
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    self.countLab.text = [NSString stringWithFormat:@"%d",[self.countF.text intValue]];
    return YES;
}

- (void)textFieldDidChangeSelection:(UITextField *)textField{
    self.countLab.text = [NSString stringWithFormat:@"%d",[self.countF.text intValue]];
    
}





@end
