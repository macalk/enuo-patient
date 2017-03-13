//
//  HomeView.m
//  enuoS
//
//  Created by apple on 17/3/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "HomeView.h"
#import "Macros.h"
#import <Masonry.h>
#import "UIColor+Extend.h"
#import <UIButton+WebCache.h>

@implementation HomeView

- (NSMutableArray *)deskButtonArr {
    if (!_deskButtonArr) {
        _deskButtonArr = [NSMutableArray array];
    }return _deskButtonArr;
}
- (NSMutableArray *)deskButtonTitleArr {
    if (!_deskButtonTitleArr) {
        _deskButtonTitleArr = [NSMutableArray array];
    }return _deskButtonTitleArr;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
                
    }
    return self;
}

- (void)createHomeView {
    
//顶部
    UILabel *topLabel = [self createLineLabel];
    [self addSubview:topLabel];
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(@10);
    }];
    
    NSArray *topImageArr = @[@"哪里不舒服_N",@"美啦美啦_N",@"便捷约定_N"];
    NSArray *topTitleArr = @[@"您哪里不舒服",@"美啦美啦",@"便捷约定"];
    
    UIButton *topButton;
    for (int i = 0; i<3; i++) {
        topButton = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth/3*i, 10, kScreenWidth/3, 187)];
        topButton.backgroundColor = [UIColor whiteColor];
        [topButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",topImageArr[i]]] forState:normal];
        [topButton setImageEdgeInsets:UIEdgeInsetsMake(-40, 0, 0, 0)];
        [self addSubview:topButton];
        
        UILabel *buttonTitleLabel = [[UILabel alloc]init];
        buttonTitleLabel.font = [UIFont systemFontOfSize:13];
        buttonTitleLabel.textAlignment = NSTextAlignmentCenter;
        buttonTitleLabel.text = [NSString stringWithFormat:@"%@",topTitleArr[i]];
        buttonTitleLabel.textColor = [UIColor stringTOColor:@"#131313"];
        [self addSubview:buttonTitleLabel];
        [buttonTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(topButton);
            make.bottom.equalTo(topButton.mas_bottom).with.offset(-50);
            make.width.mas_equalTo(@100);
        }];
        
        if (i<2) {
            UILabel *lineLabel = [[UILabel alloc]init];
            lineLabel.backgroundColor = [UIColor stringTOColor:@"#eeeeee"];
            [self addSubview:lineLabel];
            [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.top.equalTo(topButton);
                make.size.mas_equalTo(CGSizeMake(0.5, topButton.frame.size.height));
            }];

        }
        
        if (i == 0) {
            self.uncomfortableBtn = topButton;
        }else if (i == 1) {
            self.beautifulBtn = topButton;
        }else if (i == 2) {
            self.conventionBtn = topButton;
        }
    }
    
    
