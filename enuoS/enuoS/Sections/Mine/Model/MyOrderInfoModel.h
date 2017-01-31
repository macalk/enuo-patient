//
//  MyOrderInfoModel.h
//  enuoS
//
//  Created by apple on 16/11/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface preferModel : NSObject

@property (nonatomic) NSString *ID;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *money;

- (id)initWithDic:(NSDictionary *)dic;


@end


/***********/
@interface check_detailModel : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *money;
@property (nonatomic) NSString *yb;
@property (nonatomic) NSString *zf;

- (id)initWithDic:(NSDictionary *)dic;


@end

/************/

@interface MyOrderInfoModel : NSObject

+ (id)myOrderModelInitWithDic:(NSDictionary *)dic;
- (id)initWithDic:(NSDictionary *)dic;

@property (nonatomic, strong) NSArray <check_detailModel*>*check_detail;

@property (nonatomic) float baseViewHeight;

@property (nonatomic) double type_id;
@property (nonatomic) NSString *type_name;
@property (nonatomic) NSString *hos_id;
@property (nonatomic) NSString *dsort;
@property (nonatomic) NSInteger step;
@property (nonatomic) NSInteger sum_step;
@property (nonatomic) NSInteger prepaid;
@property (nonatomic) NSString *dnumber;
@property (nonatomic) NSString *hos_name;
@property (nonatomic) NSString *doc_name;
@property (nonatomic) NSString *dep_name;
@property (nonatomic) NSString *yue_time;
@property (nonatomic) NSString *delete_reason;
@property (nonatomic) NSString *ill;
@property (nonatomic) NSString *category;
@property (nonatomic) NSString *treat;
@property (nonatomic) NSString *price;
@property (nonatomic) float yb_money;
@property (nonatomic) float coupon_money;
@property (nonatomic) float ypay_money;
@property (nonatomic) float pay_jump;
@property (nonatomic) NSString *pay_method;
@property (nonatomic) NSString *pay_money;
@property (nonatomic) NSString *date;
@property (nonatomic) NSString *photo;
@property (nonatomic) NSString *rank;
@property (nonatomic) double check_money;

@property (nonatomic) NSArray *check_list;



@property (nonatomic) NSString *main_say;
@property (nonatomic) NSString *now_disease;
@property (nonatomic) float back_money;
@property (nonatomic) NSArray *data;

//充值劵
@property (nonatomic) NSArray <preferModel *>* prefer;
@property (nonatomic) NSString *prefer_json;

@end
