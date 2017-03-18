//
//  SCXAdressViewController.m
//  聊天
//
//  Created by 孙承秀 on 16/8/31.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXAdressViewController.h"

int unAcceptCount;
@interface SCXAdressViewController ()
@property(nonatomic,strong)id obser;
@end

@implementation SCXAdressViewController
singleM(address)
- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title=@"通讯录";
    self.tabBarController.title=@"通讯录";
    self.view.backgroundColor=[UIColor whiteColor];
    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
    [self setUpAddFriendButton];
    
    

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     self.tabBarController.tabBar.hidden=NO;
    unAcceptCount=0;
    self.isAttach=NO;
    [SCXLoginTool setBadgeCount:[SCXAdressViewController sharedaddress].count tabbar:self.navigationController.tabBarController];
    id obser= [[NSNotificationCenter defaultCenter] addObserverForName:SCX_FriendAskNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        //[self.SCX_tableView SCX_reloadSingleSections:0 withRowAnimation:SCXTableViewRowAnimationNone];
        [self.SCX_tableView reloadData];
    }];
    self.obser=obser;
    self.tabBarController.title=@"通讯录";
    //配置第一个section
    [self setUpAddress];
    //配置黑名单
    [self getBlackFriend];
    //获取好友列表
    [self getFriendListFromDB];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}
-(void)dealloc{
    
[[NSNotificationCenter defaultCenter] removeObserver:_obser];
}
#pragma mark--获取好友列表
-(void)getFriendListFromDB{
    [self.friendArray removeAllObjects];
    WeakSelf(weakSelf);
    [[EMClient sharedClient].contactManager getContactsFromServerWithCompletion:^(NSArray *aList, EMError *aError) {
        if (!aError) {
            int a=arc4random()%23;
            NSString *imageName=[NSString stringWithFormat:@"%d.jpg",a];
            for (NSString *name in aList) {
                NSDictionary *dic=@{kImgKey:imageName,kTitleKey:name};
                [weakSelf.friendArray addObject:dic];
            }
            weakSelf.fridenIndexArray=[ChineseString IndexArray:weakSelf.friendArray];
            weakSelf.friendArray=[ChineseString LetterSortArray:weakSelf.friendArray];
            [weakSelf SCX_reloadData];
        }
        else{
            NSLog(@"获取好友列表错误");
        }
        
    }];

}
#pragma mark - 配置黑名单
-(void)getBlackFriend{
    WeakSelf(weakSelf);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [weakSelf.blackArray removeAllObjects];
       [[EMClient sharedClient].contactManager getBlackListFromServerWithCompletion:^(NSArray *aList, EMError *aError) {
           if (!aError) {
               int a=arc4random()%23;
               NSString *imageName=[NSString stringWithFormat:@"%d.jpg",a];
               for (NSString *name in aList) {
                   NSDictionary *dic=@{kImgKey:imageName,kTitleKey:name};
                   [weakSelf.blackArray addObject:dic];
               }
              // weakSelf.BlackFridenIndexArray=[ChineseString IndexArray:weakSelf.blackArray];
               //weakSelf.blackArray=[ChineseString LetterSortArray:weakSelf.blackArray];
//               if (weakSelf.blackArray.count==0) {
//                   weakSelf.blackArray=weakSelf.friendArray;
//               }
              // [weakSelf SCX_reloadData];
           }
           else{
               NSLog(@"%@",aError);
           }
          
        }];
    });

}
#pragma mark - 配置通讯录
-(void)setUpAddress{
    self.topArray=[[NSMutableArray alloc]initWithObjects:
  @{kImgKey:@"plugins_FriendNotify",kTitleKey:@"新的朋友"},
  @{kImgKey:@"add_friend_icon_addgroup",kTitleKey:@"群聊"},
  @{kImgKey:@"Contact_icon_ContactTag",kTitleKey:@"新的标签"},
                   @{kImgKey:@"add_friend_icon_offical",kTitleKey:@"新的公众号"},@{kImgKey:@"ProfileLockOn",kTitleKey:@"黑名单" }, nil];
    //[self SCX_reloadData];
}

