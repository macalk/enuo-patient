//
//  vipModel.m
//  enuoS
//
//  Created by apple on 16/8/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "vipModel.h"
#import "NSDictionary+DeleteNull.h"

@implementation vipModel

- (id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:[NSDictionary changeType:dic]];
        
        
      
        
    }  return self;
}



+ (id)vipModelInitWhith:(NSDictionary *)dic{
    
    return [[vipModel alloc]initWithDic:dic];
}












@end
