//
//  SCXAdressViewController.h
//  聊天
//
//  Created by 孙承秀 on 16/8/31.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCXBaseViewController.h"
#import "SCXBaseTableViewController.h"
#import "SCXAdressCell.h"
#import "ViewController.h"
#import "single.h"
#import "SCXAskFriendViewController.h"
#import "UIImage+imageCompress.h"
#import "ChineseString.h"
#import "SCXPersonalViewController.h"

@interface SCXAdressViewController : SCXBaseTableViewController<EMContactManagerDelegate>
singleH(address);

/**
 好友申请详细列表
 */
@property(nonatomic,strong)NSMutableArray  *baseArray;

/**
 第一个功能section列表，数据固定
 */
@property(nonatomic,strong)NSMutableArray  *topArray;

/**
 黑名单列表
 */
@property(nonatomic,strong)NSMutableArray *blackArray;

/**
 好友列表
 */
@property(nonatomic,strong)NSMutableArray *friendArray;

/**
 索引数组
 */
@property(nonatomic,strong)NSMutableArray *fridenIndexArray;
/**
 黑名单索引数组
 */
@property(nonatomic,strong)NSMutableArray *BlackFridenIndexArray;

/**
 未添加的好友数量显示
 */
@property(nonatomic,assign)NSInteger  count;
@property(nonatomic,assign)BOOL isAttach;

/**
 添加好友提示框弹出

 */
-(void)addFriendWithViewController:(UIViewController *)VC;
@end
