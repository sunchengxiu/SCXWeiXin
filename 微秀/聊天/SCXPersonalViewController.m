//
//  SCXPersonalViewController.m
//  聊天
//
//  Created by 孙承秀 on 16/10/27.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXPersonalViewController.h"

@interface SCXPersonalViewController ()

@end

@implementation SCXPersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=kBackgroundColor;
    [self setUpDataArray];
    
}
-(void)setUpDataArray{
    NSArray *arr=@[@[@{kImgKey:_iconName,kTitleKey:_userName,kWeixinKey:_userName}],@[@{kTitleKey:@"设置备注和标签"}],@[@{kTitleKey:@"辽宁大连"},@{kTitleKey:@"个人相册"},@{kTitleKey:@"更多"}],@[@{kTitleKey:@"发消息"},@{kTitleKey:@"视频聊天"}]];
    self.dataArray=[NSMutableArray arrayWithArray:arr];
    [self SCX_reloadData];

}
/**
 配置用户数据

 @param dic 用户数据
 */
-(instancetype)initWithPersonalInfoWithDic:(NSDictionary *)dic{
    if (self=[super init]) {
        _infoDic=dic;
        _iconName=dic[kImgKey];
        _userName=dic[kTitleKey];
    }
    return self;
    
}
-(NSInteger)SCX_numberOfSectionsInTableView:(UITableView *)tableView{
    return  self.dataArray.count;
}
-(SCXBaseTableViewCell *)SCX_tableViewCellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SCXPersonalCell *cell;
    NSArray *arr=self.dataArray[indexPath.section];
    NSDictionary *dic=arr[indexPath.row];
    cell=[SCXPersonalCell cellWithTableView:self.SCX_tableView];
    cell.backgroundColor=kBackgroundColor;
    if (indexPath.section==0) {
        [cell layoutCellIsHasIconImageView:YES andAlbum:NO andSendButton:NO];
        cell.infoDic=dic;
        return cell;
        
    }
    if (indexPath.section==1) {
        [cell layoutCellIsHasIconImageView:NO andAlbum:NO andSendButton:NO];
        cell.infoDic=dic;
        return cell;
    }
    if (indexPath.section==2) {
        [cell layoutCellIsHasIconImageView:NO andAlbum:YES andSendButton:NO];
        cell.infoDic=dic;
        return cell;
    }
    if (indexPath.section==3) {
        [cell layoutCellIsHasIconImageView:NO andAlbum:NO andSendButton:YES];
        cell.infoDic=dic;
        cell.block=^(NSString *title){
            if ([title isEqualToString:@"发消息"]) {
                [self sendMessage];
            }
            if ([title isEqualToString:@"视频聊天"]) {
                [self sendMoive];
            }
        
        };
        return cell;
    }
    
    return cell;
}
-(NSInteger)SCX_tableViewNumberOfRowsInSection:(NSInteger)section{
    NSArray *arr=self.dataArray[section];
    return arr.count;
}
-(CGFloat)SCX_tableViewHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 100;
    }
    if (indexPath.section==1) {
        return 40;
    }
    if (indexPath.section==2) {
        if (indexPath.row==1) {
            return 100;
        }
        else{
            return 50;
        }
    }
    if (indexPath.section==3) {
        return 50;
    }
    return 54;
}
-(CGFloat)SCX_tableViewHeightForHeaderInSection:(NSInteger)section{
    return 20;
}

#pragma mark--发消息
-(void)sendMessage{
    SCXChatTableViewController *chat=[[SCXChatTableViewController alloc]init];
   
    self.tabBarController.selectedIndex=0;
     [self.navigationController popViewControllerAnimated:NO];
    chat.title=self.userName;
    chat.isGroup=NO ;
    chat.Username=self.userName;
    chat.navigationController.navigationItem.backBarButtonItem.title=@"微秀";
    SCXBaseNaviViewController *view=[[UIApplication sharedApplication] delegate].window.rootViewController.childViewControllers[0];
    [view pushViewController:chat animated:YES];
}
-(void)sendMoive{

}

@end
