//
//  SureWeiXinModel.h
//  enuo4
//
//  Created by apple on 16/4/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SureWeiXinModel : NSObject
@property (nonatomic,copy)NSString *appid;
@property (nonatomic,copy)NSString *noncestr;
@property (nonatomic,copy)NSString *package;
@property (nonatomic,copy)NSString *partnerid;
@property (nonatomic,copy)NSString *prepayid;
@property (nonatomic,copy)NSString *sign;
@property (nonatomic,copy)NSString *timestamp;
- (id)initWithDic:(NSDictionary *)dic;

+ (id)sureWXWithDic:(NSDictionary *)dic;


@end
