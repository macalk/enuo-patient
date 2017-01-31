//
//  PayDetailModel.m
//  enuo4
//
//  Created by apple on 16/4/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "PayDetailModel.h"

@implementation PayDetailModel

- (id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.method = [dic objectForKey:@"method"];
        self.sum = [dic objectForKey:@"sum"];
        self.orderNo = [dic objectForKey:@"orderNo"];
        self.remark  = [ dic objectForKey:@"remark"];
    }return self;
}

+ (id)payDetailModelWithDic:(NSDictionary *)dic{
    return [[PayDetailModel alloc]initWithDic:dic];
}


@end
