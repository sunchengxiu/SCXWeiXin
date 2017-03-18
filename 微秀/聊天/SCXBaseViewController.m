//
//  SCXBaseViewController.m
//  聊天
//
//  Created by 孙承秀 on 16/10/20.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXBaseViewController.h"

@interface SCXBaseViewController ()

@end

@implementation SCXBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationController.navigationBar.barTintColor=kCommonBlackColor;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -- 重写系统的一些有关控制器方法
/***推出一个控制器*/
-(void)pushViewController:(UIViewController *)viewController{
    if (![viewController isKindOfClass:[UIViewController class]]) {
        return;
    }
    if (viewController==nil) {
        return;
    }
    if (viewController.hidesBottomBarWhenPushed==NO) {
        viewController.hidesBottomBarWhenPushed=YES;
    }
    [self.navigationController pushViewController:viewController animated:YES];
    
}
/**弹出一个控制器*/
-(void)presentViewController:(UIViewController *)viewController{
    if (![viewController isKindOfClass:[UIViewController class]]) {
        return;
    }
    if (viewController==nil) {
        return;
    }
    [self presentViewController:viewController animated:YES completion:^{
        
    }];
    
}
/**回到一个控制器*/
-(void)popViewController:(UIViewController *)viewController{
    if ([viewController isKindOfClass:[UIViewController class]]) {
        return;
    }
    if (viewController==nil) {
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}
/**回到根控制器*/
-(void)popToRootViewController:(UIViewController *)viewController{
    if ([viewController isKindOfClass:[UIViewController class]]) {
        return;
    }
    if (viewController==nil) {
        return;
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
}
/**回到指定的控制器*/
-(void)popToViewController:(UIViewController *)viewController{
    if ([viewController isKindOfClass:[UIViewController class]]) {
        return;
    }
    if (viewController==nil) {
        return;
    }
    [self.navigationController popToViewController:viewController animated:YES];
    
}
/**销毁一个控制器*/
-(void)dismissViewController:(UIViewController *)viewController{
    if (![viewController isKindOfClass:[UIViewController class]]) {
        return;
    }
    if (viewController==nil) {
        return;
    }
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}
/**移除一个子控制器*/
-(void)removeChildViewController:(UIViewController *)viewController{
    if (viewController==nil) {
        return;
    }
    [viewController.view removeFromSuperview];
    [viewController willMoveToParentViewController:nil];
    
    [viewController removeFromParentViewController];
}
/**添加一个子控制器*/
-(void)adMydChildViewController:(UIViewController *)childViewController{
    
    if (childViewController==nil) {
        return;
    }
    [childViewController willMoveToParentViewController:self];
    [self.view addSubview:childViewController.view];
    childViewController.view.frame=self.view.bounds;
    [self addChildViewController:childViewController];
}


@end
