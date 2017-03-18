//
//  SCXAskCell.h
//  聊天
//
//  Created by 孙承秀 on 16/10/21.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXBaseTableViewCell.h"
@protocol SCXAskCellDelegate;
@interface SCXAskCell : SCXBaseTableViewCell
@property(nonatomic,strong)UIImageView *iconImageView;
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)UILabel *label1;
@property(nonatomic,strong)UIButton *button;
@property(nonatomic,strong)NSDictionary *infoDic;
@property(nonatomic,copy)void (^acceptBlock)(SCXAskCell *);
@property(nonatomic,weak)id <SCXAskCellDelegate>delegate;
@end
@protocol SCXAskCellDelegate <NSObject>

-(void)clickAcceptButton:(SCXAskCell *)cell andHandleBlock:(void (^)(NSInteger ))block;

@end
