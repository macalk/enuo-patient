//
//  CheckTwoModel.m
//  enuo4
//
//  Created by apple on 16/5/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CheckTwoModel.h"

@implementation CheckTwoModel
- (id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.prepaid = [dic objectForKey:@"prepaid"];
        self.pretime = [dic objectForKey:@"pretime"];
        self.hospital = [dic objectForKey:@"hospital"];
        self.dnumber = [dic objectForKey:@"dnumber"];
        self.doctor_name = [dic objectForKey:@"doctor_name"];
        self.check_name = [dic objectForKey:@"check_name"];
        self.cid = [dic objectForKey:@"id"];
    }return self;
}
+ (id)checkTwoModelWithDic:(NSDictionary *)dic{
    return [[CheckTwoModel alloc]initWithDic:dic];
}

@end
