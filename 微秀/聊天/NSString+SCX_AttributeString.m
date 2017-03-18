//
//  NSString+SCX_AttributeString.m
//  聊天
//
//  Created by 孙承秀 on 16/10/26.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "NSString+SCX_AttributeString.h"

@implementation NSString (SCX_AttributeString)
+(NSAttributedString *)SCX_getAttributeStringWithString:(NSString *)string{
    NSMutableAttributedString *mutiAttStr=[[NSMutableAttributedString alloc]initWithString:string];
    NSRange range=NSMakeRange(0, string.length);
    [mutiAttStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:range];
    [mutiAttStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
    NSMutableParagraphStyle *style=[[NSMutableParagraphStyle alloc]init];
    style.lineSpacing=5;
    [mutiAttStr addAttribute:NSParagraphStyleAttributeName value:style range:range];
    return mutiAttStr;
}
@end
