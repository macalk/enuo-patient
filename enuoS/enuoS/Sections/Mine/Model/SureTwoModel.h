//
//  SureTwoModel.h
//  enuo4
//
//  Created by apple on 16/4/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SureTwoModel : NSObject
@property (nonatomic,copy)NSString *date;
@property (nonatomic,copy)NSString *doctor_name;
@property (nonatomic,copy)NSString *hospital;
@property (nonatomic,copy)NSString *jb;
@property (nonatomic,copy)NSString *pay_method;
@property (nonatomic,copy)NSString *pay_money;
@property (nonatomic,copy)NSString *price;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *cid;
@property (nonatomic,copy)NSString *pid;
@property (nonatomic,copy)NSString *step;
@property (nonatomic,copy)NSString *money;

- (id)initWithDic:(NSDictionary *)dic;
+ (id)sureTwoModelWithDic:(NSDictionary *)dic;

@end
