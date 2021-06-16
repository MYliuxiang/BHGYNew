//
//  SearchAddressVC.m
//  BHGY
//
//  Created by liuxiang on 2020/7/13.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "SearchAddressVC.h"

@interface SearchAddressVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) UITextField *searchF;

@end

@implementation SearchAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    [self creatNav];
}

- (void)creatNav{
    
    _searchF = [[UITextField alloc] initWithFrame:CGRectMake(44,Height_StatusBar + (44 - 26) / 2, kScreenWidth - 88, 26)];
    _searchF.layer.cornerRadius = 13;
    _searchF.layer.masksToBounds = YES;
    _searchF.backgroundColor = Color_bg;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 26)];
    _searchF.leftView = view;
    _searchF.leftViewMode = UITextFieldViewModeAlways;
    _searchF.delegate = self;
    _searchF.textColor = Color_3;
    _searchF.tintColor = Color_3;
    _searchF.font = [UIFont systemFontOfSize:13];
    _searchF.returnKeyType = UIReturnKeyDone;
    [self.customNavBar addSubview:_searchF];
    
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    //将键盘弹出
    NSLog(@"开始输入");
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    //获取当前文本输入框中所输入的文字
    NSLog(@"所输入的内容为:%@",textField.text);
    //例:判断账号书写形式是否正确 如果不正确提示填写错误 重新输入
    NSLog(@"结束输入");
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    /*
    NSLog(@"内容:%@",textField.text);//获取的是上一次所输入内容
    NSLog(@"Location:%lu Length:%lu",range.location,range.length);//范围为当前文字的位置，长度为零
    NSLog(@"==%@==",string);//实时获取当前输入的字符

    */
    //需求 实时获取当前文本框中的所有文字

    NSString * resultStr = [textField.text stringByAppendingString:string];

    NSLog(@"%@",resultStr);

    //可在该方法中判断所输入文字是否正确

    return YES;
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
    
    static NSString *identifire = @"cellID";
    AdressCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AdressCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}




@end
