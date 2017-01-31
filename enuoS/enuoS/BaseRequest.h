//
//  BaseRequest.h
//  ShiGuangJi
//
//  Created by luzhen on 16/8/15.
//  Copyright © 2016年 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

//请求成功Block
typedef void (^SuccessBlock)(NSURLSessionDataTask * task,id responseObject);

//请求失败Block
typedef void (^FailBlock)(NSURLSessionDataTask *task, NSError *error);

//上传或下载进度
typedef void (^ProgressBlock)(NSURLSessionDataTask *task,NSProgress *progress);

@interface BaseRequest : NSObject

//get 请求方法
- (void)GET:(NSString *)url params:(NSDictionary *)params success:(SuccessBlock)success fail:(FailBlock)fail;

//+ (void)GET:(NSString *)url baseURL:(NSString *)baseUrl
//     params:(NSDictionary *)params success:(SuccessBlock)success fail:(FailBlock)fail;

//post 请求方式
- (void)POST:(NSString *)url
      params:(NSDictionary *)params
     success:(SuccessBlock)success
        fail:(FailBlock)fail;

//+ (void)POST:(NSString *)url
//     baseURL:(NSString *)baseUrl
//      params:(NSDictionary *)params
//     success:(SuccessBlock)success
//        fail:(FailBlock)fail;

/**
 *  含有跟路径的上传文件
 *
 *  @param url      请求网址路径
 *  @param baseurl  请求网址根路径
 *  @param params   请求参数
 *  @param filedata 文件
 *  @param name     指定参数名
 *  @param filename 文件名（要有后缀名）
 *  @param mimeType 文件类型
 *  @param progress 上传进度
 *  @param success  成功回调
 *  @param fail     失败回调
 */
//+(void)uploadWithURL:(NSString *)url
//             baseURL:(NSString *)baseurl
//              params:(NSDictionary *)params
//            fileData:(NSData *)filedata
//                name:(NSString *)name
//            fileName:(NSString *)filename
//            mimeType:(NSString *) mimeType
//            progress:(ProgressBlock)progress
//             success:(SuccessBlock)success
//                fail:(FailBlock)fail;


/**
 *  下载文件
 *
 *  @param url      请求网络路径
 *  @param fileURL  保存文件url
 *  @param progress 下载进度
 *  @param success  成功回调
 *  @param fail     失败回调
 *
 *  @return 返回NSURLSessionDownloadTask实例，可用于暂停继续，暂停调用suspend方法，重新开启下载调用resume方法
 */
//+(NSURLSessionDownloadTask *)downloadWithURL:(NSString *)url
//                                 savePathURL:(NSURL *)fileURL
//                                    progress:(ProgressBlock )progress
//                                     success:(void (^)(NSURLResponse *, NSURL *))success
//                                        fail:(void (^)(NSError *))fail;


@end
