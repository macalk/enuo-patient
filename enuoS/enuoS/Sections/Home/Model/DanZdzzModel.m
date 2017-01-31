//
//  DanZdzzModel.m
//  enuoS
//
//  Created by apple on 16/8/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "DanZdzzModel.h"
#import "NSDictionary+DeleteNull.h"
@implementation DanZdzzModel

- (id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:[NSDictionary changeType:dic]];
        
    }return self;
}


+ (id)DanZdzzModelInitWithDic:(NSDictionary *)dic{
    return [[DanZdzzModel alloc]initWithDic:dic];
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.cid = value;
    }
}

@end
