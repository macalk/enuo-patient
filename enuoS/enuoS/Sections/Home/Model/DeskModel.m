//
//  DeskModel.m
//  enuoNew
//
//  Created by apple on 16/7/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "DeskModel.h"
#import "NSDictionary+DeleteNull.h"
@implementation DeskModel

- (id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:[NSDictionary changeType:dic ]];
    }return self;
}


+ (id)deskModelInitWithDic:(NSDictionary *)dic{
    return [[DeskModel alloc]initWithDic:dic];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        self.cid = value;
    }
}


@end
