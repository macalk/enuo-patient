//
//  StateTwoModel.m
//  enuo4
//
//  Created by apple on 16/5/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "StateTwoModel.h"

@implementation StateTwoModel
- (id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.dody_check = [dic objectForKey:@"dody_check"];
        self.he_check = [dic objectForKey:@"he_check"];
        self.lab_check = [dic objectForKey:@"lab_check"];
        self.main_say = [dic objectForKey:@"main_say"];
        self.now_disease = [dic objectForKey:@"now_disease"];
        self.zhenduan = [dic objectForKey:@"zhenduan"];
    }return self;
}
+ (id)stateTwoModelWithDic:(NSDictionary *)dic{
    return [[StateTwoModel alloc]initWithDic:dic];
}



@end
