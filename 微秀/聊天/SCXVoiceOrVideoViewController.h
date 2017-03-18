//
//  SCXVoiceOrVideoViewController.h
//  聊天
//
//  Created by 孙承秀 on 16/11/1.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXBaseViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "SCXStorageManager.h"
#import <MediaPlayer/MediaPlayer.h>

//#import <CoreTelephony/CTCallCenter.h>
//#import <CoreTelephony/CTCall.h>
#import "EMClient.h"
#import "EMSDKFull.h"
#import "SCXCallManager.h"
@class EMCallSession;
@interface SCXVoiceOrVideoViewController : SCXBaseViewController
/******  callSession *****/
@property(nonatomic,strong)EMCallSession *callSession;
/******  是否为呼出者 *****/
@property(nonatomic,assign)BOOL isCaller;
/******  时间label *****/
@property(nonatomic,strong)UILabel *timeLabel;
/******  时长 *****/
@property(nonatomic,assign)int timeLength;
/******  状态 *****/
@property(nonatomic,copy)NSString *statusString;
/******  手势 *****/
@property(nonatomic,strong)UITapGestureRecognizer *tapGesture;
/****** 名字label *****/
@property(nonatomic,strong)UILabel *nameLabel;
/******  状态label *****/
@property(nonatomic,strong)UILabel *statusLabel;
/******  拒绝按钮 *****/
@property(nonatomic,strong)UIButton *rejectButton;
/******  接受Button *****/
@property(nonatomic,strong)UIButton *answerButton;
/******  挂断Button *****/
@property(nonatomic,strong)UIButton *cancelButton;
/******  topView *****/
@property(nonatomic,strong)UIView *topView;
/******  操作View *****/
@property(nonatomic,strong)UIView *actionView;
/******  头像 *****/
@property(nonatomic,strong)UIImageView *headerImageView;
/******  网络label *****/
@property(nonatomic,strong)UILabel *netWorkLabel;
/******  切换摄像头Button *****/
@property(nonatomic,strong)UIButton *switchButton;
/******  静音按钮 *****/
@property(nonatomic,strong)UIButton *silenceButton;
/******  免提按钮 *****/
@property(nonatomic,strong)UIButton *largeVoiceButton;
/******  静音Laebl *****/
@property(nonatomic,strong)UILabel *silenceLabel;
/******  免提Label *****/
@property(nonatomic,strong)UILabel *largeVoiceLabel;
/******  录音按钮 *****/
@property(nonatomic,strong)UIButton *recordButton;
/******  音频按钮 *****/
@property(nonatomic,strong)UIButton *voiceButton;
/******  视频按钮 *****/
@property(nonatomic,strong)UIButton *videoButton;
/******  视频属性显示区域 *****/
@property(nonatomic,strong)UIView  *propertyView;
/******  属性大小label *****/
@property(nonatomic,strong)UILabel *sizeLabel;
/******  属性延迟label *****/
@property(nonatomic,strong)UILabel *timeLadyLabel;
/******  属性帧率label *****/
@property(nonatomic,strong)UILabel *framerateLabel;
/******  属性丢包书label *****/
@property(nonatomic,strong)UILabel *lostcntLabel;
/******  属性本地比特率label *****/
@property(nonatomic,strong)UILabel *localBitrateLabel;
/******  属性对方比特率label *****/
@property(nonatomic,strong)UILabel *remoteBitrateLabel;
/******  播放来电声音 *****/
@property(nonatomic,strong)AVAudioPlayer  *ringPlayer;
/******  时间器 *****/
@property(nonatomic,strong)NSTimer *callTimer;
/******  property时间器 *****/
@property(nonatomic,strong)NSTimer *propertyTimer;
/******  audioCategort *****/
@property(nonatomic,copy)NSString *audio_category;
/**
 初始化

 @param callSession callSession
 @param isCaller    是否为呼出者
 @param status      状态

 @return 
 */
-(instancetype)initWithSession:(EMCallSession *)callSession isCaller:(BOOL)isCaller status:(NSString *)status;

/**
 结束通话释放对象
 */
-(void)realease;

/**
 开始计时聊天时间
 */
-(void)startTimer;

/**
 展示当前聊天信息
 */
-(void)showPropertyInfo;

/**
 网络回调处理

 @param status 当前网络状态
 */
-(void)setNetWork:(EMCallNetworkStatus)status;
@end
