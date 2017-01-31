//
//  hosHomePageCellTableViewCell.h
//  enuoS
//
//  Created by apple on 16/11/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HosModel;

@interface hosHomePageCellTableViewCell : UITableViewCell

@property (nonatomic,strong)HosModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *userHeadImage;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *serveImage1;
@property (weak, nonatomic) IBOutlet UIImageView *serveImage2;
@property (weak, nonatomic) IBOutlet UIImageView *serveImage3;
@property (weak, nonatomic) IBOutlet UIImageView *serveImage4;
@property (weak, nonatomic) IBOutlet UIImageView *serveImage5;
@property (weak, nonatomic) IBOutlet UIImageView *environmentImage1;
@property (weak, nonatomic) IBOutlet UIImageView *environmentImage2;
@property (weak, nonatomic) IBOutlet UIImageView *environmentImage3;
@property (weak, nonatomic) IBOutlet UIImageView *environmentImage4;
@property (weak, nonatomic) IBOutlet UIImageView *environmentImage5;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;



@end
