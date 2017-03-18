//
//  SCXChatFrame.m
//  聊天
//
//  Created by 孙承秀 on 16/10/26.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXChatFrame.h"
@interface SCXChatFrame()
/******  iconFrame *****/
@property(nonatomic,assign)CGRect iconFrame;
/******  名字Frame *****/
@property(nonatomic,assign)CGRect nameFrame;
/******  contentFrame *****/
@property(nonatomic,assign)CGRect contentFrame;
/******  cellHeigth *****/
@property(nonatomic,assign)CGFloat cellHeight;
@end
@implementation SCXChatFrame
-(void)setChatModel:(SCXChatModel *)chatModel{
    _chatModel=chatModel;
    /**
     *  头像Frame
     */
    CGFloat iconX;
    CGFloat iconY;
    CGFloat iconW;
    CGFloat iconH;
    /**
     *  名字Frame
     */
    CGFloat nameX;
    CGFloat nameY;
    CGFloat nameW;
    CGFloat nameH;
    
    /**
     *  聊天内容Frame
     */
    CGFloat contentX;
    CGFloat contentY;
    CGFloat contentW;
    CGFloat contentH;
   
    if (chatModel.isMe) {
        iconX=(SCX_ScreenWidth-SCX_MinMargin-SCX_IconWidth);
        
    }
    else{
        iconX=SCX_MinMargin;
        
    }
    iconY=SCX_MinMargin;
    iconW=SCX_IconWidth;
    iconH=SCX_IconWidth;
    self.iconFrame=CGRectMake(iconX, iconY, iconW, iconH);
    
    NSAttributedString *text=chatModel.contentText;
    CGFloat maxW=SCX_ScreenWidth-2*(SCX_MinMargin+SCX_IconWidth)-2*SCX_MinMargin;
    //NSString *str=[NSString alloc]initwitharr;
    //CGSize size=[text boundingRectWithSize:CGSizeMake(maxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
    CGRect size=[text boundingRectWithSize:CGSizeMake(maxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    if (size.size.width<maxW-SCX_EdgeTLeft-SCX_EdgeRight) {
        size.size.height=25;
    }
    if (chatModel.isMe) {
        contentX=iconX-size.size.width-SCX_MinMargin-SCX_EdgeTLeft-SCX_EdgeRight;
    }
    else{
        contentX=iconX+SCX_MinMargin+SCX_IconWidth;
    }
    contentY=iconY;
    contentW=size.size.width+SCX_EdgeTLeft+SCX_EdgeRight;
    contentH=size.size.height+SCX_EdgeTop+SCX_EdgeBottom;
    if (chatModel.isMe) {
        
    }
   
    switch (chatModel.messageType) {
        case SCX_MessageBodyTypeText:
        {
            
        }
            break;
        case SCX_MessageBodyTypeImage:
        {
            //适配大小
            //如果是横图
            if (chatModel.imageIsVertical) {
                contentW=200+SCX_EdgeTLeft+SCX_EdgeRight;
                
                //横图的话就让长度固定
                if (chatModel.thumbImageWidth) {
                    
                    contentH=contentW/chatModel.thumbImageWidth*chatModel.thumbImageHeight;
                    if (contentH<100) {
                        contentH=100;
                    }
                }
                else if (chatModel.largeImageWidth){
                  
                    contentH=contentW/chatModel.largeImageWidth*chatModel.largeImageHeight;
                    if (contentH<100) {
                        contentH=100;
                    }
                }
                else{
                    contentH=100;
                }
            }
            else{
                contentH=200;
                if (chatModel.thumbImageWidth) {
                    
                    contentW=contentH/chatModel.thumbImageHeight*chatModel.thumbImageWidth+SCX_EdgeTLeft+SCX_EdgeRight;
                    if (contentW<100) {
                        contentW=100;
                    }
                }
                else if (chatModel.largeImageWidth){
                 contentW=contentH/chatModel.largeImageHeight*chatModel.largeImageWidth+SCX_EdgeTLeft+SCX_EdgeRight;
                    if (contentW<100) {
                        contentW=100;
                    }
                }
                else{
                    contentW=100+SCX_EdgeTLeft+SCX_EdgeRight;
                }
            }
            if (chatModel.imageIsEqual) {
                if (chatModel.thumbImageWidth<200) {
                    contentW=chatModel.thumbImageWidth+SCX_EdgeTLeft+SCX_EdgeRight;
                    if (contentW<100) {
                        contentW=100;
                    }
                    contentH=contentW;
                }
                else if (chatModel.largeImageWidth<200){
                    contentW=chatModel.largeImageWidth+SCX_EdgeTLeft+SCX_EdgeRight;
                    if (contentW<100) {
                        contentW=100;
                    }
                    contentW=contentH;
                }
                else{
                    contentW=200+SCX_EdgeTLeft+SCX_EdgeRight;
                    contentH=200+SCX_EdgeTLeft+SCX_EdgeRight;
                }
            }
            if (chatModel.isMe) {
                contentX=iconX-SCX_MinMargin*2-contentW;
            }
            else{
                contentX=iconX+SCX_MinMargin+SCX_IconWidth;
            }
            
        }
            break;
        case SCX_MessageBodyTypeVideo:
        {
            
        }
            break;
        case SCX_MessageBodyTypeVoice:
        {
            
            contentH=chatModel.voiceHeight;
            contentW=chatModel.voiceWidth;
            if (chatModel.isMe) {
                contentX=iconX-SCX_MinMargin*2-contentW;
            }
            else{
                contentX=iconX+SCX_MinMargin+SCX_IconWidth;
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
     self.contentFrame=CGRectMake(contentX, contentY, contentW, contentH);
    self.cellHeight=(contentH>iconH)?CGRectGetMaxY(self.contentFrame)+SCX_MinMargin:(CGRectGetMaxY(self.iconFrame)+SCX_MinMargin);
    
}

@end
