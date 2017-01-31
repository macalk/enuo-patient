//
//  vipModel.h
//  enuoS
//
//  Created by apple on 16/8/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface vipModel : NSObject

@property (nonatomic,copy)NSString *cardno;

@property (nonatomic,copy)NSString *fee;

@property (nonatomic,copy)NSString *ctime;
@property (nonatomic,copy)NSString *etime;
@property (nonatomic,copy)NSString *is_delete;




- (id)initWithDic:(NSDictionary *)dic;

+ (id)vipModelInitWhith:(NSDictionary *)dic;





@end
