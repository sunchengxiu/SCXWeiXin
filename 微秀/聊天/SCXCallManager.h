//
//  SCXCallManager.h
//  聊天
//
//  Created by 孙承秀 on 16/11/1.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "single.h"
#import "EMSDKFull.h"
#import "EMCallSession.h"
#import "SCXVoiceOrVideoViewController.h"
@class SCXVoiceOrVideoViewController;
@interface SCXCallManager : NSObject<EMCallManagerDelegate>
singleH(CallManager);
/******  callsession *****/
@property(nonatomic,strong)EMCallSession *callSession;
/******  时间器 *****/
@property(nonatomic,strong)NSTimer *callTimer;
/******  callController *****/
@property(nonatomic,strong)SCXVoiceOrVideoViewController *callController;

/**
 接听电话
 */
-(void)answerCall;

/**
 挂断电话

 @param reason 原因
 */
-(void)hangUpCallWithReason:(EMCallEndReason)reason;
@end
