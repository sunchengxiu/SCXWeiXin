//
//  UIButton+SCX_AddGesture.m
//  聊天
//
//  Created by 孙承秀 on 16/10/26.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "UIButton+SCX_AddGesture.h"
#import <objc/runtime.h>
static const char *SCX_buttonLongGesKey;
static const char *SCX_buttonHandleBlockKey;
@implementation UIButton (SCX_AddGesture)
-(void)SCX_ButtonAddLongGestureWithHandleBlock:(void (^)())handleBlock{
    UILongPressGestureRecognizer *longGes=objc_getAssociatedObject(self, SCX_buttonLongGesKey);
    if (!longGes) {
        longGes=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longGesHandle:)];
        objc_setAssociatedObject(self, SCX_buttonLongGesKey, longGes, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self addGestureRecognizer:longGes];
    }
    objc_setAssociatedObject(self, SCX_buttonHandleBlockKey, handleBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(void)longGesHandle:(UILongPressGestureRecognizer *)longGes{
    
    if (longGes.state==UIGestureRecognizerStateRecognized) {
        void (^block)()=objc_getAssociatedObject(self, SCX_buttonHandleBlockKey);
        if (block) {
            block();
        }
    }
}
@end
