//
//  DocOrderModel.h
//  enuoS
//
//  Created by apple on 16/8/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DocOrderModel : NSObject
@property (nonatomic,copy)NSString*cid;

@property (nonatomic,copy)NSString *hos_id;
@property (nonatomic,copy)NSString *doc_name;
@property (nonatomic,copy)NSString *schedule;
@property (nonatomic,strong)NSArray *ill_list;
@property (nonatomic,copy)NSString *hos_name;
@property (nonatomic,strong)NSArray *schedule_list;





- (id)initWithDic:(NSDictionary *)dic;

+ (id)docOrderModelInitWithDic:(NSDictionary *)dic;



@end
