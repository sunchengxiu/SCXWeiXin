//
//  UIImageView+SCXBaseImageView.m
//  聊天
//
//  Created by 孙承秀 on 16/10/28.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "UIImageView+SCXBaseImageView.h"
#import <objc/runtime.h>
static const char *SCXTapGestureKey;
static const char *SCXHandleBlockKey;
@implementation UIImageView (SCXBaseImageView)
-(void)setTapGestureRecognizerWithActionBlock:(void (^) ())block{
    self.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap=objc_getAssociatedObject(self, SCXTapGestureKey);
    if (!tap) {
        tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureHandle:)];
        [self addGestureRecognizer:tap];
        objc_setAssociatedObject(self, SCXTapGestureKey, tap, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    objc_setAssociatedObject(self, SCXHandleBlockKey, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)tapGestureHandle:(UITapGestureRecognizer *)tap{
    /*
     // 没有触摸事件发生，所有手势识别的默认状态
     UIGestureRecognizerStatePossible,
     // 一个手势已经开始但尚未改变或者完成时
     UIGestureRecognizerStateBegan,
     // 手势状态改变
     UIGestureRecognizerStateChanged,
     // 手势完成
     UIGestureRecognizerStateEnded,
     // 手势取消，恢复至Possible状态
     UIGestureRecognizerStateCancelled,
     // 手势失败，恢复至Possible状态
     UIGestureRecognizerStateFailed,
     // 识别到手势识别
     UIGestureRecognizerStateRecognized = UIGestureRecognizerStateEnded
     */
    if (tap.state==UIGestureRecognizerStateRecognized) {
        void (^handle)()=objc_getAssociatedObject(self, SCXHandleBlockKey);
        if (handle) {
            handle();
        }
    }
    
    
}
@end
