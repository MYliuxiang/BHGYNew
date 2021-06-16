//
//  ExpectationAlert.m
//  BHGY
//
//  Created by liuxiang on 2020/7/23.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "ExpectationAlert.h"

@implementation ExpectationAlert

- (instancetype)initWithContents:(NSArray *)contents seletes:(NSArray *)seletes{
    self = [super init];
    if (self) {
        
        [self setupAutoHeightWithBottomView:self.tableView bottomMargin:0];
        self.width = kScreenWidth - 30;
        self.layer.cornerRadius = 7.5;
        self.layer.masksToBounds = YES;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.allowsMultipleSelection = YES;
        self.seletes = seletes;
        self.contents = contents;

        for (int i = 0; i < self.contents.count; i++) {
            
            NSLog(@"hahh");

            if([self.seletes containsObject:self.contents[i]]){
                NSLog(@"hahh");
                  [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
            }
//            for (NSString *str in self.seletes) {
//                if ([str isEqualToString:self.contents[i]]) {
//
//                    break;
//                }
//            }
        }
                
        
       
        self.type = LxCustomAlertTypeSheet;
    }
    return self;
}
- (IBAction)canCleAC:(id)sender {
    [self disMiss];
}

- (IBAction)doneAC:(id)sender {
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < self.tableView.indexPathsForSelectedRows.count; i++) {
        NSIndexPath *path = self.tableView.indexPathsForSelectedRows[i];
        [array addObject:self.contents[path.row]];
        
    }
    NSString *str;

    if (array.count == 0) {
        str = @"";
    }else{
       str = [array componentsJoinedByString:@","];
   }
    if (self.clickBlcok) {
        self.clickBlcok(str);
    }
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
    CenterCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (cell == nil) {
         cell = [[[NSBundle mainBundle] loadNibNamed:@"CenterCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
    }
    cell.centerL.text = self.contents[indexPath.row];
   
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
    
   
     if (self.tableView.indexPathsForSelectedRows.count > 4) {
           [MBProgressHUD showError:@"最多选择只能选择四个期望对象" toView:lxWindow];
           [tableView deselectRowAtIndexPath:indexPath animated:YES];
           return;
       }
    
}


@end
