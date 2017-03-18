//
//  SCXChatModel.m
//  聊天
//
//  Created by 孙承秀 on 16/10/26.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXChatModel.h"
#import "NSString+SCX_AttributeString.h"
@interface SCXChatModel()
/******  聊天内容 *****/
@property(nonatomic,copy)NSAttributedString *contentText;
/******  头像 *****/
@property(nonatomic,copy)UIImage *iconImage;
/******  userName *****/
@property(nonatomic,copy)NSString *userName;
/******  消息方向 *****/
@property(nonatomic,assign,getter=isIsMe)BOOL isMe;
/******  聊天信息背景图片 *****/
@property(nonatomic,strong)UIImage *contentImage;
/******  选中聊天背景图片 *****/
@property(nonatomic,strong)UIImage *contentSelectImage;
/******  消息种类 *****/
@property(nonatomic,assign)SCX_MessageBodyType messageType;
/******  详细大图 *****/
@property(nonatomic,strong)UIImage *largeImage;
/******  预览小图 *****/
@property(nonatomic,strong)UIImage *thumbImage;
/******  大图URL *****/
@property(nonatomic,copy)NSURL *lagerImageURL;
/******  小图URL *****/
@property(nonatomic,copy)NSURL *thumbURL;
/******  图片是横图还是竖图 *****/
@property(nonatomic,assign)BOOL imageIsVertical;
/******  图片是正方形 *****/
@property(nonatomic,assign)BOOL imageIsEqual;
/******  大图宽度 *****/
@property(nonatomic,assign)CGFloat largeImageWidth;
/******  大图高度 *****/
@property(nonatomic,assign)CGFloat largeImageHeight;
/******  小图宽度 *****/
@property(nonatomic,assign)CGFloat thumbImageWidth;
/******  小图高度 *****/
@property(nonatomic,assign)CGFloat thumbImageHeight;
@end
@implementation SCXChatModel
-(void)setMessage:(EMMessage *)message{
    _message=message;
    
    EMMessageBody *msgBody = message.body;
    self.messageType=(SCX_MessageBodyType)msgBody.type;
    NSString *currentUserName=[[EMClient sharedClient] currentUsername];
    if ([currentUserName isEqualToString:message.from]) {
        self.isMe=YES;
        self.contentImage=[UIImage imageNamed:@"SenderTextNodeBkg"];
        self.contentSelectImage=[UIImage imageNamed:@"SenderTextNodeBkgHL"];
        self.userName=currentUserName;
        self.iconImage=[UIImage imageNamed:@"xhr"];
    }
    else{
        self.isMe=NO;
        self.contentImage=[UIImage imageNamed:@"ReceiverTextNodeBkg"];
        self.contentSelectImage=[UIImage imageNamed:@"ReceiverAppNodeBkg_HL"];
        self.userName=message.from;
        self.iconImage=[UIImage imageNamed:@"0.jpg"];
    }
    switch (msgBody.type) {
        case EMMessageBodyTypeText:
        {
            // 收到的文字消息
            EMTextMessageBody *textBody = (EMTextMessageBody *)msgBody;
            NSString *txt = textBody.text;
            self.contentText=[NSString SCX_getAttributeStringWithString:txt];
            NSLog(@"收到的文字是 txt -- %@",txt);
        }
            break;
        case EMMessageBodyTypeImage:
        {
            // 得到一个图片消息body
            EMImageMessageBody *body = ((EMImageMessageBody *)msgBody);
            NSLog(@"大图remote路径 -- %@"   ,body.remotePath);
            NSLog(@"大图local路径 -- %@"    ,body.localPath); // // 需要使用sdk提供的下载方法后才会存在
            NSLog(@"大图的secret -- %@"    ,body.secretKey);
            NSLog(@"大图的W -- %f ,大图的H -- %f",body.size.width,body.size.height);
            NSLog(@"大图的下载状态 -- %u",body.downloadStatus);
            /**
             *  大图
             */
            if ([[NSFileManager defaultManager] fileExistsAtPath:body.localPath]) {
                self.largeImage=[UIImage imageWithContentsOfFile:body.localPath];
            }
            else{
                self.lagerImageURL=[NSURL URLWithString:body.remotePath];
            }
            self.largeImageWidth=body.size.width;
            self.largeImageHeight=body.size.height;
            
            // 缩略图sdk会自动下载
            NSLog(@"小图remote路径 -- %@"   ,body.thumbnailRemotePath);
            NSLog(@"小图local路径 -- %@"    ,body.thumbnailLocalPath);
            NSLog(@"小图的secret -- %@"    ,body.thumbnailSecretKey);
            NSLog(@"小图的W -- %f ,大图的H -- %f",body.thumbnailSize.width,body.thumbnailSize.height);
            NSLog(@"小图的下载状态 -- %u",body.thumbnailDownloadStatus);
            if ([[NSFileManager defaultManager] fileExistsAtPath:body.thumbnailLocalPath]) {
                self.thumbImage=[UIImage imageWithContentsOfFile:body.thumbnailLocalPath];
            }
            else{
                
                self.thumbURL=[NSURL URLWithString:body.thumbnailRemotePath];
                
            }
            self.imageIsVertical=self.thumbImage.size.width>self.thumbImage.size.height;
            if (self.thumbImage.size.width==self.thumbImage.size.height) {
                NSLog(@"%f---%f",body.thumbnailSize.width,body.thumbnailSize.height);
                self.imageIsEqual=YES;
            }
            else{
                self.imageIsEqual=NO;
            }
            if (body.thumbnailSize.width==0) {
                if (body.size.width!=0) {
                    
                    self.imageIsVertical=body.size.width>body.size.height;
                    if (body.size.width==body.size.height) {
                    
                        self.imageIsEqual=YES;
                    }
                    else{
                        self.imageIsEqual=NO;
                    }

                }
            }
            if (body.thumbnailSize.width) {
                self.thumbImageWidth=body.thumbnailSize.width;
                self.thumbImageHeight=body.thumbnailSize.height;
            }
            if (body.size.width) {
                self.largeImageWidth=body.size.width;
                self.largeImageHeight=body.size.height;
            }
            
        }
            break;
        case EMMessageBodyTypeLocation:
        {
            EMLocationMessageBody *body = (EMLocationMessageBody *)msgBody;
            NSLog(@"纬度-- %f",body.latitude);
            NSLog(@"经度-- %f",body.longitude);
            NSLog(@"地址-- %@",body.address);
        }
            break;
        case EMMessageBodyTypeVoice:
        {
            // 音频sdk会自动下载
            EMVoiceMessageBody *body = (EMVoiceMessageBody *)msgBody;
            NSLog(@"音频remote路径 -- %@"      ,body.remotePath);
            NSLog(@"音频local路径 -- %@"       ,body.localPath); // 需要使用sdk提供的下载方法后才会存在（音频会自动调用）
            NSLog(@"音频的secret -- %@"        ,body.secretKey);
            NSLog(@"音频文件大小 -- %lld"       ,body.fileLength);
            NSLog(@"音频文件的下载状态 -- %u"   ,body.downloadStatus);
            NSLog(@"音频的时间长度 -- %u"      ,body.duration);
            if (body.duration<=1) {
                self.voiceWidth=100;
            }
            else{
                self.voiceWidth=100+body.duration*5;
                if (self.voiceWidth>300) {
                    self.voiceWidth=300;
                }
            }
            self.voiceHeight=50;
        }
            break;
        case EMMessageBodyTypeVideo:
        {
            EMVideoMessageBody *body = (EMVideoMessageBody *)msgBody;
            
            NSLog(@"视频remote路径 -- %@"      ,body.remotePath);
            NSLog(@"视频local路径 -- %@"       ,body.localPath); // 需要使用sdk提供的下载方法后才会存在
            NSLog(@"视频的secret -- %@"        ,body.secretKey);
            NSLog(@"视频文件大小 -- %lld"       ,body.fileLength);
            NSLog(@"视频文件的下载状态 -- %u"   ,body.downloadStatus);
            NSLog(@"视频的时间长度 -- %u"      ,body.duration);
            NSLog(@"视频的W -- %f ,视频的H -- %f", body.thumbnailSize.width, body.thumbnailSize.height);
            
            // 缩略图sdk会自动下载
            NSLog(@"缩略图的remote路径 -- %@"     ,body.thumbnailRemotePath);
            NSLog(@"缩略图的local路径 -- %@"      ,body.thumbnailLocalPath);
            NSLog(@"缩略图的secret -- %@"        ,body.thumbnailSecretKey);
            NSLog(@"缩略图的下载状态 -- %u"      ,body.thumbnailDownloadStatus);
        }
            break;
        case EMMessageBodyTypeFile:
        {
            EMFileMessageBody *body = (EMFileMessageBody *)msgBody;
            NSLog(@"文件remote路径 -- %@"      ,body.remotePath);
            NSLog(@"文件local路径 -- %@"       ,body.localPath); // 需要使用sdk提供的下载方法后才会存在
            NSLog(@"文件的secret -- %@"        ,body.secretKey);
            NSLog(@"文件文件大小 -- %lld"       ,body.fileLength);
            NSLog(@"文件文件的下载状态 -- %u"   ,body.downloadStatus);
        }
            break;
            
        default:
            break;
    }
}
@end
