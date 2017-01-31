//
//  OrderView.m
//  enuoS
//
//  Created by apple on 16/11/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "OrderView.h"
#import "MyOrderInfoModel.h"
#import "Masonry.h"
#import "Macros.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIColor+Extend.h"



@implementation OrderView


- (UIView *)baseView {
    if (!_baseView) {
        _baseView = [[UIView alloc]init];
        _baseView.backgroundColor = [UIColor whiteColor];
    }return _baseView;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
    }return _bgView;
}

- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc]init];
    }return _headImageView;
}
- (UILabel *)hosNameLabel {
    if (!_hosNameLabel) {
        _hosNameLabel = [[UILabel alloc]init];
        _hosNameLabel.textColor = [UIColor stringTOColor:@"#00afa1"];
    }return _hosNameLabel;
}

- (UILabel *)rankLabel {
    if (!_rankLabel) {
        _rankLabel = [[UILabel alloc]init];
    }return _rankLabel;
}
- (UILabel *)typeNameLabel {
    if (!_typeNameLabel) {
        _typeNameLabel = [[UILabel alloc]init];
        _typeNameLabel.textColor = [UIColor orangeColor];
    }return _typeNameLabel;
}
- (UILabel *)orderNumberlabel {
    if (!_orderNumberlabel) {
        _orderNumberlabel = [[UILabel alloc]init];
    }return _orderNumberlabel;
}
- (UILabel *)orderNumberTextLable {
    if (!_orderNumberTextLable) {
        _orderNumberTextLable = [[UILabel alloc]init];
    }return _orderNumberTextLable;
}
- (UILabel *)hosLable {
    if (!_hosLable) {
        _hosLable = [[UILabel alloc]init];
    }return _hosLable;
}
- (UILabel *)hosTextLabel {
    if (!_hosTextLabel) {
        _hosTextLabel = [[UILabel alloc]init];
    }return _hosTextLabel;
}
- (UILabel *)deskLabel {
    if (!_deskLabel) {
        _deskLabel = [[UILabel alloc]init];
    }return _deskLabel;
}
- (UILabel *)deskTextLabel {
    if (!_deskTextLabel) {
        _deskTextLabel = [[UILabel alloc]init];
    }return _deskTextLabel;
}
- (UILabel *)docLabel {
    if (!_docLabel) {
        _docLabel = [[UILabel alloc]init];
    }return _docLabel;
}
- (UILabel *)docTextLabel {
    if (!_docTextLabel) {
        _docTextLabel = [[UILabel alloc]init];
    }return _docTextLabel;
}
- (UILabel *)illLabel {
    if (!_illLabel) {
        _illLabel = [[UILabel alloc]init];
    }return _illLabel;
}
- (UILabel *)illTextLabel {
    if (!_illTextLabel) {
        _illTextLabel = [[UILabel alloc]init];
    }return _illTextLabel;
}
- (UILabel *)categoryLabel {
    if (!_categoryLabel) {
        _categoryLabel = [[UILabel alloc]init];
    }return _categoryLabel;
}
- (UILabel *)categoryTextLabel {
    if (!_categoryTextLabel) {
        _categoryTextLabel = [[UILabel alloc]init];
    }return _categoryTextLabel;
}
- (UILabel *)treatLabel {
    if (!_treatLabel) {
        _treatLabel = [[UILabel alloc]init];
    }return _treatLabel;
}
- (UILabel *)treatTextLabel {
    if (!_treatTextLabel) {
        _treatTextLabel = [[UILabel alloc]init];
    }return _treatTextLabel;
}
- (UILabel *)payStyleLabel {
    if (!_payStyleLabel) {
        _payStyleLabel = [[UILabel alloc]init];
    }return _payStyleLabel;
}
- (UILabel *)payStyleTextLbel {
    if (!_payStyleTextLbel) {
        _payStyleTextLbel = [[UILabel alloc]init];
    }return _payStyleTextLbel;
}

- (UILabel *)checkLabel {
    if (!_checkLabel) {
        _checkLabel = [[UILabel alloc]init];
    }return _checkLabel;
}
- (UILabel *)checkTextLabel {
    if (!_checkTextLabel) {
        _checkTextLabel = [[UILabel alloc]init];
    }return _checkTextLabel;
}
- (UILabel *)ybMoneyLabel {
    if (!_ybMoneyLabel) {
        _ybMoneyLabel = [[UILabel alloc]init];
    }return _ybMoneyLabel;
}
- (UILabel *)ybMoneyTextLabel {
    if (!_ybMoneyTextLabel) {
        _ybMoneyTextLabel = [[UILabel alloc]init];
    }return _ybMoneyTextLabel;
}
- (UILabel *)juanLable {
    if (!_juanLable) {
        _juanLable = [[UILabel alloc]init];
    }return _juanLable;
}
- (UILabel *)juanTextLabel {
    if (!_juanTextLabel) {
        _juanTextLabel = [[UILabel alloc]init];
                
    }return _juanTextLabel;
}
- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
    }return _priceLabel;
}
- (UILabel *)priceTextLabel {
    if (!_priceTextLabel) {
        _priceTextLabel = [[UILabel alloc]init];
    }return _priceTextLabel;
}
- (UILabel *)mainSayLabel {
    if (!_mainSayLabel) {
        _mainSayLabel = [[UILabel alloc]init];
    }return _mainSayLabel;
}

- (UILabel *)mainSayTextLabel {
    if (!_mainSayTextLabel) {
        _mainSayTextLabel = [[UILabel alloc]init];
    }return _mainSayTextLabel;
}

- (UILabel *)nowDiseaseLabel {
    if (!_nowDiseaseLabel) {
        _nowDiseaseLabel = [[UILabel alloc]init];
    }return _nowDiseaseLabel;
}

- (UILabel *)nowDiseaseTextLabel {
    if (!_nowDiseaseTextLabel) {
        _nowDiseaseTextLabel = [[UILabel alloc]init];
    }return _nowDiseaseTextLabel;
}

- (UILabel *)prepaidLabel {
    if (!_prepaidLabel) {
        _prepaidLabel = [[UILabel alloc]init];
    }return _prepaidLabel;
}

- (UILabel *)prepaidTextLabel {
    if (!_prepaidTextLabel) {
        _prepaidTextLabel = [[UILabel alloc]init];
    }return _prepaidTextLabel;
}

- (UILabel *)checkDetailLabel {
    if (!_checkDetailLabel) {
        _checkDetailLabel = [[UILabel alloc]init];
    }return _checkDetailLabel;
}

- (UILabel *)allNeedPayLabel {
    if (!_allNeedPayLabel) {
        _allNeedPayLabel = [[UILabel alloc]init];
    }return _allNeedPayLabel;
}

- (UILabel *)allNeedPayTextLabel {
    if (!_allNeedPayTextLabel) {
        _allNeedPayTextLabel = [[UILabel alloc]init];
    }return _allNeedPayTextLabel;
}
- (UILabel *)havePayLabel {
    if (!_havePayLabel) {
        _havePayLabel = [[UILabel alloc]init];
    }return _havePayLabel;
}

