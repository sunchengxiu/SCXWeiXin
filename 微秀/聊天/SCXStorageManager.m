//
//  SCXStorageManager.m
//  聊天
//
//  Created by 孙承秀 on 16/10/21.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "SCXStorageManager.h"

@implementation SCXStorageManager
#pragma mark--归档
+(BOOL)archiveObject:(id)object withFileName:(NSString *)fileName{
    NSString *filePath=[self setAimFilePathFromCachesPath:fileName];
    filePath=[filePath stringByAppendingString:@".archive"];
    BOOL success=[NSKeyedArchiver archiveRootObject:object toFile:filePath];
    return success;

}
#pragma mark - 接档
+(id)unArchiveObjectWithFileName:(NSString *)fileName{
    NSString *filePath=[self setAimFilePathFromCachesPath:fileName];
    filePath = [filePath stringByAppendingString:@".archive"];
    id obj=[NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    return  obj;
}
#pragma mark - 删除沙盒中存档的文件
+(void)removeArchiveWithFileName:(NSString *)fileName{
    NSString *filePath=[self setAimFilePathFromCachesPath:fileName];
    filePath=[filePath stringByAppendingString:@".archive"];
    [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
}
#pragma mark--创建存储在沙盒中的路径
+(NSString *)setAimFilePathFromCachesPath:(NSString *)fileName{
    NSString *cachesPath=NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath=[NSString stringWithFormat:@"%@/%@",cachesPath,fileName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    return filePath;
}
#pragma mark - 设置用户偏好设置
+(void)setObject:(id)object ForKey:(NSString *)key{
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(id)objectForKey:(NSString *)key{
    id obj=[[NSUserDefaults standardUserDefaults] objectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return obj;
}

@end