//中部
    UILabel *centerFirestLabel = [self createLineLabel];
    [self addSubview:centerFirestLabel];
    [centerFirestLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topButton.mas_bottom);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(@10);
    }];
    
    NSArray *centerImageArr = @[@"找医生_N",@"找医院_N",@"周边医院_N"];
    NSArray *centerTitleArr = @[@"找医生",@"找医院",@"周边医院"];
    UIButton *centerBtn;
    for (int i = 0; i<3; i++) {
        centerBtn = [[UIButton alloc]init];
        centerBtn.backgroundColor = [UIColor whiteColor];
        [centerBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",centerImageArr[i]]] forState:normal];
        [centerBtn setTitle:[NSString stringWithFormat:@"%@",centerTitleArr[i]] forState:normal];
        centerBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [centerBtn setTitleColor:[UIColor stringTOColor:@"#131313"] forState:normal];
        [centerBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -10)];
        [self addSubview:centerBtn];
        [centerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).with.offset(kScreenWidth/3*i);
            make.top.equalTo(centerFirestLabel.mas_bottom);
            make.size.mas_equalTo(CGSizeMake(kScreenWidth/3, 50));
        }];
        
        if (i<2) {
            UILabel *lineLabel = [[UILabel alloc]init];
            lineLabel.backgroundColor = [UIColor redColor];
            [self addSubview:lineLabel];
            [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.right.equalTo(centerBtn);
                make.size.mas_equalTo(CGSizeMake(0.5, centerBtn.frame.size.height));
            }];
            
        }
        
        if (i == 0) {
            self.findDocBtn = centerBtn;
        }else if (i == 1) {
            self.findHosBtn = centerBtn;
        }else if (i == 2) {
            self.arroundHosBtn = centerBtn;
        }

    }
    
    UILabel *centerSencLabel = [self createLineLabel];
    [self addSubview:centerSencLabel];
    [centerSencLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(centerBtn.mas_bottom);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(@10);
    }];
    
    UIView *deskView = [[UIView alloc]init];
    deskView.backgroundColor = [UIColor whiteColor];
    [self addSubview:deskView];
    [deskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(centerSencLabel.mas_bottom);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(@39);
    }];
    UILabel *deskLabel = [[UILabel alloc]init];
    deskLabel.font = [UIFont systemFontOfSize:15];
    deskLabel.textColor = [UIColor stringTOColor:@"#53a3ba"];
    deskLabel.text = @"科室";
    [deskView addSubview:deskLabel];
    [deskLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(deskView);
        make.left.equalTo(deskView).with.offset(20);
    }];
    UIButton *moreBtn = [[UIButton alloc]init];
    self.deskMoreBtn = moreBtn;
    [moreBtn setTitle:@"更多" forState:normal];
    [moreBtn setTitleColor:[UIColor stringTOColor:@"#131313"] forState:normal];
    moreBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [moreBtn setImage:[UIImage imageNamed:@"下一步"] forState:normal];
    [moreBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -80)];
    [self addSubview:moreBtn];
    [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(deskView);
        make.right.equalTo(deskView);
        make.size.mas_equalTo(CGSizeMake(100, 39));
    }];
    
    
    UILabel *centerThirdLabel = [self createLineLabel];
    [self addSubview:centerThirdLabel];
    [centerThirdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(deskView.mas_bottom);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(@10);
    }];
    
    
//下部
    UIView *bottomView = [[UIView alloc]init];
    [self addSubview:bottomView];
    bottomView.backgroundColor = [UIColor whiteColor];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(centerThirdLabel.mas_bottom);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(@180);
    }];
    
    for (int i = 0; i<8; i++) {
        UIButton *button = [[UIButton alloc]init];
        button.frame = CGRectMake(kScreenWidth/4*(i%4), 90*(i/4), kScreenWidth/4, 90);
        [bottomView addSubview:button];
        [button setImageEdgeInsets:UIEdgeInsetsMake(-20, 0, 0, 0)];
        [self.deskButtonArr addObject:button];
        
        UILabel *deskBtnLabel = [[UILabel alloc]init];
        deskBtnLabel.textAlignment = NSTextAlignmentCenter;
        deskBtnLabel.font = [UIFont systemFontOfSize:10];
        deskBtnLabel.textColor = [UIColor stringTOColor:@"#6d6d6d"];
        [self addSubview:deskBtnLabel];
        [deskBtnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(button.mas_bottom).with.offset(-10);
            make.centerX.equalTo(button);
            make.width.mas_offset(button.frame.size.width);
        }];
        [self.deskButtonTitleArr addObject:deskBtnLabel];
    }
    
    
    
    
    
//最后
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(self);
        make.bottom.equalTo(bottomView);
    }];
    
    [self layoutIfNeeded];
    CGFloat viewHeight = self.frame.size.height;
    self.viewHeight = viewHeight;
    
}

//灰色粗线
- (UILabel *)createLineLabel {
    UILabel *label = [[UILabel alloc]init];
    label.backgroundColor = [UIColor stringTOColor:@"#eeeeee"];
    return label;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