- (UILabel *)havePayTextLabel {
    if (!_havePayTextLabel) {
        _havePayTextLabel = [[UILabel alloc]init];
    }return _havePayTextLabel;
}
- (UILabel *)reallyPayLabel {
    if (!_reallyPayLabel) {
        _reallyPayLabel = [[UILabel alloc]init];
    }return _reallyPayLabel;
}

- (UILabel *)reallyPayTextLabel {
    if (!_reallyPayTextLabel) {
        _reallyPayTextLabel = [[UILabel alloc]init];
    }return _reallyPayTextLabel;
}

- (UILabel *)backMoney {
    if (!_backMoney) {
        _backMoney = [[UILabel alloc]init];
    }return _backMoney;
}

- (UILabel *)backTextMoney {
    if (!_backTextMoney) {
        _backTextMoney = [[UILabel alloc]init];
    }return _backTextMoney;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc]init];
    }return _dateLabel;
}

- (UILabel *)dateTextLabel {
    if (!_dateTextLabel) {
        _dateTextLabel = [[UILabel alloc]init];
    }return _dateTextLabel;
}

- (UILabel *)sequenceLabel {
    if (!_sequenceLabel) {
        _sequenceLabel = [[UILabel alloc]init];
    }return _sequenceLabel;
}

- (UILabel *)sequenceTextLabel {
    if (!_sequenceTextLabel) {
        _sequenceTextLabel = [[UILabel alloc]init];
    }return _sequenceTextLabel;
}

- (UILabel *)payMoneyLabel {
    if (!_payMoneyLabel) {
        _payMoneyLabel = [[UILabel alloc]init];
    }return _payMoneyLabel;
}

- (UILabel *)payMoneyTextLabel {
    if (!_payMoneyTextLabel) {
        _payMoneyTextLabel = [[UILabel alloc]init];
        _payMoneyTextLabel.font = [UIFont systemFontOfSize:13];
    }return _payMoneyTextLabel;
}

- (UIView *)checkDetailView {
    if (!_checkDetailView) {
        _checkDetailView = [[UIView alloc]init];
        NSArray *array = self.model.check_list;
        for (int i = 0; i<array.count; i++) {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, i*20, 300, 15)];
            label.font = [UIFont systemFontOfSize:13];
            label.textColor = [UIColor blackColor];
            label.text = [NSString stringWithFormat:@"%@",array[i]];
            [_checkDetailView addSubview:label];
        }
    }return _checkDetailView;
}
- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc]init];
        _cancelBtn.backgroundColor = [UIColor whiteColor];
        [_cancelBtn setTitleColor:[UIColor grayColor] forState:normal];
        _cancelBtn.layer.borderWidth = 1;
        _cancelBtn.layer.borderColor = [[UIColor grayColor]CGColor];
        _cancelBtn.layer.cornerRadius = 5;
        _cancelBtn.clipsToBounds = YES;
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    }return _cancelBtn;
}
- (UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [[UIButton alloc]init];
        _sureBtn.backgroundColor = [UIColor stringTOColor:@"#00afa1"];
        _sureBtn.layer.cornerRadius = 5;
        _sureBtn.clipsToBounds = YES;
        _sureBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    }return _sureBtn;
}
- (UILabel *)reasionLabel {
    if (!_reasionLabel) {
        _reasionLabel = [[UILabel alloc]init];
    }return _reasionLabel;
}
- (UILabel *)reasionTextLabel {
    if (!_reasionTextLabel) {
        _reasionTextLabel = [[UILabel alloc]init];
    }return _reasionTextLabel;
}


