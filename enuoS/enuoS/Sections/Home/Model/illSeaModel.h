//
//  illSeaModel.h
//  enuoS
//
//  Created by apple on 16/8/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface illSeaModel : NSObject
@property (nonatomic,copy)NSString *photo;
@property (nonatomic,copy)NSString *ill;
@property (nonatomic,copy)NSString *effect;
@property (nonatomic,copy)NSString *heightprice;
@property (nonatomic,weak)NSArray *effect_list;
@property (nonatomic,copy)NSString *cycle;

- (id)initWithDic:(NSDictionary *)dic;

+ (id)IllinItWithDic:(NSDictionary *)dic;

@end
