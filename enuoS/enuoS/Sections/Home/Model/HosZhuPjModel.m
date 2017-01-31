//
//  HosZhuPjModel.m
//  enuoS
//
//  Created by apple on 16/8/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "HosZhuPjModel.h"
#import "NSDictionary+DeleteNull.h"
@implementation HosZhuPjModel



- (id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:[NSDictionary changeType:dic]];
    }return self;
}

+ (id)hosZhuPjModelInitWithDic:(NSDictionary *)dic{
    return [[HosZhuPjModel alloc]initWithDic:dic];
}

@end
