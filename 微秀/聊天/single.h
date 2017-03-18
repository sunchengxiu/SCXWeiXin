//
//  single.h
//  聊天
//
//  Created by 孙承秀 on 16/10/20.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#ifndef single_h
#define single_h
#pragma mark--单例
#define singleH(name) +(instancetype)shared##name;
#define singleM(name)\
static id singViewController=nil;\
+(instancetype)shared##name{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
singViewController=[[self allocWithZone:NULL]init];\
});\
return singViewController;\
}

#endif /* single_h */
