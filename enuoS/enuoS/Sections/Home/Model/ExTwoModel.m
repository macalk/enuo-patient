//
//  ExTwoModel.m
//  enuoS
//
//  Created by apple on 16/8/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ExTwoModel.h"
#import "NSDictionary+DeleteNull.h"
@implementation ExTwoModel



- (id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
       [ self setValuesForKeysWithDictionary:[NSDictionary changeType:dic]];
    }return self;
}

+ (id)ecTwoModelInitWithData:(NSDictionary *)dic{
    return [[ExTwoModel alloc]initWithDic:dic];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        self.cid = value;
    }
}
@end
