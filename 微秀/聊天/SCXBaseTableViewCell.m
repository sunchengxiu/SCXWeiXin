//
//  SCXBaseTableViewCell.m
//  仿内涵段子
//
//  Created by 孙承秀 on 16/9/28.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXBaseTableViewCell.h"

@implementation SCXBaseTableViewCell
- (UITableView *)tableView {
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 7.0) {
        return  (UITableView *)self.superview.superview;
    } else {
        return (UITableView *)self.superview;
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor clearColor];
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    if (tableView == nil) {
        return [[self alloc] init];
    }
    NSString *classNmae=NSStringFromClass([self class]);
    NSString *cellID=[classNmae stringByAppendingString:@"cellID"];
    // NSLog(@"------------------!!!%@",cellID);
    [tableView registerClass:[self class] forCellReuseIdentifier:cellID];
    
    return [tableView dequeueReusableCellWithIdentifier:cellID];
}
+(instancetype)cellWithTableView:(UITableView *)tableView withId:(NSString *)reuseID{
    if (tableView == nil) {
        return [[self alloc] init];
    }
    NSString *classNmae=NSStringFromClass([self class]);
    NSString *cellID=reuseID;
    // NSLog(@"------------------!!!%@",cellID);
    [tableView registerClass:[self class] forCellReuseIdentifier:cellID];
    return [tableView dequeueReusableCellWithIdentifier:cellID];
}
@end
