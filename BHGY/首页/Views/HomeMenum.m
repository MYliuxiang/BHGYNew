//
//  HomeMenum.m
//  BHGY
//
//  Created by liuxiang on 2020/7/7.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "HomeMenum.h"
#import "MenumCell.h"
#import "SubMenumCell.h"

@implementation HomeMenum

- (void)awakeFromNib{
    [super awakeFromNib];
    self.tableView1.delegate = self;
    self.tableView2.delegate = self;
    self.tableView1.dataSource = self;
    self.tableView2.dataSource = self;
    self.tableView2.allowsMultipleSelection = YES;
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
    
    if (tableView == self.tableView1) {
        static NSString *identifire = @"cellID";
        MenumCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MenumCell" owner:nil options:nil] lastObject];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];

        cell.selectedBackgroundView.backgroundColor = Color_Theme;

        
        
        return cell;
    }else{
        static NSString *identifire = @"cellID1";
        SubMenumCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"SubMenumCell" owner:nil options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        
        return cell;
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}




@end
