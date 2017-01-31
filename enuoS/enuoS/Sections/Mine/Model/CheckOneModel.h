//
//  CheckOneModel.h
//  enuo4
//
//  Created by apple on 16/5/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckOneModel : NSObject
@property (nonatomic,copy)NSString *check_name;
@property (nonatomic,copy)NSString *doctor_name;
@property (nonatomic,copy)NSString *hospital;
@property (nonatomic,copy)NSString *jb;
@property (nonatomic,copy)NSString *pretime;
@property (nonatomic,copy)NSString *order_statue_name;
@property (nonatomic,copy)NSString *prepaid;
@property (nonatomic,copy)NSString *dnumber;

- (id)initWithDic:(NSDictionary *)dic;
+ (id)checkOneModelWithDic:(NSDictionary *)dic;

@end
