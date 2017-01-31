//
//  DeskTwoModel.m
//  enuoNew
//
//  Created by apple on 16/7/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "DeskTwoModel.h"
#import "NSDictionary+DeleteNull.h"
@implementation DeskTwoModel


- (id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:[NSDictionary changeType:dic ]];
    }return self;
}


+ (id)deskTwoModelWithDic:(NSDictionary *)dic{
    return [[DeskTwoModel alloc]initWithDic:dic];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        self.cid = value;
    }
}



@end
