//
//  pjHosModel.h
//  enuoS
//
//  Created by apple on 16/8/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface pjHosModel : NSObject

@property (nonatomic,copy)NSString *cid;

@property (nonatomic,copy)NSString *hos_id;
@property (nonatomic,copy)NSString *hospital;

@property (nonatomic,copy)NSString *hos_content;

@property (nonatomic,copy)NSString *hos_zhui;

@property (nonatomic,copy)NSString *hospital_photo;


- (id)initWithDic:(NSDictionary *)dic;

+ (id)pjHosModelInitWith:(NSDictionary *)dic;




@end
