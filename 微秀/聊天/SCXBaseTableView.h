//
//  SCXBaseTableView.h
//  仿内涵段子
//
//  Created by 孙承秀 on 16/9/28.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, SCXTableViewRowAnimation) {
    SCXTableViewRowAnimationFade= UITableViewRowAnimationFade,
    SCXTableViewRowAnimationRight=UITableViewRowAnimationRight,
    SCXTableViewRowAnimationLeft= UITableViewRowAnimationLeft,
    SCXTableViewRowAnimationTop=UITableViewRowAnimationTop,
    SCXTableViewRowAnimationBottom=UITableViewRowAnimationBottom,
    SCXTableViewRowAnimationNone=UITableViewRowAnimationNone,
    SCXTableViewRowAnimationMiddle=UITableViewRowAnimationMiddle,
};
@interface SCXBaseTableView : UITableView
#pragma mark--注册操作
/**
 *  注册cell
 *
 *  @param cellClass  注册的cell
 *  @param identifier 重用标识
 */
-(void)SCX_registerClass:(Class)cellClass forCelIdentifier:(NSString *)identifier;
/**
 *  注册一个tableViewfooterHeader
 *
 *  @param aClass     要注册的类
 *  @param identifier 重用标识
 */
-(void)SCX_registerClass:(Class)aClass forHeaderFooterViewReuseIdentifier:(NSString *)identifier;
/**
 *  获取某一行对应的cell
 *
 *  @param indexPath 要获取cell的indexPath
 *
 *  @return 返回这一行对应的cell
 */
-(UITableViewCell *)SCX_cellForRowAtIndexPath:(NSIndexPath *)indexPath;
/**
 *  tableview某一行刷新动画
 *
 *  @param indexPaths 刷新的数组
 *  @param animation  刷新动画
 */
#pragma mark--刷新操作
-(void)SCX_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(SCXTableViewRowAnimation)animation;
/**
 *  刷新section,默认无动画
 *
 *  @param section 要刷新的section
 */
-(void)SCX_reloadSingleSection:(NSInteger )section;
/**
 *  刷新单个section
 *
 *  @param section   刷新的section
 *  @param animation 刷新动画
 */
-(void)SCX_reloadSingleSections:(NSInteger )section withRowAnimation:(SCXTableViewRowAnimation)animation;
/**
 *  刷新多个section，默认无动画
 *
 *  @param sections 刷新数组
 */
-(void)SCX_reloadSections:(NSArray<NSNumber *> *)sections;
/**
 *  刷新多个section
 *
 *  @param sections  刷新数组
 *  @param animation 刷新动画
 */
#pragma mark--删除操作
-(void)SCX_reloadSections:(NSArray<NSNumber *> *)sections withRowAnimation:(SCXTableViewRowAnimation)animation;
/**
 *  删除单行,默认为无动画
 *
 *  @param indexPath 删除的行
 */
-(void)SCX_deleteSingleRowAtIndexPath:(NSIndexPath  *)indexPath;
/**
 *  删除单行
 *
 *  @param indexPath 删除的行
 *  @param animation 删除动画
 */
-(void)SCX_deleteSingleRowAtIndexPath:(NSIndexPath  *)indexPath withRowAnimation:(SCXTableViewRowAnimation)animation;
/**
 *  删除某个section，默认无动画
 *
 *  @param section 删除的section   
 */
-(void)SCX_deleteSingleSection:(NSInteger )section;
/**
 *  删除单section，默认无动画
 *
 *  @param section   删除的section
 *  @param animation 动画
 */
-(void)SCX_deleteSingleSection:(NSInteger )section withRowAnimation:(SCXTableViewRowAnimation)animation;
/**
 *  删除多个section
 *
 *  @param sections 删除的section数组 
 */
-(void)SCX_deleteSections:(NSArray<NSNumber *> *)sections;
/**
 *  删除多个section
 *
 *  @param sections  section数组
 *  @param animation 删除动画
 */
#pragma mark--插入操作
-(void)SCX_deleteSections:(NSArray<NSNumber *> *)sections withRowAnimation:(SCXTableViewRowAnimation)animation;
/**
 *  增加单行
 *
 *  @param indexPath 增加的位置
 */
-(void)SCX_insertSingleRowAtIndexPaths:(NSIndexPath  *)indexPath;
/**
 *  增加单行
 *
 *  @param indexPath 增加的位置
 *  @param animation 动画
 */
-(void)SCX_insertSingleRowAtIndexPaths:(NSIndexPath  *)indexPath withRowAnimation:(SCXTableViewRowAnimation)animation;
/**
 *  增加单个section
 *
 *  @param section 增加的section
 */
-(void)SCX_insertSingleSection:(NSInteger )section;
/**
 *  增加单个section
 *
 *  @param section   增加的section
 *  @param animation 动画
 */
-(void)SCX_insertSingleSection:(NSInteger )section withRowAnimation:(SCXTableViewRowAnimation)animation;
/**
 *  增加多行
 *
 *  @param indexPaths 增加的行的数组
 */
-(void)SCX_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;
/**
 *  增加多行
 *
 *  @param indexPaths 增加的行的数组
 *  @param animation  动画
 */
-(void)SCX_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(SCXTableViewRowAnimation)animation;
/**
 *  增加多个section
 *
 *  @param sections 增加的section数组
 */
-(void)SCX_insertSections:(NSArray<NSNumber *> *)sections ;
/**
 *  增加多个section
 *
 *  @param sections  增加的section数组
 *  @param animation  动画
 */
-(void)SCX_insertSections:(NSArray<NSNumber *> *)sections withRowAnimation:(SCXTableViewRowAnimation)animation;
/**
 *  点击tableview空白处隐藏键盘
 *
 *  @param point
 *  @param event
 *
 *  @return
 */
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event;
-(void)SCX_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(SCXTableViewRowAnimation)animation;
@end
