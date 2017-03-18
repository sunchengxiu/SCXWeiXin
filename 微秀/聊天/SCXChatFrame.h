//
//  SCXChatFrame.h
//  聊天
//
//  Created by 孙承秀 on 16/10/26.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCXChatModel.h"
@interface SCXChatFrame : NSObject
/******  model *****/
@property(nonatomic,strong)SCXChatModel  *chatModel;
/******  iconFrame *****/
@property(nonatomic,assign,readonly)CGRect iconFrame;
/******  名字Frame *****/
@property(nonatomic,assign,readonly)CGRect nameFrame;
/******  contentFrame *****/
@property(nonatomic,assign,readonly)CGRect contentFrame;
/******  cellHeigth *****/
@property(nonatomic,assign,readonly)CGFloat cellHeight;
@end
