//
//  HYViewController.m
//  自定义导航控制器
//
//  Created by Sekorm on 16/4/22.
//  Copyright © 2016年 HelloYeah. All rights reserved.
//

#import "HYViewController.h"

@implementation HYViewController{
    
    NSInteger _hidenControlOptions;
    CGFloat _scrolOffsetY;
    UIScrollView * _keyScrollView;
    CGFloat _alpha;
    UIImage * _navBarBackgroundImage;
}

- (void)setKeyScrollView:(UIScrollView * )keyScrollView scrolOffsetY:(CGFloat)scrolOffsetY options:(HYHidenControlOptions)options{
    
    _keyScrollView = keyScrollView;
    _hidenControlOptions = options;
    _scrolOffsetY = scrolOffsetY;
    
    [_keyScrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
 
    CGPoint point = _keyScrollView.contentOffset;
    _alpha =  point.y/_scrolOffsetY;
    _alpha = (_alpha <= 0)?0:_alpha;
    _alpha = (_alpha >= 1)?1:_alpha;
    
    //设置导航条上的标签是否跟着透明
    self.navigationItem.leftBarButtonItem.customView.alpha = _hidenControlOptions & 1?_alpha:1;

    self.navigationItem.titleView.alpha = _hidenControlOptions >> 1 & 1 ?_alpha:1;
    self.navigationItem.rightBarButtonItem.customView.alpha = _hidenControlOptions >> 2 & 1?_alpha:1;
    
    [[[self.navigationController.navigationBar subviews]objectAtIndex:0] setAlpha:_alpha];
}

- (void)dealloc{
    
    [_keyScrollView removeObserver:self forKeyPath:@"contentOffset" context:nil];
}


//- (void)viewWillAppear:(BOOL)animated{
//    
//    
//    [super viewWillAppear:animated];
//    
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        
//        _navBarBackgroundImage = [self.navigationController.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault];
//    });
//    //设置背景图片
//    [self.navigationController.navigationBar setBackgroundImage:_navBarBackgroundImage forBarMetrics:UIBarMetricsDefault];
//    //清除边框，设置一张空的图片
//    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
//    
//    _keyScrollView.contentOffset = CGPointMake(0, _keyScrollView.contentOffset.y - 1);
//    _keyScrollView.contentOffset = CGPointMake(0, _keyScrollView.contentOffset.y + 1);
//    
//}
//
//- (void)viewWillDisappear:(BOOL)animated{
//    
//    [super viewWillDisappear:animated];
//    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:nil];
//    
//    
////    [[[self.navigationController.navigationBar subviews]objectAtIndex:0] setAlpha:0.999];
//
//}

@end
