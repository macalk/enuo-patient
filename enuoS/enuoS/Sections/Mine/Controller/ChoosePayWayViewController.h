//
//  ChoosePayWayViewController.h
//  enuoS
//
//  Created by apple on 16/11/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChoosePayWayViewController : UIViewController

@property (nonatomic,strong) NSDictionary *infoDic;

@property (weak, nonatomic) IBOutlet UIImageView *firstImageView;
@property (weak, nonatomic) IBOutlet UIImageView *secondImageView;
@property (weak, nonatomic) IBOutlet UIImageView *thirdImageView;

@property (nonatomic,copy) NSString *status;

@end
