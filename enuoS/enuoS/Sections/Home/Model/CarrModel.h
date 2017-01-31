//
//  CarrModel.h
//  enuoNew
//
//  Created by apple on 16/7/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarrModel : NSObject
@property (nonatomic,copy)NSString *cid;
@property (nonatomic,copy)NSString *photo;
@property (nonatomic,copy)NSString *sort_order;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *url;



- (id)initWithDic:(NSDictionary *)dic;
+ (id)carrModelInItWithDic:(NSDictionary *)dic;
@end
