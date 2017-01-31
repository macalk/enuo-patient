//
//  BaseRequest.m
//  ShiGuangJi
//
//  Created by luzhen on 16/8/15.
//  Copyright © 2016年 . All rights reserved.
//

#import "BaseRequest.h"

@implementation BaseRequest

//get 请求
- (void)GET:(NSString *)url params:(NSDictionary *)params
    success:(SuccessBlock)success fail:(FailBlock)fail{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        
        NSLog(@"chenggogng!!!");
        success(task,dic);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        fail(task,error);
        NSLog(@"shibai!!!");
        
    }];
    
}

//post 请求
- (void)POST:(NSString *)url params:(NSDictionary *)params success:(SuccessBlock)success fail:(FailBlock)fail {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSLog(@"chenggogng!!!");
        success(task,dic);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        fail(task,error);
        NSLog(@"shibai!!!");
        
    }];
    
}



@end
