//
//  DocOrderModel.m
//  enuoS
//
//  Created by apple on 16/8/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "DocOrderModel.h"
#import "NSDictionary+DeleteNull.h"
@implementation DocOrderModel

- (id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:[NSDictionary changeType:dic]];
        
    }return self;
}

+ (id)docOrderModelInitWithDic:(NSDictionary *)dic{
    return [[DocOrderModel alloc]initWithDic:dic];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.cid = value;
    }
}




@end
