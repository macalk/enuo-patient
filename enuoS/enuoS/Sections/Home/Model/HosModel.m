//
//  HosModel.m
//  enuoS
//
//  Created by apple on 16/7/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "HosModel.h"
#import "NSDictionary+DeleteNull.h"
@implementation HosModel

- (id)initWithData:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:[NSDictionary changeType:dic]];

    }return self;
}

+ (id)hosModelWithData:(NSDictionary *)dic{
    return [[HosModel alloc]initWithData:dic];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.cid = value;
    }
}



@end
