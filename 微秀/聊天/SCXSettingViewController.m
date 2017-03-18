//
//  SCXSettingViewController.m
//  聊天
//
//  Created by 孙承秀 on 16/8/31.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXSettingViewController.h"
#import "EMSDK.h"

@interface SCXSettingViewController ()

@end

@implementation SCXSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"设置";
   
    self.tabBarController.title=[[EMClient sharedClient] currentUsername];
    self.view.backgroundColor=[UIColor whiteColor];
    [self setUpData];
    //[self setUpLoginOutButton];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     self.tabBarController.title=[[EMClient sharedClient] currentUsername];
}
-(void)setUpData{
    _oneArray=@[@{kImgKey:@"xhr",kTitleKey:@"大牌",kDetailTitleKey:@"微信号:15699998823",kMyKey:@""}];
    _twoArray=@[@{kImgKey:@"MoreMyAlbum",kTitleKey:@"相册"},@{kImgKey:@"MoreMyFavorites",kTitleKey:@"收藏"},@{kImgKey:@"MoreMyBankCard",kTitleKey:@"钱包"},@{kImgKey:@"MyCardPackageIcon",kTitleKey:@"卡包",}];
    _threeArray=@[@{kImgKey:@"MoreExpressionShops",kTitleKey:@"表情"}];
    _fourArray=@[@{kImgKey:@"MoreSetting",kTitleKey:@"设置"}];
    [self SCX_reloadData];

}
-(NSInteger)SCX_numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(SCXBaseTableViewCell *)SCX_tableViewCellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SCXSetCell *cell=[SCXSetCell cellWithTableView:self.SCX_tableView];
    if (indexPath.section==0) {
        NSDictionary *dic=self.oneArray[indexPath.row];
        cell.imageView.image=[UIImage imageCompressImage:[UIImage imageNamed:dic[kImgKey]] targetWidth:30];
        cell.textLabel.text=dic[kTitleKey];
        return cell;
    }
    if (indexPath.section==1) {
        NSDictionary *dic=self.twoArray[indexPath.row];
        cell.imageView.image=[UIImage imageCompressImage:[UIImage imageNamed:dic[kImgKey]] targetWidth:30];
        cell.textLabel.text=dic[kTitleKey];
        return cell;
    }
    if (indexPath.section==2) {
        NSDictionary *dic=self.threeArray[indexPath.row];
        cell.imageView.image=[UIImage imageCompressImage:[UIImage imageNamed:dic[kImgKey]] targetWidth:30];
        cell.textLabel.text=dic[kTitleKey];
        return cell;
    }
    if (indexPath.section==3) {
        NSDictionary *dic=self.fourArray[indexPath.row];
        cell.imageView.image=[UIImage imageCompressImage:[UIImage imageNamed:dic[kImgKey]] targetWidth:30];
        cell.textLabel.text=dic[kTitleKey];
        return cell;
    }
    return cell;
    return nil;
}
-(NSInteger)SCX_tableViewNumberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return _oneArray.count;
    }
    if (section==1) {
        return _twoArray.count;
    }
    if (section==2) {
        return _threeArray.count;
    }
    if (section==3) {
        return _fourArray.count;
    }
    return 0;
}
-(CGFloat)SCX_tableViewHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(CGFloat)SCX_tableViewHeightForHeaderInSection:(NSInteger)section{
    return 20;
}
-(void)SCX_tableViewDidSelectRowAtIndexPath:(NSIndexPath *)indexPath withCell:(SCXBaseTableViewCell *)cell{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            SCXMyInfoViewController *infoVC=[[SCXMyInfoViewController alloc]init];
            [self pushViewController:infoVC];
        }
    }

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