- (void)createViewWithModel:(MyOrderInfoModel *)model {
    
    self.backgroundColor = [UIColor stringTOColor:@"#efefef"];
    self.bgView.backgroundColor = [UIColor stringTOColor:@"#efefef"];

    
    self.model = model;
    /**********头***********/
    [self addSubview:self.baseView];
    
    
    //头像
        self.headImageView.layer.borderWidth = 1;
        self.headImageView.layer.borderColor = [UIColor stringTOColor:@"#666666"].CGColor;
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:urlPicture,self.model.photo]]];
    
    
    
    //医院名字
    self.hosNameLabel.text = self.model.hos_name;
    self.hosNameLabel.font = [UIFont systemFontOfSize:15];
    
    //当前状态label
    self.typeNameLabel.font = [UIFont systemFontOfSize:10];
    self.typeNameLabel.text = self.model.type_name;
    
    if (self.model.type_id == 5.1) {
        self.hosNameLabel.text = self.model.doc_name;
        self.rankLabel.text = self.model.dep_name;
    }
    
    /**
     *******中间*********/
    
    //预约单号
    self.orderNumberlabel.text = @"预约单号:";
    
    self.orderNumberTextLable.text = self.model.dnumber;
    
    //预约医院
    self.hosLable.text=  @"预约医院:";
    
    self.hosTextLabel.text = self.model.hos_name;
    
    //科室
    self.deskLabel.text = @"预约科室:";
    self.deskTextLabel.text = self.model.dep_name;
    
    //预约医生
    self.docLabel.text = @"预约医生:";
    self.docTextLabel.text = self.model.doc_name;
    
    //疾病
    self.illLabel.text = @"疾       病:";
    self.illTextLabel.text = self.model.ill;
    
    //种类
    self.categoryLabel.text = @"详细分类:";
    self.categoryTextLabel.text = self.model.category;
    
    //方式
    self.treatLabel.text = @"治疗方式:";
    self.treatTextLabel.text = self.model.treat;
    
    //支付方式
    self.payStyleLabel.text = @"支付方式:";
    self.payStyleTextLbel.text = [NSString stringWithFormat:@"%@(第%ld期/共%ld期)",self.model.pay_method,(long)self.model.step,(long)self.model.sum_step];
    
    //劵
    self.juanLable.text = @"代  金  劵:";
    self.juanTextLabel.text = @"请  选  择";
    
    //约定金额
    self.priceLabel.text = @"约定金额:";
    self.priceTextLabel.text = self.model.pay_money;
    
    //检查金额
    self.checkLabel.text = @"检查费用:";
    
    self.checkTextLabel.text = self.model.pay_money;
    
    //医保
    self.ybMoneyLabel.text = @"医       保:";
    
    //主诉
    self.mainSayLabel.text = @"主       诉:";
    self.mainSayTextLabel.text = self.model.main_say;
    
    //现病史
    self.nowDiseaseLabel.text = @"现  病  史:";
    self.nowDiseaseTextLabel.text = self.model.now_disease;
    
    //预交金额
    self.prepaidLabel.text = @"预交金额:";
    self.prepaidTextLabel.text = self.model.pay_money;
    
    //检查明细
    self.checkDetailLabel.text = @"检查名细:";
    //    [self.bgView addSubview:self.checkDetailView];
    
    //实付金额
    self.reallyPayLabel.text = @"实付金额:";
    self.reallyPayTextLabel.text = self.model.pay_money;
    
    //退款金额
    self.backMoney.text = @"退款金额:";
    self.backTextMoney.text = [NSString stringWithFormat:@"%f",self.model.back_money];
    
    //预约时间
    self.dateLabel.text = @"约诊时间:";
    self.dateTextLabel.text = self.model.yue_time;
    
    //预约排号
    self.sequenceLabel.text = @"预约排号:";
    self.sequenceTextLabel.text = self.model.dsort;
    
    //取消原因
    self.reasionLabel.text = @"取消原因:";
    self.reasionTextLabel.text = self.model.delete_reason;
    
    /*********尾部********/
    
    //预交金额
    self.payMoneyLabel.text = @"预交金额:";
    
    self.payMoneyTextLabel.text = self.model.price;
    
    NSArray *labelArr = @[self.orderNumberlabel,
                          self.orderNumberTextLable,
                          self.hosLable,
                          self.hosTextLabel,
                          self.deskLabel,
                          self.deskTextLabel,
                          self.docLabel,
                          self.docTextLabel,
                          self.illLabel,
                          self.illTextLabel,
                          self.categoryLabel,
                          self.categoryTextLabel,
                          self.treatLabel,
                          self.treatTextLabel,
                          self.payStyleLabel,
                          self.payStyleTextLbel,
                          self.juanLable,
                          self.juanTextLabel,
                          self.priceLabel,
                          self.priceTextLabel,
                          self.checkLabel,
                          self.checkTextLabel,
                          self.ybMoneyLabel,
                          self.ybMoneyTextLabel,
                          self.mainSayLabel,
                          self.mainSayTextLabel,
                          self.nowDiseaseLabel,
                          self.nowDiseaseTextLabel,
                          self.prepaidLabel,
                          self.prepaidTextLabel,
                          self.checkDetailLabel,
                          self.reallyPayLabel,
                          self.reallyPayTextLabel,
                          self.backMoney,
                          self.backTextMoney,
                          self.dateLabel,
                          self.dateTextLabel,
                          self.sequenceLabel,
                          self.sequenceTextLabel,
                          self.reasionLabel,
                          self.reasionTextLabel,
                          self.payMoneyLabel];
    for (int i = 0;i<labelArr.count ; i++) {
        UILabel *label = labelArr[i];
        label.font = [UIFont systemFontOfSize:13];
    }
        
    /***********检查明细*********/
    NSArray *titleArray = @[@"项目",@"金额",@"自费金额",@"医保金额"];
    NSInteger lineNum = self.model.check_detail.count +1;
    float labelWidth = self.checkDetailView.bounds.size.width/4;
    for (int i = 0; i<lineNum*4; i++) {
        UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(labelWidth*(i%4), (i/4)*50, labelWidth, 50)];
        detailLabel.textAlignment = NSTextAlignmentCenter;
        [self.checkDetailView addSubview:detailLabel];
        if (i<4) {
            detailLabel.text = titleArray[i];
        }else {
            detailLabel.text = @"111";
        }
    }
    
    
    
    /********布局开始********/
    //1.通用模块
    [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(10);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
    
    if (self.model.type_id<0) {//取消的订单
        [self.baseView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.bgView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        [self allUse];
        
        [self.baseView addSubview:self.bgView];
        
        [self.bgView addSubview:self.orderNumberlabel];
        [self.bgView addSubview:self.orderNumberTextLable];
        [self.bgView addSubview:self.deskLabel];
        [self.bgView addSubview:self.deskTextLabel];
        [self.bgView addSubview:self.docLabel];
        [self.bgView addSubview:self.docTextLabel];
        [self.bgView addSubview:self.dateLabel];
        [self.bgView addSubview:self.dateTextLabel];
        [self.bgView addSubview:self.reasionLabel];
        [self.bgView addSubview:self.reasionTextLabel];
        
        //单号
        [self.orderNumberlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.baseView).with.offset(20);
            make.top.equalTo(self.headImageView.mas_bottom).with.offset(20);
        }];
        
        [self.orderNumberTextLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.orderNumberlabel.mas_centerY);
            make.left.equalTo(self.orderNumberlabel.mas_right).with.offset(10);
        }];
        
        //科室
        [self.deskLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.baseView).with.offset(20);
            make.top.equalTo(self.orderNumberlabel.mas_bottom).with.offset(9);
            
        }];
        [self.deskTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.deskLabel.mas_centerY);
            make.left.equalTo(self.deskLabel.mas_right).with.offset(10);
        }];
        
        //预约医生
        [self.docLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.baseView).with.offset(20);
            make.top.equalTo(self.deskLabel.mas_bottom).with.offset(9);
        }];
        
        [self.docTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.docLabel.mas_centerY);
            make.left.equalTo(self.docLabel.mas_right).with.offset(10);
        }];
        
        
        //时间
        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.baseView).with.offset(20);
            make.top.equalTo(self.docLabel.mas_bottom).with.offset(9);
        }];
        
        [self.dateTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.dateLabel.mas_centerY);
            make.left.equalTo(self.dateLabel.mas_right).with.offset(10);
        }];
        
        //原因
        [self.reasionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.baseView).with.offset(20);
            make.top.equalTo(self.dateLabel.mas_bottom).with.offset(9);
        }];
        
        [self.reasionTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.reasionLabel.mas_centerY);
            make.left.equalTo(self.reasionLabel.mas_right).with.offset(10);
        }];
        
        //bgView
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headImageView.mas_bottom).with.offset(10);
            make.left.equalTo(self.baseView);
            make.right.equalTo(self.baseView);
            make.bottom.equalTo(self.reasionLabel.mas_bottom).with.offset(10);
        }];
        
        [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(10);
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.bottom.equalTo(self.bgView.mas_bottom).with.offset(30);
        }];
        
        [self layoutIfNeeded];
        model.baseViewHeight = [self.baseView systemLayoutSizeFittingSize: UILayoutFittingCompressedSize].height;

    }
    
    //等待预约确认
    if (self.model.type_id == 0) {
        [self.baseView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.bgView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        [self.cancelBtn setTitle:@"取消治疗" forState:normal];
        
        [self allUse];
        
        [self.baseView addSubview:self.bgView];
        [self.baseView addSubview:self.cancelBtn];

        
        [self.bgView addSubview:self.orderNumberlabel];
        [self.bgView addSubview:self.orderNumberTextLable];
        [self.bgView addSubview:self.deskLabel];
        [self.bgView addSubview:self.deskTextLabel];
        [self.bgView addSubview:self.docLabel];
        [self.bgView addSubview:self.docTextLabel];
        [self.bgView addSubview:self.illLabel];
        [self.bgView addSubview:self.illTextLabel];
        [self.bgView addSubview:self.categoryLabel];
        [self.bgView addSubview:self.categoryTextLabel];
        [self.bgView addSubview:self.treatLabel];
        [self.bgView addSubview:self.treatTextLabel];
        [self.bgView addSubview:self.dateLabel];
        [self.bgView addSubview:self.dateTextLabel];
        
        //单号
        [self.orderNumberlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.baseView).with.offset(20);
            make.top.equalTo(self.headImageView.mas_bottom).with.offset(20);
        }];
        
        [self.orderNumberTextLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.orderNumberlabel.mas_centerY);
            make.left.equalTo(self.orderNumberlabel.mas_right).with.offset(10);
        }];
        
        //科室
        [self.deskLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.baseView).with.offset(20);
            make.top.equalTo(self.orderNumberlabel.mas_bottom).with.offset(9);
            
        }];
        [self.deskTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.deskLabel.mas_centerY);
            make.left.equalTo(self.deskLabel.mas_right).with.offset(10);
        }];
        
        //预约医生
        [self.docLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.baseView).with.offset(20);
            make.top.equalTo(self.deskLabel.mas_bottom).with.offset(9);
        }];
        
        [self.docTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.docLabel.mas_centerY);
            make.left.equalTo(self.docLabel.mas_right).with.offset(10);
        }];
        
        //疾病
        [self.illLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.baseView).with.offset(20);
            make.top.equalTo(self.docLabel.mas_bottom).with.offset(9);
        }];
        
        [self.illTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.illLabel.mas_centerY);
            make.left.equalTo(self.illLabel.mas_right).with.offset(10);
        }];
        
        //种类
        [self.categoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.baseView).with.offset(20);
            make.top.equalTo(self.illLabel.mas_bottom).with.offset(9);
        }];
        
        [self.categoryTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.categoryLabel.mas_centerY);
            make.left.equalTo(self.categoryLabel.mas_right).with.offset(10);
        }];

        
        //方式
        [self.treatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.baseView).with.offset(20);
            make.top.equalTo(self.categoryLabel.mas_bottom).with.offset(9);
        }];
        
        [self.treatTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.treatLabel.mas_centerY);
            make.left.equalTo(self.treatLabel.mas_right).with.offset(10);
        }];
        
        //时间
        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.baseView).with.offset(20);
            make.top.equalTo(self.treatLabel.mas_bottom).with.offset(9);
        }];
        
        [self.dateTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.dateLabel.mas_centerY);
            make.left.equalTo(self.dateLabel.mas_right).with.offset(10);
        }];

        //bgView
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headImageView.mas_bottom).with.offset(10);
            make.left.equalTo(self.baseView);
            make.right.equalTo(self.baseView);
            make.bottom.equalTo(self.dateLabel.mas_bottom).with.offset(10);
        }];
        
        //取消按钮
        [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.baseView).with.offset(-20);
            make.top.equalTo(self.bgView.mas_bottom).with.offset(10);
            make.size.mas_offset(CGSizeMake(80, 25));
        }];
        
        [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(10);
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.bottom.equalTo(self.cancelBtn.mas_bottom).with.offset(10);
        }];
        
        [self layoutIfNeeded];
        model.baseViewHeight = [self.baseView systemLayoutSizeFittingSize: UILayoutFittingCompressedSize].height;

    }
    
    //等待就诊
    if (self.model.type_id == 1 || self.model.type_id == 1.2) {
        
        [self.baseView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.bgView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        [self allUse];
        
        [self.baseView addSubview:self.bgView];
        
        
        
        [self.bgView addSubview:self.hosLable];
        [self.bgView addSubview:self.hosTextLabel];
        
        [self.bgView addSubview:self.deskLabel];
        [self.bgView addSubview:self.deskTextLabel];
        [self.bgView addSubview:self.docLabel];
        [self.bgView addSubview:self.docTextLabel];
        [self.bgView addSubview:self.illLabel];
        [self.bgView addSubview:self.illTextLabel];
        
        //医院
        [self.hosLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.baseView).with.offset(20);
            make.top.equalTo(self.headImageView.mas_bottom).with.offset(20);
        }];
        
        [self.hosTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.hosLable.mas_centerY);
            make.left.equalTo(self.hosLable.mas_right).with.offset(10);
        }];
        
        //科室
        [self.deskLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.baseView).with.offset(20);
            make.top.equalTo(self.hosLable.mas_bottom).with.offset(9);
            
        }];
        [self.deskTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.deskLabel.mas_centerY);
            make.left.equalTo(self.deskLabel.mas_right).with.offset(10);
        }];
        
        //预约医生
        [self.docLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.baseView).with.offset(20);
            make.top.equalTo(self.deskLabel.mas_bottom).with.offset(9);
        }];
        
        [self.docTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.docLabel.mas_centerY);
            make.left.equalTo(self.docLabel.mas_right).with.offset(10);
        }];
        
        //疾病
        [self.illLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.baseView).with.offset(20);
            make.top.equalTo(self.docLabel.mas_bottom).with.offset(9);
        }];
        
        [self.illTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.illLabel.mas_centerY);
            make.left.equalTo(self.illLabel.mas_right).with.offset(10);
        }];
        
        
        
        if (self.model.type_id == 1) {//1：等待就诊
            
            [self.cancelBtn setTitle:@"取消治疗" forState:normal];
            
            [self.bgView addSubview:self.dateLabel];
            [self.bgView addSubview:self.dateTextLabel];
            [self.bgView addSubview:self.orderNumberlabel];
            [self.bgView addSubview:self.orderNumberTextLable];
            [self.bgView addSubview:self.sequenceLabel];
            [self.bgView addSubview:self.sequenceTextLabel];
            [self.baseView addSubview:self.prepaidLabel];
            [self.baseView addSubview:self.prepaidTextLabel];
            [self.baseView addSubview:self.cancelBtn];
            
            
            //预约时间
            [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.baseView).with.offset(20);
                make.top.equalTo(self.illLabel.mas_bottom).with.offset(9);
            }];
            [self.dateTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.dateLabel.mas_centerY);
                make.left.equalTo(self.dateLabel.mas_right).with.offset(10);
            }];
            
            //订单号
            [self.orderNumberlabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.baseView).with.offset(20);
                make.top.equalTo(self.dateLabel.mas_bottom).with.offset(10);
            }];
            
            [self.orderNumberTextLable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.orderNumberlabel.mas_centerY);
                make.left.equalTo(self.orderNumberlabel.mas_right).with.offset(10);
            }];
            
            //预约排号
            [self.sequenceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.baseView).with.offset(20);
                make.top.equalTo(self.orderNumberlabel.mas_bottom).with.offset(9);
            }];
            [self.sequenceTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.sequenceLabel.mas_centerY);
                make.left.equalTo(self.sequenceLabel.mas_right).with.offset(10);
            }];
            
            //bgView
            [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.headImageView.mas_bottom).with.offset(10);
                make.left.equalTo(self.baseView);
                make.right.equalTo(self.baseView);
                make.bottom.equalTo(self.sequenceLabel.mas_bottom).with.offset(10);
            }];
            
