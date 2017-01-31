//
//  MyExperienceCardDetailModel.m
//  enuoS
//
//  Created by apple on 16/12/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MyExperienceCardDetailModel.h"

@implementation MyExperienceCardDetailModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+(id)MyExperienceCardDetailModelInitWithDic:(NSDictionary *)dic {
    return [[self alloc]initWithDic:dic];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

@end
