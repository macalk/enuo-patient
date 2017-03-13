//
//  LZScrollView.m
//  enuoS
//
//  Created by apple on 17/3/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "LZScrollView.h"
#import <UIButton+WebCache.h>

@interface LZScrollView () 

@property (nonatomic,strong)ButtonBlock block;

@end

@implementation LZScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)createScrollViewAndPagControllWithImageUrlArr:(NSArray *)arr {
    
    float LZWidth = [UIScreen mainScreen].bounds.size.width;
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.frame];
    self.scroll = scrollView;
    scrollView.pagingEnabled = YES;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(LZWidth*arr.count, 100);
    [self addSubview:scrollView];
    
    for (int i = 0; i<arr.count; i++) {
        
//        UIImageView *imageView = [[UIImageView alloc]init];
//        imageView.image = [UIImage imageNamed:@"下一步"];
//        imageView.frame = CGRectMake(LZWidth*i, 0, LZWidth, scrollView.frame.size.height);
//        [scrollView addSubview:imageView];
        
        UIButton *buttom = [[UIButton alloc]init];
        buttom.tag = 10+i;
        buttom.frame = CGRectMake(LZWidth*i, 0, LZWidth, scrollView.frame.size.height);
        [scrollView addSubview:buttom];
        [buttom sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",arr[i]]] forState:normal];
        [buttom addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    
    UIPageControl *pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(LZWidth/2-10, self.frame.size.height -30, 20, 15)];
    self.pageControl = pageControl;
    pageControl.numberOfPages = 3;
    pageControl.currentPage = 0;
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    [self addSubview:pageControl];

}

//实现block回调的方法
- (void)addButtonAction:(ButtonBlock)block {
    self.block = block;
}
- (void)buttonAction:(UIButton *)sender {
    if (self.block) {
        self.block(sender);
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