//            //预交金额
//            [self.prepaidTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.right.equalTo(self.baseView.mas_right).with.offset(-20);
//                make.top.equalTo(self.bgView.mas_bottom).with.offset(20);
//            }];
//            [self.prepaidLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.centerY.equalTo(self.prepaidTextLabel.mas_centerY);
//                make.right.equalTo(self.prepaidTextLabel.mas_left).with.offset(-10);
//            }];
            
            //取消按钮
            [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.baseView).with.offset(-20);
                make.top.equalTo(self.bgView.mas_bottom).with.offset(10);
                make.size.mas_offset(CGSizeMake(80, 25));
            }];
            
            
            [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).with.offset(10);
                make.left.equalTo(self);
                make.right.equalTo(self);
                make.bottom.equalTo(self.cancelBtn.mas_bottom).with.offset(10);
            }];
            
            [self layoutIfNeeded];
            model.baseViewHeight = [self.baseView systemLayoutSizeFittingSize: UILayoutFittingCompressedSize].height;
            
            
        }else {//完成检查待就诊
            
            [self.cancelBtn setTitle:@"结束治疗" forState:normal];
            
            [self.bgView addSubview:self.checkDetailLabel];
            [self.bgView addSubview:self.checkDetailView];
            [self.bgView addSubview:self.checkLabel];
            [self.bgView addSubview:self.checkTextLabel];
            [self.bgView addSubview:self.prepaidTextLabel];
            [self.bgView addSubview:self.prepaidLabel];
            
            [self.bgView addSubview:self.dateLabel];
            [self.bgView addSubview:self.dateTextLabel];
            [self.bgView addSubview:self.orderNumberlabel];
            [self.bgView addSubview:self.orderNumberTextLable];
            [self.baseView addSubview:self.sequenceLabel];
            [self.baseView addSubview:self.sequenceTextLabel];
            [self.baseView addSubview:self.cancelBtn];
            
            
            //项目检查
            [self.checkDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.baseView).with.offset(20);
                make.top.equalTo(self.illLabel.mas_bottom).with.offset(9);
            }];
            [self.checkDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.checkDetailLabel.mas_top);
                make.left.equalTo(self.checkDetailLabel.mas_right).with.offset(10);
                make.height.mas_offset(self.model.check_list.count*20);
            }];
            
            //检查费用
            [self.checkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.baseView).with.offset(20);
                make.top.equalTo(self.checkDetailView.mas_bottom).with.offset(9);
            }];
            [self.checkTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.checkLabel.mas_centerY);
                make.left.equalTo(self.checkLabel.mas_right).with.offset(10);
            }];
            
            //预约时间
            [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.baseView).with.offset(20);
                make.top.equalTo(self.checkLabel.mas_bottom).with.offset(9);
            }];
            [self.dateTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.dateLabel.mas_centerY);
                make.left.equalTo(self.dateLabel.mas_right).with.offset(10);
            }];
            
            //订单号
            [self.orderNumberlabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.baseView).with.offset(20);
                make.top.equalTo(self.dateLabel.mas_bottom).with.offset(10);
            }];
            
            [self.orderNumberTextLable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.orderNumberlabel.mas_centerY);
                make.left.equalTo(self.orderNumberlabel.mas_right).with.offset(10);
            }];
            
            //预约排号
            [self.sequenceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.baseView).with.offset(20);
                make.top.equalTo(self.orderNumberlabel.mas_bottom).with.offset(9);
            }];
            [self.sequenceTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.sequenceLabel.mas_centerY);
                make.left.equalTo(self.sequenceLabel.mas_right).with.offset(10);
            }];
            
            //bgView
            [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.headImageView.mas_bottom).with.offset(10);
                make.left.equalTo(self.baseView);
                make.right.equalTo(self.baseView);
                make.bottom.equalTo(self.sequenceLabel.mas_bottom).with.offset(10);
            }];
            
