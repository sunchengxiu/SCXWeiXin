//
//  UIView+Tap.h
//  聊天
//
//  Created by 孙承秀 on 16/10/21.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Tap)
-(void)setTapGestureRecognizerWithActionBlock:(void (^) ())block;
@end
