//
//  HosHomePageView.m
//  enuoS
//
//  Created by apple on 16/11/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "HosHomePageView.h"
#import "Macros.h"
#import <Masonry.h>
#import "HosModel.h"
#import "UIColor+Extend.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation HosHomePageView

- (HosModel *)model {
    if (!_model) {
        _model = [[HosModel alloc]init];
    }return _model;
}


- (void)createHeadViewWithType:(NSString *)type {
    UIView *headView = [[UIView alloc]init];
    [self addSubview:headView];
    
    //关注按钮
    self.likeBtn = [[UIButton alloc]init];
    if (self.model.guanzhu == 0) {
        [self.likeBtn setImage:[UIImage imageNamed:@"关注"] forState:normal];
    }else {
        [self.likeBtn setImage:[UIImage imageNamed:@"关注-s"] forState:normal];
    }
    
    [headView addSubview:self.likeBtn];
    
    //评论
    UIImageView *commentView = [[UIImageView alloc]init];
    [commentView setImage:[UIImage imageNamed:@"形状-1-拷贝"]];
    [headView addSubview:commentView];
    UILabel *commentLabel = [[UILabel alloc]init];
    commentLabel.text = @"0";
    commentLabel.textColor = [UIColor orangeColor];
    commentLabel.font = [UIFont systemFontOfSize:9];
    [headView addSubview:commentLabel];
    
    //鼎
    UIImageView *dingImageView = [[UIImageView alloc]init];
    [dingImageView setImage:[UIImage imageNamed:@"鼎"]];
    [headView addSubview:dingImageView];
    UILabel *dingLabel = [[UILabel alloc]init];
    dingLabel.text = @"0";
    dingLabel.textColor = [UIColor orangeColor];
    dingLabel.font = [UIFont systemFontOfSize:9];
    [headView addSubview:dingLabel];
    
    
    UIImageView *hosImageView = [[UIImageView alloc]init];
    NSString * url = [NSString stringWithFormat:urlPicture,self.model.photo];
    [hosImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
    [self addSubview:hosImageView];
    
    UILabel *hosNameLabel = [[UILabel alloc]init];
    hosNameLabel.font = [UIFont systemFontOfSize:13];
    hosNameLabel.text = self.model.hos_name;
    hosNameLabel.textColor = [UIColor stringTOColor:@"#00afa1"];
    [self addSubview:hosNameLabel];
    
    UILabel *deskLabel = [[UILabel alloc]init];
    deskLabel.text = self.model.rank;
    
    UILabel *ybLabel = [[UILabel alloc]init];
    ybLabel.text = @"医保 :";
    UILabel *ybTextLabel = [[UILabel alloc]init];
    ybTextLabel.text = self.model.yb;
    
    UILabel *phoneLabel = [[UILabel alloc]init];
    phoneLabel.text = @"电话 :";
    UILabel *phoneTextLabel = [[UILabel alloc]init];
    phoneTextLabel.text = self.model.phone;
    
    UILabel *peopleNumLabel = [[UILabel alloc]init];
    peopleNumLabel.text = @"预约 :";
    UILabel *peopleNumTextLabel = [[UILabel alloc]init];
    peopleNumTextLabel.text = [NSString stringWithFormat:@"%@ 人",self.model.zhen];
    
    UILabel *hosWebLabel = [[UILabel alloc]init];
    hosWebLabel.text = @"医院官网 :";
    UILabel *hosWebTextLabel = [[UILabel alloc]init];
    hosWebTextLabel.font = [UIFont systemFontOfSize:10];
    hosWebTextLabel.textColor = [UIColor stringTOColor:@"#00afa1"];
    hosWebTextLabel.text = self.model.website;
    [self addSubview:hosWebTextLabel];
    
    UILabel *addressLabel = [[UILabel alloc]init];
    addressLabel.text = @"地       址 :";
    UILabel *addressTextLabel = [[UILabel alloc]init];
    addressTextLabel.numberOfLines = 0;
    addressTextLabel.text = self.model.address;
    
    UILabel *permitLabel = [[UILabel alloc]init];
    permitLabel.text = @"医疗许可证 :";
    UILabel *permitTextLabel = [[UILabel alloc]init];
    permitTextLabel.text = self.model.yljg;
    
    UILabel *busPathLabel = [[UILabel alloc]init];
    busPathLabel.text = @"公交路线 :";
    UILabel *busPathTextLabel = [[UILabel alloc]init];
    busPathTextLabel.numberOfLines = 0;
    busPathTextLabel.text = self.model.bus;
    
    UILabel *appointLabel = [[UILabel alloc]init];
    appointLabel.text = @"约定病种 :";
    UILabel *appointTextLabel = [[UILabel alloc]init];
    appointTextLabel.numberOfLines = 0;
    appointTextLabel.text = self.model.ill;
    
    
    
    
    NSArray *labelArr = @[deskLabel,ybLabel,phoneLabel,peopleNumLabel,hosWebLabel,addressLabel,permitLabel,busPathLabel,appointLabel];
    for (int i = 0; i<labelArr.count; i++) {
        UILabel *label = labelArr[i];
        label.font = [UIFont systemFontOfSize:10];
        [headView addSubview:label];
    }
    
    NSArray *labelTextArr = @[ybTextLabel,phoneTextLabel,peopleNumTextLabel,addressTextLabel,permitTextLabel,busPathTextLabel,appointTextLabel];
    for (int i = 0; i<labelTextArr.count; i++) {
        UILabel *textLabel = labelTextArr[i];
        [headView addSubview:textLabel];
        textLabel.font = [UIFont systemFontOfSize:10];
        textLabel.textColor = [UIColor stringTOColor:@"#666666"];
    }
    
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_offset(@400);
    }];
    
    
    /****3个图标****/
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(headView).with.offset(-10);
        make.top.equalTo(headView).with.offset(27);
        make.size.mas_offset(CGSizeMake(17, 17));
    }];
    
    [commentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.likeBtn.mas_centerY);
        make.right.equalTo(self.likeBtn.mas_left).with.offset(-12);
    }];
    [commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(commentView);
        make.left.equalTo(commentView).with.offset(10);
        make.size.mas_offset(CGSizeMake(10, 6));
    }];
    
    [dingImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(commentView);
        make.right.equalTo(commentView.mas_left).with.offset(-12);
        make.size.mas_offset(CGSizeMake(15, 17));
    }];
    [dingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(dingImageView);
        make.left.equalTo(dingImageView.mas_right);
        make.size.mas_offset(CGSizeMake(10, 6));
    }];
    /*************/
    
    
    [hosImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headView.mas_top).with.offset(10);
        make.left.equalTo(headView.mas_left).with.offset(20);
