//
//  SCXLoginViewController.h
//  聊天
//
//  Created by 孙承秀 on 16/8/31.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMSDK.h"
#import "AppDelegate.h"
#import "SCXLoginTool.h"
#import <MBProgressHUD.h>
@interface SCXLoginViewController : UIViewController
//singleH(LoginViewController);
@property(nonatomic,strong)UITextField *userTextField;
@property(nonatomic,strong)UITextField *passWordTextField;
@property(nonatomic,strong)UIButton *loginButton;
@property(nonatomic,strong)UIButton *registerButton;
@property(nonatomic,strong)MBProgressHUD *hud;
@end
