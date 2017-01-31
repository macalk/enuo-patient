//
//  OrderView.h
//  enuoS
//
//  Created by apple on 16/11/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>


@class MyOrderInfoModel;

@interface OrderView : UIView

- (void)createViewWithModel:(MyOrderInfoModel *)model;

@property (nonatomic,strong)MyOrderInfoModel *model;

@property (nonatomic,strong)UIView *bgView;

@property (nonatomic,strong)UIView *baseView;
@property (nonatomic,strong)UILabel *hosNameLabel;
@property (nonatomic,strong)UIImageView *headImageView;

@property (nonatomic,strong)UILabel *rankLabel;
@property (nonatomic,strong)UILabel *typeNameLabel;
@property (nonatomic,strong)UILabel *orderNumberlabel;
@property (nonatomic,strong)UILabel *orderNumberTextLable;
@property (nonatomic,strong)UILabel *hosLable;
@property (nonatomic,strong)UILabel *hosTextLabel;
@property (nonatomic,strong)UILabel *deskLabel;
@property (nonatomic,strong)UILabel *deskTextLabel;
@property (nonatomic,strong)UILabel *docLabel;
@property (nonatomic,strong)UILabel *docTextLabel;
@property (nonatomic,strong)UILabel *illLabel;
@property (nonatomic,strong)UILabel *illTextLabel;
@property (nonatomic,strong)UILabel *categoryLabel;
@property (nonatomic,strong)UILabel *categoryTextLabel;
@property (nonatomic,strong)UILabel *treatLabel;
@property (nonatomic,strong)UILabel *treatTextLabel;
@property (nonatomic,strong)UILabel *payStyleLabel;
@property (nonatomic,strong)UILabel *payStyleTextLbel;
@property (nonatomic,strong)UILabel *juanLable;
@property (nonatomic,strong)UILabel *juanTextLabel;
@property (nonatomic,strong)UILabel *priceLabel;
@property (nonatomic,strong)UILabel *priceTextLabel;

@property (nonatomic,strong)UILabel *checkLabel;
@property (nonatomic,strong)UILabel *checkTextLabel;
@property (nonatomic,strong)UILabel *ybMoneyLabel;
@property (nonatomic,strong)UILabel *ybMoneyTextLabel;
@property (nonatomic,strong)UILabel *reallyPayLabel;
@property (nonatomic,strong)UILabel *reallyPayTextLabel;
@property (nonatomic,strong)UILabel *allNeedPayLabel;
@property (nonatomic,strong)UILabel *allNeedPayTextLabel;
@property (nonatomic,strong)UILabel *havePayLabel;
@property (nonatomic,strong)UILabel *havePayTextLabel;
@property (nonatomic,strong)UILabel *reasionLabel;
@property (nonatomic,strong)UILabel *reasionTextLabel;


@property (nonatomic,strong)UILabel *mainSayLabel;
@property (nonatomic,strong)UILabel *mainSayTextLabel;
@property (nonatomic,strong)UILabel *nowDiseaseLabel;
@property (nonatomic,strong)UILabel *nowDiseaseTextLabel;
@property (nonatomic,strong)UILabel *prepaidLabel;

@property (nonatomic,strong)UILabel *prepaidTextLabel;
@property (nonatomic,strong)UILabel *checkDetailLabel;
@property (nonatomic,strong)UILabel *backMoney;
@property (nonatomic,strong)UILabel *backTextMoney;
@property (nonatomic,strong)UILabel *dateLabel;
@property (nonatomic,strong)UILabel *dateTextLabel;
@property (nonatomic,strong)UILabel *sequenceLabel;
@property (nonatomic,strong)UILabel *sequenceTextLabel;
@property (nonatomic,strong)UILabel *payMoneyLabel;
@property (nonatomic,strong)UILabel *payMoneyTextLabel;

@property (nonatomic,strong)UIView  *checkDetailView;

@property (nonatomic,strong)UIButton *cancelBtn;
@property (nonatomic,strong)UIButton *sureBtn;



@end
