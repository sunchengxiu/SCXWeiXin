//
//  SCXLoginTool.m
//  聊天
//
//  Created by 孙承秀 on 16/10/20.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXLoginTool.h"
#import "SCXCallManager.h"
@implementation SCXLoginTool
singleM(login);
-(void)loginOut{
    for (NSInteger i=0; i<_tabBarController.childViewControllers.count; i++) {
        UIViewController *vc=_tabBarController.childViewControllers[i];
        [vc willMoveToParentViewController:nil];
        [vc removeFromParentViewController];
    }
    SCXLoginViewController *login=[[SCXLoginViewController alloc]init];
    [[UIApplication sharedApplication] delegate].window.rootViewController=login;
    [[EMClient sharedClient].chatManager removeDelegate:self];
    [[EMClient sharedClient] removeDelegate:self];
    [[EMClient sharedClient].contactManager removeDelegate:self];
    [[EMClient sharedClient].groupManager addDelegate:self delegateQueue:nil];
}
-(void)loginSuccess{
    [SCXCallManager sharedCallManager];
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
    [[SCXAdressViewController sharedaddress].baseArray removeAllObjects];
    UITabBarController *tabbar=[[UITabBarController alloc]init];
    _tabBarController=tabbar;
    NSArray *arr=@[@{kClassKey:@"SCXViewController",
                     kTitleKey:@"微秀",
                     kImgKey    : @"tabbar_mainframe",
                     kSelImgKey : @"tabbar_mainframeHL"},
                   @{kClassKey:@"SCXAdressViewController",
                     kTitleKey:@"通讯录",
                     kImgKey    : @"tabbar_contacts",
                     kSelImgKey : @"tabbar_contactsHL"},
                   @{kClassKey:@"SCXFoundViewController",
                     kTitleKey:@"发现",
                     kImgKey    : @"tabbar_discover",
                     kSelImgKey : @"tabbar_discoverHL"},
                   @{kClassKey:@"SCXSettingViewController",
                     kTitleKey:@"设置",
                     kImgKey    : @"tabbar_me",
                     kSelImgKey : @"tabbar_meHL"}];
    NSMutableArray *arr1=[[NSMutableArray alloc]initWithCapacity:0];
    [arr enumerateObjectsUsingBlock:^(NSDictionary  * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SCXBaseViewController *controller=[NSClassFromString(obj[kClassKey]) new] ;
        controller.title=obj[kTitleKey];
        SCXBaseNaviViewController *nav=[[SCXBaseNaviViewController alloc]initWithRootViewController:controller];
        [nav.navigationBar setTitleTextAttributes:@{
           NSForegroundColorAttributeName:[UIColor whiteColor]}];
        nav.navigationBar.barTintColor=kCommonBlackColor;
        UITabBarItem *item=nav.tabBarItem;
        item.image = [UIImage imageNamed:obj[kImgKey]];
        item.selectedImage = [[UIImage imageNamed:obj[kSelImgKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.title=obj[kTitleKey];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
        [arr1 addObject:nav];
        
        [tabbar addChildViewController:nav];
    }];
    id obj= [SCXStorageManager unArchiveObjectWithFileName:SCX_ArchiveFriendAskInfo];
    if (obj!=nil) {
        
        [SCXLoginTool setBadgeCount:[[NSUserDefaults standardUserDefaults] integerForKey:kUnReadCount] tabbar:tabbar];
        
        [SCXAdressViewController sharedaddress].baseArray=[[NSMutableArray alloc]initWithArray:((NSArray *)obj)];
       
    }
    [SCXAdressViewController sharedaddress].count=[[NSUserDefaults standardUserDefaults] integerForKey:kUnReadCount];;
    [[[UIApplication sharedApplication] delegate] window].rootViewController=tabbar;
    [tabbar setSelectedIndex:0];
    
}
#pragma mark-设置tabbar未读示数
+(void)setBadgeCount:(NSInteger )count tabbar:(UITabBarController *)tabbar{
    
    if (count>0) {
        tabbar.childViewControllers[1].tabBarItem.badgeValue=[NSString stringWithFormat:@"%ld",count];
    }
    else{
        tabbar.childViewControllers[1].tabBarItem.badgeValue=nil;
    }

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

/*!
 *  \~chinese
 *  用户B同意用户A的加好友请求后，用户A会收到这个回调
 *
 *  @param aUsername   用户B
 *
 *  \~english
 *  Delegate method will be invoked is a friend request is approved.
 *
 *  User A will receive this callback after user B approved user A's friend request
 *  @param aUsername   User who approves the friend's request
 */
- (void)friendRequestDidApproveByUser:(NSString *)aUsername{
    [MBProgressHUD showMessage:[NSString stringWithFormat:@"%@同意添加您为好友",aUsername] toView:nil];
}

/*!
 *  \~chinese
 *  用户B拒绝用户A的加好友请求后，用户A会收到这个回调
 *
 *  @param aUsername   用户B
 *
 *  \~english
 *  Delegate method will be invoked if a friend request is declined.
 *
 *  User A will receive this callback after user B declined user A's friend request
 *
 *  @param aUsername   User who declined the friend's request
 */
- (void)friendRequestDidDeclineByUser:(NSString *)aUsername{
    [MBProgressHUD showMessage:[NSString stringWithFormat:@"%@拒绝添加您为好友",aUsername] toView:nil];
}

/*!
 *  \~chinese
 *  用户B删除与用户A的好友关系后，用户A会收到这个回调
 *
 *  @param aUsername   用户B
 *
 *  \~english
 
 *  Delegate method will be invoked if user is removed as a contact by another user
 *
 *  User A will receive this callback after User B unfriended with user A
 *
 *  @param aUsername   User who unfriended the cureent user
 */
- (void)friendshipDidRemoveByUser:(NSString *)aUsername{
  
   
}

/*!
 *  \~chinese
 *  用户B同意用户A的好友申请后，用户A和用户B都会收到这个回调
 *
 *  @param aUsername   用户好友关系的另一方
 *
 *  \~english
 *  Delegate method will be invoked id the user is added as a contact by another user.
 *
 *  Both user A and B will receive this callback after User B agreed user A's add-friend invitation
 *
 *  @param aUsername   Another user of user‘s friend relationship
 */
- (void)friendshipDidAddByUser:(NSString *)aUsername{
    //[MBProgressHUD showMessage:[NSString stringWithFormat:@"您已成功添加对方为好友"] toView:nil];
}

/*!
 *  \~chinese
 *  用户B申请加A为好友后，用户A会收到这个回调
 *
 *  @param aUsername   用户B
 *  @param aMessage    好友邀请信息
 *
 *  \~english
 *  Delegate method will be invoked when user receives a friend request
 *
 *  User A will receive this callback when receiving a friend request from user B
 *
 *  @param aUsername   Friend request sender
 *  @param aMessage    Friend request message
 */
- (void)friendRequestDidReceiveFromUser:(NSString *)aUsername
                                message:(NSString *)aMessage{
    NSString *str=[NSString stringWithFormat:@"%@请求添加您未好友\n理由:%@",aUsername,aMessage];
    UIAlertController *alert=[UIAlertController alertControllerWithTitle: @"好友请求" message:str preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"拒绝" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        EMError *error=[[EMClient sharedClient].contactManager declineInvitationForUsername:aUsername];
        if (!error) {
            [MBProgressHUD showMessage:[NSString stringWithFormat:@"您已拒绝添加%@为好友",aUsername] toView:nil];
        }
        else{
            [MBProgressHUD showMessage:[NSString stringWithFormat:@"拒绝失败"] toView:nil];
        }
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"同意" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        EMError *errror;
        errror= [[EMClient sharedClient].contactManager acceptInvitationForUsername:aUsername];
        if (!errror) {
            [MBProgressHUD showMessage:[NSString stringWithFormat:@"您已成功添加%@为好友",aUsername] toView:nil];
        }
        else{
            [MBProgressHUD showMessage:[NSString stringWithFormat:@"好友添加失败"] toView:nil];
        }
    }]];
    SCXAdressViewController *address=_tabBarController.viewControllers[1];
    int number= [address.tabBarItem.badgeValue intValue]+1;
    _tabBarController.viewControllers[1].tabBarItem.badgeValue  =[NSString stringWithFormat:@"%d",number];
    NSString *imageName=[NSString stringWithFormat:@"%d.jpg",arc4random()%23];
    NSString *strLiyou;
    if (aMessage) {
        strLiyou=aMessage;
    }
    else{
     strLiyou =[NSString stringWithFormat:@"%@请求添加您为好友",aUsername];
    }
  
    
    NSDictionary *userInfo=@{kUser:aUsername,kLIYou:strLiyou, kAcceptButtonTitle:@"接受"};
    
    NSDictionary *dic=@{kTitleKey:userInfo,kImgKey:imageName };
    
    [[SCXAdressViewController sharedaddress].baseArray addObject:[NSArray arrayWithObject:dic]];;
    [SCXAdressViewController sharedaddress].count+=1;
    [[NSUserDefaults standardUserDefaults] setInteger:[SCXAdressViewController sharedaddress].count forKey:kUnReadCount];
    NSLog(@"%@",[SCXAdressViewController sharedaddress].baseArray);
    NSLog(@"%ld",[SCXAdressViewController sharedaddress].baseArray.count);
    [[NSNotificationCenter defaultCenter] postNotificationName:SCX_FriendAskNotification object:nil];
    [SCXStorageManager archiveObject:[SCXAdressViewController sharedaddress].baseArray withFileName:SCX_ArchiveFriendAskInfo];
    
}
-(void)didJoinGroup:(EMGroup *)aGroup inviter:(NSString *)aInviter message:(NSString *)aMessage{
    NSLog(@"%@",aGroup);
    NSLog(@"----%@",aInviter);
    NSLog(@"----%@",aMessage);
}

@end
