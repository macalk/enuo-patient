//
//  StateModel.m
//  enuo4
//
//  Created by apple on 16/5/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "StateModel.h"

@implementation StateModel
- (id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.jb = [dic objectForKey:@"jb"];
        self.dnumber = [dic objectForKey:@"dnumber"];
        self.pay_situation = [dic objectForKey:@"pay_situation"];
        self.price = [dic objectForKey:@"price"];
        self.doctor_name = [dic objectForKey:@"doctor_name"];
        self.date = [dic objectForKey:@"date"];
    }return self;
}


+ (id)stateModelWithDic:(NSDictionary *)dic{
    return [[StateModel alloc]initWithDic:dic];
}



@end
