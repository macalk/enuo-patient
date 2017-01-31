//
//  DanZdzzModel.h
//  enuoS
//
//  Created by apple on 16/8/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DanZdzzModel : NSObject

@property (nonatomic,copy)NSString *cid;

@property (nonatomic,copy)NSString *pid;

@property (nonatomic,copy)NSString *bszz;

@property (nonatomic,copy)NSString *inspect;

@property (nonatomic,copy)NSString *judge;

@property (nonatomic,copy)NSString *doubt;

@property (nonatomic,copy)NSString *sub_time;

@property (nonatomic,copy)NSString *check_time;

@property (nonatomic,copy)NSString *statue;

@property (nonatomic,copy)NSString *add_type;

@property (nonatomic,copy)NSString *user_id;

@property (nonatomic,copy)NSString *sort_order;

@property (nonatomic,strong)NSArray *jc_list;

@property (nonatomic,strong)NSArray *ky_list;


- (id)initWithDic:(NSDictionary *)dic;

+ (id)DanZdzzModelInitWithDic:(NSDictionary *)dic;









@end
