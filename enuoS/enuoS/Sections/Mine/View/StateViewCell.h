//
//  StateViewCell.h
//  enuo4
//
//  Created by apple on 16/5/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StateViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dnlabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *doctorLabel;
@property (weak, nonatomic) IBOutlet UILabel *jblabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *jlBtn;
@property (weak, nonatomic) IBOutlet UILabel *payStateLabel;

@end
