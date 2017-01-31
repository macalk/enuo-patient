//
//  PJDocTableViewCell.h
//  enuoS
//
//  Created by apple on 16/8/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PjDocModel.h"

@interface PJDocTableViewCell : UITableViewCell
//@property (weak, nonatomic) IBOutlet UIView *bgView;
//@property (weak, nonatomic) IBOutlet UIImageView *photoImage;
//@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//@property (weak, nonatomic) IBOutlet UIButton *markBtn;
//
//@property (weak, nonatomic) IBOutlet UILabel *proLabel;
//@property (weak, nonatomic) IBOutlet UILabel *deskLabel;
//@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (nonatomic,strong) PjDocModel *model;


@property (weak, nonatomic) IBOutlet UILabel *skillOrEnvironmentLabel;

@property (weak, nonatomic) IBOutlet UIImageView *docImageView;
@property (weak, nonatomic) IBOutlet UILabel *docNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *deskLabel;
@property (weak, nonatomic) IBOutlet UIButton *payBtn;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@property (weak, nonatomic) IBOutlet UIImageView *xx0;
@property (weak, nonatomic) IBOutlet UIImageView *xx1;
@property (weak, nonatomic) IBOutlet UIImageView *xx2;

@property (nonatomic,strong) NSMutableArray *arrOne;
@property (nonatomic,strong) NSMutableArray *arrTwo;

@property (nonatomic,copy) NSString *dnumber;

@end
