//
//  SCXFoundViewController.m
//  聊天
//
//  Created by 孙承秀 on 16/10/20.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXFoundViewController.h"

@interface SCXFoundViewController ()

@end

@implementation SCXFoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpData];
    
}
-(void)setUpData{
    _oneArray=@[@{kImgKey:@"ff_IconShowAlbum",kTitleKey:@"朋友圈"}];
    _twoArray=@[@{kImgKey:@"ff_IconQRCode",kTitleKey: @"扫一扫"},@{kImgKey:@"ff_IconShake",kTitleKey: @"摇一摇"}];
    _threeArray=@[@{kImgKey:@"ff_IconLocationService",kTitleKey: @"附近的人"},@{kImgKey:@"ff_IconBottle",kTitleKey: @"漂流瓶"}];
    _fourArray=@[@{kImgKey:@"CreditCard_ShoppingBag",kTitleKey: @"购物"},@{kImgKey:@"MoreGame",kTitleKey: @"游戏"}];
}
-(NSInteger)SCX_numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(SCXBaseTableViewCell *)SCX_tableViewCellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SCXFoundCell *cell=[SCXFoundCell cellWithTableView:self.SCX_tableView];
    NSString *imageName;
    if (indexPath.section==0) {
        NSDictionary *dic=_oneArray[indexPath.row];
        cell.textLabel.text=dic[kTitleKey];
        imageName=dic[kImgKey];
    }
    if (indexPath.section==1) {
        NSDictionary *dic=_twoArray[indexPath.row];
        cell.textLabel.text=dic[kTitleKey];
        imageName=dic[kImgKey];
    }
    if (indexPath.section==2) {
        NSDictionary *dic=_threeArray[indexPath.row];
        cell.textLabel.text=dic[kTitleKey];
        imageName=dic[kImgKey];
    }
    if (indexPath.section==3) {
        NSDictionary *dic=_fourArray[indexPath.row];
        cell.textLabel.text=dic[kTitleKey];
        imageName=dic[kImgKey];
    }
    cell.imageView.image=[UIImage imageCompressImage:[UIImage imageNamed:imageName] targetWidth:30];
    
    return cell;
}
-(NSInteger)SCX_tableViewNumberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    else{
        return 2;
    }
}
-(CGFloat)SCX_tableViewHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
}
-(CGFloat)SCX_tableViewHeightForHeaderInSection:(NSInteger)section{
    return 20;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
