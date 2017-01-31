//
//  DeskTwoModel.h
//  enuoNew
//
//  Created by apple on 16/7/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeskTwoModel: NSObject

@property(nonatomic,copy)NSString *PID;
@property (nonatomic,copy)NSString *cid;
@property (nonatomic,copy)NSString *sDepName;
@property (nonatomic,copy)NSString *photo;


- (id)initWithDic:(NSDictionary *)dic;

+ (id)deskTwoModelWithDic:(NSDictionary *)dic;


@end
