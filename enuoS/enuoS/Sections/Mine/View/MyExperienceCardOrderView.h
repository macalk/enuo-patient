//
//  MyExperienceCardOrderView.h
//  enuoS
//
//  Created by apple on 16/12/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyExperienceCardOrderModel.h"

@interface MyExperienceCardOrderView : UIView

- (void)createViewWithModel:(MyExperienceCardOrderModel *)model;

@property (nonatomic,strong)MyExperienceCardOrderModel *model;

@property (nonatomic,strong)UIImageView *hosImageView;
@property (nonatomic,strong)UILabel *hosNameLabel;
@property (nonatomic,strong)UILabel *typeLabel;

@property (nonatomic,strong)UIView *bgView;

@property (nonatomic,strong)UILabel *illLabel;//疾病项目
@property (nonatomic,strong)UILabel *illTextLabel;

@property (nonatomic,strong)UILabel *cardOrderLabel;//单号
@property (nonatomic,strong)UILabel *cardOrderTextLabel;

@property (nonatomic,strong)UILabel *timeLabel;//时间
@property (nonatomic,strong)UILabel *timeTextLabel;

@property (nonatomic,strong)UILabel *evaluateLabel;//评价
@property (nonatomic,strong)UILabel *evaluateTextLabel;

@property (nonatomic,strong)UIButton *button;


@end
