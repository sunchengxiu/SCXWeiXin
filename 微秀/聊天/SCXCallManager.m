//
//  SCXCallManager.m
//  聊天
//
//  Created by 孙承秀 on 16/11/1.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXCallManager.h"

@implementation SCXCallManager
singleM(CallManager);
-(id)init{
    if (self=[super init]) {
        [[EMClient sharedClient].callManager addDelegate:self delegateQueue:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(makeCall:) name:CALL_NOTIFIGATION object:nil];
    }
    return self;
}
#pragma mark--注册通话
-(void)makeCall:(NSNotification *)no{
    if (no.object) {
        [self makeCallWithUsername:[no.object valueForKey:@"userName"] isVideo:[[no.object valueForKey:@"type"] boolValue] andController:[no.object valueForKey:@"controller"]];
    }
}
#pragma mark--和视频控制器建立关联
- (void)makeCallWithUsername:(NSString *)aUsername
                     isVideo:(BOOL)aIsVideo andController:(UIViewController *)controller{
    if (aUsername.length==0) {
        return;
    }
    void (^complementblock)(EMCallSession *,EMError *)=^(EMCallSession *callSession,EMError *error){
        WeakSelf(weakSelf);
        if (!error&&callSession) {
            weakSelf.callSession=callSession;
            [weakSelf startCallTimer];
            weakSelf.callController=[[SCXVoiceOrVideoViewController alloc]initWithSession:callSession isCaller:YES status:@"连接中"];
            [controller presentViewController:weakSelf.callController animated:YES completion:nil];
        }
        else{
            [[EMClient sharedClient].callManager endCall:aUsername reason:EMCallEndReasonFailed];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"异常错误" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alertView show];
        }
    
    };
    if (aIsVideo) {
        [[EMClient sharedClient].callManager startVideoCall:aUsername completion:^(EMCallSession *aCallSession, EMError *aError) {
            complementblock(aCallSession,aError);
        }];
    }
    else{
        [[EMClient sharedClient].callManager startVoiceCall:aUsername completion:^(EMCallSession *aCallSession, EMError *aError) {
            complementblock(aCallSession,aError);
        }];
    }
}
#pragma mark--开始连接，50秒没连接成功则取消
-(void)startCallTimer{
    self.callTimer=[NSTimer scheduledTimerWithTimeInterval:50 target:self selector:@selector(cancelCall) userInfo:nil repeats:NO];

}
#pragma mark-取消连接
-(void)cancelCall{
    [self hangUpCallWithReason:EMCallEndReasonNoResponse];
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"对方无响应" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
    [alert show];
}
#pragma mark--接听
-(void)answerCall{
    if (self.callSession) {
        /*!
         *  \~chinese
         *  接收方同意通话请求
         *
         *  @param  aSessionId 通话ID
         *
         *  @result 错误信息
         *
         *  \~english
         *  Recipient answer the incoming call
         *
         *  @param  aSessionId Session Id
         *
         *  @result Error
         */

        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            EMError *error=[[EMClient sharedClient].callManager answerIncomingCall:self.callSession.sessionId];
            if (error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (error.code==EMErrorNetworkUnavailable) {
                        UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"提示" message:@"网络连接失败" preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *action=[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                            
                        }];
                        [controller addAction:action];
                        [[[[UIApplication sharedApplication] delegate] window].rootViewController.navigationController     presentViewController:controller animated:YES completion:^{
                            
                        }];
                    }
                    else{
                        
                        [self hangUpCallWithReason:EMCallEndReasonFailed];
                    }
                    
                });
            }
        });
    }
}
-(void)hangUpCallWithReason:(EMCallEndReason)reason{
    [self stopCallTimer];
    if (self.callSession) {
        /*!
         *  \~chinese
         *  结束通话
         *
         *  @param aSessionId 通话的ID
         *  @param aReason    结束原因
         *
         *  \~english
         *  End the call
         *
         *  @param aSessionId Session ID
         *  @param aReason    End reason
         */
        [[EMClient sharedClient].callManager endCall:self.callSession.sessionId reason:reason];
    }
    self.callSession=nil;
    [self.callController realease];
    self.callController=nil;
}
-(void)stopCallTimer{
    if (self.callTimer==nil) {
        return;
    }
    [self.callTimer invalidate];
    self.callTimer=nil;
}
#pragma mark--EMcallDelegate
/*!
 *  \~chinese
 *  用户B同意用户A拨打的通话后，用户A会收到这个回调
 *
 *  @param aSession  会话实例
 *
 *  \~english
 *  Delegate method invokes when the outgoing call is accepted by the recipient.
 *  User A will receive this callback after user B accept A's call.
 *
 *  @param Session instance
 */
