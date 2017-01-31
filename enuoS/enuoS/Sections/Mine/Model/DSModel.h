//
//  DSModel.h
//  enuoS
//
//  Created by apple on 16/8/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSModel : NSObject
@property (nonatomic,copy)NSString *cid;
@property (nonatomic,copy)NSString *photo;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *nuo;
@property (nonatomic,copy)NSString *professional;
@property (nonatomic,copy)NSString *hos_id;
@property (nonatomic,copy)NSString *zhen;
@property (nonatomic,copy)NSString *dnumber;
@property (nonatomic,copy)NSString *hos_name;
@property (nonatomic,copy)NSString *dep_name;
@property (nonatomic,assign)NSInteger statue;


- (id)initWithDic:(NSDictionary *)dic;

+ (id)dsModelInitWithDic:(NSDictionary *)dic;


@end