//            //预交金额
//            [self.prepaidTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.right.equalTo(self.baseView.mas_right).with.offset(-20);
//                make.top.equalTo(self.bgView.mas_bottom).with.offset(20);
//            }];
//            [self.prepaidLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.centerY.equalTo(self.prepaidTextLabel.mas_centerY);
//                make.right.equalTo(self.prepaidTextLabel.mas_left).with.offset(-10);
//            }];
            
            //取消按钮
            [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.bgView).with.offset(-20);
                make.top.equalTo(self.bgView.mas_bottom).with.offset(10);
                make.size.mas_offset(CGSizeMake(80, 25));
            }];
            
            [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).with.offset(10);
                make.left.equalTo(self);
                make.right.equalTo(self);
                make.bottom.equalTo(self.cancelBtn.mas_bottom).with.offset(10);
            }];
            
            [self layoutIfNeeded];
            model.baseViewHeight = [self.baseView systemLayoutSizeFittingSize: UILayoutFittingCompressedSize].height;
            
        }
        
    }
    
    //待支付
    if (self.model.type_id == 3 || self.model.type_id == 1.1) {
        
        [self.baseView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.bgView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        [self allUse];
        
        [self.baseView addSubview:self.bgView];
        
        
        [self.bgView addSubview:self.orderNumberlabel];
        [self.bgView addSubview:self.orderNumberTextLable];
        [self.bgView addSubview:self.hosLable];
        [self.bgView addSubview:self.hosTextLabel];
        [self.bgView addSubview:self.docLabel];
        [self.bgView addSubview:self.docTextLabel];
        
        //订单号
        [self.orderNumberlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.baseView).with.offset(20);
            make.top.equalTo(self.headImageView.mas_bottom).with.offset(20);
        }];
        [self.orderNumberTextLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.orderNumberlabel.mas_centerY);
            make.left.equalTo(self.orderNumberlabel.mas_right).with.offset(10);
        }];
        
        //医院
        [self.hosLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.baseView).with.offset(20);
            make.top.equalTo(self.orderNumberlabel.mas_bottom).with.offset(9);
        }];
        
        [self.hosTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.hosLable.mas_centerY);
            make.left.equalTo(self.hosLable.mas_right).with.offset(10);
        }];
        
        
        //预约医生
        [self.docLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.baseView).with.offset(20);
            make.top.equalTo(self.hosLable.mas_bottom).with.offset(9);
        }];
        
        [self.docTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.docLabel.mas_centerY);
            make.left.equalTo(self.docTextLabel.mas_right).with.offset(10);
        }];
        
        
        
        
        if (self.model.type_id == 3) {//治疗待支付
            if (self.model.check_money>0) {
                [self.cancelBtn setTitle:@"结束治疗" forState:normal];

            }else {
                [self.cancelBtn setTitle:@"取消治疗" forState:normal];

            }
            [self.sureBtn setTitle:@"确认治疗" forState:normal];
            
            [self.bgView addSubview:self.illLabel];
            [self.bgView addSubview:self.illTextLabel];
            [self.bgView addSubview:self.categoryLabel];
            [self.bgView addSubview:self.categoryTextLabel];
            [self.bgView addSubview:self.treatLabel];
            [self.bgView addSubview:self.treatTextLabel];
            [self.bgView addSubview:self.payStyleLabel];
            [self.bgView addSubview:self.payStyleTextLbel];
            [self.bgView addSubview:self.juanLable];
            [self.bgView addSubview:self.juanTextLabel];
            [self.bgView addSubview:self.priceLabel];
            [self.bgView addSubview:self.priceTextLabel];
            [self.baseView addSubview:self.prepaidTextLabel];
            [self.baseView addSubview:self.prepaidLabel];
            [self.baseView addSubview:self.sureBtn];
            [self.baseView addSubview:self.cancelBtn];
            
            
            //疾病
            [self.illLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.baseView).with.offset(20);
                make.top.equalTo(self.docLabel.mas_bottom).with.offset(9);
            }];
            
            [self.illTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.illLabel.mas_centerY);
                make.left.equalTo(self.illLabel.mas_right).with.offset(10);
            }];
            
            //种类
            [self.categoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.baseView).with.offset(20);
                make.top.equalTo(self.illLabel.mas_bottom).with.offset(9);
            }];
            
            [self.categoryTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.categoryLabel.mas_centerY);
                make.left.equalTo(self.categoryLabel.mas_right).with.offset(10);
            }];
            
            //方式
            [self.treatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.baseView).with.offset(20);
                make.top.equalTo(self.categoryLabel.mas_bottom).with.offset(9);
            }];
            [self.treatTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.treatLabel.mas_centerY);
                make.left.equalTo(self.treatLabel.mas_right).with.offset(10);
            }];
            
            //支付方式
            [self.payStyleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.baseView).with.offset(20);
                make.top.equalTo(self.treatLabel.mas_bottom).with.offset(9);
            }];
            [self.payStyleTextLbel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.payStyleLabel.mas_centerY);
                make.left.equalTo(self.payStyleLabel.mas_right).with.offset(10);
            }];
            
            //劵
            [self.juanLable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.baseView).with.offset(20);
                make.top.equalTo(self.payStyleLabel.mas_bottom).with.offset(9);
                
            }];
            [self.juanTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.juanLable.mas_centerY);
                make.left.equalTo(self.juanLable.mas_right).with.offset(10);
                make.width.mas_offset(@200);
            }];
            
            //约定金额
            [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.baseView).with.offset(20);
                make.top.equalTo(self.juanLable.mas_bottom).with.offset(9);
                
            }];
            [self.priceTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.priceLabel.mas_centerY);
                make.left.equalTo(self.priceLabel.mas_right).with.offset(10);
            }];
            
            //bgView
            [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.headImageView.mas_bottom).with.offset(10);
                make.left.equalTo(self.baseView);
                make.right.equalTo(self.baseView);
                make.bottom.equalTo(self.priceLabel.mas_bottom).with.offset(10);
            }];
            
