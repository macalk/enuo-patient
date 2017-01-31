//
//  DSModel.m
//  enuoS
//
//  Created by apple on 16/8/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "DSModel.h"
#import "NSDictionary+DeleteNull.h"
@implementation DSModel

- (id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:[NSDictionary changeType:dic]];
    }return self;
}

+ (id)dsModelInitWithDic:(NSDictionary *)dic{
    return [[DSModel alloc]initWithDic:dic];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.cid = value;
    }
}

@end
