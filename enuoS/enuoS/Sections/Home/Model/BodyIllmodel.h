//
//  BodyIllmodel.h
//  enuoS
//
//  Created by apple on 16/8/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BodyIllmodel : NSObject

@property (nonatomic,copy)NSString *bid;

@property (nonatomic,copy)NSString *cid;
@property (nonatomic,copy)NSString *zz;
@property (nonatomic,copy)NSString *sex;
@property (nonatomic,copy)NSString *introduce;





- (id)initWithDic:(NSDictionary *)dic;


+ (id)BodyIllModelInItWithDic:(NSDictionary *)dic;



@end
