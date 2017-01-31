//
//  PayViewController.h
//  enuo4
//
//  Created by apple on 16/4/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLPaySdk.h"

@interface PayViewController : UIViewController<LLPaySdkDelegate>

@property (nonatomic,copy)NSString *notify_url;
@property (nonatomic,copy)NSString *orderNo;
@property (nonatomic,copy)NSString *fee;

@property (nonatomic,copy)NSString *oneUrl;
@property (nonatomic,copy)NSString *twoUrl;
@property (nonatomic,copy)NSString *threeUrl;
@end