-(void)callDidAccept:(EMCallSession *)aSession{
    if ([[UIApplication sharedApplication] applicationState]!=UIApplicationStateActive) {
        [[EMClient sharedClient].callManager endCall:aSession.sessionId reason:EMCallEndReasonFailed];
    }
    if ([aSession.sessionId isEqualToString:self.callSession.sessionId]) {
        [self stopCallTimer];
        self.callController.statusLabel.text=@"可以尽情的聊天了";
        self.callController.timeLabel.hidden=NO;
        [self.callController showPropertyInfo];
        [self.callController startTimer];
        //发送者只有一个挂断按钮
        _callController.cancelButton.hidden = NO;
        _callController.rejectButton.hidden = YES;
        _callController.answerButton.hidden = YES;
    }
}
/*!
 *  \~chinese
 *  用户A拨打用户B，用户B会收到这个回调
 *
 *  @param aSession  会话实例
 *
 *  \~english
 *  Delegate method will be invoked when receiving a call.
 *  User B will receive this callback after user A dial user B.
 *
 *  @param aSession  Session instance
 */
-(void)callDidReceive:(EMCallSession *)aSession{
    /********如果之前存在回话 ，那么此次通话繁忙占线********/
    if (self.callSession&&self.callSession.status!=EMCallSessionStatusDisconnected) {
        [[EMClient sharedClient].callManager endCall:aSession.sessionId reason:EMCallEndReasonBusy];
    }
    if ([[UIApplication sharedApplication] applicationState]!=UIApplicationStateActive) {
        [[EMClient sharedClient].callManager endCall:aSession.sessionId reason:EMCallEndReasonFailed];
    }
    self.callSession=aSession;
    if (self.callSession) {
        [self startCallTimer];
        /********链接成功等待接听********/
        self.callController=[[SCXVoiceOrVideoViewController alloc]initWithSession:aSession isCaller:NO status:@"连接成功"];
        self.callController.modalPresentationStyle=UIModalPresentationFullScreen;
        [[[[UIApplication sharedApplication] delegate]window].rootViewController presentViewController:self.callController animated:YES completion:nil];
    }
}
/*!
 *  \~chinese
 *  通话通道建立完成，用户A和用户B都会收到这个回调
 *
 *  @param aSession  会话实例
 *
 *  \~english
 *  Delegate method invokes when the connection is established.
 *  Both user A and B will receive this callback.
 *
 *  @param aSession  Session instance
 */
-(void)callDidConnect:(EMCallSession *)aSession{
    if ([aSession.sessionId isEqualToString:self.callSession.sessionId]) {
        self.callController.statusLabel.hidden=NO;
        self.callController.statusLabel.text=@"已经成功连接到对方";
        //[self.callController showPropertyInfo];
        AVAudioSession *session=[AVAudioSession sharedInstance];
        [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
        [session setActive:YES error:nil];
    }
}
/*!
 *  \~chinese
 *  1. 用户A或用户B结束通话后，对方会收到该回调
 *  2. 通话出现错误，双方都会收到该回调
 *
 *  @param aSession  会话实例
 *  @param aReason   结束原因
 *  @param aError    错误
 *
 *  \~english
 *  Delegate method invokes when the other party ends the call or some error happens.
 *  1.The another party will receive this callback after user A or user B end the call.
 *  2.Both user A and B will receive this callback after error occured.
 *
 *  @param aSession  Session instance
 *  @param aOption   The reason of ending the call
 *  @param aError    EMError
 */
-(void)callDidEnd:(EMCallSession *)aSession reason:(EMCallEndReason)aReason error:(EMError *)aError{
    if ([aSession.sessionId isEqualToString:self.callSession.sessionId]) {
        [self stopCallTimer];
        self.callSession=nil;
        [self.callController realease];
        self.callController=nil;
        NSString *reasen;
        if (aReason!=EMCallEndReasonHangup) {
            switch (aReason) {
                case EMCallEndReasonFailed:{
                reasen=@"连接失败";
                }
                    break;
                case EMCallEndReasonBusy:{
                   reasen=@"对方占线";
                }
                    break;
                case EMCallEndReasonDecline:{
                    reasen=@"对方拒绝";
                }
                    break;
                case EMCallEndReasonNoResponse:{
                    reasen=@"对方没有响应";
                }
                    break;
                    
                default:
                    break;
            }
            if (aError) {
                
            }
            else{
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:reasen delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
    }
}
/*!
 *  \~chinese
 *  用户A和用户B正在通话中，用户A暂停或者恢复数据流传输时，用户B会收到该回调
 *
 *  @param aSession  会话实例
 *  @param aType     改变类型
 *
 *  \~english
 *  Delegate method invokes when the other party pauses or resumes the call.
 *  User A and B are on the same call, A pauses or resumes the call, B will receive this callback.
 *
 *  @param aSession  Session instance
 *  @param aType     Current call status
 */
-(void)callStateDidChange:(EMCallSession *)aSession type:(EMCallStreamingStatus)aType{

}
/*!
 *  \~chinese
 *  用户A和用户B正在通话中，用户A的网络状态出现不稳定，用户A会收到该回调
 *
 *  @param aSession  会话实例
 *  @param aStatus   当前状态
 *
 *  \~english
 *  Delegate method invokes when the local network status changes.
 *  User A and B are on the same call, A's network status changes from active to unstable or unavailable, and A will receive the callback.
 *
 *  @param aSession  Session instance
 *  @param aStatus   Current network status
 */
-(void)callNetworkStatusDidChange:(EMCallSession *)aSession status:(EMCallNetworkStatus)aStatus{
    if ([self.callSession.sessionId isEqualToString:aSession.sessionId]) {
        [self.callController setNetWork:aStatus];
    }
}
@end