//        make.height.mas_offset(@118);
//        make.width.mas_offset(@73);
        make.size.mas_offset(CGSizeMake(118, 73));
    }];
    
    [hosNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hosImageView);
        make.left.equalTo(hosImageView.mas_right).with.offset(5);
        make.height.mas_offset(@13);
    }];
    
    [deskLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hosNameLabel);
        make.top.equalTo(hosNameLabel.mas_bottom).with.offset(5);
        make.height.mas_offset(@10);
    }];
    
    [ybLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(deskLabel);
        make.top.equalTo(deskLabel.mas_bottom).with.offset(5);
        make.height.mas_offset(@10);
    }];
    [ybTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ybLabel);
        make.left.equalTo(ybLabel.mas_right).with.offset(5);
        make.height.mas_offset(@10);
    }];
    
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ybLabel);
        make.top.equalTo(ybLabel.mas_bottom).with.offset(5);
        make.height.mas_offset(@10);
    }];
    [phoneTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(phoneLabel);
        make.left.equalTo(phoneLabel.mas_right).with.offset(5);
        make.height.mas_offset(@10);
    }];
    
    [peopleNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneLabel);
        make.top.equalTo(phoneLabel.mas_bottom).with.offset(5);
        make.height.mas_offset(@10);
    }];
    [peopleNumTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(peopleNumLabel);
        make.left.equalTo(peopleNumLabel.mas_right).with.offset(5);
        make.height.mas_offset(@10);
    }];
    
    
    [permitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hosImageView);
        make.top.equalTo(hosImageView.mas_bottom).with.offset(10);
        make.height.mas_offset(@10);
    }];
    [permitTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(permitLabel);
        make.left.equalTo(permitLabel.mas_right).with.offset(5);
        make.height.mas_offset(@10);
    }];
    
    [hosWebLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(permitLabel);
        make.top.equalTo(permitLabel.mas_bottom).with.offset(10);
        make.height.mas_offset(@10);
    }];
    [hosWebTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(hosWebLabel);
        make.left.equalTo(hosWebLabel.mas_right).with.offset(5);
        make.height.mas_offset(@10);
    }];
    
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hosWebLabel);
        make.top.equalTo(hosWebLabel.mas_bottom).with.offset(10);
        make.height.mas_offset(@10);
    }];
    [addressTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addressLabel);
        make.left.equalTo(addressLabel.mas_right).with.offset(5);
        make.width.mas_offset(kScreenWidth-80);
    }];
    
    
    [busPathLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addressLabel);
        if ([addressTextLabel.text isEqualToString:@""]) {
            make.top.equalTo(addressLabel.mas_bottom).with.offset(10);
        }else {
            make.top.equalTo(addressTextLabel.mas_bottom).with.offset(10);
        }
        make.height.mas_offset(@10);
    }];
    [busPathTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(busPathLabel);
        make.left.equalTo(busPathLabel.mas_right).with.offset(5);
        make.width.mas_offset(kScreenWidth-80);
    }];
    
    
    [appointLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(busPathLabel);
        if ([busPathTextLabel.text isEqualToString:@""]) {
            make.top.equalTo(busPathLabel.mas_bottom).with.offset(10);
        }else {
            make.top.equalTo(busPathTextLabel.mas_bottom).with.offset(10);
        }
        make.height.mas_offset(@10);
    }];
    [appointTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(appointLabel);
        make.left.equalTo(appointLabel.mas_right).with.offset(5);
        make.width.mas_offset(kScreenWidth-80);

    }];
    
    
    UILabel *lineLabel = [[UILabel alloc]init];
    lineLabel.backgroundColor = [UIColor stringTOColor:@"#cbcbcb"];
    [headView addSubview:lineLabel];
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(appointTextLabel.mas_bottom).with.offset(10);
        make.left.right.equalTo(headView);
        make.height.mas_offset(@1);
    }];
    
    
    //医院简介
    UILabel *hosIntroduceLabel = [[UILabel alloc]init];
    hosIntroduceLabel.text = @"医院简介";
    hosIntroduceLabel.font = [UIFont systemFontOfSize:13];
    hosIntroduceLabel.textColor = [UIColor stringTOColor:@"#00afa1"];
    [headView addSubview:hosIntroduceLabel];
    
    UILabel *hosIntroduceTextLabel = [[UILabel alloc]init];
    hosIntroduceTextLabel.text = self.model.hos_information;
    hosIntroduceTextLabel.font = [UIFont systemFontOfSize:11];
    hosIntroduceTextLabel.textColor = [UIColor stringTOColor:@"#666666"];
    [headView addSubview:hosIntroduceTextLabel];
    
    [hosIntroduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headView).with.offset(20);
        make.top.equalTo(lineLabel.mas_bottom).with.offset(10);
    }];
    [hosIntroduceTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hosIntroduceLabel);
        make.top.equalTo(hosIntroduceLabel.mas_bottom).with.offset(10);
        make.right.equalTo(headView.mas_right).with.offset(-20);
    }];
    
    UIButton *moreButton = [[UIButton alloc]init];
    self.moreBtn = moreButton;
    [headView addSubview:moreButton];
    
    if ([type isEqualToString:@"more"]) {
        hosIntroduceTextLabel.numberOfLines = 0;
        [moreButton setImage:[UIImage imageNamed:@"筛选收缩"] forState:normal];
    }else {
        hosIntroduceTextLabel.numberOfLines = 6;
        [moreButton setImage:[UIImage imageNamed:@"筛选展开"] forState:normal];
    }
    
    [moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headView.mas_centerX);
        make.top.equalTo(hosIntroduceTextLabel.mas_bottom).with.offset(10);
        make.size.mas_offset(CGSizeMake(kScreenWidth, 10));
    }];
    
    UILabel *lineTwoLabel = [[UILabel alloc]init];
    lineTwoLabel.backgroundColor = [UIColor stringTOColor:@"#cbcbcb"];
    [headView addSubview:lineTwoLabel];
    [lineTwoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(headView);
        make.top.equalTo(moreButton.mas_bottom).with.offset(10);
        make.height.mas_offset(@1);
    }];
    
    [self layoutIfNeeded];
    self.viewHeight = CGRectGetMaxY(lineTwoLabel.frame);
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
