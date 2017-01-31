//
//  BodyModel.h
//  enuoS
//
//  Created by apple on 16/8/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BodyModel : NSObject

@property (nonatomic,copy)NSString *body;
@property (nonatomic,copy)NSString *cid;
@property (nonatomic,copy)NSString *sort_order;

- (id)initWithDic:(NSDictionary *)dic;


+ (id)bodyModelInitWithDic:(NSDictionary *)dic;





@end
