//
//  illListModel.m
//  enuoS
//
//  Created by apple on 16/8/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "illListModel.h"
#import "NSDictionary+DeleteNull.h"
@implementation illListModel




- (id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:[NSDictionary changeType:dic]];
        
    }return self;
}



+ (id)illListModelWithDic:(NSDictionary *)dic{
    return [[illListModel alloc]initWithDic:dic];
}




@end
