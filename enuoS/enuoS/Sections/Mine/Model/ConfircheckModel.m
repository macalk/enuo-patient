//
//  ConfircheckModel.m
//  enuo4
//
//  Created by apple on 16/5/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ConfircheckModel.h"

@implementation ConfircheckModel
- (id)initWithDic:(NSDictionary *)dic{
    self =[super init];
    if (self) {
        self.check_name = [dic objectForKey:@"check_name"];
        self.dnumber = [dic objectForKey:@"dnumber"];
        self.doc_id  = [dic objectForKey:@"doc_id"];
        self.doctor_name = [ dic objectForKey:@"doctor_name"];
        self.hos_id = [dic objectForKey:@"hos_id"];
        self.hospital = [dic objectForKey:@"hospital"];
        self.cid = [dic objectForKey:@"id"];
        self.is_next = [dic objectForKey:@"0"];
        self.jb = [dic objectForKey:@"jb"];
        self.main_say = [dic objectForKey:@"main_say"];
        self.now_disease = [dic objectForKey:@"now_disease"];
        self.nowdate = [dic objectForKey:@"nowdate"];
        self.operate = [dic objectForKey:@"operate"];
        self.prepaid = [dic objectForKey:@"prepaid"];
        self.pretime = [dic objectForKey:@"pretime"];
        self.ybpay = [dic objectForKey:@"ybpay"];
    }return self;
}

+ (id)confircheckModelInitWithDic:(NSDictionary *)dic{
    return [[ConfircheckModel alloc]initWithDic:dic];
}



@end
