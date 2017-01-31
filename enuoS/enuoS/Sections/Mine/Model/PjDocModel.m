//
//  PjDocModel.m
//  enuoS
//
//  Created by apple on 16/8/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "PjDocModel.h"
#import "NSDictionary+DeleteNull.h"
@implementation PjDocModel


/*****/
- (id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }return self;
}
+ (id)pjDocModelWithDic:(NSDictionary *)dic{
    return [[PjDocModel alloc]initWithDic:dic];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.cid = value;
    }
    
}



@end
