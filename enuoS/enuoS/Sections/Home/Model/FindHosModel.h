//
//  FindHosModel.h
//  enuoS
//
//  Created by apple on 16/7/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FindHosModel : NSObject
@property (nonatomic,copy)NSString *cid;
@property (nonatomic,copy)NSString *photo;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *rank;
@property (nonatomic,copy)NSString *dun;
@property (nonatomic,copy)NSString *yb;
@property (nonatomic,copy)NSString *zhen;
@property (nonatomic,copy)NSString *introduce;
@property (nonatomic,copy)NSString *phone;
@property (nonatomic,copy)NSString *ill;
@property (nonatomic,copy)NSString *hos_name;
@property (nonatomic,assign)NSInteger comment_num;

@property (nonatomic,copy)NSString *address;


- (id)initWithDic:(NSDictionary *)dic;

+ (id)findHosModelInithWithDic:(NSDictionary *)dic;
@end
