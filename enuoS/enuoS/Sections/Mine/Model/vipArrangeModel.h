//
//  vipArrangeModel.h
//  enuo4
//
//  Created by apple on 16/5/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface vipArrangeModel : NSObject

@property (nonatomic,copy)NSString *hos_id;
@property (nonatomic,copy)NSString *hospital_name;
@property (nonatomic,copy)NSString *cid;
@property (nonatomic,copy)NSString *end_time;
@property (nonatomic,copy)NSString *start_time;
@property (nonatomic,copy)NSString *ill;
@property (nonatomic,copy)NSString *mb_id;
@property (nonatomic,copy)NSString *photo;
@property (nonatomic,copy)NSString *price;
@property (nonatomic,copy)NSString *category;
@property (nonatomic,copy)NSString *treat;
@property (nonatomic,copy)NSString *dep_id;
@property (nonatomic,copy)NSString *PID;
@property (nonatomic,copy)NSString *bargin_price;




- (id)initWithDic:(NSDictionary *)dic;

+ (id)vipArrangeWithDic:(NSDictionary *)dic;


@end
