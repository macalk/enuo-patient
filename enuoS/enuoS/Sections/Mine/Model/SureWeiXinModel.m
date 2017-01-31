//
//  SureWeiXinModel.m
//  enuo4
//
//  Created by apple on 16/4/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SureWeiXinModel.h"

@implementation SureWeiXinModel
- (id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.appid = [dic objectForKey:@"appid"];
        self.noncestr = [dic objectForKey:@"noncestr"];
        self.package = [dic objectForKey:@"package"];
        self.partnerid = [dic objectForKey:@"partnerid"];
        self.prepayid = [dic objectForKey:@"prepayid"];
        self.sign = [dic objectForKey:@"sign"];
        self.timestamp = [dic objectForKey:@"timestamp"];
        
        
    }return self;
}

+ (id)sureWXWithDic:(NSDictionary *)dic{
    return [[SureWeiXinModel alloc]initWithDic:dic];
}




@end
