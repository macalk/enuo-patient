//
//  PjDocModel.h
//  enuoS
//
//  Created by apple on 16/8/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PjDocModel : NSObject

@property (nonatomic,copy)NSString *cid;
@property (nonatomic,copy)NSString *doc_id;
@property (nonatomic,copy)NSString *doc_name;
@property (nonatomic,copy)NSString *content;
@property (nonatomic,copy)NSString *hos_id;
@property (nonatomic,copy)NSString *zhui;
@property (nonatomic,copy)NSString *hos_name;
@property (nonatomic,copy)NSString *dep_name;
@property (nonatomic,copy)NSString *professional;
@property (nonatomic,copy)NSString *photo;
@property (nonatomic,copy)NSString *dnumber;
@property (nonatomic,copy)NSString *type;
@property (nonatomic,copy)NSString *service;
@property (nonatomic,copy)NSString *level;
@property (nonatomic,copy)NSString *huanjing;
@property (nonatomic,copy)NSString *username;
@property (nonatomic,copy)NSString *type_id;
@property (nonatomic,copy)NSString *type_name;
@property (nonatomic,copy)NSString *ill;
@property (nonatomic,copy)NSString *rank;


- (id)initWithDic:(NSDictionary *)dic;

+ (id)pjDocModelWithDic:(NSDictionary *)dic;

@end
