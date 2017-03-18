//
//  SCXLoginViewController.m
//  聊天
//
//  Created by 孙承秀 on 16/8/31.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXLoginViewController.h"
#import "EMSDK.h"
#import "EMError.h"
@interface SCXLoginViewController ()<EMChatManagerDelegate,EMClientDelegate>

@end

@implementation SCXLoginViewController
//singleM(LoginViewController);
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"登陆微秀";
    self.view.backgroundColor=[UIColor whiteColor];
    [self setUpLoginView];
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
    // Do any additional setup after loading the view.
}

-(void)setUpLoginView{
    UITextField *userName=[[UITextField alloc]init];
    _userTextField=userName;
    [userName setBackgroundColor:[UIColor purpleColor]];
    [self.view addSubview:_userTextField];
    UITextField *passWord=[[UITextField alloc]init];
    [passWord setBackgroundColor:[UIColor purpleColor]];
    _passWordTextField=passWord;
    [self.view addSubview:_passWordTextField];
    UIButton *loginButton=[[UIButton alloc]init];
    _loginButton=loginButton;
    [loginButton setBackgroundColor:[UIColor greenColor]];
    [loginButton setTitle:@"登陆微秀" forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginButton];
    
    UIButton *registerButton=[[UIButton alloc]init];
    _registerButton=registerButton;
    [registerButton setBackgroundColor:[UIColor greenColor]];
    [registerButton setTitle:@"注册微秀" forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(registerButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];

    
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [_userTextField autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view];
    [_userTextField autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.view withOffset:50];
    [_userTextField autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.view withOffset:-50];
    [_userTextField autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view withOffset:150];
    [_userTextField autoSetDimension:ALDimensionHeight toSize:50];
    [_passWordTextField autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_userTextField withOffset:30];
    [_passWordTextField autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_userTextField];
    [_passWordTextField autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_userTextField];
    [_passWordTextField autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_userTextField];
    [self.view layoutIfNeeded];
    [_loginButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_passWordTextField withOffset:30];
    [_loginButton autoAlignAxis:ALAxisVertical toSameAxisOfView:_userTextField];
    [_loginButton autoSetDimension:ALDimensionWidth toSize:_passWordTextField.frame.size.width/2];
    [_loginButton autoSetDimension:ALDimensionHeight toSize:50];
    
    [_registerButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_loginButton withOffset:30];
    [_registerButton autoAlignAxis:ALAxisVertical toSameAxisOfView:_userTextField];
    [_registerButton autoSetDimension:ALDimensionWidth toSize:_passWordTextField.frame.size.width/2];
    [_registerButton autoSetDimension:ALDimensionHeight toSize:50];
    

}
-(void)registerButton:(UIButton *)button{
    if (_hud) {
        [_hud removeFromSuperview];
        _hud=nil;
    }
    _hud=[[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:_hud];
    
    _hud.labelText=@"注册中...";
    [_hud show:YES];
   
    
    // hud.dimBackground=YES;
    __block __weak typeof(_hud)HUD=_hud;
    HUD.yOffset=150;
    [[EMClient sharedClient] registerWithUsername:_userTextField.text password:_passWordTextField.text completion:^(NSString *aUsername, EMError *aError) {
         _hud.mode=MBProgressHUDModeText;
        if (aError==nil) {
            _hud.labelText=@"注册成功";
            [_hud showAnimated:YES whileExecutingBlock:^{
                sleep(3);
            } completionBlock:^{
                [HUD removeFromSuperview];
                HUD=nil;
            }];
          
           
            
           
        }
        else{
            NSLog(@"注册失败原因;%@",aError.errorDescription);
            _hud.labelText=@"注册失败";
            [_hud showAnimated:YES whileExecutingBlock:^{
                sleep(3);
            } completionBlock:^{
                [HUD removeFromSuperview];
                HUD=nil;
            }];
            
        }
    }];
    
}
-(void)login:(UIButton *)button{
    
    if (_hud) {
        [_hud removeFromSuperview];
        _hud=nil;
    }
   _hud=[[MBProgressHUD alloc]initWithView:self.view];
   
    [self.view addSubview:_hud];
    
    _hud.labelText=@"登陆中...";
//    [_hud showAnimated:YES whileExecutingBlock:^{
//        
//    }];
    [_hud show:YES];
    
    
   // hud.dimBackground=YES;
   __block __weak typeof(_hud)HUD=_hud;
    HUD.yOffset=150;
   
    
   
   [[EMClient sharedClient] loginWithUsername:_userTextField.text password:_passWordTextField.text completion:^(NSString *aUsername, EMError *aError) {
       _hud.mode=MBProgressHUDModeText;
       if (aError==nil) {
           [[EMClient sharedClient].options setIsAutoLogin:YES];
           NSLog(@"登陆成功");
           _hud.labelText=@"登陆成功";
            [[EMClient sharedClient].options setIsAutoLogin:YES];
           [_hud showAnimated:YES whileExecutingBlock:^{
               sleep(3);
           } completionBlock:^{
               [HUD removeFromSuperview];
               HUD=nil;
           }];
           [[SCXLoginTool sharedlogin] loginSuccess];
       }
       else{
           NSLog(@"登陆失败");
            NSLog(@"登陆失败原因:%@",aError.errorDescription);
            _hud.labelText=@"登陆失败";
           [_hud showAnimated:YES whileExecutingBlock:^{
               sleep(3);
           } completionBlock:^{
               [HUD removeFromSuperview];
               HUD=nil;
           }];
       }
    }];
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*!
 *  \~chinese
 *  当前登录账号在其它设备登录时会接收到此回调
 *
 *  \~english
 *  Delegate method will be invoked when current IM account logged into another device
 */
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
-(void)autoLoginDidCompleteWithError:(EMError *)aError{

    if (!aError) {
        NSLog(@"自动登录成功");
    }
    else{
        NSLog(@"自动登录失败");
    }
}


@end
