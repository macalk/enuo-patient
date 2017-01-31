//
//  WaitDocTableViewCell.h
//  enuoS
//
//  Created by apple on 16/7/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaitDocTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *belowView;

@property (weak, nonatomic) IBOutlet UILabel *hosLabel;

@property (weak, nonatomic) IBOutlet UILabel *deskLabel;


@property (weak, nonatomic) IBOutlet UILabel *docLabel;

@property (weak, nonatomic) IBOutlet UILabel *illLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UIButton *onlyButton;

@end
