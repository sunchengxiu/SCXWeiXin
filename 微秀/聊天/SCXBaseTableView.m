//
//  SCXBaseTableView.m
//  仿内涵段子
//
//  Created by 孙承秀 on 16/9/28.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXBaseTableView.h"

@implementation SCXBaseTableView
#pragma maek--初始化
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{

    if (self=[super initWithFrame:frame style:style]) {
        self.backgroundColor=[UIColor redColor];
    }
    return self;
}
#pragma mark--注册cell
-(void)SCX_registerClass:(Class)cellClass forCelIdentifier:(NSString *)identifier{
    if (cellClass&&identifier.length) {
         [self registerClass:cellClass forCellReuseIdentifier:identifier];
    }
}
#pragma mark--注册一个tableViewfooterHeader
-(void)SCX_registerClass:(Class)aClass forHeaderFooterViewReuseIdentifier:(NSString *)identifier{
    if (aClass&&identifier.length) {
        [self registerClass:aClass forHeaderFooterViewReuseIdentifier:identifier];
    }
}
#pragma mark--获取某一行对应的cell
-(UITableViewCell *)SCX_cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSInteger sectionNumber=self.numberOfSections;
    NSInteger currentSection=indexPath.section;
    if (currentSection+1>sectionNumber||currentSection<0) {
        NSLog(@"section越界");
        return nil;
    }
    if (indexPath.row>[self numberOfRowsInSection:currentSection]||indexPath.row<0) {
        NSLog(@"列表数量越界");
        return nil;
    }
    return [self cellForRowAtIndexPath:indexPath];

}
#pragma mark--tableView某一行刷新动画
-(void)SCX_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(SCXTableViewRowAnimation)animation{
    if (indexPaths.count==0) {
        return;
    }
    for (NSIndexPath *indexPath in indexPaths) {
        if (!indexPath) {
            return;
            break;
        }
        NSInteger allSection=self.numberOfSections;
        NSInteger currentSection=indexPath.section;
        if (currentSection+1>allSection||currentSection<0) {
            NSLog(@"section越界了");
            return;
            break;
        }
        if (indexPath.row+1>[self numberOfRowsInSection:currentSection]||indexPath.row<0) {
            NSLog(@"row越界了");
            return;
            break;
        }
    }
    [self beginUpdates];
    [self reloadRowsAtIndexPaths:indexPaths withRowAnimation:(UITableViewRowAnimation)animation];

}
#pragma mark--刷新某个section
-(void)SCX_reloadSingleSection:(NSInteger )section{
    [self SCX_reloadSingleSections:section withRowAnimation:SCXTableViewRowAnimationNone];
}
-(void)SCX_reloadSingleSections:(NSInteger )section withRowAnimation:(SCXTableViewRowAnimation)animation{
    NSInteger allSection=self.numberOfSections;
    if (section+1>allSection||section<0) {
        NSLog(@"section越界了");
    }
    else{
        [self reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:(UITableViewRowAnimation)animation];
    
    }

}
#pragma mark--刷新多个Sections
-(void)SCX_reloadSections:(NSArray<NSNumber *> *)sections{

    [self SCX_reloadSections:sections withRowAnimation:SCXTableViewRowAnimationNone];
}
-(void)SCX_reloadSections:(NSArray<NSNumber *> *)sections withRowAnimation:(SCXTableViewRowAnimation)animation{

    if (sections.count==0) {
        return;
    }
    __block typeof(self)weakSelf=self;
    [sections enumerateObjectsUsingBlock:^(NSNumber*   obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [weakSelf SCX_reloadSingleSections:obj.integerValue withRowAnimation:animation];
    }];
}
#pragma mark--删除单行
-(void)SCX_deleteSingleRowAtIndexPath:(NSIndexPath  *)indexPath {
    [self SCX_deleteSingleRowAtIndexPath:indexPath withRowAnimation:SCXTableViewRowAnimationNone];
}
-(void)SCX_deleteSingleRowAtIndexPath:(NSIndexPath  *)indexPath withRowAnimation:(SCXTableViewRowAnimation)animation{
    NSInteger sectionNumber=self.numberOfSections;
    NSInteger currentSection=indexPath.section;
    if (currentSection+1>sectionNumber||currentSection<0) {
        NSLog(@"section越界");
        return ;
    }
    if (indexPath.row>[self numberOfRowsInSection:currentSection]||indexPath.row<0) {
        NSLog(@"列表数量越界");
        return ;
    }
   
    [self beginUpdates];
    [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimation)animation];
    [self endUpdates];
    
   

}
#pragma mark--删除多行
-(void)SCX_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    [self SCX_deleteRowsAtIndexPaths:indexPaths withRowAnimation:SCXTableViewRowAnimationNone   ];
}
-(void)SCX_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(SCXTableViewRowAnimation)animation{
    if (indexPaths.count==0) {
        return;
    }
    __block typeof(self)weakSelf=self;
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [weakSelf SCX_deleteSingleRowAtIndexPath:obj withRowAnimation:animation];
    }];
}
#pragma makr--删除单个Section
-(void)SCX_deleteSingleSection:(NSInteger )section{
    [self SCX_deleteSingleSection:section withRowAnimation:SCXTableViewRowAnimationNone];

}
-(void)SCX_deleteSingleSection:(NSInteger )section withRowAnimation:(SCXTableViewRowAnimation)animation{
    NSInteger sectionCount=self.numberOfSections;
    if (sectionCount+1>sectionCount||sectionCount<0) {
        NSLog(@"section越界");
    }
    [self deleteSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:(UITableViewRowAnimation)animation];
}
#pragma mark--删除多个section
-(void)SCX_deleteSections:(NSArray<NSNumber *> *)sections {
    [self SCX_deleteSections:sections withRowAnimation:SCXTableViewRowAnimationNone];

}
-(void)SCX_deleteSections:(NSArray<NSNumber *> *)sections withRowAnimation:(SCXTableViewRowAnimation)animation{
    if (!sections) {
        return;
    }
    __block typeof(self)weakSelf=self;
    [sections enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [weakSelf SCX_deleteSingleSection:obj.integerValue withRowAnimation:animation];
    }];
}
#pragma mark--增加单行
-(void)SCX_insertSingleRowAtIndexPaths:(NSIndexPath  *)indexPath {
    [self SCX_insertSingleRowAtIndexPaths:indexPath withRowAnimation:SCXTableViewRowAnimationNone];
}
-(void)SCX_insertSingleRowAtIndexPaths:(NSIndexPath  *)indexPath withRowAnimation:(SCXTableViewRowAnimation)animation{
    if (!indexPath) return ;
    NSInteger sectionNumber = self.numberOfSections;
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    NSInteger rowNumber = [self numberOfRowsInSection:section];
    if (section > sectionNumber || section < 0) {
        // section 越界
        NSLog(@"section 越界 : %ld", section);
    } else if (row > rowNumber || row < 0) {
        NSLog(@"row 越界 : %ld", row);
    } else {
        [self beginUpdates];
        [self insertRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimation)animation];
        [self endUpdates];
    }

}
#pragma mark--增加单个section
-(void)SCX_insertSingleSection:(NSInteger )section {

    [self SCX_insertSingleSection:section withRowAnimation:SCXTableViewRowAnimationNone];
}
-(void)SCX_insertSingleSection:(NSInteger )section withRowAnimation:(SCXTableViewRowAnimation)animation{
    NSInteger sectionNumber = self.numberOfSections;
    if (section + 1 > sectionNumber || section < 0) {
        // section越界
        NSLog(@" section 越界 : %ld", section);
    } else {
        [self beginUpdates];
        [self insertSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:(UITableViewRowAnimation)animation];
        [self endUpdates];
    }
}
#pragma mark--增加多行
-(void)SCX_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    [self SCX_insertRowsAtIndexPaths:indexPaths withRowAnimation:SCXTableViewRowAnimationNone];
}
-(void)SCX_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(SCXTableViewRowAnimation)animation{
    if (indexPaths.count == 0) return ;
    __block typeof(self)weakSelf=self;
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSIndexPath class]]) {
            [weakSelf SCX_insertSingleRowAtIndexPaths:obj withRowAnimation:animation];
        }
    }];

}

#pragma mark--增加多个section
-(void)SCX_insertSections:(NSArray<NSNumber *> *)sections {
    [self SCX_insertSections:sections withRowAnimation:SCXTableViewRowAnimationNone];
}
-(void)SCX_insertSections:(NSArray<NSNumber *> *)sections withRowAnimation:(SCXTableViewRowAnimation)animation{
    if (sections.count == 0) return ;
    __block typeof (self)weakSelf=self;
    [sections enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            [weakSelf SCX_insertSingleSection:obj.integerValue withRowAnimation:animation];
        }
    }];

}
#pragma mark--点击tableView空白处隐藏键盘
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    id view=[super hitTest:point withEvent:event];
    if (![view isKindOfClass:[UITextField class]]) {
        [self endEditing:YES];
    }
    return view;
}



@end
