//
//  BaiduModel.m
//  enuo4
//
//  Created by apple on 16/3/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaiduModel.h"
#import "NSDictionary+DeleteNull.h"
@implementation BaiduModel
- (id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
  [self setValuesForKeysWithDictionary:[NSDictionary changeType:dic ]];
    }return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.cid = value;
    }
}
+ (id)baiDuModelWithDic:(NSDictionary *)dic{
    return [[BaiduModel alloc]initWithDic:dic];
}
@end
