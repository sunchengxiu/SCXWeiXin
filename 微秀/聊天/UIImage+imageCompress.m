//
//  UIImage+imageCompress.m
//  聊天
//
//  Created by 孙承秀 on 16/10/23.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "UIImage+imageCompress.h"

@implementation UIImage (imageCompress)
//压缩图片
+ (UIImage *)image:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}
// 图片剪切

+ (UIImage*)clipImageWithImage:(UIImage*)image inRect:(CGRect)rect {
    
    CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    
    UIGraphicsBeginImageContext(image.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextDrawImage(context, rect, imageRef);
    
    UIImage* clipImage = [UIImage imageWithCGImage:imageRef];
    
    //    CGImageCreateWithImageInRect(CGImageRef  _Nullable image, <#CGRect rect#>)
    
    //    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();      // 不同的方式
    
    UIGraphicsEndImageContext();
    
    //    NSData* data = [NSData dataWithData:UIImagePNGRepresentation(clipImage)];
    
    //    BOOL flag = [data writeToFile:@"/Users/gua/Desktop/Image/后.png" atomically:YES];
    
    //    GGLogDebug(@"========压缩后=======%@",clipImage);
    
    return clipImage;
    
}

// 图片压缩

+ (UIImage*)imageCompressImage:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth {
    
    CGSize imageSize = sourceImage.size;
    
    CGFloat width = imageSize.width;
    
    CGFloat height = imageSize.height;
    
    CGFloat targetWidth = defineWidth;
    
    CGFloat targetHeight = (targetWidth / width) * height;
    
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    
    [sourceImage drawInRect:CGRectMake(0,0,targetWidth, targetHeight)];
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

@end
