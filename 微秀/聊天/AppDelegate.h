//
//  AppDelegate.h
//  聊天
//
//  Created by 孙承秀 on 16/8/31.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMSDK.h"
#import "SCXLoginViewController.h"
#import "SCXLoginTool.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,EMClientDelegate,EMChatManagerDelegate>
@property (strong, nonatomic) UIWindow *window;


@end

