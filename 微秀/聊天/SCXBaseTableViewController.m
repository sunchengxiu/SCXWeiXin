//
//  SCXBaseTableViewController.m
//  聊天
//
//  Created by 孙承秀 on 16/10/20.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXBaseTableViewController.h"
#import <objc/runtime.h>
const char *SCXBaseTableViewLeftHandleKey;
const char *SCXBaseTableViewRightHandleKey;
@interface SCXBaseTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation SCXBaseTableViewController

-(void)setNeedCellSepLine:(BOOL)needCellSepLine{
    _needCellSepLine = needCellSepLine;
    self.SCX_tableView.separatorStyle = needCellSepLine ? UITableViewCellSeparatorStyleSingleLine : UITableViewCellSeparatorStyleNone;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor redColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    // self.tableView.frame = CGRectMake(0, 40, ScreenWidth, ScreenHeight-40-64);
    self.SCX_tableView.frame=self.view.bounds;
    
    [self.view addSubview:self.SCX_tableView];
}
#pragma mark--懒加载
-(SCXBaseTableView *)SCX_tableView{
    if (!_SCX_tableView) {
        SCXBaseTableView *tab = [[SCXBaseTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [self.view addSubview:tab];
        _SCX_tableView = tab;
        tab.dataSource = self;
        tab.delegate = self;
        tab.backgroundColor = [UIColor colorWithRed:0.94f green:0.94f blue:0.94f alpha:1.00f];
        
    }
    return _SCX_tableView;
    
}
-(NSMutableArray *)dataArray{
    if (_dataArray==nil) {
        _dataArray=[[NSMutableArray alloc]initWithCapacity:0];
    }
    return _dataArray;
}
#pragma maek--设置刷新的种类
/**
 *  设置刷新的种类
 *
 *  @param refreshType 刷新种类
 */
-(void)setRefreshType:(SCXREefreshType)refreshType{
    _refreshType=refreshType;
    switch (refreshType) {
        case SCXREefreshTypeNone:
            break;
        case SCXREefreshTypeOblyDownRefresh:
            [self SCX_addDownRefresh];
            break;
        case SCXREefreshTypeOnlyUpRefresh:
            [self SCX_addUpRefresh];
            break;
        case SCXREefreshTypeRefresh:
            [self SCX_addDownRefresh];
            [self SCX_addUpRefresh];
            break;
            
        default:
            break;
    }
    
}
#pragma mark --  添加下拉刷新
-(void)SCX_addDownRefresh{
   
}
#pragma mark -- 添加上啦刷新
-(void)SCX_addUpRefresh{
   
}
#pragma mark--下拉刷新实现
-(void)SCX_beginDownRefresh{
    if (self.refreshType==SCXREefreshTypeNone||self.refreshType==SCXREefreshTypeOnlyUpRefresh) {
        return;
    }
    self.isDownRefresh=YES;
    self.isUpRefresh=NO;
    
}
#pragma mark--上拉刷新实现
-(void)SCX_beginUpRefresh{
    if (self.refreshType==SCXREefreshTypeOblyDownRefresh||self.refreshType==SCXREefreshTypeNone) {
        return;
    }
    self.isUpRefresh=YES;
    self.isDownRefresh=NO;
}
#pragma mark--刷新数据
-(void)SCX_reloadData{
    [self.SCX_tableView reloadData];
}

/** 右边item*/
- (void)setLeftNaviItem:(UIBarButtonItem *)leftNaviItem {
    
    _leftNaviItem = leftNaviItem;
    self.navigationItem.rightBarButtonItem = leftNaviItem;
}

- (UIBarButtonItem *)navRightItem {
    return self.navigationItem.rightBarButtonItem;
}
#pragma mark--设置导航栏左右按钮
-(void)SCX_setLeftNavigationItemWithTitle:(NSString *)title handle:(void (^)(NSString *))handle{
    
    [self SCX_setNavigitionItemWithTitle:title handel:handle isLeftItem:YES ];
}
-(void)SCX_setRightNavigationItemWithTitle:(NSString *)title handle:(void (^)(NSString *))handle{
    [self SCX_setNavigitionItemWithTitle:title handel:handle isLeftItem:NO];
    
}
-(void)SCX_setNavigitionItemWithTitle:(NSString *)title handel:(void (^)(NSString *))handle isLeftItem:(BOOL)isLeftItem{
    self.navigationItem.backBarButtonItem.tintColor=[UIColor whiteColor];
    if (title.length==0||!handle    ) {
        if (title.length==0) {
            title=@"";
        }
        if ([title isKindOfClass:[NSNull class]]||title==nil) {
            title=@"";
        }
        if (isLeftItem) {
            self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:nil action:nil];
        }
        else self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:nil action:nil];
    }
    else{
        if (isLeftItem) {
            objc_setAssociatedObject(self, SCXBaseTableViewLeftHandleKey, handle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(SCX_navigationItemClick:)];
        }
        else{
            objc_setAssociatedObject(self, SCXBaseTableViewRightHandleKey, handle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(SCX_navigationItemClick:)];
            self.navigationItem.rightBarButtonItem.tintColor=[UIColor whiteColor];
        }
        
        
    }
    
}
-(void)SCX_navigationItemClick:(UIBarButtonItem *)button{
    void(^handle)(NSString *)= objc_getAssociatedObject(self, SCXBaseTableViewRightHandleKey);
    if (handle) {
        handle(button.title );
    }
}
#pragma mark--tableview代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self respondsToSelector:@selector(SCX_numberOfSectionsInTableView:)]) {
        return [self SCX_numberOfSectionsInTableView:tableView];
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self respondsToSelector:@selector(SCX_tableViewNumberOfRowsInSection:)]) {
        return [self SCX_tableViewNumberOfRowsInSection:section];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self respondsToSelector:@selector(SCX_tableViewCellForRowAtIndexPath:)]) {
        return [self SCX_tableViewCellForRowAtIndexPath:indexPath];
    }
    SCXBaseTableViewCell *cell=[SCXBaseTableViewCell cellWithTableView:tableView];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self respondsToSelector:@selector(SCX_tableViewHeightForRowAtIndexPath:)]) {
        return [self SCX_tableViewHeightForRowAtIndexPath:indexPath];
    }
    return tableView.rowHeight;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SCXBaseTableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self respondsToSelector:@selector(SCX_tableViewDidSelectRowAtIndexPath:withCell:)]) {
        [self SCX_tableViewDidSelectRowAtIndexPath:indexPath withCell:cell];
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if ([self respondsToSelector:@selector(SCX_tableViewViewForHeaderInSection:)]) {
        return [self SCX_tableViewViewForHeaderInSection:section];
    }
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if ([self respondsToSelector:@selector(SCX_tableViewViewForFooterInSection:)]) {
        return [self SCX_tableViewViewForHeaderInSection:section];
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([self respondsToSelector:@selector(SCX_tableViewHeightForHeaderInSection:)]) {
        return [self SCX_tableViewHeightForHeaderInSection:section];
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if ([self respondsToSelector:@selector(SCX_tableViewHeightForFooterInSection:)]) {
        return [self SCX_tableViewHeightForFooterInSection:section];
    }
    return 0;
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self respondsToSelector:@selector(SCX_tableViewCanEditRowAtIndexPath:)]) {
        return [self SCX_tableViewCanEditRowAtIndexPath:indexPath];
    }
    return NO;
}
-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self respondsToSelector:@selector(SCX_tableVieweEditActionsForRowAtIndexPath:)]) {
        return [self SCX_tableVieweEditActionsForRowAtIndexPath:indexPath];
    }
    return nil;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self respondsToSelector:@selector(SCX_tableViewEditingStyleForRowAtIndexPath:)]) {
        return (UITableViewCellEditingStyle)[self SCX_tableViewEditingStyleForRowAtIndexPath:indexPath];
    }
    return UITableViewCellEditingStyleDelete;

}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self respondsToSelector:@selector(SCX_commitEditingStyle:forRowAtIndexPath:)]) {
        SCXTableViewCellEditingStyle style;
        switch (editingStyle) {
            case UITableViewCellEditingStyleNone:
                style=SCXTableViewCellEditingStyleNone;
                break;
            case UITableViewCellEditingStyleDelete:
                style=SCXTableViewCellEditingStyleDelete;
                break;
            case UITableViewCellEditingStyleInsert:
                style=SCXTableViewCellEditingStyleIndert;
                break;
                
            default:
                break;
        }
        [self SCX_commitEditingStyle:style forRowAtIndexPath:indexPath];
    }
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if ([self respondsToSelector:@selector(SCX_tableViewtitleForHeaderInSection:)]) {
        return  [self SCX_tableViewtitleForHeaderInSection:section];
    }
    return nil;
}
-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    if ([self respondsToSelector:@selector(SCX_sectionIndexTitlesForTableView:)]) {
        return [self SCX_sectionIndexTitlesForTableView:tableView];
    }
    return nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
