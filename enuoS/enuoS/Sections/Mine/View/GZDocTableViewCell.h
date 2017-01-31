//
//  GZDocTableViewCell.h
//  enuoS
//
//  Created by apple on 16/8/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GZDocTableViewCell : UITableViewCell



@property (weak, nonatomic) IBOutlet UIButton *gzBtn;



@property (weak, nonatomic) IBOutlet UIImageView *photoImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *nuoImage;
@property (weak, nonatomic) IBOutlet UILabel *nuoNumber;
@property (weak, nonatomic) IBOutlet UILabel *proLabel;
@property (weak, nonatomic) IBOutlet UILabel *deskLabel;
@property (weak, nonatomic) IBOutlet UILabel *hosLabel;
@property (weak, nonatomic) IBOutlet UILabel *pepLaebl;

@property (weak, nonatomic) IBOutlet UIView *bgView;








@end
