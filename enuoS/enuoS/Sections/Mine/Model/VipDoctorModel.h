//
//  VipDoctorModel.h
//  enuo4
//
//  Created by apple on 16/5/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VipDoctorModel : NSObject
@property (nonatomic,copy)NSString *doctor_photo;
@property (nonatomic,copy)NSString *hospital_name;
@property (nonatomic,copy)NSString *cid;
@property(nonatomic,copy)NSString *introduce;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *nuo;
@property (nonatomic,copy)NSString *professional;
@property (nonatomic,copy)NSString *registration_fee;
@property (nonatomic,copy)NSString *treatment;
@property (nonatomic,copy)NSString *zhen;

- (id)initWithDic:(NSDictionary *)dic;

+ (id)vipModelInitWithDic:(NSDictionary *)dic;

@end
