//
//  CFFlowButtonView.m
//  CFFlowButtonView
//
//  Created by 周凌宇 on 15/10/27.
//  Copyright © 2015年 周凌宇. All rights reserved.
//

#import "CFFlowButtonView.h"
#import "UIView+Extension.h"
#import "UIView+Category.h"
#import "UIColor+Extend.h"
#import <Masonry.h>

@implementation CFFlowButtonView


- (UILabel *)cateLabel {
    if (!_cateLabel) {
        _cateLabel = [[UILabel alloc]init];
    }return _cateLabel;
}
- (UILabel *)treatLabel {
    if (!_treatLabel) {
        _treatLabel = [[UILabel alloc]init];
    }return _treatLabel;
}
- (UILabel *)hoseLabel {
    if (!_hoseLabel) {
        _hoseLabel = [[UILabel alloc]init];
    }return _hoseLabel;
}


- (UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [[UIButton alloc]init];
        _sureBtn.layer.cornerRadius = 5;
        _sureBtn.clipsToBounds = YES;
        [_sureBtn setTitle:@"确认" forState:normal];
        [_sureBtn setTitleColor:[UIColor whiteColor] forState:normal];
        _sureBtn.backgroundColor = [UIColor stringTOColor:@"#00afa1"];
    }return _sureBtn;
}

- (instancetype)initWithButtonList:(NSMutableArray *)buttonList WithTitleList:(NSMutableArray *)titleList{
    if (self = [super init]) {
        _titleList = titleList;
        _buttonList = buttonList;
        
        for (UIButton *button in self.buttonList[0]) {
            [self addSubview:button];
        }
        for (UIButton *button in self.buttonList[1]) {
            [self addSubview:button];
        }
        for (UIButton *button in self.buttonList[2]) {
            [self addSubview:button];
        }  
        
    }
    return self;
}

- (void)layoutSubviews {
    
    NSArray *titleLabelArr = @[self.cateLabel,self.treatLabel,self.hoseLabel];
    
    for (int i=0; i<3; i++) {
        
        UILabel *label = titleLabelArr[i];
        self.currenArr = self.buttonList[i];
        
    label.text = [NSString stringWithFormat:@"%@",_titleList[i]];
        
    [self addSubview:label];
        if (i == 0) {
            label.frame = CGRectMake(10, 10, 120, 20);
        }else {
            CGFloat lastBtnY = CGRectGetMaxY(self.lastBtn.frame) + 10;
            label.frame = CGRectMake(10, lastBtnY, 120, 20);
        }
    
    CGFloat margin = 10;

    // 存放每行的第一个Button
    NSMutableArray *rowFirstButtons = [NSMutableArray array];
    
    // 对第一个Button进行设置
    UIButton *button0 = self.currenArr[0];
    button0.x = 10;
    button0.y = CGRectGetMaxY(label.frame)+10;
    [rowFirstButtons addObject:self.currenArr[0]];
    
    // 对其他Button进行设置
    int row = 0;
    for (int i = 1; i < self.currenArr.count; i++) {
        UIButton *button = self.currenArr[i];
        
        int sumWidth = 0;
        int start = (int)[self.currenArr indexOfObject:rowFirstButtons[row]];
        for (int j = start; j <= i; j++) {
            UIButton *button = self.currenArr[j];
                sumWidth += (button.width + margin);
        }
        sumWidth += 10;
        
        UIButton *lastButton = self.currenArr[i - 1];
        if (sumWidth >= self.width) {
            button.x = margin;
            button.y = lastButton.y + margin + button.height;
            [rowFirstButtons addObject:button];
            row ++;
        } else {
            button.x = sumWidth - margin - button.width;
            button.y = lastButton.y;
        }
                
    }
        self.lastBtn = self.currenArr.lastObject;
    }
    
    [self addSubview:self.sureBtn];
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.lastBtn.mas_bottom).with.offset(50);
        make.width.mas_offset(@100);
    }];
    
    self.height = CGRectGetMaxY(self.sureBtn.frame) + 50;
}


@end
