//
//  StateModel.h
//  enuo4
//
//  Created by apple on 16/5/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StateModel : NSObject
@property (nonatomic,copy)NSString *dnumber;
@property (nonatomic,copy)NSString *date;
@property (nonatomic,copy)NSString *doctor_name;
@property (nonatomic,copy)NSString *jb;
@property (nonatomic,copy)NSString *price;
@property (nonatomic,copy)NSString *pay_situation;
- (id)initWithDic:(NSDictionary *)dic;

+ (id)stateModelWithDic:(NSDictionary *)dic;


@end
