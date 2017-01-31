//
//  pjHosModel.m
//  enuoS
//
//  Created by apple on 16/8/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "pjHosModel.h"
#import "NSDictionary+DeleteNull.h"
@implementation pjHosModel

- (id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:[NSDictionary changeType:dic]];
        
    }return self;
}




+ (id)pjHosModelInitWith:(NSDictionary *)dic{
    
    return [[pjHosModel alloc]initWithDic:dic];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.cid = value;
    }
}




@end
