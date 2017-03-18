//
//  SCXBaseTableViewCell.h
//  仿内涵段子
//
//  Created by 孙承秀 on 16/9/28.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCXBaseTableViewCell : UITableViewCell
/**
 *  快速创建一个tableViewCell
 *
 *  @param tableView
 *
 *  @return cell
 */
+(instancetype)cellWithTableView:(UITableView *)tableView;
+(instancetype)cellWithTableView:(UITableView *)tableView withId:(NSString *)reuseID;
@property (nonatomic, weak) UITableView *tableView;
;
@end
