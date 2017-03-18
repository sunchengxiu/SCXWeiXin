//
//  SCXVoiceOrVideoViewController.m
//  聊天
//
//  Created by 孙承秀 on 16/11/1.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXVoiceOrVideoViewController.h"
#import "EMCallSession.h"
@interface SCXVoiceOrVideoViewController ()

@end

@implementation SCXVoiceOrVideoViewController
#pragma mark--初始化
-(instancetype)initWithSession:(EMCallSession *)callSession isCaller:(BOOL)isCaller status:(NSString *)status{

    if (self=[super init]) {
        _callSession=callSession;
        _isCaller=isCaller;
        _timeLabel.text=@"";
        _timeLength=0;
        _statusString=status;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addGestureRecognizer:self.tapGesture];
    /**
     *  对方名字
     */
    _nameLabel.text=_callSession.remoteUsername;
    _statusLabel.text=_statusString;
    [self instanceVoiceView];
    if (_isCaller) {
        self.rejectButton.hidden=YES;
        self.answerButton.hidden=YES;
        self.cancelButton.hidden=NO;
    }
    else{
        self.cancelButton.hidden=YES;
        self.answerButton.hidden=NO;
        self.rejectButton.hidden=NO;
    }
    if (_callSession.type==EMCallTypeVideo) {
        [self instanceVideoView];
        [self.view bringSubviewToFront:self.topView];
        [self.view bringSubviewToFront:self.actionView];
    }
        // Do any additional setup after loading the view.
}
#pragma mark--初始化语音视图和视频视图
#pragma mark--语音视图
-(void)instanceVoiceView{

    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    /********背景图片********/
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:self.view.bounds];
    imageView.contentMode=UIViewContentModeScaleToFill;
    imageView.image=[UIImage imageNamed:@"callBg.png"];
    [self.view addSubview:imageView];
    
    /*************************************************************/
    [self.view addSubview:self.topView];
    [self.topView addSubview:self.statusLabel];
    [self.topView addSubview:self.timeLabel];
    [self.topView addSubview:self.headerImageView];
    [self.topView addSubview:self.nameLabel];
    [self.topView addSubview:self.netWorkLabel];
    if (self.callSession.type==EMCallTypeVideo) {
        [self.topView addSubview:self.switchButton];
    }
    
    /*************************************************************/
    [self.view addSubview:self.actionView];
    [self.actionView addSubview:self.silenceButton];
    [self.actionView addSubview:self.largeVoiceButton];
    [self.actionView addSubview:self.silenceLabel];
    [self.actionView addSubview:self.largeVoiceLabel];
     [self.actionView addSubview:self.rejectButton];
    [self.actionView addSubview:self.answerButton];
    [self.actionView addSubview:self.cancelButton];
    
    /*************************************************************/
    if (self.callSession.type==EMCallTypeVideo) {
        [self.actionView addSubview:self.recordButton];
        [self.actionView addSubview:self.voiceButton];
        [self.actionView addSubview:self.videoButton];
        
    }
}
#pragma mark--视频视图
-(void)instanceVideoView{
    /********对方窗口等于全屏********/
    self.callSession.remoteVideoView=[[EMCallRemoteView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview: self.callSession.remoteVideoView];
    /********自己的窗口********/
    CGFloat width=80;
    CGFloat height=SCX_ScreenHeight/SCX_ScreenWidth*width;
    self.callSession.localVideoView=[[EMCallLocalView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-90, CGRectGetMaxY(self.statusLabel.frame), width, height)];
    [self.view addSubview:self.callSession.localVideoView];
    [self.view addSubview:self.propertyView];
    
    /*************************************************************/
    width = (CGRectGetWidth(_propertyView.frame) - 20) / 2;
    height = CGRectGetHeight(_propertyView.frame) / 3;
    _sizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    _sizeLabel.backgroundColor = [UIColor clearColor];
    _sizeLabel.textColor = [UIColor whiteColor];
    [self.propertyView addSubview:_sizeLabel];
    
    /*************************************************************/
    _timeLadyLabel = [[UILabel alloc] initWithFrame:CGRectMake(width, 0, width, height)];
    _timeLadyLabel.backgroundColor = [UIColor clearColor];
    _timeLadyLabel.textColor = [UIColor whiteColor];
    [self.propertyView addSubview:_timeLadyLabel];
    
    /*************************************************************/
    _framerateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, height, width, height)];
    _framerateLabel.backgroundColor = [UIColor clearColor];
    _framerateLabel.textColor = [UIColor whiteColor];
    [self.propertyView addSubview:_framerateLabel];
    
    /*************************************************************/
    _lostcntLabel = [[UILabel alloc] initWithFrame:CGRectMake(width, height, width, height)];
    _lostcntLabel.backgroundColor = [UIColor clearColor];
    _lostcntLabel.textColor = [UIColor whiteColor];
    [self.propertyView addSubview:_lostcntLabel];
    
    /*************************************************************/
    _localBitrateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, height * 2, width, height)];
    _localBitrateLabel.backgroundColor = [UIColor clearColor];
    _localBitrateLabel.textColor = [UIColor whiteColor];
    [self.propertyView addSubview:_localBitrateLabel];
    
    /*************************************************************/
    _remoteBitrateLabel = [[UILabel alloc] initWithFrame:CGRectMake(width, height * 2, width, height)];
    _remoteBitrateLabel.backgroundColor = [UIColor clearColor];
    _remoteBitrateLabel.textColor = [UIColor whiteColor];
    [self.propertyView addSubview:_remoteBitrateLabel];
}
#pragma mark--刷新属性数据
-(void)reloadPropertyData{
    if (self.callSession) {
        self.sizeLabel.text=[NSString stringWithFormat:@"宽/高:%i/%i",[self.callSession getVideoWidth],[self.callSession getVideoHeight]];
        self.timeLadyLabel.text=[NSString stringWithFormat:@"延迟：%i",[self.callSession getVideoLatency]];
        self.framerateLabel.text = [NSString stringWithFormat:@"帧率：%i",[_callSession getVideoFrameRate]];
        self.lostcntLabel.text = [NSString stringWithFormat:@"丢包数：%i",  [_callSession getVideoLostRateInPercent]];
        self.localBitrateLabel.text = [NSString stringWithFormat:@"本地比特率：%i", [_callSession getVideoLocalBitrate]];
        self.remoteBitrateLabel.text = [NSString stringWithFormat:@"对方比特率：%i", [_callSession getVideoRemoteBitrate]];
    }
}
#pragma mark--开始响铃
-(void)beginRing{

    [_ringPlayer stop];
    NSString *musicPath=[[NSBundle mainBundle] pathForResource:@"callRing" ofType:@"mp3"];
    _ringPlayer=[[AVAudioPlayer alloc] initWithContentsOfURL:musicPath error:nil];
    [_ringPlayer setVolume:50];
    _ringPlayer.numberOfLoops=-1;//一直播放
    if ([_ringPlayer prepareToPlay]) {
        [_ringPlayer play];
    }
}
#pragma mark--停止声音
-(void)stopPlay{
    [_ringPlayer stop];
}
- (void)timeTimerAction:(id)sender{
    _timeLength+=1;
    int hour=_timeLength/3600;
    int min=(_timeLength-hour*3600)/60;
    int s=_timeLength - hour * 3600 - min * 60;
    if (hour>0) {
        _timeLabel.text=[NSString stringWithFormat:@"%i:%i:%i",hour,min,s];
        
    }
    else if (min>0){
    _timeLabel.text=[NSString stringWithFormat:@"00:%i:%i",min,s];
    }
    else{
        _timeLabel.text=[NSString stringWithFormat:@"00:00:%i",s];
    }
}
#pragma mark - 懒加载
-(UITapGestureRecognizer *)tapGesture{
    if (!_tapGesture) {
        _tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    }
    return _tapGesture;

}
-(UIView *)topView{
    if (!_topView) {
        _topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
        _topView.backgroundColor=[UIColor clearColor];
        
    }
    return _topView;

}
-(UILabel *)statusLabel{

    if (!_statusLabel) {
        _statusLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 20, self.topView.frame.size.width-20, 20)];
        [_statusLabel setFont:[UIFont systemFontOfSize:15]];
        _statusLabel.backgroundColor = [UIColor clearColor];
        _statusLabel.textColor = [UIColor clearColor];
        _statusLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _statusLabel;
}
-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.statusLabel.frame), self.topView.frame.size.width, 15)];
        _timeLabel.font = [UIFont systemFontOfSize:12.0];
        _timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _timeLabel;
}
-(UIImageView *)headerImageView{
    if (!_headerImageView) {
        _headerImageView=[[UIImageView alloc]initWithFrame:CGRectMake((self.topView.frame.size.width - 50) / 2, CGRectGetMaxY(self.statusLabel.frame) + 20, 50, 50)];
        _headerImageView.image = [UIImage imageNamed:@"user"];
    }
    return _headerImageView;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerImageView.frame) + 5,self.topView.frame.size.width, 20)];
        _nameLabel.font = [UIFont systemFontOfSize:14.0];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.text = _callSession.remoteUsername;
    }
    return _nameLabel;
}
-(UILabel *)netWorkLabel{
    if (!_netWorkLabel) {
        _netWorkLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.nameLabel.frame) + 5, self.topView.frame.size.width, 20)];
        _netWorkLabel.font = [UIFont systemFontOfSize:14.0];
        _netWorkLabel.backgroundColor = [UIColor clearColor];
        _netWorkLabel.textColor = [UIColor whiteColor];
        _netWorkLabel.textAlignment = NSTextAlignmentCenter;
        _netWorkLabel.hidden = YES;

    }
    return _netWorkLabel;

}
-(UIButton *)switchButton{
    if (!_switchButton) {
        _switchButton=[[UIButton alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_statusLabel.frame) + 20, 60, 30)];
        [_switchButton setBackgroundColor:[UIColor clearColor]];
        [_switchButton setTitle:@"切换摄像头" forState:UIControlStateNormal];
        [_switchButton.titleLabel setFont:[UIFont systemFontOfSize:10]];
        [_switchButton addTarget:self action:@selector(switchCameraAction) forControlEvents:UIControlEventTouchUpInside];
        _switchButton.userInteractionEnabled = YES;
    }
    return _switchButton;
}
-(UIView *)actionView{
    if (!_actionView) {
        _actionView=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 260, self.view.frame.size.width, 260)];
        _actionView.backgroundColor = [UIColor clearColor];
    }
    return _actionView;
}
-(UIButton *)silenceButton{
    if (!_silenceButton) {
        CGFloat tmpWidth = self.actionView.frame.size.width / 2;
        _silenceButton = [[UIButton alloc] initWithFrame:CGRectMake((tmpWidth - 40) / 2, 80, 40, 40)];
        [_silenceButton setImage:[UIImage imageNamed:@"call_silence"] forState:UIControlStateNormal];
        [_silenceButton setImage:[UIImage imageNamed:@"call_silence_h"] forState:UIControlStateSelected];
        [_silenceButton addTarget:self action:@selector(silenceAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _silenceButton;
}
-(UIButton *)largeVoiceButton{
    if (!_largeVoiceButton) {
        CGFloat tmpWidth = self.actionView.frame.size.width / 2;
        _largeVoiceButton=[[UIButton alloc]initWithFrame:CGRectMake(tmpWidth + (tmpWidth - 40) / 2, _silenceButton.frame.origin.y, 40, 40)];
        [_largeVoiceButton setImage:[UIImage imageNamed:@"call_out"] forState:UIControlStateNormal];
        [_largeVoiceButton setImage:[UIImage imageNamed:@"call_out_h"] forState:UIControlStateSelected];
        [_largeVoiceButton addTarget:self action:@selector(largeVoice) forControlEvents:UIControlEventTouchUpInside];
    }
    return _largeVoiceButton;
}
-(UILabel *)silenceLabel{
    if (!_silenceLabel) {
        CGFloat tmpWidth = self.actionView.frame.size.width / 2;
        _silenceLabel=[[UILabel alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(_silenceButton.frame) + 5, tmpWidth - 60, 20)];
        _silenceLabel.backgroundColor = [UIColor clearColor];
        _silenceLabel.textColor = [UIColor whiteColor];
        _silenceLabel.font = [UIFont systemFontOfSize:13.0];
        _silenceLabel.textAlignment = NSTextAlignmentCenter;
        _silenceLabel.text = @"静音";
    }
    return _silenceLabel;
}
-(UILabel *)largeVoiceLabel{
    if (!_largeVoiceLabel) {
        CGFloat tmpWidth = self.actionView.frame.size.width / 2;
        _largeVoiceLabel = [[UILabel alloc] initWithFrame:CGRectMake(tmpWidth + 30, CGRectGetMaxY(self.largeVoiceButton.frame) + 5, tmpWidth - 60, 20)];
        _largeVoiceLabel.backgroundColor = [UIColor clearColor];
        _largeVoiceLabel.textColor = [UIColor whiteColor];
        _largeVoiceLabel.font = [UIFont systemFontOfSize:13.0];
        _largeVoiceLabel.textAlignment = NSTextAlignmentCenter;
        _largeVoiceLabel.text = @"免提";

    }
    return _largeVoiceLabel;
}
-(UIButton *)rejectButton{
    if (!_rejectButton) {
        CGFloat tmpWidth = self.actionView.frame.size.width / 2;
        _rejectButton = [[UIButton alloc] initWithFrame:CGRectMake((tmpWidth - 100) / 2, CGRectGetMaxY(self.largeVoiceLabel.frame) + 30, 100, 40)];
        [_rejectButton setTitle:@"拒绝" forState:UIControlStateNormal];
        [_rejectButton setBackgroundColor:[UIColor colorWithRed:191 / 255.0 green:48 / 255.0 blue:49 / 255.0 alpha:1.0]];
        [_rejectButton addTarget:self action:@selector(rejectAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rejectButton;
}
-(UIButton *)answerButton{
    if (!_answerButton) {
        CGFloat tmpWidth = self.actionView.frame.size.width / 2;
        _answerButton = [[UIButton alloc] initWithFrame:CGRectMake(tmpWidth + (tmpWidth - 100) / 2, self.rejectButton.frame.origin.y, 100, 40)];
        [_answerButton setTitle:@"接听" forState:UIControlStateNormal];
        [_answerButton setBackgroundColor:[UIColor colorWithRed:191 / 255.0 green:48 / 255.0 blue:49 / 255.0 alpha:1.0]];;
        [_answerButton addTarget:self action:@selector(answerAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _answerButton;
}
-(UIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 200) / 2, self.rejectButton.frame.origin.y, 200, 40)];
        [_cancelButton setTitle:@"挂断" forState:UIControlStateNormal];
        [_cancelButton setBackgroundColor:[UIColor colorWithRed:191 / 255.0 green:48 / 255.0 blue:49 / 255.0 alpha:1.0]];;
        [_cancelButton addTarget:self action:@selector(hangupAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
    
}
-(UIButton *)recordButton{
    if (!_recordButton) {
        CGFloat tmpWidth = _actionView.frame.size.width / 3;
        _recordButton = [[UIButton alloc] initWithFrame:CGRectMake((tmpWidth-40)/2, 20, 40, 40)];
        _recordButton.layer.cornerRadius = 20.f;
        [_recordButton setTitle:@"录制" forState:UIControlStateNormal];
        [_recordButton setTitle:@"停止播放" forState:UIControlStateSelected];
        [_recordButton.titleLabel setFont:[UIFont systemFontOfSize:10]];
        [_recordButton setBackgroundColor:[UIColor clearColor]];
        [_recordButton addTarget:self action:@selector(recordAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _recordButton;
}
-(UIButton *)voiceButton{
    if (!_voiceButton) {
        CGFloat tmpWidth = _actionView.frame.size.width / 3;
        _voiceButton = [[UIButton alloc] initWithFrame:CGRectMake(tmpWidth * 2 + (tmpWidth - 40) / 2, 20, 40, 40)];
        _voiceButton.layer.cornerRadius = 20.f;
        [_voiceButton setTitle:@"音视开启" forState:UIControlStateNormal];
        [_voiceButton setTitle:@"音视中断" forState:UIControlStateSelected];
        [_voiceButton.titleLabel setFont:[UIFont systemFontOfSize:10]];
        [_voiceButton setBackgroundColor:[UIColor clearColor]];
        [_voiceButton addTarget:self action:@selector(voicePauseAction) forControlEvents:UIControlEventTouchUpInside];

    }
    return _voiceButton;
}
-(UIButton *)videoButton{
    if (!_videoButton) {
        CGFloat tmpWidth = _actionView.frame.size.width / 3;
        _videoButton = [[UIButton alloc] initWithFrame:CGRectMake(tmpWidth + (tmpWidth - 40) / 2, 20, 40, 40)];
        _videoButton.layer.cornerRadius = 20.f;
        [_videoButton setTitle:@"视频开启" forState:UIControlStateNormal];
        [_videoButton setTitle:@"视频中断" forState:UIControlStateSelected];
        [_videoButton.titleLabel setFont:[UIFont systemFontOfSize:10]];
        [_videoButton setBackgroundColor:[UIColor clearColor]];
        [_videoButton addTarget:self action:@selector(videoPauseAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _videoButton;
}
-(UIView *)propertyView{
    if (!_propertyView) {
        _propertyView=[[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMinY(self.actionView.frame) - 90, self.view.frame.size.width - 20, 90)];
        _propertyView.backgroundColor = [UIColor clearColor];
        _propertyView.hidden = NO;
    }
    return _propertyView;
}
#pragma mark--是否显示属性
-(BOOL )isShowCallInfo{
    return [[NSUserDefaults standardUserDefaults] boolForKey:IsShowCallInfo];
}
#pragma mark--空白处点击事件
-(void)tapAction:(UITapGestureRecognizer *)tap{
    self.topView.hidden=!self.topView.hidden;
    self.actionView.hidden=!self.actionView.hidden;
}
#pragma mark--切换摄像头
-(void)switchCameraAction{
    /********切换摄像头********/
    [self.callSession switchCameraPosition:self.switchButton.selected];
    self.switchButton.selected=!self.switchButton.selected;
}
#pragma mark--静音
-(void)silenceAction{
    self.silenceButton.selected=!self.silenceButton.selected;
    if (self.silenceButton.selected) {
        [[EMClient sharedClient].callManager pauseVoiceWithSession:self.callSession.sessionId error:nil];
    }
    else{
        [[EMClient sharedClient].callManager resumeVoiceWithSession:self.callSession.sessionId error:nil];
    }
}
#pragma mark--免提
-(void)largeVoice{
    AVAudioSession *session=[AVAudioSession sharedInstance];
    if (self.largeVoiceButton.selected) {
        //正常模式
        [session overrideOutputAudioPort:AVAudioSessionPortOverrideNone error:nil];
    }
    else{
        //免提
        [session overrideOutputAudioPort:AVAudioSessionPortOverrideSpeaker error:nil];
    }
    self.largeVoiceButton.selected=!self.largeVoiceButton.selected;
}
#pragma mark -- 拒绝
-(void)rejectAction{
    [self.callTimer invalidate];
    [self stopPlay];
    AVAudioSession *session=[AVAudioSession sharedInstance];
    [session setCategory:self.audio_category error:nil];
    [session setActive:YES error:nil];
    [[SCXCallManager sharedCallManager] hangUpCallWithReason:EMCallEndReasonDecline];
}
#pragma mark--接听
-(void)answerAction{
    /********停止声音********/
    [self stopPlay];
    AVAudioSession *session=[AVAudioSession sharedInstance];
    _audio_category=session.category;
    if (![self.audio_category isEqualToString:AVAudioSessionCategoryPlayAndRecord]) {
        [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
        [session setActive:YES error:nil];
    }
    [[SCXCallManager sharedCallManager] answerCall];
}
#pragma mark--挂断
-(void)hangupAction{
    [self stopPlay];
    [self.callTimer invalidate];
    AVAudioSession *session=[AVAudioSession sharedInstance];
    [session setCategory:self.audio_category error:nil];
    [session setActive:YES error:nil];
    [[SCXCallManager sharedCallManager] hangUpCallWithReason:EMCallEndReasonHangup];
}
#pragma mark--录音事件
-(void)recordAction{
    self.recordButton.selected=!self.recordButton.selected;
    if (self.recordButton.selected) {
        NSString *record_path=[SCXStorageManager setAimFilePathFromCachesPath:@"record"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:record_path]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:record_path withIntermediateDirectories:YES attributes:nil error:nil];
            
        }
        /********环信开始录音********/
        [self.callSession startVideoRecordingToFilePath:record_path error:nil];
    }
    else{
        //播放这段语音
        NSString *tempPath=[self.callSession stopVideoRecording:nil];
        MPMoviePlayerController *controller=[[MPMoviePlayerController alloc]initWithContentURL:[NSURL URLWithString:tempPath]];
        [controller prepareToPlay];
        controller.movieSourceType = MPMovieSourceTypeFile;
        [self presentMoviePlayerViewControllerAnimated:controller];
    }
}
#pragma mark--音频事件
-(void)voicePauseAction{
    self.voiceButton.selected=!self.voiceButton.selected;
    if (self.voiceButton.selected) {
        [[EMClient sharedClient].callManager pauseVoiceWithSession:self.callSession.sessionId error:nil];
    }
    else{
        [[EMClient sharedClient].callManager resumeVoiceWithSession:self.callSession.sessionId error:nil];
    }
}
#pragma mark--视频事件
-(void)videoPauseAction{
    self.videoButton.selected=!self.videoButton.selected;
    if (self.videoButton.selected) {
        /********环信停止视频********/
        [[EMClient sharedClient].callManager pauseVideoWithSession:self.callSession.sessionId error:nil];
    }
    else{
        /********环信开始视频********/
        [[EMClient sharedClient].callManager resumeVideoWithSession:self.callSession.sessionId error:nil];
    }
}
#pragma mark--是否可以视频
+(BOOL)canVideo{
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"]!=NSOrderedAscending) {
        
        if (!([AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo]==AVAuthorizationStatusAuthorized)) {
            UIAlertView * alt = [[UIAlertView alloc] initWithTitle:@"No camera permissions" message:@"Please open in \"Setting\"-\"Privacy\"-\"Camera\"." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alt show];

            return NO;
        }
    }
    return YES;
}
#pragma mark--开始计时
-(void)startTimer{
    self.timeLength=0;
    self.callTimer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeTimerAction:) userInfo:nil repeats:YES];
}
#pragma mark--开始展示视频信息
-(void)showPropertyInfo{
    if (self.callSession.type==EMCallTypeVideo) {
        [self reloadPropertyData];
        self.propertyTimer=[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(reloadPropertyData) userInfo:nil repeats:YES];
    }
}
-(void)setNetWork:(EMCallNetworkStatus)status{
    switch (status) {
        case EMCallNetworkStatusNormal:
            self.netWorkLabel.text=@"";
            self.netWorkLabel.hidden=YES;
            break;
        case EMCallNetworkStatusNoData:
            self.netWorkLabel.text=@"没有通话数据";
            self.netWorkLabel.hidden=NO;
            break;
        case EMCallNetworkStatusUnstable:
            self.netWorkLabel.text=@"当前网络不稳定";
            self.netWorkLabel.hidden=NO;
            break;
            
        default:
            break;
    }

}
#pragma mark--结束通话释放对象
-(void)realease{
    self.callSession.remoteVideoView.hidden=YES;
    self.callSession=nil;
    self.propertyView=nil;
    if (self.callTimer) {
        [self.callTimer invalidate];
        self.callTimer=nil;
    }
    if (self.propertyTimer) {
        [self.propertyTimer invalidate];
        self.propertyTimer=nil;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [[AVAudioSession sharedInstance] setActive:NO error:nil];
        [self dismissViewControllerAnimated:YES completion:nil];
    });

}
@end
