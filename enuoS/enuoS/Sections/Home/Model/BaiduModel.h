//
//  BaiduModel.h
//  enuo4
//
//  Created by apple on 16/3/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaiduModel : NSObject

@property (nonatomic,copy)NSString *address;
@property (nonatomic,copy)NSString *area;
@property (nonatomic,copy)NSString *hos_name;
@property (nonatomic,copy)NSString *cid;
@property (nonatomic,copy)NSString *ill;
@property (nonatomic,copy)NSString *lat;
@property (nonatomic,copy)NSString *lng;
@property (nonatomic,copy)NSString *phone;
@property (nonatomic,copy)NSString *photo;


- (id)initWithDic:(NSDictionary *)dic;


+ (id)baiDuModelWithDic:(NSDictionary *)dic;



@end
