//
//  SCXAnimation.h
//  聊天
//
//  Created by 孙承秀 on 16/9/9.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMMessage.h"
#import "EMSDK.h"
@interface SCXAnimation : NSObject
+(void)playVoiceAinmationWithMessageLabel:(UILabel *)messageLabel andMessage:(EMMessage *)message andSenderOrReceive:(BOOL)boolReceive andImageView:(UIImageView *)imageView;

@end
