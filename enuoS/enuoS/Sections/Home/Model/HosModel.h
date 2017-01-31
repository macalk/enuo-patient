//
//  HosModel.h
//  enuoS
//
//  Created by apple on 16/7/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HosModel : NSObject

@property (nonatomic,copy)NSString *cid;
@property (nonatomic,copy)NSString *photo;
@property (nonatomic,copy)NSString *hos_name;
@property (nonatomic,copy)NSString *rank;
@property (nonatomic,assign)NSInteger guanzhu;
@property (nonatomic,copy)NSString *phone;
@property (nonatomic,copy)NSString *yb;
@property (nonatomic,copy)NSString *website;
@property (nonatomic,copy)NSString *address;
@property (nonatomic,copy)NSString *ill;
@property (nonatomic,copy)NSString *bus;
@property (nonatomic,copy)NSString *yljg;
@property (nonatomic,copy)NSString *hos_information;
@property (nonatomic,copy)NSString *zhen;
@property (nonatomic,copy)NSString *department;

@property (nonatomic,copy)NSString *name;//医生名字

/**评论区***/
@property (nonatomic,copy)NSString *user;
@property (nonatomic,copy)NSString *nowdate;
@property (nonatomic,copy)NSString *hos_content;
@property (nonatomic,copy)NSString *huanjing;
@property (nonatomic,copy)NSString *service;







- (id)initWithData:(NSDictionary *)dic;


+ (id)hosModelWithData:(NSDictionary *)dic;



@end
