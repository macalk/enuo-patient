//
//  CheckOneModel.m
//  enuo4
//
//  Created by apple on 16/5/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CheckOneModel.h"

@implementation CheckOneModel
- (id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    
    if (self) {
        self.dnumber = [dic objectForKey:@"dnumber"];
        self.hospital = [dic objectForKey:@"hospital"];
        self.pretime = [dic objectForKey:@"pretime"];
        self.prepaid = [dic objectForKey:@"prepaid"];
        self.doctor_name = [dic objectForKey:@"doctor_name"];
        self.order_statue_name = [dic objectForKey:@"order_statue_name"];
        self.check_name = [dic objectForKey:@"check_name"];
        self.jb = [dic objectForKey:@"jb"];
    }return self;
}

+ (id)checkOneModelWithDic:(NSDictionary *)dic{
    return [[CheckOneModel alloc]initWithDic:dic];
}


@end
