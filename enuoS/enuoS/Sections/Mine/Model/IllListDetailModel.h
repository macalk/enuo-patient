//
//  IllListDetailModel.h
//  enuoS
//
//  Created by apple on 16/8/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IllListDetailModel : NSObject
@property (nonatomic,copy)NSString *heightprice;
@property (nonatomic,copy)NSString *cycle;
@property (nonatomic,copy)NSString *effect;
@property (nonatomic,strong)NSArray *effect_list;


- (id)initWithDic:(NSDictionary *)dic;


+ (id)IllListDocModelWith:(NSDictionary *)dic;








@end
