//
//  ConfircheckModel.h
//  enuo4
//
//  Created by apple on 16/5/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConfircheckModel : NSObject
@property (nonatomic,copy)NSString *check_name;
@property (nonatomic,copy)NSString *dnumber;
@property (nonatomic,copy)NSString *doc_id;
@property (nonatomic,copy)NSString *doctor_name;
@property (nonatomic,copy)NSString *hos_id;
@property (nonatomic,copy)NSString *hospital;
@property (nonatomic,copy)NSString *cid;
@property (nonatomic,copy)NSString *is_next;
@property (nonatomic,copy)NSString *jb;
@property (nonatomic,copy)NSString *main_say;
@property (nonatomic,copy)NSString *now_disease;
@property (nonatomic,copy)NSString *nowdate;
@property (nonatomic,copy)NSString *operate;
@property (nonatomic,copy)NSString *prepaid;
@property (nonatomic,copy)NSString *pretime;
@property (nonatomic,copy)NSString *ybpay;
- (id)initWithDic:(NSDictionary *)dic;

+ (id)confircheckModelInitWithDic:(NSDictionary *)dic;


@end
