//
//  ALiPayModel.m
//  enuoS
//
//  Created by apple on 16/11/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ALiPayModel.h"

@implementation ALiPayModel

- (NSString *)description {
    
//    if (self.app_id) {
//        [discription appendFormat:@"app_id=%@&", self.app_id];
//    }
//
//    if (self.passback_params) {
//        [discription appendFormat:@"passback_params=%@", self.passback_params];
//    }
//    
//    if (self.charset) {
//        [discription appendFormat:@"&charset=%@", self.charset];
//    }
//    if (self.method) {
//        [discription appendFormat:@"&method=%@", self.method];
//    }
//    if (self.notify_url) {
//        [discription appendFormat:@"&notify_url=%@", self.notify_url];
//    }
//    
//    if (self.sign_type) {
//        [discription appendFormat:@"&sign_type=%@", self.sign_type];
//    }
//    if (self.timestamp) {
//        [discription appendFormat:@"&timestamp=%@", self.timestamp];
//    }
//    if (self.version) {
//        [discription appendFormat:@"&version=%@", self.version];
//    }
    
    NSMutableString * discription = [NSMutableString string];

    
    if (self.biz_content) {
        [discription appendFormat:@"{%@}", [self biz]];
    }
    
    return discription;
    
}

- (NSString *)biz {
    NSMutableString *biz = [NSMutableString string];
    for (NSString * key in [self.biz_content allKeys]) {
        [biz appendFormat:@",\"%@\":\"%@\"", key, [self.biz_content objectForKey:key]];
    }
    return biz;
}


@end
