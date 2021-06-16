//
//  ChatMessageVC.m
//  BHGY
//
//  Created by liuxiang on 2020/7/8.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "ChatMessageVC.h"
#import "SeeRedVC.h"
#import "SendRedVC.h"

@interface ChatMessageVC ()
@property (weak, nonatomic) IBOutlet UIButton *sendB;

@end

@implementation ChatMessageVC
- (id)init {
    self = [super init];
    if (self) {
        //设置要显示的会话类型
        [self setDisplayConversationTypes:@[
            @(ConversationType_PRIVATE),
            @(ConversationType_APPSERVICE),
            @(ConversationType_PUBLICSERVICE),
            @(ConversationType_GROUP),
            @(ConversationType_SYSTEM)
        ]];

        //聚合会话类型
        [self setCollectionConversationType:@[ @(ConversationType_SYSTEM) ]];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.fd_prefersNavigationBarHidden = YES;
    self.conversationListTableView.tableFooterView = [UIView new];
    self.conversationListTableView.backgroundColor = Color_bg;
    self.conversationListTableView.separatorColor = Color_line;
    self.conversationListTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    

    
    //视图的 frame 需要开发者根据需求设定
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.height)];
    UIImageView *empty = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 71, 71)];
    empty.image = [UIImage imageNamed:@"baocuofankui"];
    [view addSubview:empty];
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:13];
    label.text = @"暂无对话";
    label.textColor = Color_6;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    [view addSubview:label];
    
    [empty mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view);
        make.top.equalTo(view).offset((kScreenHeight - Height_NavBar - Height_TabBar - 36 - 71) / 2);
    }];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view);
        make.top.equalTo(empty.mas_bottom).offset(10);
        
    }];
    
    
    
   
    self.emptyConversationView = view;

 
   RCConversationViewController *conversationVC = [[RCConversationViewController alloc] initWithConversationType:ConversationType_PRIVATE targetId:@"5f2a62fc1183e3625ca57b5a"];
      //5f2a62fc1183e3625ca57b5a 3320
      //    5f2a596b1183e3625ca57b57 3312
   [self.navigationController pushViewController:conversationVC animated:YES];


}

//cell
- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType
conversationModel:(RCConversationModel *)model
               atIndexPath:(NSIndexPath *)indexPath{
    
    ChatVC *conversationVC = [[ChatVC alloc] initWithConversationType:model.conversationModelType targetId:model.targetId];
       
    [self.navigationController pushViewController:conversationVC animated:YES];
    
    
}

#pragma mark - JXCategoryListContentViewDelegate
- (UIView *)listView {
    return self.view;
}

- (void)listDidAppear {
    
}

- (void)listDidDisappear {
    
}






@end
