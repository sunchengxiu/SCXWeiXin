//
//  SCXSendTableViewCell.h
//  聊天
//
//  Created by 孙承秀 on 16/9/1.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMSDK.h"
#import "SCXBaseTableViewCell.h"
#import "SCXChatModel.h"
#import "SCXChatFrame.h"
#import <UIImageView+WebCache.h>
#import <SDImageCache.h>
#import <UIButton+WebCache.h>
#import "UIImageView+SCXBaseImageView.h"
@class SCXButton;
@interface SCXSendTableViewCell : SCXBaseTableViewCell
@property(nonatomic,strong)EMMessage *message;
/******  SCXModel *****/
@property(nonatomic,strong)SCXChatFrame *chatFrmae;
/******  聊天背景按钮 *****/
@property(nonatomic,strong)SCXButton *contentButton;
/******  头像 *****/
@property(nonatomic,strong)UIImageView *iconImageView;
/******  图片 *****/
@property(nonatomic,strong)UIImageView *contentImageView;
/******  语音动画imageView *****/
@property(nonatomic,strong)UIImageView *voiceImageView;
@end