//            //预交金额
//            [self.prepaidTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.right.equalTo(self.baseView.mas_right).with.offset(-20);
//                make.top.equalTo(self.bgView.mas_bottom).with.offset(10);
//            }];
//            [self.prepaidLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.centerY.equalTo(self.prepaidTextLabel.mas_centerY);
//                make.right.equalTo(self.prepaidTextLabel.mas_left).with.offset(-10);
//            }];
            
            //取消和确认按钮
            [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(_baseView.mas_right).with.offset(-20);
                make.top.equalTo(self.bgView.mas_bottom).with.offset(10);
                make.size.mas_offset(CGSizeMake(80, 25));
            }];
            [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.sureBtn.mas_centerY);
                make.right.equalTo(self.sureBtn.mas_left).with.offset(-20);
                make.size.mas_offset(CGSizeMake(80, 25));
                
            }];
            
            [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).with.offset(10);
                make.left.equalTo(self);
                make.right.equalTo(self);
                make.bottom.equalTo(self.cancelBtn.mas_bottom).with.offset(10);
            }];
            
            [self layoutIfNeeded];
            model.baseViewHeight = [self.baseView systemLayoutSizeFittingSize: UILayoutFittingCompressedSize].height;
            
            
        }else if (self.model.type_id == 1.1) {//检查待支付
            
            [self.sureBtn setTitle:@"确认检查" forState:normal];
            [self.cancelBtn setTitle:@"取消检查" forState:normal];
            
            [self.bgView addSubview:self.mainSayLabel];
            [self.bgView addSubview:self.mainSayTextLabel];
            [self.bgView addSubview:self.nowDiseaseLabel];
            [self.bgView addSubview:self.nowDiseaseTextLabel];
            [self.bgView addSubview:self.checkDetailLabel];
            [self.bgView addSubview:self.checkDetailView];
            [self.bgView addSubview:self.prepaidTextLabel];
            [self.bgView addSubview:self.prepaidLabel];
            [self.baseView addSubview:self.sureBtn];
            [self.baseView addSubview:self.cancelBtn];
            
            //
            //主诉
            [self.mainSayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.baseView).with.offset(20);
                make.top.equalTo(self.docLabel.mas_bottom).with.offset(9);
            }];
            [self.mainSayTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.mainSayLabel.mas_centerY);
                make.left.equalTo(self.mainSayLabel.mas_right).with.offset(10);
            }];
            //现病史
            [self.nowDiseaseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.baseView).with.offset(20);
                make.top.equalTo(self.mainSayLabel.mas_bottom).with.offset(9);
            }];
            [self.nowDiseaseTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.nowDiseaseLabel.mas_centerY);
                make.left.equalTo(self.nowDiseaseLabel.mas_right).with.offset(10);
            }];
            
            //医技检查
            [self.checkDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.baseView).with.offset(20);
                make.top.equalTo(self.nowDiseaseLabel.mas_bottom).with.offset(9);
            }];
            [self.checkDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.checkDetailLabel.mas_top);
                make.left.equalTo(self.checkDetailLabel.mas_right).with.offset(10);
                make.height.mas_offset(self.model.check_list.count*20);
            }];
            
            //bgView
            [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.headImageView.mas_bottom).with.offset(10);
                make.left.equalTo(self.baseView);
                make.right.equalTo(self.baseView);
                make.bottom.equalTo(self.checkDetailView.mas_bottom).with.offset(10);
            }];
            
            
