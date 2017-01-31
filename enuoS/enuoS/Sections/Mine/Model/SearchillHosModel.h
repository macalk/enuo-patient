//
//  SearchillHosModel.h
//  enuoS
//
//  Created by apple on 16/8/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchillHosModel : NSObject

@property (nonatomic,copy)NSString *ill;
@property (nonatomic,copy)NSString *photo;
@property (nonatomic,copy)NSString *dep_id;
@property (nonatomic,copy)NSString *ID;
@property (nonatomic,copy)NSString *lowprice;
@property (nonatomic,copy)NSString *cycle;
@property (nonatomic,copy)NSString *category;
@property (nonatomic,copy)NSString *treat;
@property (nonatomic,copy)NSString *heightprice;
@property (nonatomic,copy)NSString *hos_id;
@property (nonatomic,copy)NSString *vip;
@property (nonatomic,copy)NSString *hos_name;

@property (nonatomic,copy)NSString *name;




- (id)initWithDic:(NSDictionary *)dic;

+ (id)searchillHosModelInitWithDic:(NSDictionary *)dic;




@end
