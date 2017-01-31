//
//  CheckPayCell.h
//  enuoS
//
//  Created by apple on 16/7/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckPayCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *markLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *hosLabel;
@property (weak, nonatomic) IBOutlet UILabel *docLabel;
@property (weak, nonatomic) IBOutlet UILabel *zhuSuLabel;

@property (weak, nonatomic) IBOutlet UILabel *illLabel;


@property (weak, nonatomic) IBOutlet UILabel *yCheckLabel;


@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;



@property (weak, nonatomic) IBOutlet UIButton *sureBtton;

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;











@end
