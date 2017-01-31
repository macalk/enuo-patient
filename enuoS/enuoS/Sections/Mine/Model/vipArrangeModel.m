//
//  vipArrangeModel.m
//  enuo4
//
//  Created by apple on 16/5/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "vipArrangeModel.h"

@implementation vipArrangeModel
- (id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }return self;
}

+ (id)vipArrangeWithDic:(NSDictionary *)dic{
    return [[vipArrangeModel alloc]initWithDic:dic];
}



- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.cid = value;
    }
}


@end
