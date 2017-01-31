//
//  StateTwoModel.h
//  enuo4
//
//  Created by apple on 16/5/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StateTwoModel : NSObject
@property (nonatomic,copy)NSString *main_say;
@property (nonatomic,copy)NSString *lab_check;
@property (nonatomic,copy)NSString *zhenduan;
@property (nonatomic,copy)NSString *now_disease;
@property (nonatomic,copy)NSString *he_check;
@property (nonatomic,copy)NSString *dody_check;



- (id)initWithDic:(NSDictionary *)dic;
+ (id)stateTwoModelWithDic:(NSDictionary*)dic;


@end
