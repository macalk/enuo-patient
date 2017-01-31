//
//  SureEndModel.m
//  enuo4
//
//  Created by apple on 16/4/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SureEndModel.h"

@implementation SureEndModel
- (id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.premoney = [dic objectForKey:@"premoney"];
        self.price = [dic objectForKey:@"price"];
        self.pro_ID = [dic objectForKey:@"pro_ID"];
        self.prepaid = [[dic objectForKey:@"prepaid"] integerValue] ;
        self.zf_money = [dic objectForKey:@"zf_money"];
        self.yb_money = [dic objectForKey:@"yb_money"];
        self.jb = [dic objectForKey:@"jb"];
    }return self;
}
+ (id)sureEndModelInitWithDic:(NSDictionary *)dic{
    return [[SureEndModel alloc]initWithDic:dic];
}







@end
