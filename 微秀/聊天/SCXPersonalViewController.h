//
//  SCXPersonalViewController.h
//  聊天
//
//  Created by 孙承秀 on 16/10/27.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXBaseTableViewController.h"
#import "SCXPersonalCell.h"
#import "SCXChatTableViewController.h"
@interface SCXPersonalViewController : SCXBaseTableViewController
/******  用户详细信息 *****/
@property(nonatomic,strong)NSDictionary *infoDic;
/******  头像 *****/
@property(nonatomic,strong)NSString *iconName;
/******  名字 *****/
@property(nonatomic,strong)NSString *userName;

/**
 将用户详细信息已字典的形式传递过来

 @param dic 用户信息
 */
-(instancetype)initWithPersonalInfoWithDic:(NSDictionary *)dic;
@end
