//
//  FileHelp.m
//  YUFileHelp
//
//  Created by yuzhx on 15/8/2.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "FileHelp.h"


#define TestFilePath [FileHelp createFileDirectories:[NSString stringWithFormat:@"%@/file",@"test"]]

@implementation FileHelp

/**
 * 文件名字修改 (默认在ZKFilePath 文件下操作)
 *
 * @param resourceFileName 原文件名
 *
 * @param name 新文件名
 *
 * @return (bool)
 **/
+(NSString*)modifyFileName:(NSString*)resourceFileName NewFileName:(NSString*)name
{
    NSFileManager*fileManager = [NSFileManager defaultManager];
    
    NSString*resource = [NSString stringWithFormat:@"%@/%@",TestFilePath,resourceFileName];
    
    NSString*NewName = [NSString stringWithFormat:@"%@/%@",TestFilePath,name];
    
    if([fileManager moveItemAtPath:resource
        
                            toPath:NewName
        
                             error:nil])
    {
        NSLog(@"成功修改文件名==%@",NewName);
        return NewName;
    }
    
    NSLog(@"文件名字修改失败");
    return nil;
}


/**
 * 单个文件的大小
 *
 * @param filePath 文件的路径
 *
 * @return 返回文件大小
 **/
+ (long long) fileSizeAtPath:(NSString*) filePath{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:filePath]){
        
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
    
}

/**
 *  遍历文件夹获得文件夹大小，
 *
 *  @param filePath 文件夹的的路径
 *
 *  @return 返回文件夹大小(多少M)
 */
+ (float ) folderSizeAtPath:(NSString*) folderPath{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if (![manager fileExistsAtPath:folderPath]) return 0;
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    
    NSString* fileName;
    
    long long folderSize = 0;
    
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
        
    }
    
    return folderSize/(1024.0*1024.0);
}

/**
 * 读取file里面的所有文件路径
 *
 * @return 返回所有文件属性dic
 **/
+ (NSMutableArray*)GetFilePathInDocumentsDir{
    
    NSMutableArray *fileArray = [[NSMutableArray alloc] init];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSDirectoryEnumerator *dirEnum = [fileManager enumeratorAtPath:TestFilePath];
    
    NSString *fileName;
    NSString *filePath;
    NSString *fileSize;
    NSString *fileDate;
    
    
    while (fileName = [dirEnum nextObject])
    {
        if(![fileName isEqualToString:@".DS_Store"])
        {
            
            filePath = [TestFilePath stringByAppendingPathComponent:fileName];
            
            NSDictionary *fileAttributes = [fileManager attributesOfItemAtPath:filePath error:nil];
            
            
            if ([fileAttributes objectForKey:NSFileSize])
            {
                fileSize = [fileAttributes objectForKey:NSFileSize];
            }
            
            if ([fileAttributes objectForKey:NSFileCreationDate])
            {
                fileDate = [fileAttributes objectForKey:NSFileCreationDate];
            }
            
            [fileArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                  fileName,@"fileName",
                                  filePath,@"filePath",
                                  fileSize,@"fileSize",
                                  fileDate,@"fileDate",
                                  nil]];
            
        }
    }
    return fileArray;
}

/**
 * 创建需要保存文件到Documents的目录
 *
 * @param Directories 文件夹名字
 *
 * @return 返回创建成功的文件夹路径
 **/
+ (NSString*)createFileDirectories:(NSString*)Directories{
    
    NSString *FilePath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
                          stringByAppendingPathComponent:Directories];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = FALSE;
    BOOL isDirExist = [fileManager fileExistsAtPath:FilePath isDirectory:&isDir];
    if(!(isDirExist && isDir))    {
        BOOL bCreateDir = [fileManager createDirectoryAtPath:FilePath withIntermediateDirectories:YES attributes:nil error:nil];
        if(!bCreateDir){
            NSLog(@"创建失败！");
        }
        NSLog(@"创建目录 FilePath%@",FilePath);
    }
    return FilePath;
}
/**
 * 创建需要保存文件到tmp的目录
 *
 * @param Directories 文件夹名字
 *
 * @return 返回创建成功的文件夹路径
 **/
+ (NSString*)createTempDirectories:(NSString*)Directories{
    
    NSString *FilePath = [[NSHomeDirectory() stringByAppendingPathComponent:@"tmp"]
                          stringByAppendingPathComponent:Directories];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = FALSE;
    BOOL isDirExist = [fileManager fileExistsAtPath:FilePath isDirectory:&isDir];
    if(!(isDirExist && isDir))    {
        BOOL bCreateDir = [fileManager createDirectoryAtPath:FilePath withIntermediateDirectories:YES attributes:nil error:nil];
        if(!bCreateDir){
            NSLog(@"创建失败！");
        }
        NSLog(@"创建目录 FilePath%@",FilePath);
    }
    return FilePath;
}


/**
 * 删除沙盒 文件or文件夹
 *
 * @param FilePath 需要删除的文件路径
 *
 * @return 返回操作结果(bool)
 **/
+ (BOOL)removeItemAtPath:(NSString*)FilePath{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL isRemove = [fileManager removeItemAtPath:FilePath error:nil];
    
    if (isRemove)
    {
        NSLog(@"删除文件==%@ ",FilePath);
        return YES;
    }
    
    NSLog(@"删除文件失败！");
    return NO;
}

@end
