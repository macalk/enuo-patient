//
//  ExThreeModel.h
//  enuoS
//
//  Created by apple on 16/8/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExThreeModel : NSObject
@property (nonatomic,copy)NSString *cid;
@property (nonatomic,copy)NSString *zid;
@property (nonatomic,copy)NSString *mayzz;
@property (nonatomic,copy)NSString *explain;
@property (nonatomic,copy)NSString *dep_id;
@property (nonatomic,copy)NSString *sdep_id;




- (id)initWithDic:(NSDictionary *)dic;



+(id)exThreeModelInithDic:(NSDictionary *)dic;
@end
