//
//  SCXAskFriendViewController.m
//  聊天
//
//  Created by 孙承秀 on 16/10/21.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXAskFriendViewController.h"
extern int unAcceptCount;
@interface SCXAskFriendViewController ()

@end

@implementation SCXAskFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpAddFriendButton];
   // [self SCX_reloadData];
}
-(void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    [SCXAdressViewController sharedaddress].count=unAcceptCount;
    [[NSUserDefaults standardUserDefaults] setInteger:unAcceptCount forKey:kUnReadCount];
}
-(void)setUpAddFriendButton{
    
    self.navigationItem.title=@"新的朋友";
    //设置返回按钮字体颜色
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self. navigationItem.rightBarButtonItem.title=@"添加朋友";
    [self.view setBackgroundColor:[UIColor whiteColor ]];
    [self SCX_setRightNavigationItemWithTitle:@"添加朋友" handle:^(NSString * str) {
        [[SCXAdressViewController sharedaddress] addFriendWithViewController:self];
    }];
   
}
-(NSInteger)SCX_numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}
-(NSInteger)SCX_tableViewNumberOfRowsInSection:(NSInteger)section{
    return [SCXAdressViewController sharedaddress].baseArray.count;
}
-(CGFloat)SCX_tableViewHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
}
-(SCXBaseTableViewCell *)SCX_tableViewCellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SCXAskCell *cell=[SCXAskCell cellWithTableView:self.SCX_tableView];
//    cell.acceptBlock=^(SCXAskCell *cell){
//        NSIndexPath *indexPath1=[self.SCX_tableView indexPathForCell:cell];
//        [self acceptFriend:indexPath1.row];
//    };
    cell.delegate=self;
    NSArray *arr=[SCXAdressViewController sharedaddress].baseArray[indexPath.row];
    cell.infoDic=arr[0];
    return cell;

}
-(BOOL)SCX_tableViewCanEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
-(SCXTableViewCellEditingStyle)SCX_tableViewEditingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return SCXTableViewCellEditingStyleDelete;
    
}
-(void)SCX_commitEditingStyle:(SCXTableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle==SCXTableViewCellEditingStyleDelete) {
        [self notAcceptFriend:indexPath.row];
    }
}
#pragma askCell代理方法
-(void)clickAcceptButton:(SCXAskCell *)cell andHandleBlock:(void (^)(NSInteger))block{
    NSIndexPath *indexPath1=[self.SCX_tableView indexPathForCell:cell];
    [self acceptFriend:indexPath1.row andHandleBlock:block];
}
#pragma mark--拒绝好友
-(void)notAcceptFriend:(NSInteger)row{
    NSDictionary *dic=[SCXAdressViewController sharedaddress].baseArray[row][0];
    NSDictionary *dict=dic[kTitleKey];
    NSString *acceptTiele=dict[kAcceptButtonTitle];
    if ([acceptTiele isEqualToString:@"接受"]) {
        [[EMClient sharedClient].contactManager declineInvitationForUsername:dict[kUser]];
    }
    if ([SCXAdressViewController sharedaddress].count>0) {
        [SCXAdressViewController sharedaddress].count--;
        [[NSUserDefaults standardUserDefaults] setInteger:[SCXAdressViewController sharedaddress].count forKey:kUnReadCount];
        unAcceptCount--;
        [SCXLoginTool setBadgeCount:unAcceptCount tabbar:self.navigationController.tabBarController];
    }
    [[SCXAdressViewController sharedaddress].baseArray removeObjectAtIndex:row];
    [SCXStorageManager archiveObject:[SCXAdressViewController sharedaddress].baseArray withFileName:SCX_ArchiveFriendAskInfo];
    [self.SCX_tableView SCX_deleteSingleRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
}
#pragma mark - 接受好友请求通知
-(void)acceptFriend:(NSInteger )row andHandleBlock:(void (^)(NSInteger))block{
    if ([SCXAdressViewController sharedaddress].baseArray.count>0) {

        NSArray *arr=[SCXAdressViewController sharedaddress].baseArray[row];
        NSDictionary *dic=arr.firstObject;
        NSDictionary *dic1= dic[kTitleKey];
        NSMutableDictionary *infoDic=[[NSMutableDictionary alloc]initWithDictionary: dic1];
        [[EMClient sharedClient].contactManager acceptInvitationForUsername:infoDic[kUser]];
        [infoDic setObject:@"已接受" forKey:kAcceptButtonTitle];
        NSDictionary *dict=[[NSDictionary alloc]initWithDictionary:infoDic];
        dic1=dict;
        NSDictionary *dd=@{kImgKey:dic[kImgKey],kTitleKey:dic1};
         [[SCXAdressViewController sharedaddress].baseArray replaceObjectAtIndex:row withObject:[NSArray arrayWithObject:dd]];
        [SCXStorageManager archiveObject:[SCXAdressViewController sharedaddress].baseArray withFileName:SCX_ArchiveFriendAskInfo];
        
        if ([SCXAdressViewController sharedaddress].count>0) {
            [SCXAdressViewController sharedaddress].count-=1;
            [[NSUserDefaults standardUserDefaults] setInteger:[SCXAdressViewController sharedaddress].count forKey:kUnReadCount];
            [SCXLoginTool setBadgeCount:[SCXAdressViewController sharedaddress].count tabbar:self.navigationController.tabBarController];
        }
        
        if (block) {
            block(row);
        }
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
