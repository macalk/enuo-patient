//
//  hosFiltrateView.m
//  enuoS
//
//  Created by apple on 16/11/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "hosFiltrateView.h"
#import "Macros.h"
#import "FindHosModel.h"
#import "UIColor+Extend.h"

@implementation hosFiltrateView


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)createBtnWithAreaArray:(NSArray *)areaArr andSortArr:(NSArray *)sortArr andTitleArr:(NSArray *)titleArr{
    
    self.sortArr = sortArr;
    self.areaArr = areaArr;
    self.titleArr = titleArr;
    
    for (UIButton *button in areaArr) {
        [self addSubview:button];
    }
    
    for (UIButton *button in sortArr) {
        [self addSubview:button];
    }
    
    
    
}

- (void)layoutSubviews {
    for (int i = 0;i<self.titleArr.count; i++) {
        UILabel *titlelabel = [[UILabel alloc]init];
        titlelabel.text = [NSString stringWithFormat:@"%@",self.titleArr[i]];
        titlelabel.font = [UIFont systemFontOfSize:13];
        titlelabel.textAlignment = NSTextAlignmentCenter;
        titlelabel.frame = CGRectMake(kScreenWidth/2*i, 0, kScreenWidth/2, 44);
        [self addSubview:titlelabel];
    }
    
    
    for (int i = 0; i<self.areaArr.count; i++) {
        UIButton *button = self.areaArr[i];
        if (self.titleArr == nil) {
            button.center = CGPointMake(kScreenWidth/4, 22+44*i);
        }else {
            button.center = CGPointMake(kScreenWidth/4, 66+44*i);
        }
        button.bounds = CGRectMake(0, 0, kScreenWidth/2, 44);
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button setTitleColor:[UIColor blackColor] forState:normal];
    }
    
    for (int i = 0; i<self.sortArr.count; i++) {
        UIButton *button = self.sortArr[i];
        if (self.titleArr == nil) {
            button.center = CGPointMake(kScreenWidth/4*3, 22+44*i);
        }else {
            button.center = CGPointMake(kScreenWidth/4*3, 66+44*i);
        }
        button.bounds = CGRectMake(0, 0, kScreenWidth/2, 44);
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button setTitleColor:[UIColor blackColor] forState:normal];
    }

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
