//
//  DanZlIntroModel.m
//  enuoS
//
//  Created by apple on 16/8/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "DanZlIntroModel.h"
#import "NSDictionary+DeleteNull.h"

@implementation DanZlIntroModel


- (id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:[NSDictionary changeType:dic]];
    }return self;
}


+ (id)danZlIntroModelWithDic:(NSDictionary *)dic{
    return [[DanZlIntroModel alloc]initWithDic:dic];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.cid = value;
    }
}



@end
