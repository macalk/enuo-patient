//
//  SureOneModel.m
//  enuo4
//
//  Created by apple on 16/4/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SureOneModel.h"

@implementation SureOneModel
- (id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.zhenduan = [dic objectForKey:@"zhenduan"];
        self.main_say = [dic objectForKey:@"main_say"];
        self.lab_check = [dic objectForKey:@"lab_check"];
        self.he_check = [dic objectForKey:@"he_check"];
        self.now_disease = [dic objectForKey:@"now_disease"];
        self.dody_check = [dic objectForKey:@"dody_check"];
        
    }return self;
}
+ (id)sureOneModelInithWithDic:(NSDictionary *)dic{
    return [[SureOneModel alloc]initWithDic:dic];
}





@end
