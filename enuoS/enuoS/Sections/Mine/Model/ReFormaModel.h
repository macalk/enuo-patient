//
//  ReFormaModel.h
//  enuo4
//
//  Created by apple on 16/4/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReFormaModel : NSObject
@property (nonatomic,copy)NSString *confirm;
@property (nonatomic,copy)NSString *conpay;
@property (nonatomic,copy)NSString *conpay_time;
@property (nonatomic,copy)NSString *cztime;
@property (nonatomic,copy)NSString *date;
@property (nonatomic,copy)NSString *delete_reason;
@property (nonatomic,copy)NSString *delete_table;
@property (nonatomic,copy)NSString *delete_time;
@property (nonatomic,copy)NSString *department;
@property (nonatomic,copy)NSString *dnumber;
@property (nonatomic,copy)NSString *doc_id;
@property (nonatomic,copy)NSString *doctor_name;
@property (nonatomic,copy)NSString *dsort;
@property (nonatomic,copy)NSString *hos_id;
@property (nonatomic,copy)NSString *hospital;
@property (nonatomic,copy)NSString *cid;
@property (nonatomic,copy)NSString *is_delete;
@property (nonatomic,copy)NSString *jb;
@property (nonatomic,copy)NSString *nowdate;
@property (nonatomic,copy)NSString *onumber;
@property (nonatomic,copy)NSString *operate;
@property (nonatomic,copy)NSString *pay;
@property (nonatomic,copy)NSString *statue;
@property (nonatomic,copy)NSString *type;
@property (nonatomic,copy)NSString *user;
@property (nonatomic,copy)NSString *username;
@property (nonatomic,copy)NSString *yue_statue;
@property (nonatomic,copy)NSString *yue_time;

- (id)initWithDic:(NSDictionary *)dic;


+ (id)reFormaModelInitWithDic:(NSDictionary *)dic;







@end
