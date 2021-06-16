//
//  AddAdressVC.m
//  BHGY
//
//  Created by liuxiang on 2020/7/13.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "AddAdressVC.h"

@interface AddAdressVC ()
@property (weak, nonatomic) IBOutlet UIButton *adressB;
@property (weak, nonatomic) IBOutlet UITextField *textF;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AddAdressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.title = @"请选择节目地点";
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"fanhui"]];

    [self.adressB layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
    self.textF.layer.cornerRadius = 13;
    self.textF.layer.masksToBounds = YES;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    SearchAddressVC *vc = [[SearchAddressVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    return NO;
}
- (IBAction)seletedCityAC:(id)sender {
    
    SeletedCityVC *vc = [[SeletedCityVC alloc]init];
//    vc.cityBlock = ^(NSString * _Nonnull cityName) {
//        
//    };
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self.navigationController presentViewController:vc animated:YES completion:nil];
    
}

#pragma  mark --------UITableView Delegete----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        static NSString *identifire = @"cellIDone";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifire];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
        }
        cell.textLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
        cell.textLabel.textColor = Color_3;
        cell.textLabel.left = 20;
        cell.textLabel.text = @"待定";
        
        
        return cell;
    }
    static NSString *identifire = @"cellID";
    AdressCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AdressCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 45;
    }else{
        return UITableViewAutomaticDimension;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.1;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
    
}
- (UIView *)tableView:(UITableView *)tableView viewFooterInSection:(NSInteger)section
{
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}





@end
