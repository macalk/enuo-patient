//
//  PJHosTableViewCell.h
//  enuoS
//
//  Created by apple on 16/8/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PJHosTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *hosPhoto;
@property (weak, nonatomic) IBOutlet UILabel *hosLabel;

@property (weak, nonatomic) IBOutlet UIButton *markBtn;

@property (weak, nonatomic) IBOutlet UILabel *centLabel;
@end
