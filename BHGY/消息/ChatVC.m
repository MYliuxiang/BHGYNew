//
//  ChatVC.m
//  BHGY
//
//  Created by liuxiang on 2020/8/5.
//  Copyright © 2020 liuxiang. All rights reserved.
//

#import "ChatVC.h"
#import "LXRedMessageCell.h"
#import "LXRedMessageContent.h"
#import "SeeRedVC.h"
#import "SendRedVC.h"


@interface ChatVC ()

@end

@implementation ChatVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   
    [self refreshTitle];
   
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.displayUserNameInCell = NO;
//    self.messageHasReadStatusView =
        
    
    [self.navigationController.navigationBar setTitleTextAttributes:
    @{NSFontAttributeName:[UIFont systemFontOfSize:16],
      NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#FFFFFF"]}];
//
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:Color_Theme] forBarMetrics:UIBarMetricsDefault];
//    

    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fanhui"] style:UIBarButtonItemStylePlain target:self action:@selector(backAC)];
    
      self.navigationItem.leftBarButtonItem = backItem;
    
    [self.chatSessionInputBarControl.pluginBoardView updateItemAtIndex:0 image:[UIImage imageNamed:@"矩形"] title:@"相册"];
    
    [self.chatSessionInputBarControl.pluginBoardView updateItemAtIndex:1 image:[UIImage imageNamed:@"矩形备份 2"] title:@"拍摄"];

    
    [self.chatSessionInputBarControl.pluginBoardView updateItemAtIndex:2 image:[UIImage imageNamed:@"矩形备份 3"] title:@"位置"];

    
    [self.chatSessionInputBarControl.pluginBoardView updateItemAtIndex:3 image:[UIImage imageNamed:@"矩形备份 4"] title:@"阅读即焚"];

    [self.chatSessionInputBarControl.pluginBoardView insertItemWithImage:[UIImage imageNamed:@"矩形备份 5"] title:@"百花币红包" tag:1005];

     [self.chatSessionInputBarControl.pluginBoardView insertItemWithImage:[UIImage imageNamed:@"编组 13"] title:@"连麦" tag:1006];
     [self.chatSessionInputBarControl.pluginBoardView insertItemWithImage:[UIImage imageNamed:@"矩形备份 7"] title:@"视频" tag:1007];
    
    
    ///注册自定义测试消息Cell
       [self registerClass:[LXRedMessageCell class] forMessageClass:[LXRedMessageContent class]];
      [self registerClass:[LxRedTipCell class] forMessageClass:[LxRedTipContent class]];

    [self xw_addNotificationForName:@"chatReload" block:^(NSNotification * _Nonnull notification) {
        [self.conversationMessageCollectionView reloadData];
    }];

}

- (void)refreshTitle {
    if (self.conversationType == ConversationType_GROUP) {
//        RCDGroupInfo *groupInfo = [RCDGroupManager getGroupInfo:self.targetId];
//        if (groupInfo.groupName) {
//            self.userName = groupInfo.groupName;
//        }
//        if ([groupInfo.number intValue] > 0) {
//            self.title = [NSString stringWithFormat:@"%@(%d)", self.userName, [groupInfo.number intValue]];
//        } else {
//            self.title = [NSString stringWithFormat:@"%@", self.userName];
//        }
    } else if(self.conversationType == ConversationType_PRIVATE){
        RCUserInfo *userInfo = [[RCIM sharedRCIM] getUserInfoCache:self.targetId];
        if (userInfo) {
            self.title = userInfo.name;
        }
    }
}

