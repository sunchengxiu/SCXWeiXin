//
//  SCXViewController.m
//  聊天
//
//  Created by 孙承秀 on 16/8/31.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXViewController.h"
#import "EMSDK.h"
#import "SCXChatTableViewController.h"
#import "UIImage+imageCompress.h"
@interface SCXViewController ()<UITableViewDataSource,UITableViewDelegate,EMChatManagerDelegate,EMClientDelegate,EMContactManagerDelegate>

@end

@implementation SCXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"微秀";
    //self.SCX_tableView.backgroundColor=kBackgroundColor;
    //设置代理
    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.title=@"微秀";
    [self loadConversation];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}
-(void)loadConversation{
    [self.dataArray removeAllObjects];
    __weak typeof (self)weakSelf=self;
        dispatch_async(dispatch_get_main_queue(), ^{
            NSArray *arr11=[[EMClient sharedClient].chatManager getAllConversations];
            NSArray *sortArr=[arr11 sortedArrayUsingComparator:^NSComparisonResult(EMConversation* obj1, EMConversation * obj2) {
                if (obj1.lastReceivedMessage.timestamp>obj2.latestMessage.timestamp) {
                    return (NSComparisonResult )NSOrderedAscending;
                }
                else {
                    return (NSComparisonResult)NSOrderedDescending;
                    
                }
                
            }];
            weakSelf.dataArray=[NSMutableArray arrayWithArray:sortArr];
            [weakSelf.SCX_tableView reloadData];
            [self setUpUnreadCount];
        });
}
#pragma mark--设置未读数量
-(void)setUpUnreadCount{
    NSInteger count=0;
    for (EMConversation *conversation in self.dataArray) {
        count+=conversation.unreadMessagesCount;
    }
    if (count>0) {
        
        self.tabBarController.tabBarItem.badgeValue=[NSString stringWithFormat:@"%ld",count];
        [[self.tabBarController.tabBar.items objectAtIndex:0] setBadgeValue:[NSString stringWithFormat:@"%ld",count]];
        self.tabBarController.title=[NSString stringWithFormat:@"微秀(%ld)",(long)count];
    }
    else{
    self.tabBarController.title=@"微秀";
        self.tabBarController.tabBarItem.badgeValue=nil;
        [[self.tabBarController.tabBar.items objectAtIndex:0] setBadgeValue:nil];
    }
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:count];
}
-(void)didConnectionStateChanged:(EMConnectionState)aConnectionState{
    if (aConnectionState==EMConnectionDisconnected) {
        NSLog(@"网络失去连接");
    }
    else{
    
        NSLog(@"连接正常");
    }

}
-(SCXBaseTableViewCell *)SCX_tableViewCellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SCXCell *cell=[SCXCell cellWithTableView:self.SCX_tableView];
    if (self.dataArray.count>0) {
        EMConversation *conversation=self.dataArray[indexPath.row];
        NSString *text;
        EMMessage *message=conversation.lastReceivedMessage;
        if ([message.body isKindOfClass:[EMTextMessageBody class]]) {
            EMTextMessageBody *body=(EMTextMessageBody *)message.body;
            text=body.text;
        }
        else if ([message.body isKindOfClass:[EMImageMessageBody class]]){
            
            EMImageMessageBody *body=(EMImageMessageBody *)message.body;
            text=body.displayName;
        }
        else if([message.body isKindOfClass:[EMVoiceMessageBody class]]){
            EMVoiceMessageBody *body=(EMVoiceMessageBody *)message.body;
            text=body.displayName;
            
        }
        NSString *str=[NSString stringWithFormat:@"%@--%d",conversation.conversationId,conversation.unreadMessagesCount];
        cell.textLabel.text=str;
        cell.detailTextLabel.text=text;
        int a=arc4random()%23;
        NSString *imageName=[NSString stringWithFormat:@"%d.jpg",a];
        UIImage *image=[UIImage imageNamed:imageName];
        cell.imageView.image=[UIImage imageCompressImage:image targetWidth:40];
    }
    return cell;
    return nil;

}
-(void)SCX_tableViewDidSelectRowAtIndexPath:(NSIndexPath *)indexPath withCell:(SCXBaseTableViewCell *)cell{
    SCXChatTableViewController *chat=[[SCXChatTableViewController alloc]init];
//    CGRect frame=CGRectMake(0, 0, SCX_ScreenWidth, SCX_ScreenHeight-50);
//    chat.view.frame=frame;
    EMConversation *conversation=self.dataArray[indexPath.row];
    if (conversation.type==EMChatTypeGroupChat) {
        chat.isGroup=YES;
        chat.group=[EMGroup groupWithId:conversation.conversationId];
    }
    else{
        chat.isGroup=NO;
        chat.Username=conversation.conversationId;
    }
    chat.title=conversation.conversationId;
    //chat.hidesBottomBarWhenPushed=YES;
    chat.navigationController.navigationItem.backBarButtonItem.title=@"微秀";
    [self.navigationController pushViewController:chat animated:YES];

}
-(CGFloat)SCX_tableViewHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
}
-(NSInteger)SCX_tableViewNumberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(NSInteger)SCX_numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}
-(void)userAccountDidLoginFromOtherDevice{
    NSLog(@"账号在异地登录");
    
}
/*!
 *  \~chinese
 *  当前登录账号已经被从服务器端删除时会收到该回调
 *
 *  \~english
 *  Delegate method will be invoked when current IM account is removed from server
 */
-(void)userAccountDidRemoveFromServer{
    NSLog(@"账号被服务器移除");
    
}

@end
