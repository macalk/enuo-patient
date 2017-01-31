//
//  ConfireCheckTableCell.h
//  enuo4
//
//  Created by apple on 16/5/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfireCheckTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dnumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *hospitalLabel;
@property (weak, nonatomic) IBOutlet UILabel *doctorLabel;
@property (weak, nonatomic) IBOutlet UILabel *main_sayLabel;
@property (weak, nonatomic) IBOutlet UILabel *now_diseaseLabel;
@property (weak, nonatomic) IBOutlet UILabel *check_nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *prepaidLabel;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIButton *passBtn;

@end
