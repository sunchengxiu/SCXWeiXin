//
//  SCXSettingViewController.h
//  聊天
//
//  Created by 孙承秀 on 16/8/31.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCXBaseViewController.h"
#import "AppDelegate.h"
#import "SCXLoginTool.h"
#import "SCXSetCell.h"
#import "SCXMyInfoViewController.h"
@interface SCXSettingViewController : SCXBaseTableViewController
@property(nonatomic,strong)UIButton *loginOutButton;
@property(nonatomic,strong)MBProgressHUD *hud;
@property(nonatomic,strong)NSArray *oneArray;
@property(nonatomic,strong)NSArray *twoArray;
@property(nonatomic,strong)NSArray *threeArray;
@property(nonatomic,strong)NSArray *fourArray;
@end
