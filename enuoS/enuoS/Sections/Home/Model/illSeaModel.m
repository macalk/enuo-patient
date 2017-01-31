//
//  illSeaModel.m
//  enuoS
//
//  Created by apple on 16/8/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "illSeaModel.h"
#import "NSDictionary+DeleteNull.h"
@implementation illSeaModel

- (id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:[NSDictionary changeType:dic]];
    }return self;
}

+ (id)IllinItWithDic:(NSDictionary *)dic{
    return [[illSeaModel alloc]initWithDic:dic];
}
@end
