//
//  SubmiteValuateVC.h
//  enuoS
//
//  Created by apple on 16/12/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyOrderInfoModel.h"

//发表评价
@interface SubmiteValuateVC : UIViewController

@property (nonatomic,strong)MyOrderInfoModel *model;

@property (nonatomic,copy)NSString *hosImageUrl;
@property (nonatomic,copy)NSString *hosName;
@property (nonatomic,copy)NSString *hosDesk;
@property (nonatomic,copy)NSString *docImageUrl;
@property (nonatomic,copy)NSString *docName;
@property (nonatomic,copy)NSString *docDesk;


@property (weak, nonatomic) IBOutlet UIImageView *hos_imageView;
@property (weak, nonatomic) IBOutlet UILabel *hos_nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *deskLabel;
@property (weak, nonatomic) IBOutlet UITextView *hosTextView;
@property (weak, nonatomic) IBOutlet UIButton *hos_attitudeBtn;

@property (weak, nonatomic) IBOutlet UIImageView *doc_imageView;
@property (weak, nonatomic) IBOutlet UILabel *doc_nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *docDeskLabel;
@property (weak, nonatomic) IBOutlet UITextView *docTextView;
@property (weak, nonatomic) IBOutlet UIButton *sendCommentBtn;

@end
