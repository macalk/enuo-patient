//
//  FindDocModel.m
//  enuoNew
//
//  Created by apple on 16/7/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "FindDocModel.h"
#import "NSDictionary+DeleteNull.h"
@implementation FindDocModel



- (id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
     
       [self setValuesForKeysWithDictionary:[NSDictionary changeType:dic]];
        
    }  return self;
}





+ (id)findDocModelInitWithDic:(NSDictionary *)dic{
    return [[FindDocModel alloc]initWithDic:dic];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        
        self.cid = value;
    }
}
@end
