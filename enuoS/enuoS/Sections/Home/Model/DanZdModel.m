//
//  DanZdModel.m
//  enuoS
//
//  Created by apple on 16/8/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "DanZdModel.h"
#import "NSDictionary+DeleteNull.h"
@implementation DanZdModel

- (id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:[NSDictionary changeType:dic]];
    }return self;
}

+ (id)DanZdModelInitWithData:(NSDictionary *)dic{
    return [[DanZdModel alloc]initWithDic:dic];
}



- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.cid = value;
    }
}



@end
