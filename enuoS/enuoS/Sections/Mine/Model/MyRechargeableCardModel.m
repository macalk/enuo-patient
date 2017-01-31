//
//  MyRechargeableCardModel.m
//  enuoS
//
//  Created by apple on 16/12/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MyRechargeableCardModel.h"

@implementation MyRechargeableCardModel

- (id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
        
    }return self;
}

+ (id)MyRechargeableCardModelInitWithDic:(NSDictionary *)dic{
    return [[MyRechargeableCardModel alloc]initWithDic:dic];
}


@end
