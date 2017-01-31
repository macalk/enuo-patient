//
//  DanZdModel.h
//  enuoS
//
//  Created by apple on 16/8/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DanZdModel : NSObject

@property (nonatomic,copy)NSString *cid;

@property (nonatomic,copy)NSString *zz;
@property (nonatomic,copy)NSString *sort_order;


- (id)initWithDic:(NSDictionary *)dic;

+ (id)DanZdModelInitWithData:(NSDictionary *)dic;

@end
