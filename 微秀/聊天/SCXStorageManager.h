//
//  SCXStorageManager.h
//  聊天
//
//  Created by 孙承秀 on 16/10/21.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCXStorageManager : NSObject

/**
 归档

 @param object   归档对象
 @param fileName 归档路径
 */
+(BOOL)archiveObject:(id)object withFileName:(NSString *)fileName;

/**
 解档

 @param fileName 解档路径

 @return 返回解档得到的数据
 */
+(id)unArchiveObjectWithFileName:(NSString *)fileName;

/**
 从沙盒中删除存档的内容

 @param fileName 沙盒路径
 */
+(void)removeArchiveWithFileName:(NSString *)fileName;

/**
 设置目的存储路径

 @param fileName 目的路径

 @return 返回目的完整存储路径
 */
+(NSString *)setAimFilePathFromCachesPath:(NSString *)fileName;

/**
 设置用户偏好设置

 @param object 偏好设置
 @param key    key
 */
+(void)setObject:(id)object ForKey:(NSString *)key;

/**
 取出用户偏好设置

 @param key key

 @return 用户偏好设置
 */
+(id)objectForKey:(NSString *)key;
@end
