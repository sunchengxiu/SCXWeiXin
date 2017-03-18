//
//  UIImage+imageCompress.h
//  聊天
//
//  Created by 孙承秀 on 16/10/23.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (imageCompress)
+ (UIImage*)imageCompressImage:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;
+ (UIImage *)image:(UIImage*)image scaledToSize:(CGSize)newSize;
@end
