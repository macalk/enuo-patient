//
//  OrderStateViewCell.h
//  enuoS
//
//  Created by apple on 16/8/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderStateViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *hos_name;
@property (weak, nonatomic) IBOutlet UILabel *desk_label;
@property (weak, nonatomic) IBOutlet UILabel *doc_label;
@property (weak, nonatomic) IBOutlet UILabel *ill_label;
@property (weak, nonatomic) IBOutlet UILabel *time_label;
@property (weak, nonatomic) IBOutlet UILabel *dnumber_label;
@property (weak, nonatomic) IBOutlet UILabel *statue_label;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *treateLabel;

@end
