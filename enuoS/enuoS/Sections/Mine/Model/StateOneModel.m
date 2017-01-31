//
//  StateOneModel.m
//  enuo4
//
//  Created by apple on 16/5/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "StateOneModel.h"

@implementation StateOneModel
- (id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.dnumber = [dic objectForKey:@"dnumber"];
        self.jb = [dic objectForKey:@"jb"];
        self.pay_statue = [dic objectForKey:@"pay_statue"];
        self.hospital = [dic objectForKey:@"hospital"];
        self.understand = [dic objectForKey:@"understand"];
        self.cycle = [dic objectForKey:@"cycle"];
        self.effectt = [dic objectForKey:@"effectt"];
        self.price = [dic objectForKey:@"price"];
    }return self;
}
+ (id)stateOneModelInitWithDic:(NSDictionary *)dic{
    return [[StateOneModel alloc]initWithDic:dic];
}

@end
