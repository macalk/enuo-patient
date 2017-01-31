//
//  MyExperienceCardDetailModel.h
//  enuoS
//
//  Created by apple on 16/12/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyExperienceCardDetailModel : NSObject

+(id)MyExperienceCardDetailModelInitWithDic:(NSDictionary *)dic;

@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *cardno;
@property (nonatomic,copy) NSString *product;
@property (nonatomic,copy) NSString *hos_id;
@property (nonatomic,copy) NSString *start_time;
@property (nonatomic,copy) NSString *end_time;
@property (nonatomic,copy) NSString *use_time;
@property (nonatomic,copy) NSString *create_time;
@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *is_used;
@property (nonatomic,copy) NSString *hos_name;
@property (nonatomic,assign) int is_yue;


@end
