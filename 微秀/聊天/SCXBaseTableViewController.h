//
//  SCXBaseTableViewController.h
//  聊天
//
//  Created by 孙承秀 on 16/10/20.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCXBaseTableView.h"
#import "SCXBaseTableViewCell.h"
#import "SCXBaseViewController.h"
typedef NS_ENUM(NSUInteger, SCXREefreshType) {
    /** 无法刷新*/
    SCXREefreshTypeNone = 0,
    /** 只能刷新*/
    SCXREefreshTypeOblyDownRefresh,
    /** 只能上拉加载*/
    SCXREefreshTypeOnlyUpRefresh,
    /** 能刷新*/
    SCXREefreshTypeRefresh
};
typedef  NS_ENUM(NSUInteger,SCXTableViewCellEditingStyle){
    /*
    UITableViewCellEditingStyleNone,
    UITableViewCellEditingStyleDelete,
    UITableViewCellEditingStyleInsert
     */
    SCXTableViewCellEditingStyleNone=0,
    SCXTableViewCellEditingStyleDelete,
    SCXTableViewCellEditingStyleIndert

};
@interface SCXBaseTableViewController : SCXBaseViewController
@property(nonatomic,assign)BOOL needCellSepLine;

@property(nonatomic,assign)SCXREefreshType refreshType;
@property(nonatomic,assign)BOOL isDownRefresh;
@property(nonatomic,assign)BOOL isUpRefresh;
@property(nonatomic,strong)SCXBaseTableView *SCX_tableView;
@property(nonatomic,strong)UIBarButtonItem *rightNaviItem;
@property(nonatomic,strong)UIBarButtonItem *leftNaviItem;
/**
 *  数据源
 */
@property(nonatomic,strong)NSMutableArray *dataArray;
/**
 *  开始下拉刷新
 */
-(void)SCX_beginDownRefresh;
/**
 *  开始上拉刷新
 */
-(void)SCX_beginUpRefresh;
/**
 *  刷新数据
 */
-(void)SCX_reloadData;
/**
 *  tableView代理方法，section数量
 *
 *  @param tableView tableView
 *
 *  @return section数量
 */
- (NSInteger)SCX_numberOfSectionsInTableView:(UITableView *)tableView ;
/**
 *  tableView代理方法，cell数量
 *
 *  @param section section
 *
 *  @return cell数量
 */
- (NSInteger)SCX_tableViewNumberOfRowsInSection:(NSInteger)section;;
/**
 *  重用cell
 *
 *  @param indexPath
 *
 *  @return
 */
- (SCXBaseTableViewCell *)SCX_tableViewCellForRowAtIndexPath:(NSIndexPath *)indexPath;
/**
 *  创建一个tableViewHeader；
 *
 *  @param section
 *
 *  @return
 */
-(UIView *)SCX_tableViewViewForHeaderInSection:(NSInteger)section;
/**
 *  创建一个脚
 *
 *  @param section
 *
 *  @return
 */
-(UIView *)SCX_tableViewViewForFooterInSection:(NSInteger)section;
/**
 *  tableViewCell行高
 *
 *  @param indexPath
 *
 *  @return
 */
-(CGFloat)SCX_tableViewHeightForRowAtIndexPath:(NSIndexPath *)indexPath;
/**
 *  tableViewCell点击某一行事件
 *
 *  @param indexPath
 *  @param cell
 */
-(void)SCX_tableViewDidSelectRowAtIndexPath:(NSIndexPath *)indexPath withCell:(SCXBaseTableViewCell *)cell;
/**
 *  header高度设置
 *
 *  @param section
 *
 *  @return
 */
-(CGFloat)SCX_tableViewHeightForHeaderInSection:(NSInteger)section;
/**
 *  footer高度设置
 *
 *  @param section
 *
 *  @return
 */
-(CGFloat)SCX_tableViewHeightForFooterInSection:(NSInteger)section;
-(SCXTableViewCellEditingStyle)SCX_tableViewEditingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
-(void)SCX_commitEditingStyle:(SCXTableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;
-(NSString *)SCX_tableViewtitleForHeaderInSection:(NSInteger)section;
-(NSArray *)SCX_sectionIndexTitlesForTableView:(UITableView *)tableView;
-(BOOL)SCX_tableViewCanEditRowAtIndexPath:(NSIndexPath *)indexPath;
-(NSArray *)SCX_tableVieweEditActionsForRowAtIndexPath:(NSIndexPath *)indexPath;
/**
 *  设置导航栏右边按钮
 *
 *  @param title  按钮文字
 *  @param handle 点击回调方法
 */
-(void)SCX_setRightNavigationItemWithTitle:(NSString *)title handle:(void (^)(NSString *))handle;
/**
 *  设置导航栏左边按钮
 *
 *  @param title   按钮文字
 *  @param handle 点击回调方法
 */
-(void)SCX_setLeftNavigationItemWithTitle:(NSString *)title handle:(void (^)(NSString *))handle;
@end
