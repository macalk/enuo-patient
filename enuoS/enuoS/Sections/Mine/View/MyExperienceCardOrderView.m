//
//  MyExperienceCardOrderView.m
//  enuoS
//
//  Created by apple on 16/12/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MyExperienceCardOrderView.h"
#import "UIColor+Extend.h"
#import <Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "Macros.h"

@implementation MyExperienceCardOrderView

- (UIImageView *)hosImageView {
    if (!_hosImageView) {
        _hosImageView = [[UIImageView alloc]init];
    }return _hosImageView;
}
- (UILabel *)hosNameLabel {
    if (!_hosNameLabel) {
        _hosNameLabel = [[UILabel alloc]init];
        _hosNameLabel.font = [UIFont systemFontOfSize:15];
        _hosNameLabel.textColor = [UIColor stringTOColor:@"#22ccc6"];
    }return _hosNameLabel;
}
- (UILabel *)typeLabel {
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc]init];
        _typeLabel.font = [UIFont systemFontOfSize:13];
        _typeLabel.textColor = [UIColor orangeColor];
    }return _typeLabel;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor stringTOColor:@"#efefef"];
    }return _bgView;
}
- (UILabel *)illLabel {
    if (!_illLabel) {
        _illLabel = [[UILabel alloc]init];
        _illLabel.font = [UIFont systemFontOfSize:13];
        _illLabel.text = @"约定项目: ";
    }return _illLabel;
}
- (UILabel *)illTextLabel {
    if (!_illTextLabel) {
        _illTextLabel = [[UILabel alloc]init];
        _illTextLabel.font = [UIFont systemFontOfSize:13];
    }return _illTextLabel;
}
- (UILabel *)cardOrderLabel {
    if (!_cardOrderLabel) {
        _cardOrderLabel = [[UILabel alloc]init];
        _cardOrderLabel.font = [UIFont systemFontOfSize:13];
        _cardOrderLabel.text = @"体验劵号: ";
    }return _cardOrderLabel;
}
- (UILabel *)cardOrderTextLabel {
    if (!_cardOrderTextLabel) {
        _cardOrderTextLabel = [[UILabel alloc]init];
        _cardOrderTextLabel.font = [UIFont systemFontOfSize:13];
    }return _cardOrderTextLabel;
}
- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = [UIFont systemFontOfSize:13];
        _timeLabel.text = @"预定时间: ";
    }return _timeLabel;
}
- (UILabel *)timeTextLabel {
    if (!_timeTextLabel) {
        _timeTextLabel = [[UILabel alloc]init];
        _timeTextLabel.font = [UIFont systemFontOfSize:13];
    }return _timeTextLabel;
}
- (UILabel *)evaluateLabel {
    if (!_evaluateLabel) {
        _evaluateLabel = [[UILabel alloc]init];
        _evaluateLabel.font = [UIFont systemFontOfSize:13];
        _evaluateLabel.text = @"评       价: ";
    }return _evaluateLabel;
}
- (UILabel *)evaluateTextLabel {
    if (!_evaluateTextLabel) {
        _evaluateTextLabel = [[UILabel alloc]init];
        _evaluateTextLabel.font = [UIFont systemFontOfSize:13];
    }return _evaluateTextLabel;
}
- (UIButton *)button {
    if (!_button) {
        _button = [[UIButton alloc]init];
        [_button setTitleColor:[UIColor whiteColor] forState:normal];
        [_button setBackgroundColor:[UIColor stringTOColor:@"#22ccc6"]];
        _button.layer.cornerRadius = 5;
        _button.titleLabel.font = [UIFont systemFontOfSize:15];
        _button.clipsToBounds = YES;
    }return _button;
}

