//
//  MyExperienceCardOrderModel.h
//  enuoS
//
//  Created by apple on 16/12/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyExperienceCardOrderModel : NSObject

+(id)MyExperienceCardOrderModelInitWithDic:(NSDictionary *)dic;

@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *username;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *cardno;
@property (nonatomic,copy) NSString *hos_id;
@property (nonatomic,copy) NSString *confirm;
@property (nonatomic,copy) NSString *date;
@property (nonatomic,copy) NSString *create_time;
@property (nonatomic,copy) NSString *is_delete;
@property (nonatomic,copy) NSString *delete_reason;
@property (nonatomic,copy) NSString *pj;
@property (nonatomic,copy) NSString *hos_name;
@property (nonatomic,copy) NSString *photo;
@property (nonatomic,copy) NSString *product;
@property (nonatomic,assign) NSInteger type_id;
@property (nonatomic,copy) NSString *type_name;

@property (nonatomic,assign) float bgViewHeight;

@end
