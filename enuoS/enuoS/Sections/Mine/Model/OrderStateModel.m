//
//  OrderStateModel.m
//  enuoS
//
//  Created by apple on 16/8/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "OrderStateModel.h"
#import "NSDictionary+DeleteNull.h"
@implementation OrderStateModel


- (id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:[NSDictionary changeType:dic]];
    }return self;
}



+ (id)orderInitWithDic:(NSDictionary *)dic{
    return [[OrderStateModel alloc]initWithDic:dic];
}


@end
