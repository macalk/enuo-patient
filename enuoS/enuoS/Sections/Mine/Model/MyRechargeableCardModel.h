//
//  MyRechargeableCardModel.h
//  enuoS
//
//  Created by apple on 16/12/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyRechargeableCardModel : NSObject

+ (id)MyRechargeableCardModelInitWithDic:(NSDictionary *)dic;

@property (nonatomic,copy) NSString *dnumber;
@property (nonatomic,copy) NSString *fee;
@property (nonatomic,copy) NSString *start_time;
@property (nonatomic,copy) NSString *end_time;
@property (nonatomic,copy) NSString *is_delete;

@end
