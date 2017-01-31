//
//  FindHosModel.m
//  enuoS
//
//  Created by apple on 16/7/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "FindHosModel.h"
#import "NSDictionary+DeleteNull.h"
@implementation FindHosModel

- (id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    
    if (self) {
        [self setValuesForKeysWithDictionary:[NSDictionary changeType:dic]];
    }return self;
}



+ (id)findHosModelInithWithDic:(NSDictionary *)dic{
    return [[FindHosModel alloc]initWithDic:dic];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.cid = value;
    }
}



@end