- (void)pluginBoardView:(RCPluginBoardView *)pluginBoardView clickedItemWithTag:(NSInteger)tag{
    
    if (tag == 1001) {
        
        TZImgePickHelper *helper = [[TZImgePickHelper alloc] initMaxCount:9];
        helper.allowTakePicture = NO;
        helper.allowPickingOriginalPhoto = YES;
        helper.didFinishPickingPhotosHandle = ^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            for (UIImage *image in photos) {
                RCImageMessage *message = [RCImageMessage messageWithImageData:UIImageJPEGRepresentation(image, 1)];
                [[RCIM sharedRCIM] sendMediaMessage:ConversationType_PRIVATE targetId:self.targetId content:message pushContent:nil pushData:nil progress:^(int progress, long messageId) {
                } success:^(long messageId) {
                } error:^(RCErrorCode errorCode, long messageId) {
                } cancel:^(long messageId) {
                }];
                [self.conversationMessageCollectionView scrollToBottom];
            }
            
            
        };
        [self presentViewController:helper animated:YES completion:nil];
        
        return;
    }
    
    if ( tag == 1002 || tag == 1003 || tag == 1004) {
        [super pluginBoardView:pluginBoardView
            clickedItemWithTag:tag];
    }
    if (tag == 1005) {
        
        SendRedVC *vc = [[SendRedVC alloc] init];
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
        vc.senderId = self.targetId;
        vc.sendBlock = ^(NSDictionary * _Nonnull redDic) {
            LXRedMessageContent *textMessage = [LXRedMessageContent messageWithContent:redDic[@"num"] withTitle:redDic[@"title"]];
            
            [[RCIM sharedRCIM] sendMessage:ConversationType_PRIVATE targetId:self.targetId content:textMessage pushContent:nil pushData:nil success:^(long messageId) {
                
            } error:^(RCErrorCode nErrorCode, long messageId) {
                
            }];
        };
        [self presentViewController:nav animated:YES completion:nil];
        
   
        
    }
    
//    [self resetQucilySendView];

    
}

- (void)backAC{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didTapMessageCell:(RCMessageModel *)model{
    if ([model.content isKindOfClass:[LXRedMessageContent class]]) {
        
        if ([model.senderUserId isEqualToString:[RCIM sharedRCIM].currentUserInfo.userId]) {
            //说明是自己发送的红包
            return;
        }
        
        LXRedMessageContent *content = (LXRedMessageContent *)model.content;
        
        NSString *extra = model.extra;
        if ([extra isEqualToString:@"0"]) {

            
            LxRedTipContent *message = [LxRedTipContent messageWithredMessageID:[NSString stringWithFormat:@"%ld",model.messageId]];
            [[RCIM sharedRCIM] sendMessage:ConversationType_PRIVATE targetId:self.targetId content:message pushContent:nil pushData:nil success:^(long messageId) {
                
            } error:^(RCErrorCode nErrorCode, long messageId) {
                
            }];
            
            [[RCIMClient sharedRCIMClient] setMessageExtra:model.messageId value:@"1"];
            [self.conversationMessageCollectionView reloadData];
        }
 
    }
}

- (void)willDisplayMessageCell:(RCMessageBaseCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    RCMessageModel *model = [self.conversationDataRepository objectAtIndex:indexPath.row];
    if (([cell isKindOfClass:[RCTextMessageCell class]] || [cell isKindOfClass:[RCImageMessageCell class]] || [cell isKindOfClass:[RCVoiceMessageCell class]] || [cell isKindOfClass:[RCMessageCell class]])  && model.conversationType == ConversationType_PRIVATE) {
        if (model.content) {
            for (UIView *view in [((RCMessageCell *)cell).messageHasReadStatusView subviews]) {
                [view removeFromSuperview];
            }
            UILabel *hasReadView = [[UILabel alloc] initWithFrame:CGRectMake(-18, 5, 30, 20)];
            hasReadView.textAlignment = NSTextAlignmentRight;
            hasReadView.font = [UIFont systemFontOfSize:12];
            hasReadView.textColor = Color_6;
            ((RCMessageCell *)cell).messageHasReadStatusView.hidden = NO;
            if (model.sentStatus == SentStatus_READ) {
                CGRect hasReadViewFrame = hasReadView.frame;
                hasReadViewFrame.origin.y -= 19;
                hasReadView.frame = hasReadViewFrame;
                hasReadView.text = @"已读";
                [((RCMessageCell *)cell).messageHasReadStatusView addSubview:hasReadView];
            } else if (model.sentStatus == SentStatus_SENT) {
                hasReadView.text = @"未读";
                [((RCMessageCell *)cell).messageHasReadStatusView addSubview:hasReadView];
            }
        }
    } else {
//    for (UIView *view in [((RCMessageCell *)cell).messageHasReadStatusView subviews]) {
//        [view removeFromSuperview];
//        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
