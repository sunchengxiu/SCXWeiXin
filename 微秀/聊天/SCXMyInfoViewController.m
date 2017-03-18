//
//  SCXMyInfoViewController.m
//  聊天
//
//  Created by 孙承秀 on 16/10/26.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXMyInfoViewController.h"

@interface SCXMyInfoViewController ()

@end

@implementation SCXMyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpLoginOutButton];
    self.view.backgroundColor=[UIColor whiteColor];
    // Do any additional setup after loading the view.
}
-(void)setUpLoginOutButton{
    _loginOutButton=[[UIButton alloc]init];
    [_loginOutButton setTitle:@"退出登录" forState:UIControlStateNormal];
    [_loginOutButton addTarget:self action:@selector(loginOut:) forControlEvents:UIControlEventTouchUpInside];
    [_loginOutButton setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:_loginOutButton];
    
}
-(void)loginOut:(UIButton *)button{
    [_hud removeFromSuperview];
    _hud=nil;
    _hud=[[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:_hud];
    _hud.mode=MBProgressHUDModeText;
    [[EMClient sharedClient] logout:YES completion:^(EMError *aError) {
        if (aError==nil) {
            
            _hud.labelText=@"退出成功";
            [_hud showAnimated:YES whileExecutingBlock:^{
                sleep(2);
            }];
            [[SCXLoginTool sharedlogin] loginOut];
        }
        else{
            _hud.labelText=@"退出失败";
            [_hud showAnimated:YES whileExecutingBlock:^{
                sleep(2);
            }];
            
        }
    }];
}
-(void)viewWillLayoutSubviews{
    
    [super viewWillLayoutSubviews];
    [_loginOutButton autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view withOffset:([UIScreen mainScreen].bounds.size.height-50)/2];
    
    [_loginOutButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.view withOffset:80];
    [_loginOutButton autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.view withOffset:-80];
    [_loginOutButton autoSetDimension:ALDimensionHeight toSize:50];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
