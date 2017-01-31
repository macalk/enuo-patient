//
//  MyExperienceCardDetailCell.h
//  enuoS
//
//  Created by apple on 16/12/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyExperienceCardDetailModel.h"

@interface MyExperienceCardDetailCell : UITableViewCell

@property (nonatomic,strong)MyExperienceCardDetailModel *model;

@property (weak, nonatomic) IBOutlet UILabel *orderNumberLabel;
@property (weak, nonatomic) IBOutlet UIButton *statusButton;
@property (weak, nonatomic) IBOutlet UILabel *illLabel;
@property (weak, nonatomic) IBOutlet UILabel *hosLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@end
