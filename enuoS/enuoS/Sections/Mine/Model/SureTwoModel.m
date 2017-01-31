//
//  SureTwoModel.m
//  enuo4
//
//  Created by apple on 16/4/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SureTwoModel.h"

@implementation SureTwoModel
- (id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.price = [dic objectForKey:@"price"];
        self.pay_method = [dic objectForKey:@"pay_method"];
        //self.price = [dic objectForKey:@"dic"];
        self.pay_money = [dic objectForKey:@"pay_money"];
        self.date = [dic objectForKey:@"data"];
        self.doctor_name = [dic objectForKey:@"doctor_name"];
        self.jb = [dic objectForKey:@"jb"];
        self.name = [dic objectForKey:@"name"];//券
        self.step = [dic objectForKey:@"step"];
        self.pid = [dic objectForKey:@"pid"];
        self.cid = [dic objectForKey:@"id"];
        self.money = [dic objectForKey:@"money"];
        
    }return self;
}

+ (id)sureTwoModelWithDic:(NSDictionary *)dic{
    return [[SureTwoModel alloc]initWithDic:dic];
}



@end
