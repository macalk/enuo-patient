//
//  PayDetailModel.h
//  enuo4
//
//  Created by apple on 16/4/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayDetailModel : NSObject
@property (nonatomic,copy)NSString *method;
@property (nonatomic,copy)NSString *orderNo;
@property (nonatomic,copy)NSString *remark;
@property (nonatomic,copy)NSString *sum;

- (id)initWithDic:(NSDictionary *)dic;

+ (id)payDetailModelWithDic:(NSDictionary *)dic;


@end
