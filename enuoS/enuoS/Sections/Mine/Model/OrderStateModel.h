//
//  OrderStateModel.h
//  enuoS
//
//  Created by apple on 16/8/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderStateModel : NSObject

@property (nonatomic,copy)NSString *yue_statue;
@property (nonatomic,copy)NSString *yue_statue_name;
@property (nonatomic,copy)NSString *delete_reason;
@property (nonatomic,copy)NSString *hos_name;
@property (nonatomic,copy)NSString *department;

@property (nonatomic,copy)NSString *doc_name;
@property (nonatomic,copy)NSString *ill;
@property (nonatomic,copy)NSString *treat;
@property (nonatomic,copy)NSString *category;



@property (nonatomic,copy)NSString *yue_time;
@property (nonatomic,copy)NSString *dnumber;


- (id)initWithDic:(NSDictionary *)dic;

+ (id)orderInitWithDic:(NSDictionary *)dic;



@end
