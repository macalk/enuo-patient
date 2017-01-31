//
//  SearchILLDocCell.h
//  enuoS
//
//  Created by apple on 16/11/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchillDocModel;
@interface SearchILLDocCell : UITableViewCell

@property (nonatomic,strong)SearchillDocModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *professionalLabel;//主治
@property (weak, nonatomic) IBOutlet UILabel *deskLabel;//科室
@property (weak, nonatomic) IBOutlet UILabel *hosNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *peopleNumLabel;//预约人数
@property (weak, nonatomic) IBOutlet UILabel *nuoLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentNumLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;



@end
