//
//  ExTwoModel.h
//  enuoS
//
//  Created by apple on 16/8/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExTwoModel : NSObject
@property (nonatomic,copy)NSString *cid;
@property (nonatomic,copy)NSString *zz;
@property (nonatomic,copy)NSString *introduce;
@property (nonatomic,copy)NSArray *maybe_list;



- (id)initWithDic:(NSDictionary *)dic;

+ (id)ecTwoModelInitWithData:(NSDictionary *)dic;

@end
