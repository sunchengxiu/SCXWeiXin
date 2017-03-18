//
//  SCXBaseViewController.h
//  聊天
//
//  Created by 孙承秀 on 16/10/20.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCXBaseTableView.h"

@interface SCXBaseViewController : UIViewController
/**添加一个子控制器*/
-(void)adMydChildViewController:(UIViewController *)childViewController;
/**移除一个子控制器*/
-(void)removeChildViewController:(UIViewController *)viewController;
/**销毁一个控制器*/
-(void)dismissViewController:(UIViewController *)viewController;
/**回到指定的控制器*/
-(void)popToViewController:(UIViewController *)viewController;
/**回到根控制器*/
-(void)popToRootViewController:(UIViewController *)viewController;
/**回到一个控制器*/
-(void)popViewController:(UIViewController *)viewController;
/**弹出一个控制器*/
-(void)presentViewController:(UIViewController *)viewController;
/***推出一个控制器*/
-(void)pushViewController:(UIViewController *)viewController;
@end
