//
//  UIButton+SCX_AddGesture.h
//  聊天
//
//  Created by 孙承秀 on 16/10/26.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (SCX_AddGesture)
-(void)SCX_ButtonAddLongGestureWithHandleBlock:(void (^)())handleBlock;
@end
