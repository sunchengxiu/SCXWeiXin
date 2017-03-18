//
//  ViewController.h
//  聊天
//
//  Created by 孙承秀 on 16/8/31.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMSDK.h"
#import "SCXAdressViewController.h"
#import "single.h"
#import "SCXBaseNaviViewController.h"
#import "SCXViewController.h"
#import "SCXAdressViewController.h"
#import "SCXSettingViewController.h"
#import "SCXFoundViewController.h"
@interface ViewController : UITabBarController<EMChatManagerDelegate,EMClientDelegate,EMContactManagerDelegate>
//singleH(viewController);
@property(nonatomic,strong)NSArray  *friendArr;
-(void)setUpTarBarController;

@end

