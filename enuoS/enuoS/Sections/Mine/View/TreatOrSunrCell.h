//
//  TreatOrSunrCell.h
//  enuoS
//
//  Created by apple on 16/7/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TreatOrSunrCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *markLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderLabel;
@property (weak, nonatomic) IBOutlet UILabel *hosLabel;
@property (weak, nonatomic) IBOutlet UILabel *docLabel;
@property (weak, nonatomic) IBOutlet UILabel *treatLabel;
@property (weak, nonatomic) IBOutlet UILabel *checkMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *treatMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;
@property (weak, nonatomic) IBOutlet UIView *belowLabel;

@end
