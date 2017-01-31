//
//  CarrModel.m
//  enuoNew
//
//  Created by apple on 16/7/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CarrModel.h"
#import "NSDictionary+DeleteNull.h"
@implementation CarrModel

- (id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
       [self setValuesForKeysWithDictionary:[NSDictionary changeType:dic ]];
    }return self;
}

+ (id)carrModelInItWithDic:(NSDictionary *)dic{
    return [[CarrModel alloc]initWithDic:dic];
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.cid = value;
    }
}
@end
