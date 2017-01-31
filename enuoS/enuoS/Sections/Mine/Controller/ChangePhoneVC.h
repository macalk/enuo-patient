//
//  ChangePhoneVC.h
//  enuoS
//
//  Created by apple on 16/12/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePhoneVC : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *yzCodeTextField;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@property (nonatomic,copy) NSString *state; //状态值

@end
