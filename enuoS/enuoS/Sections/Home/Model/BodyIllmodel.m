//
//  BodyIllmodel.m
//  enuoS
//
//  Created by apple on 16/8/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BodyIllmodel.h"
#import "NSDictionary+DeleteNull.h"
@implementation BodyIllmodel




- (id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:[NSDictionary changeType:dic]];
    }return self;
}



+ (id)BodyIllModelInItWithDic:(NSDictionary *)dic{
    return [[BodyIllmodel alloc]initWithDic:dic];
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.cid = value;
    }
}






@end
