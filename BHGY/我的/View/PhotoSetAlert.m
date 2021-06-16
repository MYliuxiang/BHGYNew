//
//  PhotoSetAlert.m
//  BHGY
//
//  Created by liuxiang on 2020/7/25.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "PhotoSetAlert.h"

@implementation PhotoSetAlert

- (instancetype)initWithContents:(NSArray *)contents withIndex:(NSInteger)index{
 
    self = [super init];
    if (self) {
        
        [self setupAutoHeightWithBottomView:self.cancleB bottomMargin:0];
        self.width = kScreenWidth - 30;
        self.layer.cornerRadius = 7.5;
        self.layer.masksToBounds = YES;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.contents = contents;
        self.type = LxCustomAlertTypeSheet;
        self.seletedIndex = index;
    }
    return self;
    
    
}
- (IBAction)cancleAC:(id)sender {
    [self disMiss];
}

#pragma  mark --------UITableView Delegete----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.contents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifire = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifire];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 30, 44)];
        label.font = [UIFont systemFontOfSize:13];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        label.tag =  100;
        [cell.contentView addSubview:label];
        
    }
    
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:100];
    label.text = self.contents[indexPath.row];
    if (indexPath.row == self.seletedIndex) {
        label.textColor = Color_Theme;
    }else{
        label.textColor = Color_3;
    }
 
    return cell;
    
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
    
    if (self.clickBlcok != nil) {
        self.clickBlcok(indexPath.row);
    }
    [self disMiss];
    
}


@end
