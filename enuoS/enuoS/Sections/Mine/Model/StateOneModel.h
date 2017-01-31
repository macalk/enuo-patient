//
//  StateOneModel.h
//  enuo4
//
//  Created by apple on 16/5/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StateOneModel : NSObject
@property (nonatomic,copy)NSString *dnumber;
@property (nonatomic,copy)NSString *jb;
@property (nonatomic,copy)NSString *hospital;
@property (nonatomic,copy)NSString *price;
@property (nonatomic,copy)NSString *pay_statue;
@property(nonatomic,copy)NSString *cycle;
@property (nonatomic,copy)NSString *effectt;
@property (nonatomic,copy)NSString *understand;
- (id)initWithDic:(NSDictionary *)dic;
+ (id)stateOneModelInitWithDic:(NSDictionary *)dic;
@end
