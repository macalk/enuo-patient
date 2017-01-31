//
//  LrdTableViewCell.h
//  enuoS
//
//  Created by apple on 16/8/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>


@class LrdDateModel;

@interface LrdTableViewCell : UITableViewCell

@property (nonatomic, strong) LrdDateModel *model;
@property (nonatomic,strong)UILabel *ill;
@end
