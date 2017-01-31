//
//  ExThreeModel.m
//  enuoS
//
//  Created by apple on 16/8/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ExThreeModel.h"
#import "NSDictionary+DeleteNull.h"
@implementation ExThreeModel

- (id)initWithDic:(NSDictionary *)dic{
    self  = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:[NSDictionary changeType:dic]];
        
    }return self;




}


+ (id)exThreeModelInithDic:(NSDictionary *)dic{
    return [[ExThreeModel alloc]initWithDic:dic];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.cid = value;
    }
}
@end
