//
//  HosZhuPjModel.h
//  enuoS
//
//  Created by apple on 16/8/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HosZhuPjModel : NSObject
@property (nonatomic,copy)NSString *pj;
@property (nonatomic,assign)NSInteger pj_num;
@property (nonatomic,assign)NSInteger ave_huanjing;
@property (nonatomic,assign)NSInteger ave_service;


- (id)initWithDic:(NSDictionary *)dic;
+ (id)hosZhuPjModelInitWithDic:(NSDictionary *)dic;




@end
