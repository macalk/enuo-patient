//
//  DocOrderViewController.h
//  enuoS
//
//  Created by apple on 16/8/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface DocOrderViewController : RootViewController


@property (nonatomic,copy)NSString *hosId;
@property (nonatomic,copy)NSString *hosName;
@property (nonatomic,copy)NSString *docId;
@property (nonatomic,copy)NSString *docName;
@property (nonatomic,copy)NSString *dep_id;
@property (nonatomic,copy)NSString *illID;


@property (nonatomic,copy)NSString *VIP;

@property (nonatomic,copy)NSString *currentSunDeskID;

@property (nonatomic,copy)NSString *ill;//疾病
@property (nonatomic,copy)NSString *classify;//详细分类
@property (nonatomic,copy)NSString *cureWay;//治疗方式
@property (nonatomic,copy)NSString *price;//约定价格
@property (nonatomic,copy)NSString *cycle;//约定周期




@end
