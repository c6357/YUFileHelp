# YUFileHelp
#import <Foundation/Foundation.h>

@interface FileHelp : NSObject

typedef void (^FileObjectBlock)(NSString* m_filePath,BOOL StatusCode);

/**
 * 文件名字修改 (默认在ZKFilePath 文件下操作)
 *
 * @param resourceFileName 原文件名
 *
 * @param name 新文件名
 *
 * @return (bool)
 **/
+(NSString*)modifyFileName:(NSString*)resourceFileName NewFileName:(NSString*)name;



/**
 * 获取单个文件的大小
 *
 * @param filePath 文件的路径
 *
 * @return 返回文件大小
 **/
+(long long) fileSizeAtPath:(NSString*) filePath;



/**
 *  遍历文件夹获得文件夹大小，
 *
 *  @param filePath 文件夹的的路径
 *
 *  @return 返回文件夹大小(多少M)
 */
+ (float ) folderSizeAtPath:(NSString*) folderPath;



/**
 * 读取file里面的所有文件路径
 *
 * @return 返回所有文件属性dic
 **/
+ (NSMutableArray*)GetFilePathInDocumentsDir;



/**
 * 创建需要保存文件到Documents的目录
 *
 * @param Directories 文件夹名字
 *
 * @return 返回创建成功的文件夹路径
 **/
+ (NSString*)createFileDirectories:(NSString*)Directories;



/**
 * 创建需要保存文件到tmp的目录
 *
 * @param Directories 文件夹名字
 *
 * @return 返回创建成功的文件夹路径
 **/
+ (NSString*)createTempDirectories:(NSString*)Directories;



/**
 * 删除沙盒 文件or文件夹
 *
 * @param FilePath 需要删除的文件路径
 *
 * @return 返回操作结果(bool)
 **/
+ (BOOL)removeItemAtPath:(NSString*)FilePath;