#pragma mark -  设置添加好友按钮
-(void)setUpAddFriendButton{
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [button addTarget:self action:@selector(addFriendWithViewController:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:@"contacts_add_friend"] forState:UIControlStateNormal];
    self. navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
   

}
#pragma mark--tableView代理方法
-(NSInteger)SCX_numberOfSectionsInTableView:(UITableView *)tableView{
    return _fridenIndexArray.count+1;
}
-(NSInteger)SCX_tableViewNumberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return self.topArray.count;
    }
    else{
        if ((section-1)<self.friendArray.count) {
            NSArray *arr=self.friendArray[section-1];
            return arr.count;
        }
        else return 0;
        
    }
    
}
-(SCXBaseTableViewCell *)SCX_tableViewCellForRowAtIndexPath:(NSIndexPath *)indexPath{
     SCXAdressCell *cell=[SCXAdressCell cellWithTableView:self.SCX_tableView];
    NSDictionary *dic;
    if (indexPath.section==0) {
        if (indexPath.row<5) {
             dic=self.topArray[indexPath.row];
        }
        else{
            if ([self.topArray[indexPath.row] isKindOfClass:[NSArray class]]) {
                NSArray *arr=self.topArray[indexPath.row];
                dic=arr.firstObject;
            }
            else{
            dic=self.topArray[indexPath.row];
            }
        }
        if (indexPath.row==0&&indexPath.section==0) {
            cell.count=[NSString stringWithFormat:@"%ld",[SCXAdressViewController sharedaddress].count];
        }
        else{
            cell.count=@"0";
        }
    }
    else {
        cell.count=@"0";
        if (indexPath.section-1<self.friendArray.count) {
            NSArray *arr=self.friendArray[indexPath.section-1];
            dic=arr[indexPath.row];
        }
        else{
            return cell;
        }
        
        
    }
    
    if (indexPath.section==0&&indexPath.row>=5) {
        [cell.imageView.layer setCornerRadius:25];
        cell.imageView. layer.masksToBounds=YES;
        NSString *name=dic[kImgKey];
        NSLog(@"%@",name);
        cell.imageView.image=[UIImage imageCompressImage:[UIImage imageNamed:name] targetWidth:30];
    }
    else{
        //cell.imageView.layer setCornerRadius:25];
        cell.imageView. layer.masksToBounds=NO;
        cell.imageView.image=[UIImage imageCompressImage:[UIImage imageNamed:dic[kImgKey]] targetWidth:30];
    }
    
    
    cell.imageView.contentMode=UIViewContentModeScaleToFill;
    cell.textLabel.text=dic[kTitleKey];
    
    return cell;
    return nil;
}
-(BOOL)SCX_tableViewCanEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row<5) {
            return NO;
        }
        else{
            return YES;
        }
        
    }
    else return YES;
}
-(NSArray *)SCX_tableVieweEditActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section>0) {
        UITableViewRowAction *antion=[UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"加入黑名单" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            NSMutableArray *arr=self.friendArray[indexPath.section-1];
            NSDictionary * dic=arr[indexPath.row];
            NSString *name=dic[kTitleKey];
            [[EMClient sharedClient].contactManager addUserToBlackList:name     completion:^(NSString *aUsername, EMError *aError) {
                if (!aError) {
                    NSLog(@"点击加入黑名单");
                    self.isAttach=NO;
                    [self setUpAddress];
                    [self getBlackFriend];
                    
                    [self SCX_reloadData];
                    [MBProgressHUD showMessage:[NSString stringWithFormat:@"您已将%@好加入黑名单",name] toView:self
                     .view];
                }
                
            }];
            
        }];
        antion.backgroundColor = [UIColor colorWithRed:0 green:124/255.0 blue:223/255.0 alpha:1];
        UITableViewRowAction *action=[UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            NSLog(@"点击删除l");
            NSMutableArray *arr=self.friendArray[indexPath.section-1];
            NSDictionary * dic=arr[indexPath.row];
            NSString *name=dic[kTitleKey];
            [[EMClient sharedClient].contactManager deleteContact:name completion:^(NSString *aUsername, EMError *aError) {
                if (!aError) {
                    [MBProgressHUD showMessage:[NSString stringWithFormat:@"您已删除和%@好友关系",name] toView:self
                     .view];
                }
            }];
            [arr removeObjectAtIndex:indexPath.row];
            if (arr.count==0) {
                [self.friendArray removeObjectAtIndex:indexPath.section-1];
            }
            
            self.fridenIndexArray=[ChineseString IndexArray:self.friendArray];
            [self.SCX_tableView reloadData];
            
        }];
        return @[antion,action];

    }
    else{
        UITableViewRowAction *action=[UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"移除黑名单" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            NSDictionary * dic=self.blackArray[indexPath.row-5];
           
            NSString *name=dic[kTitleKey];
            [[EMClient sharedClient].contactManager removeUserFromBlackList:name completion:^(NSString *aUsername, EMError *aError) {
                self.isAttach=NO;
                [self setUpAddress];
                [self getBlackFriend];
                [self SCX_reloadData];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD showMessage:[NSString stringWithFormat:@"移除成功"] toView:self
                     .view];
                });
                
            }];
        }];
        return @[action];
    }
   
}
-(CGFloat)SCX_tableViewHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
}
-(void)SCX_tableViewDidSelectRowAtIndexPath:(NSIndexPath *)indexPath withCell:(SCXBaseTableViewCell *)cell{
    if (indexPath.section==0&&indexPath.row==0) {
        SCXAskFriendViewController *ask=[[SCXAskFriendViewController alloc]init];
        [self pushViewController:ask];
    }
    if (indexPath.row==1&&indexPath.section==0) {
        SCXGroupViewController *group=[[SCXGroupViewController alloc]init];
       // UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:group];
        [self.navigationController pushViewController:group animated:YES];
    }
    if (indexPath.section==0&&indexPath.row==4) {
       
        //[self getBlackFriend];
        if (self.isAttach) {
            //[self getBlackFriend];
            self.isAttach=NO;
            if (self.blackArray.count>0) {
                if (self.blackArray.count>0&&self.blackArray!=nil) {
                   
                    for (NSInteger i=self.blackArray.count; i>0; i--) {
                        NSLog(@"%ld--------%ld",self.topArray.count,i);
                        NSIndexPath *indexpath=[NSIndexPath indexPathForRow:i+4 inSection:0];
                        if (i<self.topArray.count) {
                            [self.topArray removeObjectAtIndex:i+4];
                            
                            [self.SCX_tableView SCX_deleteSingleRowAtIndexPath:indexpath withRowAnimation:SCXTableViewRowAnimationNone];
                        }
                        
                    }
                }
                
            }
            
           
        }
        else{
             [self setUpAddress];
            for (int i=0; i<self.blackArray.count; i++) {
                NSIndexPath *indexpath=[NSIndexPath indexPathForRow:i+5 inSection:0];
                [self.topArray addObject:self.blackArray[i]];
                [self.SCX_tableView SCX_insertSingleRowAtIndexPaths:indexpath withRowAnimation:SCXTableViewRowAnimationNone];
            }
            self.isAttach=YES;
        }
    }
    if (indexPath.section>0) {
        if (indexPath.section-1<self.friendArray.count) {
            
            NSArray *arr=self.friendArray[indexPath.section-1];
            NSDictionary *dic=arr[indexPath.row];
            SCXPersonalViewController *personal=[[SCXPersonalViewController alloc]initWithPersonalInfoWithDic:dic];
            [self pushViewController:personal];
            NSLog(@"详情页");
        }
       
    }
}
-(NSString *)SCX_tableViewtitleForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0;
    }
    else{
    return _fridenIndexArray[section-1];
    }
}
-(NSArray *)SCX_sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.fridenIndexArray;
}
-(CGFloat)SCX_tableViewHeightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0;
    }
    else{
    return 40;
    }
}
#pragma mark - 添加好友
-(void)addFriendWithViewController:(UIViewController *)VC{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle: @"添加好友" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder=@"用户名";
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder=@"添加理由";
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"添加" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [[EMClient sharedClient].contactManager addContact:alert.textFields.firstObject.text message:@"加个好友呗" completion:^(NSString *aUsername, EMError *aError) {
            if (!aError) {
                NSLog(@"好友请求成功");
            }
            else{
                NSLog(@"好友请求失败");
            }
        }];
    }]];
    if ([VC isKindOfClass:[UIViewController class]]) {
        [VC presentViewController:alert animated:YES completion:^{
            
        }];
    }
    else{
        [self presentViewController:alert];
    }
}

#pragma mark--懒加载
-(NSMutableArray *)baseArray{
    if (!_baseArray) {
        _baseArray=[[NSMutableArray alloc]initWithCapacity:0];
        
    }
    return _baseArray;
}
-(NSMutableArray *)topArray{
    if (!_topArray) {
        _topArray=[[NSMutableArray alloc]initWithCapacity:0];
        
    }
    return _topArray;
}
-(NSMutableArray *)blackArray{
    if (!_blackArray) {
        _blackArray=[[NSMutableArray alloc]initWithCapacity:0];
    }
    return _blackArray;
}
-(NSMutableArray *)friendArray{
    if (!_friendArray) {
        _friendArray=[[NSMutableArray alloc]initWithCapacity:0];
    }
    return _friendArray;

}
-(NSMutableArray *)fridenIndexArray{
    if (!_fridenIndexArray) {
        _fridenIndexArray=[[NSMutableArray alloc]initWithCapacity:0];
    }
    return _fridenIndexArray;
}
-(NSMutableArray *)BlackFridenIndexArray{
    if (!_BlackFridenIndexArray) {
        _BlackFridenIndexArray=[[NSMutableArray alloc]initWithCapacity:0];
    }
    return _BlackFridenIndexArray;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