//            //预交金额
//            [self.prepaidTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.right.equalTo(self.baseView.mas_right).with.offset(-20);
//                make.top.equalTo(self.bgView.mas_bottom).with.offset(10);
//            }];
//            [self.prepaidLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.centerY.equalTo(self.prepaidTextLabel.mas_centerY);
//                make.right.equalTo(self.prepaidTextLabel.mas_left).with.offset(-10);
//            }];
            
            //取消和确认按钮
            [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(_baseView.mas_right).with.offset(-20);
                make.top.equalTo(self.bgView.mas_bottom).with.offset(10);
                make.size.mas_offset(CGSizeMake(80, 25));
            }];
            [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.sureBtn.mas_centerY);
                make.right.equalTo(self.sureBtn.mas_left).with.offset(-20);
                make.size.mas_offset(CGSizeMake(80, 25));
                
            }];
            
            [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).with.offset(10);
                make.left.equalTo(self);
                make.right.equalTo(self);
                make.bottom.equalTo(self.cancelBtn.mas_bottom).with.offset(10);
            }];
            
            [self layoutIfNeeded];
            model.baseViewHeight = [self.baseView systemLayoutSizeFittingSize: UILayoutFittingCompressedSize].height;
            
        }
        
        
    }
    
    //待确认
    if (self.model.type_id == 4 || self.model.type_id == 1.3) {
        
        [self.baseView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.bgView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        [self.baseView addSubview:self.bgView];
        
        [self allUse];
        
        
        [self.bgView addSubview:self.orderNumberlabel];
        [self.bgView addSubview:self.orderNumberTextLable];
        [self.bgView addSubview:self.hosLable];
        [self.bgView addSubview:self.hosTextLabel];
        [self.bgView addSubview:self.docLabel];
        [self.bgView addSubview:self.docTextLabel];
        [self.baseView addSubview:self.cancelBtn];
        [self.baseView addSubview:self.sureBtn];
    
        
        [self.cancelBtn setTitle:@"申诉" forState:normal];
        [self.sureBtn setTitle:@"确认" forState:normal];
        
        //订单号
        [self.orderNumberlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.baseView).with.offset(20);
            make.top.equalTo(self.headImageView.mas_bottom).with.offset(20);
        }];
        [self.orderNumberTextLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.orderNumberlabel.mas_centerY);
            make.left.equalTo(self.orderNumberlabel.mas_right).with.offset(10);
        }];
        
        //医院
        [self.hosLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.baseView).with.offset(20);
            make.top.equalTo(self.orderNumberlabel.mas_bottom).with.offset(9);
        }];
        [self.hosTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.hosLable.mas_centerY);
            make.left.equalTo(self.hosLable.mas_right).with.offset(10);
        }];
        
        //预约医生
        [self.docLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgView).with.offset(20);
            make.top.equalTo(self.hosLable.mas_bottom).with.offset(9);
        }];
        [self.docTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.docLabel.mas_centerY);
            make.left.equalTo(self.docLabel.mas_right).with.offset(10);
        }];
        
        
        if (self.model.type_id == 4) {//治疗完成
            
            [self.bgView addSubview:self.illLabel];
            [self.bgView addSubview:self.illTextLabel];
            [self.bgView addSubview:self.categoryLabel];
            [self.bgView addSubview:self.categoryTextLabel];
            [self.bgView addSubview:self.treatLabel];
            [self.bgView addSubview:self.treatTextLabel];
            [self.bgView addSubview:self.payStyleLabel];
            [self.bgView addSubview:self.payStyleTextLbel];
            [self.bgView addSubview:self.priceLabel];
            [self.bgView addSubview:self.priceTextLabel];
            [self.bgView addSubview:self.checkLabel];
            [self.bgView addSubview:self.checkTextLabel];
            [self.bgView addSubview:self.ybMoneyLabel];
            [self.bgView addSubview:self.ybMoneyTextLabel];
            [self.bgView addSubview:self.juanLable];
            [self.bgView addSubview:self.juanTextLabel];
            [self.bgView addSubview:self.reallyPayLabel];
            [self.bgView addSubview:self.reallyPayTextLabel];
            
            
            //疾病
            [self.illLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.baseView).with.offset(20);
                make.top.equalTo(self.docLabel.mas_bottom).with.offset(9);
            }];
            
            [self.illTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.illLabel.mas_centerY);
                make.left.equalTo(self.illLabel.mas_right).with.offset(10);
            }];
            
            //种类
            [self.categoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.baseView).with.offset(20);
                make.top.equalTo(self.illLabel.mas_bottom).with.offset(9);
            }];
            
            [self.categoryTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.categoryLabel.mas_centerY);
                make.left.equalTo(self.categoryLabel.mas_right).with.offset(10);
            }];
            
            
            //方式
            [self.treatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.baseView).with.offset(20);
                make.top.equalTo(self.categoryLabel.mas_bottom).with.offset(9);
            }];
            [self.treatTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.treatLabel.mas_centerY);
                make.left.equalTo(self.treatLabel.mas_right).with.offset(10);
            }];
            
            //支付方式
            [self.payStyleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.baseView).with.offset(20);
                make.top.equalTo(self.treatLabel.mas_bottom).with.offset(9);
            }];
            [self.payStyleTextLbel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.payStyleLabel.mas_centerY);
                make.left.equalTo(self.payStyleLabel.mas_right).with.offset(10);
            }];
            
            
            //约定金额
            [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.baseView).with.offset(20);
                make.top.equalTo(self.payStyleLabel.mas_bottom).with.offset(9);
                
            }];
            [self.priceTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.priceLabel.mas_centerY);
                make.left.equalTo(self.priceLabel.mas_right).with.offset(10);
            }];
            
            //检查费用
            [self.checkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.baseView).with.offset(20);
                make.top.equalTo(self.priceLabel.mas_bottom).with.offset(9);
            }];;
            [self.checkTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.checkLabel.mas_centerY);
                make.left.equalTo(self.checkLabel.mas_right).with.offset(10);
                
            }];
            
            //劵
            [self.juanLable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.baseView).with.offset(20);
                make.top.equalTo(self.checkLabel.mas_bottom).with.offset(9);
                
            }];
            [self.juanTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.juanLable.mas_centerY);
                make.left.equalTo(self.juanLable.mas_right).with.offset(10);
            }];
            
            //医保
            [self.ybMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.baseView).with.offset(20);
                make.top.equalTo(self.juanLable.mas_bottom).with.offset(9);
            }];
            [self.ybMoneyTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.juanLable.mas_centerY);
                make.left.equalTo(self.juanLable.mas_right).with.offset(10);
            }];
            
            
            //实付金额
            [self.reallyPayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.baseView).with.offset(20);
                make.top.equalTo(self.ybMoneyLabel.mas_bottom).with.offset(9);
            }];
            [self.reallyPayTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.reallyPayLabel.mas_centerY);
                make.left.equalTo(self.reallyPayLabel.mas_right).with.offset(10);
            }];
            
            //bgView
            [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.headImageView.mas_bottom).with.offset(10);
                make.left.equalTo(self.baseView);
                make.right.equalTo(self.baseView);
                make.bottom.equalTo(self.reallyPayLabel.mas_bottom).with.offset(10);
            }];
            
            //取消和确定按钮
            [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(_baseView.mas_right).with.offset(-20);
                make.top.equalTo(self.bgView.mas_bottom).with.offset(10);
                make.size.mas_offset(CGSizeMake(50, 25));
            }];
            [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.cancelBtn.mas_centerY);
                make.right.equalTo(self.cancelBtn.mas_left).with.offset(-20);
                make.size.mas_offset(CGSizeMake(50, 25));
                
            }];
            [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).with.offset(10);
                make.left.equalTo(self);
                make.right.equalTo(self);
                make.bottom.equalTo(self.cancelBtn.mas_bottom).with.offset(10);
            }];
            
            [self layoutIfNeeded];
            model.baseViewHeight = [self.baseView systemLayoutSizeFittingSize: UILayoutFittingCompressedSize].height;
            
            
        }else if (self.model.type_id == 1.3) {//退款确认
            
            [self.bgView addSubview:self.treatLabel];
            [self.bgView addSubview:self.treatTextLabel];
            [self.bgView addSubview:self.mainSayLabel];
            [self.bgView addSubview:self.mainSayTextLabel];
            [self.bgView addSubview:self.nowDiseaseLabel];
            [self.bgView addSubview:self.nowDiseaseTextLabel];
            [self.bgView addSubview:self.prepaidLabel];
            [self.bgView addSubview:self.prepaidTextLabel];
            [self.bgView addSubview:self.checkDetailLabel];
            [self.bgView addSubview:self.checkDetailView];
            [self.bgView addSubview:self.backMoney];
            [self.bgView addSubview:self.backTextMoney];
            [self.baseView addSubview:self.cancelBtn];
            [self.baseView addSubview:self.sureBtn];
            
            
            
            //治疗方案
            [self.treatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.baseView).with.offset(20);
                make.top.equalTo(self.docLabel.mas_bottom).with.offset(9);
            }];
            [self.treatTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.juanLable.mas_centerY);
                make.left.equalTo(self.juanLable.mas_right).with.offset(10);
            }];
            //主诉
            [self.mainSayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.baseView).with.offset(20);
                make.top.equalTo(self.treatLabel.mas_bottom).with.offset(9);
            }];
            [self.mainSayTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.mainSayLabel.mas_centerY);
                make.left.equalTo(self.mainSayLabel.mas_right).with.offset(10);
            }];
            //现病史
            [self.nowDiseaseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.baseView).with.offset(20);
                make.top.equalTo(self.mainSayLabel.mas_bottom).with.offset(9);
            }];
            [self.nowDiseaseTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.mainSayLabel.mas_centerY);
                make.left.equalTo(self.mainSayLabel.mas_right).with.offset(10);
            }];
            //预交金额
            [self.prepaidLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.baseView).with.offset(20);
                make.top.equalTo(self.nowDiseaseLabel.mas_bottom).with.offset(9);
                
            }];
            [self.prepaidTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.prepaidLabel.mas_centerY);
                make.left.equalTo(self.prepaidLabel.mas_right).with.offset(10);
            }];
            //检查明细
            [self.checkDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.baseView).with.offset(20);
                make.top.equalTo(self.prepaidLabel.mas_bottom).with.offset(9);
            }];
            [self.checkDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.checkDetailLabel.mas_top);
                make.left.equalTo(self.checkDetailLabel.mas_right).with.offset(10);
            }];
            //退款金额
            [self.backMoney mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.baseView).with.offset(20);
                make.top.equalTo(self.checkDetailView.mas_bottom).with.offset(9);
                
            }];
            [self.backTextMoney mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.backMoney.mas_centerY);
                make.left.equalTo(self.backMoney.mas_right).with.offset(10);
            }];
            
            //bgView
            [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.headImageView.mas_bottom).with.offset(10);
                make.left.equalTo(self.baseView);
                make.right.equalTo(self.baseView);
                make.bottom.equalTo(self.backMoney.mas_bottom).with.offset(10);
            }];
            
            //取消和确定按钮
            [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(_baseView.mas_right).with.offset(-20);
                make.top.equalTo(self.bgView.mas_bottom).with.offset(10);
                make.size.mas_offset(CGSizeMake(50, 25));
            }];
            [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.cancelBtn.mas_centerY);
                make.right.equalTo(self.cancelBtn.mas_left).with.offset(-20);
                make.size.mas_offset(CGSizeMake(50, 25));
                
            }];
            
            [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).with.offset(10);
                make.left.equalTo(self);
                make.right.equalTo(self);
                make.bottom.equalTo(self.cancelBtn.mas_bottom).with.offset(10);
            }];
            
            [self layoutIfNeeded];
            model.baseViewHeight = [self.baseView systemLayoutSizeFittingSize: UILayoutFittingCompressedSize].height;
        }
        
        
        
    }
    
    //待待评价
    if (self.model.type_id == 5 || self.model.type_id == 5.1) {
        
        [self.baseView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.bgView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        [self.baseView addSubview:self.bgView];
        
        [self allUse];
        
        
        [self.bgView addSubview:self.orderNumberlabel];
        [self.bgView addSubview:self.orderNumberTextLable];
        
        [self.bgView addSubview:self.docLabel];
        [self.bgView addSubview:self.docTextLabel];
        [self.bgView addSubview:self.illLabel];
        [self.bgView addSubview:self.illTextLabel];
        [self.bgView addSubview:self.categoryLabel];
        [self.bgView addSubview:self.categoryTextLabel];
        [self.bgView addSubview:self.treatLabel];
        [self.bgView addSubview:self.treatTextLabel];
        
        [self.baseView addSubview:self.allNeedPayLabel];
        [self.baseView addSubview:self.allNeedPayTextLabel];
        [self.baseView addSubview:self.havePayLabel];
        [self.baseView addSubview:self.havePayTextLabel];
        [self.baseView addSubview:self.sureBtn];
        
        if ([self.model.type_name isEqualToString:@"可打赏"]) {
            [self.sureBtn setTitle:@"去打赏" forState:normal];
        }else {
            [self.sureBtn setTitle:@"去评价" forState:normal];
        }
        
        
        //订单号
        [self.orderNumberlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.baseView).with.offset(20);
            make.top.equalTo(self.headImageView.mas_bottom).with.offset(20);
        }];
        
        [self.orderNumberTextLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.orderNumberlabel.mas_centerY);
            make.left.equalTo(self.orderNumberlabel.mas_right).with.offset(10);
        }];
        
        //预约医生
        [self.docLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.baseView).with.offset(20);
            make.top.equalTo(self.orderNumberlabel.mas_bottom).with.offset(9);
        }];
        [self.docTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.docLabel.mas_centerY);
            make.left.equalTo(self.docLabel.mas_right).with.offset(10);
        }];
        
        //疾病
        [self.illLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.baseView).with.offset(20);
            make.top.equalTo(self.docLabel.mas_bottom).with.offset(9);
        }];
        
        [self.illTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.illLabel.mas_centerY);
            make.left.equalTo(self.illLabel.mas_right).with.offset(10);
        }];
        
        //种类
        [self.categoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.baseView).with.offset(20);
            make.top.equalTo(self.illLabel.mas_bottom).with.offset(9);
        }];
        
        [self.categoryTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.categoryLabel.mas_centerY);
            make.left.equalTo(self.categoryLabel.mas_right).with.offset(10);
        }];
        
        //方式
        [self.treatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.baseView).with.offset(20);
            make.top.equalTo(self.categoryLabel.mas_bottom).with.offset(9);
        }];
        [self.treatTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.treatLabel.mas_centerY);
            make.left.equalTo(self.treatLabel.mas_right).with.offset(10);
        }];
        
        //bgView
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headImageView.mas_bottom).with.offset(10);
            make.left.equalTo(self.baseView);
            make.right.equalTo(self.baseView);
            make.bottom.equalTo(self.treatLabel.mas_bottom).with.offset(10);
        }];
        
        //合计费用
        [self.allNeedPayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.baseView).with.offset(20);
            make.top.equalTo(self.bgView.mas_bottom).with.offset(9);
        }];
        [self.allNeedPayTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.allNeedPayLabel.mas_centerY);
            make.left.equalTo(self.allNeedPayLabel.mas_right).with.offset(10);
        }];
        
        //已交费用
        [self.havePayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.allNeedPayTextLabel.mas_right).with.offset(50);
            make.top.equalTo(self.bgView.mas_bottom).with.offset(9);
        }];
        [self.havePayTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.havePayLabel.mas_centerY);
            make.left.equalTo(self.havePayLabel.mas_right).with.offset(10);
        }];
        
        //sureBtn
        [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_baseView.mas_right).with.offset(-20);
            make.top.equalTo(self.havePayTextLabel.mas_bottom).with.offset(10);
            make.size.mas_offset(CGSizeMake(80, 25));
        }];
        
        [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(10);
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.bottom.equalTo(self.sureBtn.mas_bottom).with.offset(10);
        }];
        
        [self layoutIfNeeded];
        model.baseViewHeight = [self.baseView systemLayoutSizeFittingSize: UILayoutFittingCompressedSize].height;
        
        
    }
    
    
}


- (void)allUse {
    
    [self.baseView addSubview:self.headImageView];
    [self.baseView addSubview:self.hosNameLabel];
    [self.baseView addSubview:self.typeNameLabel];
    
    
    //头像
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.baseView).with.offset(20);
        make.top.equalTo(self.baseView).with.offset(10);
        make.size.mas_offset(CGSizeMake(52, 32));
    }];
    
    //医院名字
    
    [self.hosNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headImageView.mas_centerY);
        make.left.equalTo(self.headImageView.mas_right).with.offset(17);
    }];
    
    //当前状态
    [self.typeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView).with.offset(10);
        make.right.equalTo(self.baseView.mas_right).with.offset(-20);
    }];
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
