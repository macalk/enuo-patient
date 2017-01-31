//
//  DSMoneyModel.h
//  enuoS
//
//  Created by apple on 16/8/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSMoneyModel : NSObject
@property (nonatomic,copy)NSString *cid;
@property (nonatomic,copy)NSString *money;




- (id)initWithDic:(NSDictionary *)dic;

+ (id)dsModelInitWithDic:(NSDictionary *)dic;


@end
