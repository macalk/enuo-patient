//
//  TitleButtomView.m
//  ShiGuangJi
//
//  Created by luzhen on 16/8/18.
//  Copyright © 2016年 杭州笑嘻嘻网络科技有限公司. All rights reserved.
//

#import "TitleButtomView.h"
#import "UIColor+Extend.h"
#define WIDTH  [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height


@interface TitleButtomView ()

//记录选中的button
@property (nonatomic,strong) UIButton *selectBtn;

//下划线 lineLabel
@property (nonatomic,strong) UILabel *lineLabel;

//下划线宽度
@property (nonatomic,assign) float lineWidth;


@end

@implementation TitleButtomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor stringTOColor:@"#FFFFFF"];
        
    }
    return self;
}


//创建titleView（好友、客户、内部、供应商、群发）
- (void)createTitleBtnWithBtnArray:(NSArray *)titleBtnArray {
    
    //创建Button
    for (int i = 0; i<titleBtnArray.count; i++) {
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH/titleBtnArray.count*i, 0, WIDTH/titleBtnArray.count, self.bounds.size.height)];
        
        button.tag = 100+i;
        
        [button setTitleColor:[UIColor blackColor] forState:normal];
//        [button setTitleColor:[UIColor stringTOColor:@"#4A90E2"] forState:UIControlStateSelected];
        
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        
        [button setTitle:[NSString stringWithFormat:@"%@",titleBtnArray[i]] forState:normal];
        
        [button addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:button];
        
        if (0 == i) {
            button.selected = YES;
            
            self.selectBtn = button;
        }
    }
    
    //创建下划线
    self.lineWidth = WIDTH/titleBtnArray.count;
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.bounds.size.height-2, _lineWidth, 2)];
    lineLabel.backgroundColor = [UIColor stringTOColor:@"#4A90E2"];
    
    self.lineLabel = lineLabel;
    
    [self addSubview:lineLabel];
    
    
    
}

- (void)titleButtonClick:(UIButton *)sender {
    
    //代理
    [self.delegate titleButtonClickDelegate:sender.tag-100];
    
    
    self.selectBtn.selected = NO;

    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.lineLabel.frame = CGRectMake(_lineWidth*(sender.tag-100), self.lineLabel.frame.origin.y, _lineWidth, 2);
    }];
    
  
    self.selectBtn = sender;
    
    sender.selected = YES;
    
}

//被动改变button的状态
- (void)changeButtonState:(NSInteger)buttonTag {
    
    UIButton *titleBtn = [self viewWithTag:buttonTag+100];
    
    self.selectBtn.selected = NO;
    
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.lineLabel.frame = CGRectMake(_lineWidth*buttonTag, self.lineLabel.frame.origin.y, _lineWidth, 2);
    }];
    
    
    self.selectBtn = titleBtn;
    
    titleBtn.selected = YES;

}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
