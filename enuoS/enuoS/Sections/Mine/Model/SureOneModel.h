//
//  SureOneModel.h
//  enuo4
//
//  Created by apple on 16/4/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SureOneModel : NSObject
@property (nonatomic,copy)NSString *zhenduan;
@property (nonatomic,copy)NSString *main_say;
@property (nonatomic,copy)NSString *now_disease;
@property (nonatomic,copy)NSString *dody_check;
@property (nonatomic,copy)NSString *he_check;
@property (nonatomic,copy)NSString *lab_check;
- (id)initWithDic:(NSDictionary *)dic;

+ (id)sureOneModelInithWithDic:(NSDictionary *)dic;



@end