- (void)createViewWithModel:(MyExperienceCardOrderModel *)model {
        
    UILabel *topLineLabel = [[UILabel alloc]init];
    topLineLabel.backgroundColor = [UIColor stringTOColor:@"#f4f4f4"];
    [self addSubview:topLineLabel];
    
    
    [self addSubview:self.bgView];
    [self addSubview:self.hosImageView];
    [self addSubview:self.hosNameLabel];
    [self addSubview:self.typeLabel];
    [self.bgView addSubview:self.illLabel];
    [self.bgView addSubview:self.illTextLabel];
    [self.bgView addSubview:self.cardOrderLabel];
    [self.bgView addSubview:self.cardOrderTextLabel];
    [self.bgView addSubview:self.timeLabel];
    [self.bgView addSubview:self.timeTextLabel];
    [self addSubview:self.button];
    

    [self.hosImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:urlPicture,model.photo]]];
    self.hosNameLabel.text = model.hos_name;
    self.typeLabel.text = model.type_name;
    self.illTextLabel.text = model.product;
    self.cardOrderTextLabel.text = model.cardno;
    self.timeTextLabel.text = model.date;
    self.evaluateTextLabel.text = model.delete_reason;

    if (model.type_id == 0 || model.type_id == 1) {//预约中 || 已预约
        [self.button setTitle:@"取消订单" forState:normal];
    }else if (model.type_id == 2) {
        
        if ( model.pj == nil || [model.pj isEqualToString:@""]) {
            [self.button setTitle:@"评价" forState:normal];
        }else {
            [self.bgView addSubview:self.evaluateLabel];
            [self.bgView addSubview:self.evaluateTextLabel];
            self.evaluateTextLabel.text = model.pj;
            [self.button setBackgroundColor:[UIColor lightGrayColor]];
            [self.button setTitle:@"已评价" forState:normal];
        }
    }else {
        self.evaluateLabel.text = @"取消原因: ";
        [self.bgView addSubview:self.evaluateLabel];
        [self.bgView addSubview:self.evaluateTextLabel];
        self.button.hidden = YES;
    }

        
    [topLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_offset(10);
    }];
    
    [self.hosImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(20);
        make.left.equalTo(self).with.offset(20);
        make.size.mas_offset(CGSizeMake(52, 32));
    }];
    [self.hosNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.hosImageView);
        make.left.equalTo(self.hosImageView.mas_right).with.offset(17);
    }];
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.hosNameLabel.mas_bottom).with.offset(10);
        make.right.equalTo(self).with.offset(-20);
    }];
    
    [self.illLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).with.offset(20);
        make.top.equalTo(self.bgView).with.offset(10);
    }];
    [self.illTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.illLabel);
        make.left.equalTo(self.illLabel.mas_right).with.offset(10);
    }];
    
    [self.cardOrderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.illLabel.mas_bottom).with.offset(10);
        make.right.equalTo(self.illLabel);
    }];
    [self.cardOrderTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.cardOrderLabel);
        make.left.equalTo(self.cardOrderLabel.mas_right).with.offset(10);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cardOrderLabel.mas_bottom).with.offset(10);
        make.right.equalTo(self.cardOrderLabel);
    }];
    [self.timeTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.timeLabel);
        make.left.equalTo(self.timeLabel.mas_right).with.offset(10);
    }];
    
    [self.evaluateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLabel.mas_bottom).with.offset(10);
        make.right.equalTo(self.timeLabel);
    }];
    [self.evaluateTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.evaluateLabel);
        make.left.equalTo(self.evaluateLabel.mas_right).with.offset(10);
    }];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (model.type_id < 0 || model.pj != nil) {
            make.bottom.equalTo(self.evaluateLabel).with.offset(10);
        }else {
            make.bottom.equalTo(self.timeLabel).with.offset(10);
        }
        make.top.equalTo(self.typeLabel.mas_bottom).with.offset(10);
        make.left.right.equalTo(self);
    }];
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView.mas_bottom).with.offset(8);
        make.right.equalTo(self.bgView.mas_right).with.offset(-20);
        make.width.mas_offset(@80);
    }];
    
    [self layoutIfNeeded];
    model.bgViewHeight = [self.bgView systemLayoutSizeFittingSize: UILayoutFittingCompressedSize].height;    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
