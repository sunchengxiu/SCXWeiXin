//
//  SCXAnimation.m
//  聊天
//
//  Created by 孙承秀 on 16/9/9.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXAnimation.h"
#import "EMCDDeviceManager.h"
static UIImageView *voiceView;
@implementation SCXAnimation
+(void)playVoiceAinmationWithMessageLabel:(UILabel *)messageLabel andMessage:(EMMessage *)message andSenderOrReceive:(BOOL)boolReceive andImageView:(UIImageView *)imageView{
    if (voiceView) {
        [voiceView stopAnimating];
        [voiceView removeFromSuperview];
    }
    EMVideoMessageBody *video=(EMVideoMessageBody *)message.body;
    NSString *path=video.localPath;
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        path=video.remotePath;
    }
    [[EMCDDeviceManager sharedInstance] asyncPlayingWithPath:path completion:^(NSError *error) {
        if (!error) {
            NSLog(@"语音播放成功 ");
            [voiceView stopAnimating];
            [voiceView removeFromSuperview];
        }
    }];
    // 2. 添加动画
    // 2.1 创建一个UIImageView 添加到label上
    UIImageView *imgView = [[UIImageView alloc] init];
    [messageLabel addSubview:imgView];
    
    // 2.2添加动画图片
    if (boolReceive) {
        imgView.animationImages = @[[UIImage imageNamed:@"chat_receiver_audio_playing000"],
                                    [UIImage imageNamed:@"chat_receiver_audio_playing001"],
                                    [UIImage imageNamed:@"chat_receiver_audio_playing002"],
                                    [UIImage imageNamed:@"chat_receiver_audio_playing003"]];
        imgView.frame = CGRectMake(0, (messageLabel.frame.size.height-20)/2, 20, 20);
    } else {
        imgView.animationImages = @[[UIImage imageNamed:@"chat_sender_audio_playing_000"],
                                    [UIImage imageNamed:@"chat_sender_audio_playing_001"],
                                    [UIImage imageNamed:@"chat_sender_audio_playing_002"],
                                    [UIImage imageNamed:@"chat_sender_audio_playing_003"]];
        imgView.frame = CGRectMake(messageLabel.bounds.size.width - 20, (messageLabel.frame.size.height-20)/2, 20, 20);
    }
    imgView.animationDuration = 1;
    [imgView startAnimating];
    voiceView = imgView;

}
@end
