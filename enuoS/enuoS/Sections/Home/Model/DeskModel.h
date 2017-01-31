//
//  DeskModel.h
//  enuoNew
//
//  Created by apple on 16/7/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeskModel : NSObject
@property (nonatomic,copy)NSString *department;
@property (nonatomic,copy)NSString *cid;
@property (nonatomic,copy)NSString *photo;


- (id)initWithDic:(NSDictionary *)dic;
+ (id)deskModelInitWithDic:(NSDictionary *)dic;

@end
