//
//  SCXPersonalCell.h
//  聊天
//
//  Created by 孙承秀 on 16/10/27.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXBaseTableViewCell.h"

@interface SCXPersonalCell : SCXBaseTableViewCell
/******  用户信息 *****/
@property(nonatomic,strong)NSDictionary *infoDic;
/******  用户头像 *****/
@property(nonatomic,strong)UIImageView *iconImageView;
/******  名字 *****/
@property(nonatomic,strong)UILabel *nameLabel;
/******  微信号 *****/
@property(nonatomic,strong)UILabel *weixinLabel;
/******  title *****/
@property(nonatomic,strong)UILabel *titleLabel;
/******  发消息按钮 *****/
@property(nonatomic,strong)UIButton *sendMessageButton;
/******  视频按钮 *****/
@property(nonatomic,strong)UIButton *sendMoiveButton;
/******  是否含有头像 *****/
@property(nonatomic,assign)BOOL isIconImageView;
/******  是否含有相册 *****/
@property(nonatomic,assign)BOOL  isHasAlbum;
/******  是否有发送按钮 *****/
@property(nonatomic,assign)BOOL isSend;
/******  按钮点击Block *****/
@property(nonatomic,copy)void (^block)(NSString *);

/**
 配置视图是否含有头像，相册，发送信息按钮

 @param isImageView  头像
 @param isAlbum      相册
 @param isSendButton 发送按钮
 */
-(void)layoutCellIsHasIconImageView:(BOOL)isImageView andAlbum:(BOOL)isAlbum andSendButton:(BOOL)isSendButton;
@end
