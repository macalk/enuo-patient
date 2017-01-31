//
//  RefundTableViewCell.h
//  enuoS
//
//  Created by apple on 16/7/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RefundTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *belowView;
@property (weak, nonatomic) IBOutlet UILabel *orderLabel;

@property (weak, nonatomic) IBOutlet UILabel *hosLbael;
@property (weak, nonatomic) IBOutlet UILabel *illLabel;
@property (weak, nonatomic) IBOutlet UILabel *checkLabel;
@property (weak, nonatomic) IBOutlet UILabel *alreadyMoneyLabel;


@property (weak, nonatomic) IBOutlet UILabel *actualMoneyLabel;

@property (weak, nonatomic) IBOutlet UILabel *markLabel;

@property (weak, nonatomic) IBOutlet UILabel *MoneyLabel;


@property (weak, nonatomic) IBOutlet UIButton *onlyButton;



@end
