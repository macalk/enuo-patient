//
//  AppointViewCell.h
//  enuo4
//
//  Created by apple on 16/5/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppointViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dnumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *hospitalLabel;
@property (weak, nonatomic) IBOutlet UILabel *doctorLabel;
@property (weak, nonatomic) IBOutlet UILabel *check_nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *prepaidLabe;
@property (weak, nonatomic) IBOutlet UIButton *passBtn;

@end
