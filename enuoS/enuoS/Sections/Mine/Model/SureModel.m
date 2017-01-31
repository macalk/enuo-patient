//
//  SureModel.m
//  enuo4
//
//  Created by apple on 16/4/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SureModel.h"

@implementation SureModel



- (id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.hospital = [dic objectForKey:@"hospital"];
        self.dnumber = [dic objectForKey:@"dnumber"];
        self.jb = [dic objectForKey:@"jb"];
        self.price = [dic objectForKey:@"price"];
        self.psy_statue = [dic objectForKey:@"pay_statue"];
        self.cycle = [dic objectForKey:@"cycle"];
        self.effectt = [dic objectForKey:@"effectt"];
        self.understand = [dic objectForKey:@"understand"];
    }return self;
}

+ (id)sureModelInitWithDic:(NSDictionary *)dic{
    return [[SureModel alloc]initWithDic:dic];
}
@end
