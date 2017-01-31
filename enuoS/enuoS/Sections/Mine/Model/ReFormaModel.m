//
//  ReFormaModel.m
//  enuo4
//
//  Created by apple on 16/4/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ReFormaModel.h"

@implementation ReFormaModel

- (id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.confirm = [dic objectForKey:@"confirm"];
        self.conpay = [dic objectForKey:@"conpay"];
        self.conpay_time = [dic objectForKey:@"conpay_time"];
        self.cztime = [dic objectForKey:@"cztime"];
        self.date = [dic objectForKey:@"date"];
        self.delete_reason = [dic objectForKey:@"delete_reason"];
        self.delete_table = [dic objectForKey:@"delete_table"];
        self.delete_time = [dic objectForKey:@"delete_time"];
        self.department = [dic objectForKey:@"department"];
        self.dnumber = [dic objectForKey:@"dnumber"];
        self.doc_id = [dic objectForKey:@"doc_id"];
        self.doctor_name = [dic objectForKey:@"doctor_name"];
        self.dsort = [dic objectForKey:@"dsort"];
        self.hos_id = [dic objectForKey:@"hos_id"];
        self.hospital = [dic objectForKey:@"hospital"];
        self.cid = [dic objectForKey:@"id"];
        self.is_delete = [dic objectForKey:@"is_delete"];
        self.jb = [dic objectForKey:@"jb"];
        self.nowdate = [dic objectForKey:@"nowdate"];
        self.onumber = [dic objectForKey:@"onumber"];
        self.operate = [dic objectForKey:@"operate"];
        self.pay = [dic objectForKey:@"pay"];
        self.statue = [dic objectForKey:@"statue"];
        self.type = [dic objectForKey:@"type"];
        self.user = [dic objectForKey:@"user"];
        self.username = [dic objectForKey:@"username"];
        self.yue_statue = [dic objectForKey:@"yue_statue"];
        self.yue_time = [dic objectForKey:@"yue_time"];
        
    }return self;
}




+ (id)reFormaModelInitWithDic:(NSDictionary *)dic{
    return [[ReFormaModel alloc]initWithDic:dic];
}

//- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
//    if ([key isEqualToString:@"id"]) {
//        self.cid = value;
//    }
//}











@end
