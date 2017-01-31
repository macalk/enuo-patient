//
//  SureEndModel.h
//  enuo4
//
//  Created by apple on 16/4/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SureEndModel : NSObject
@property (nonatomic,copy)NSString *pro_ID;
@property (nonatomic,copy)NSString *jb;
@property (nonatomic,copy)NSString *yb_money;
@property (nonatomic,copy)NSString *zf_money;
@property (nonatomic,copy)NSString *price;
@property (nonatomic,copy)NSString *premoney;
@property (nonatomic,assign)NSInteger  prepaid;



- (id)initWithDic:(NSDictionary *)dic;
+ (id)sureEndModelInitWithDic:(NSDictionary *)dic;

@end
