//
//  LZScrollView.h
//  enuoS
//
//  Created by apple on 17/3/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZScrollView : UIView

typedef void (^ButtonBlock) (UIButton *sender);

@property (nonatomic,strong) UIScrollView *scroll;
@property (nonatomic,strong) UIPageControl *pageControl;

- (void)createScrollViewAndPagControllWithImageUrlArr:(NSArray *)arr;

- (void)addButtonAction:(ButtonBlock)block;  

@end
