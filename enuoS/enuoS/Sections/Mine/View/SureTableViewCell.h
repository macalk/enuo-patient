//
//  SureTableViewCell.h
//  enuo4
//
//  Created by apple on 16/4/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SureTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dnummberLabel;
@property (weak, nonatomic) IBOutlet UILabel *jbLabel;
@property (weak, nonatomic) IBOutlet UILabel *hospitalLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UILabel *pay_statue;
@property (weak, nonatomic) IBOutlet UILabel *cycleLabel;
@property (weak, nonatomic) IBOutlet UILabel *effecttLabel;
@property (weak, nonatomic) IBOutlet UILabel *underStandLabel;
@property (weak, nonatomic) IBOutlet UIButton *seeButton;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;
@property (weak, nonatomic) IBOutlet UIButton *passButton;

@end
