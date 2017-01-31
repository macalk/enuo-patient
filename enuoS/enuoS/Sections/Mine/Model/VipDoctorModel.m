//
//  VipDoctorModel.m
//  enuo4
//
//  Created by apple on 16/5/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "VipDoctorModel.h"

@implementation VipDoctorModel
- (id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }return self;
}
+ (id)vipModelInitWithDic:(NSDictionary *)dic{
    return [[VipDoctorModel alloc]initWithDic:dic];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.cid = value;
    }

}

@end
