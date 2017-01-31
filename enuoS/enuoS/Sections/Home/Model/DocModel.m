//
//  DocModel.m
//  enuoS
//
//  Created by apple on 16/7/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "DocModel.h"
#import "NSDictionary+DeleteNull.h"
@implementation DocModel


- (id)initWihData:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:[NSDictionary changeType:dic]];
    }return self;
}

+ (id)docModelInitWithData:(NSDictionary *)dic{
    return [[DocModel alloc]initWihData:dic];
}



- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.cid = value;
    }
}
@end
