//
//  SCXSendTableViewCell.m
//  聊天
//
//  Created by 孙承秀 on 16/9/1.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXSendTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "SCXAnimation.h"
#import "SCXButton.h"
#import "NSString+SCX_AttributeString.h"
#import "EMCDDeviceManager.h"
static UIImageView *animationView;
@implementation SCXSendTableViewCell

- (void)awakeFromNib {
   
    // Initialization code
   
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
    }
    return self;
}



-(void)tapGesture:(UITapGestureRecognizer *)tap{
    if (self.message.body.type==EMMessageBodyTypeVoice) {
        BOOL receiver = [self.reuseIdentifier isEqualToString:@"receiveCell"];
       
        [SCXAnimation playVoiceAinmationWithMessageLabel:_contentButton andMessage:self.message andSenderOrReceive:receiver andImageView:nil];
    }

}
#pragma mark--配置数据
-(void)setChatFrmae:(SCXChatFrame *)chatFrmae{
    
    _chatFrmae=chatFrmae;
    SCXChatModel *model=chatFrmae.chatModel;
    [self.voiceImageView removeFromSuperview];
    self.voiceImageView=nil;
    [self.iconImageView removeFromSuperview];
    self.iconImageView=nil;
    [self.contentButton removeFromSuperview];
    self.contentButton=nil;
    [self.contentImageView removeFromSuperview];
    self.contentImageView=nil;
     self.iconImageView.image=model.iconImage;
    [self.contentButton setBackgroundImage:[model.contentImage stretchableImageWithLeftCapWidth:21 topCapHeight:34] forState:UIControlStateNormal];
    [self.contentButton setBackgroundImage:[model.contentSelectImage resizableImageWithCapInsets:UIEdgeInsetsMake(SCX_EdgeTop, SCX_EdgeTLeft, SCX_EdgeBottom, SCX_EdgeRight)] forState:UIControlStateSelected];
    self.contentButton.contentEdgeInsets=UIEdgeInsetsMake(SCX_EdgeTop-5, SCX_EdgeTLeft, SCX_EdgeBottom, SCX_EdgeRight);
   
    switch (model.messageType) {
        case SCX_MessageBodyTypeText:
        {
            
            [self.contentButton setAttributedTitle:model.contentText forState:UIControlStateNormal];
            if (self.chatFrmae.chatModel.isMe) {
                self.contentButton.contentEdgeInsets=UIEdgeInsetsMake(SCX_EdgeTop, SCX_EdgeTLeft, 0, SCX_EdgeRight);
            }
           
            if (chatFrmae.chatModel.isMe) {
                self.contentButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
                self.contentButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
            }
            else{
                self.contentButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
                self.contentButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
            }
        }
            break;
        case SCX_MessageBodyTypeImage:
        {
            if (model.thumbImage||model.largeImage) {
                if (model.thumbImage) {
                    [self.contentImageView setImage:self.chatFrmae.chatModel.thumbImage];
                }
                else{
                    [self.contentImageView setImage:self.chatFrmae.chatModel.largeImage];
                }
                
            }
            else{
                [self.contentImageView setBackgroundColor:[UIColor whiteColor]];
                [self.contentImageView sd_setImageWithURL:model.thumbURL placeholderImage:nil options:SDWebImageProgressiveDownload progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                    NSLog(@"下载了： %ld",receivedSize);
                    
                } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    
                }];
            }
            
        }
            break;
        case SCX_MessageBodyTypeVideo:
        {
            
        }
            break;
        case SCX_MessageBodyTypeVoice:
        {
            [self.contentButton addTarget:self action:@selector(playVoice:) forControlEvents:UIControlEventTouchUpInside];
            //[self.contentButton setImage:[UIImage imageNamed:@"SenderVoiceNodePlaying003"] forState:UIControlStateNormal];
            [self.contentButton addSubview:self.voiceImageView];
            if (!self.chatFrmae.chatModel.isMe) {
                self.voiceImageView.frame = CGRectMake(15, 8, 25, 25);
                self.voiceImageView.image=[UIImage imageNamed:@"chat_receiver_audio_playing_full"];
            }
            else{
                self.voiceImageView.frame=CGRectMake(self.chatFrmae.contentFrame.size.width-35, 8, 25, 25);
                self.voiceImageView.image=[UIImage imageNamed:@"chat_sender_audio_playing_full"];
            }
            
        }
            break;
        case SCX_MessageBodyTypeFile:
        {
            
        }
            break;
        case SCX_MessageBodyTypeCmd:
        {
            
        }
            break;
        case SCX_MessageBodyTypeLocation:
        {
            
        }
            break;
            
        default:
            break;
    }

}
#pragma mark--懒加载
-(UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView=[[UIImageView alloc]init];
        [_iconImageView setBackgroundColor:[UIColor redColor]];
        [self.contentView addSubview:_iconImageView];
    }
    return _iconImageView;
}
-(SCXButton *)contentButton{
    if (!_contentButton) {
        _contentButton=[[SCXButton alloc]init];
       // [self.contentButton setBackgroundColor:[UIColor blueColor]];
        [self.contentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.contentButton.titleLabel.numberOfLines=0;
        [self.contentView addSubview:_contentButton];
    }
    return _contentButton;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.iconImageView.frame=self.chatFrmae.iconFrame;
    self.contentButton.frame=self.chatFrmae.contentFrame;
    if (self.chatFrmae.chatModel.messageType==SCX_MessageBodyTypeImage) {
        CGRect frame= self.chatFrmae.contentFrame;
        self.contentImageView.frame=CGRectMake(frame.origin.x+10, frame.origin.y+10, frame.size.width-20, frame.size.height-30);
        
    }
}

-(UIImageView *)contentImageView{
    if (!_contentImageView) {
        _contentImageView=[[UIImageView alloc]init];
        [self.contentView addSubview:_contentImageView];
    }
    return _contentImageView;
}
-(UIImageView *)voiceImageView{
    if (_voiceImageView==nil) {
        _voiceImageView=[[UIImageView alloc]init];
        
    }
    return _voiceImageView;
    
}
-(void)playVoice:(UIButton *)btn{
    
    [animationView stopAnimating];
    [animationView removeFromSuperview];
    animationView=[[UIImageView alloc]init];
    [self.contentButton addSubview:animationView];
    EMVoiceMessageBody *body=(EMVoiceMessageBody *)self.chatFrmae.chatModel.message.body;
    NSString *path=body.localPath;
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        path=body.remotePath;
    }
    [[EMCDDeviceManager sharedInstance] asyncPlayingWithPath:path completion:^(NSError *error) {
        if (!error) {
            NSLog(@"播放成功");
        }
        else{
            NSLog(@"播放失败");
            NSLog(@"%@",error);
        }
        [animationView stopAnimating];
        [animationView removeFromSuperview];
    }];
    [self.contentButton addSubview:animationView];
    if (!self.chatFrmae.chatModel.isMe) {
        animationView.animationImages= @[[UIImage imageNamed:@"chat_receiver_audio_playing000"],
                                    [UIImage imageNamed:@"chat_receiver_audio_playing001"],
                                    [UIImage imageNamed:@"chat_receiver_audio_playing002"],
                                    [UIImage imageNamed:@"chat_receiver_audio_playing003"]];
        animationView.frame = CGRectMake(15, 8, 25, 25);
        
    } else {
        animationView.animationImages = @[[UIImage imageNamed:@"chat_sender_audio_playing_000"],
                                    [UIImage imageNamed:@"chat_sender_audio_playing_001"],
                                    [UIImage imageNamed:@"chat_sender_audio_playing_002"],
                                    [UIImage imageNamed:@"chat_sender_audio_playing_003"]];
        animationView.frame=CGRectMake(self.chatFrmae.contentFrame.size.width-35, 8, 25, 25);
    }
    animationView.animationDuration=1;
    [animationView startAnimating];
    NSLog(@"播放语音");
}
@end
