//
//  DanZdIntroModel.m
//  enuoS
//
//  Created by apple on 16/8/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "DanZdIntroModel.h"
#import "NSDictionary+DeleteNull.h"
@implementation DanZdIntroModel



- (id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:[NSDictionary changeType:dic]];
        
    }return self;
}



+ (id)DanZdIntroModelWithDic:(NSDictionary *)dic{
    return [[DanZdIntroModel alloc]initWithDic:dic];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.cid = value;
    }
}


@end
