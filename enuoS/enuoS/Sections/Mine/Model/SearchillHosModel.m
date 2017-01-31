//
//  SearchillHosModel.m
//  enuoS
//
//  Created by apple on 16/8/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SearchillHosModel.h"
#import "NSDictionary+DeleteNull.h"
@implementation SearchillHosModel

- (id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:[NSDictionary changeType:dic]];
        
    }return self;
}

+ (id)searchillHosModelInitWithDic:(NSDictionary *)dic{
    return [[SearchillHosModel alloc]initWithDic:dic];
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}




@end
