//
//  IllListDetailModel.m
//  enuoS
//
//  Created by apple on 16/8/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "IllListDetailModel.h"
#import "NSDictionary+DeleteNull.h"

@implementation IllListDetailModel

- (id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:[NSDictionary changeType:dic]];
    }return self;
}


+ (id)IllListDocModelWith:(NSDictionary *)dic{
    return [[IllListDetailModel alloc]initWithDic:dic];
}


@end
