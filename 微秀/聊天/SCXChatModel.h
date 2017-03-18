//
//  SCXChatModel.h
//  聊天
//
//  Created by 孙承秀 on 16/10/26.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIImageView+WebCache.h>
typedef NS_ENUM(NSInteger,SCX_MessageBodyType) {
    SCX_MessageBodyTypeText = EMMessageBodyTypeText,    /*! \~chinese 文本类型 \~english Text */
    SCX_MessageBodyTypeImage = EMMessageBodyTypeImage,         /*! \~chinese 图片类型 \~english Image */
    SCX_MessageBodyTypeVideo =EMMessageBodyTypeVideo,         /*! \~chinese 视频类型 \~english Video */
    SCX_MessageBodyTypeLocation =EMMessageBodyTypeLocation,      /*! \~chinese 位置类型 \~english Location */
    SCX_MessageBodyTypeVoice =EMMessageBodyTypeVoice,         /*! \~chinese 语音类型 \~english Voice */
    SCX_MessageBodyTypeFile =EMMessageBodyTypeFile,          /*! \~chinese 文件类型 \~english File */
    SCX_MessageBodyTypeCmd =EMMessageBodyTypeCmd,           /*! \~chinese 命令类型 \~english Command */


};
@interface SCXChatModel : NSObject
/******  消息 *****/
@property(nonatomic,strong)EMMessage *message;
/******  聊天内容 *****/
@property(nonatomic,copy,readonly)NSAttributedString *contentText;
/******  头像 *****/
@property(nonatomic,copy,readonly)UIImage *iconImage;
/******  userName *****/
@property(nonatomic,copy,readonly)NSString *userName;
/******  消息方向 *****/
@property(nonatomic,assign,getter=isIsMe,readonly)BOOL isMe;
/******  聊天信息背景图片 *****/
@property(nonatomic,strong,readonly)UIImage *contentImage;
/******  选中聊天背景图片 *****/
@property(nonatomic,strong,readonly)UIImage *contentSelectImage;

/******  消息种类 *****/
@property(nonatomic,assign,readonly)SCX_MessageBodyType messageType;
/******  详细大图 *****/
@property(nonatomic,strong,readonly)UIImage *largeImage;
/******  预览小图 *****/
@property(nonatomic,strong,readonly)UIImage *thumbImage;
/******  大图URL *****/
@property(nonatomic,copy,readonly)NSURL *lagerImageURL;
/******  小图URL *****/
@property(nonatomic,copy,readonly)NSURL *thumbURL;
/******  图片是横图还是竖图 *****/
@property(nonatomic,assign,readonly)BOOL imageIsVertical;
/******  图片是正方形 *****/
@property(nonatomic,assign,readonly)BOOL imageIsEqual;
/******  大图宽度 *****/
@property(nonatomic,assign,readonly)CGFloat largeImageWidth;
/******  大图高度 *****/
@property(nonatomic,assign,readonly)CGFloat largeImageHeight;
/******  小图宽度 *****/
@property(nonatomic,assign,readonly)CGFloat thumbImageWidth;
/******  小图高度 *****/
@property(nonatomic,assign,readonly)CGFloat thumbImageHeight;
/******  语音长度 *****/
@property(nonatomic,assign)CGFloat voiceWidth;
/******  语音宽度 *****/
@property(nonatomic,assign)CGFloat voiceHeight;
@end
