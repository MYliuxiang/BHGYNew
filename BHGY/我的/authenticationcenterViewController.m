//
//  authenticationcenterViewController.m
//  BHGY
//
//  Created by 李立 on 2020/7/12.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "authenticationcenterViewController.h"
#import "NvshenrenzViewController.h"
#import "CertificationprocessViewController.h"
@interface authenticationcenterViewController ()

@end

@implementation authenticationcenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.customNavBar.title = @"认证中心";
    [self setui];
}

//初始化ui
-(void)setui{
    
    UIImageView *icomimagview = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-77.6)/2, Height_NavBar+50, 77.6, 77.6)];
//    icomimagview.backgroundColor = [UIColor grayColor];
    icomimagview.image = [UIImage imageNamed:@"真人认证图标"];
    [self.view addSubview:icomimagview];
    
    //将通过面容
    UILabel *mianronglabel = [[UILabel alloc]initWithFrame:CGRectMake(0, Height_NavBar+148.5, kScreenWidth, 22.5)];
    mianronglabel.font = [UIFont systemFontOfSize:16];
    mianronglabel.textColor = [UIColor colorWithHexString:@"#333333"];
    mianronglabel.text = @"将通过面容进行认证";
    mianronglabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:mianronglabel];
    
    //真人认证
    UIButton *renzhengbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    renzhengbutton.frame = CGRectMake((kScreenWidth-295)/2, mianronglabel.bottom+30, 295, 45);
    renzhengbutton.backgroundColor = [UIColor colorWithHexString:@"#4BC6AF"];
    renzhengbutton.titleLabel.font = [UIFont systemFontOfSize:15];
    KViewBorderRadius(renzhengbutton, 22.5, 0.5, [UIColor clearColor]);
    [renzhengbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [renzhengbutton setTitle:@"真人认证" forState:UIControlStateNormal];
    [renzhengbutton addTarget:self action:@selector(renzhenbutton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:renzhengbutton];
    
    //女神认证
    UIButton *nvshenbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    nvshenbutton.frame = CGRectMake((kScreenWidth-295)/2, renzhengbutton.bottom+15, 295, 45);
    nvshenbutton.backgroundColor = [UIColor colorWithHexString:@"#FB78A3"];
    nvshenbutton.titleLabel.font = [UIFont systemFontOfSize:15];
    KViewBorderRadius(nvshenbutton, 22.5, 0.5, [UIColor clearColor]);
    [nvshenbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nvshenbutton setTitle:@"女神认证" forState:UIControlStateNormal];
    [nvshenbutton addTarget:self action:@selector(nvshengbuttonaciton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nvshenbutton];
    
    //认证特权
    UILabel *tequanlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, nvshenbutton.bottom+35, kScreenWidth, 16.5)];
    tequanlabel.font = [UIFont systemFontOfSize:12];
    tequanlabel.textColor = [UIColor colorWithHexString:@"#999999"];
    tequanlabel.text = @"——   认证特权    ——";
    tequanlabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tequanlabel];
    
    //循环创建
    for (int i = 0; i <3; i ++) {
        UIButton *iconbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        iconbutton.frame = CGRectMake(15, tequanlabel.bottom+14+i*55, 43, 40);
        KViewBorderRadius(iconbutton, 7.5, 0.5, [UIColor clearColor]);
        iconbutton.backgroundColor = [UIColor colorWithHexString:@"#4BC6AF"];
        [iconbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [iconbutton setTitle:@"真人" forState:UIControlStateNormal];
        iconbutton.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.view addSubview:iconbutton];
        
        //图片后面的文字
        UILabel *iconlabel = [[UILabel alloc]initWithFrame:CGRectMake(iconbutton.right+15.5, iconbutton.top+11, 90, 18.5)];
        iconlabel.font = [UIFont systemFontOfSize:13];
        iconlabel.textColor = [UIColor colorWithHexString:@"#666666"];
        iconlabel.text = @"免费发广播";
        [self.view addSubview:iconlabel];
        
        
        UIButton *abexbutton = [UIButton buttonWithType:UIButtonTypeCustom];
       abexbutton.frame = CGRectMake(iconbutton.right+164, tequanlabel.bottom+14+i*55, 43, 40);
       KViewBorderRadius(abexbutton, 7.5, 0.5, [UIColor clearColor]);
       abexbutton.backgroundColor = [UIColor colorWithHexString:@"#4BC6AF"];
       [abexbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
       [abexbutton setTitle:@"真人" forState:UIControlStateNormal];
       abexbutton.titleLabel.font = [UIFont systemFontOfSize:13];
       [self.view addSubview:abexbutton];
       
       //图片后面的文字
       UILabel *abexiconlabel = [[UILabel alloc]initWithFrame:CGRectMake(abexbutton.right+15.5, abexbutton.top+11, 90, 18.5)];
       abexiconlabel.font = [UIFont systemFontOfSize:13];
       abexiconlabel.textColor = [UIColor colorWithHexString:@"#666666"];
       abexiconlabel.text = @"免费发广播";
       [self.view addSubview:abexiconlabel];
        
        if (i ==1) {
         iconlabel.text = @"报名男士广播";
         abexiconlabel.text = @"私聊男士";
        }else if (i ==2){
            [iconbutton setTitle:@"女神" forState:UIControlStateNormal];
            [abexbutton setTitle:@"女神" forState:UIControlStateNormal];
            iconbutton.backgroundColor = [UIColor colorWithHexString:@"#FB78A3"];
            abexbutton.backgroundColor = [UIColor colorWithHexString:@"#FB78A3"];
            iconlabel.text = @"红包照片";
            abexiconlabel.text = @"收费相册";
        }
    }
    
}



//真人认证
-(void)renzhenbutton{
    CertificationprocessViewController *vc = [[CertificationprocessViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}


//女神认证
-(void)nvshengbuttonaciton{
    NvshenrenzViewController *vc = [[NvshenrenzViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
@end
