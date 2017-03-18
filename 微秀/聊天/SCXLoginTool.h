//
//  SCXLoginTool.h
//  聊天
//
//  Created by 孙承秀 on 16/10/20.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
@class SCXCallManager;
@interface SCXLoginTool : NSObject<EMChatManagerDelegate,EMClientDelegate,EMContactManagerDelegate,EMGroupManagerDelegate>
singleH(login);
@property(nonatomic,strong)UITabBarController  *tabBarController;
-(void)loginSuccess;
-(void)loginOut;
+(void)setBadgeCount:(NSInteger )count tabbar:(UITabBarController *)tabbar;
@end
