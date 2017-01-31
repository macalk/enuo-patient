//
//  AppointChecKModel.m
//  enuo4
//
//  Created by apple on 16/5/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AppointChecKModel.h"

@implementation AppointChecKModel

- (id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.dnumber = [dic objectForKey:@"dnumber"];
        self.prepaid = [dic objectForKey:@"prepaid"];
        self.pretime = [dic objectForKey:@"pretime"];
        self.hospital = [dic objectForKey:@"hospital"];
        self.doctor_name = [dic objectForKey:@"doctor_name"];
        self.check_name = [dic objectForKey:@"check_name"];
        
    }return self;
}
+ (id)appointInitWithDic:(NSDictionary *)dic{
    return [[AppointChecKModel alloc]initWithDic:dic];
}

@end
