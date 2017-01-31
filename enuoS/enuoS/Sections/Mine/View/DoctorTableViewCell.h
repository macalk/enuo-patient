//
//  DoctorTableViewCell.h
//  enuo2
//
//  Created by apple on 16/3/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoctorTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *DoctorPhoto;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *hospitalLabel;
@property (weak, nonatomic) IBOutlet UILabel *professionalLabel;
@property (weak, nonatomic) IBOutlet UILabel *zhenLabel;
@property (weak, nonatomic) IBOutlet UILabel *nuoLabel;
@property (weak, nonatomic) IBOutlet UIImageView *picLabel;
@property (weak, nonatomic) IBOutlet UILabel *illLabel;
@property (weak, nonatomic) IBOutlet UILabel *treatmentLabel;

@end
