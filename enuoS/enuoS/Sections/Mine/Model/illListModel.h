//
//  illListModel.h
//  enuoS
//
//  Created by apple on 16/8/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface illListModel : NSObject

@property (nonatomic,copy)NSString *ill;
@property (nonatomic,copy)NSString *cid;

- (id)initWithDic:(NSDictionary *)dic;


+ illListModelWithDic:(NSDictionary *)dic;





@end
