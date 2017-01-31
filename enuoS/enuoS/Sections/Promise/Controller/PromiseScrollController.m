//
//  PromiseScrollController.m
//  enuoS
//
//  Created by apple on 16/7/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "PromiseScrollController.h"
#import "TitleLabel.h"
#import "PromisesViewController.h"
#import "PromiseTwoViewController.h"
#import "Macros.h"

@interface PromiseScrollController ()<UIScrollViewDelegate>

@property (nonatomic,strong)UIScrollView *markScrollView;
@property (nonatomic,strong)UIScrollView *contentScrollView;
@property (nonatomic,strong)UIView *topBackView;
@property (nonatomic,strong)UISegmentedControl *segmented;

@end

@implementation PromiseScrollController


//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//        [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
//}


//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//     [[UIApplication sharedApplication]setStatusBarStyle: UIStatusBarStyleDefault];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeigth-64)];
    
    [self.view addSubview:webView];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://mp.weixin.qq.com/s?__biz=MzIyMTA1NzYzMA==&mid=2650302274&idx=1&sn=3e0db9499c9eb69b440e31849e63959e&chksm=8fce4073b8b9c965429fcdb75b594ff638adf9334bc4fcd6e4204aaba51c583da70cd8bf7783&scene=0#rd"]];
    
    [webView loadRequest:request];
    
    /*************新版本只用加载web*************/
    
//    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
//
//   [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
//    self.navigationController.navigationBar.translucent = NO;
//    
//    [self initScorllView];
//    [self creatSegement];
//    //添加自控制器
//    //添加自控制器
//    [self addChildVC];
//
//    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
//    [self scrollViewDidScroll:self.contentScrollView];
    
}

- (void)creatSegement{
    self.segmented = [[UISegmentedControl alloc]initWithItems:@[@"医生",@"医院"]];
    self.segmented.frame = CGRectMake(0, 0, 120, 30);
    self.navigationItem.titleView = self.segmented;
    self.segmented.selectedSegmentIndex = 0;
    self.segmented.tintColor =  [UIColor whiteColor];

    [self.segmented addTarget:self action:@selector(handleChangeSegmentWithValue:) forControlEvents:UIControlEventValueChanged];
}
- (void)initScorllView{
    
    CGFloat uiWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat uiHeigh = [UIScreen mainScreen].bounds.size.height;
    //初始化导航scrollView
//    _markScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,20, 40)];
//    _markScrollView.backgroundColor = [UIColor lightGrayColor];
//    _markScrollView.showsHorizontalScrollIndicator = NO;
//    //[self.view addSubview:self.markScrollView];
//    self.navigationItem.titleView = _markScrollView;
    //初始化内容scrollView
    _contentScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, uiWidth, uiHeigh)];
    _contentScrollView.backgroundColor = [UIColor whiteColor];
    _contentScrollView.contentSize = CGSizeMake(uiWidth*2,0);
    _contentScrollView.showsHorizontalScrollIndicator = NO;
    _contentScrollView.showsVerticalScrollIndicator = NO;
     self.view =  _contentScrollView;
    _contentScrollView.pagingEnabled = YES;
    _contentScrollView.delegate = self;
   
    //添加标题
    
    //[self setupTitle];
    
    
    
    
    
    
}

- (void)handleChangeSegmentWithValue:(UISegmentedControl *)sender{
    
       self.contentScrollView.contentOffset = CGPointMake(sender.selectedSegmentIndex *kScreenWidth , 0);

         [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
}




-(void)addChildVC
{

        
        PromisesViewController *ceshiVC = [[PromisesViewController alloc]init];
        NSString *title = [NSString stringWithFormat:@"标题医生"];
    
        ceshiVC.title = title;
        PromiseTwoViewController *twoVC = [[PromiseTwoViewController alloc]init];
        
        //ceshiVC.receiver = [NSString stringWithFormat:@"%d",i];
        
   [self addChildViewController:ceshiVC];
    [self addChildViewController:twoVC];
    
  
}













#pragma mark -- scrollView Delegate
/**
 *  人为的拖拽 会调用
 *
// */
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

#pragma mark -- 核心代码
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    
    //取出需要显示的控制器
    //拿到索引
    NSInteger  index =  scrollView.contentOffset.x/scrollView.frame.size.width;
    UIViewController *willShow =  self.childViewControllers[index];
    
    /**
     *  标题自动居中
     */
    
    CGPoint offsetPoint = self.markScrollView.contentOffset;
    
    TitleLabel *label = self.markScrollView.subviews[index];
    
    offsetPoint.x = label.center.x -scrollView.frame.size.width*0.5;
    
    //左边超出处理
    if (offsetPoint.x<0) offsetPoint.x = 0;
    //最大偏移量
    CGFloat maxX = self.markScrollView.contentSize.width -scrollView.frame.size.width;
    //右边超出处理
    if (offsetPoint.x>maxX) offsetPoint.x = maxX;
    
    [self.markScrollView setContentOffset:offsetPoint animated:YES];
    
    
    
    //当前的位置的已经显示过了 就直接返回
    if ([willShow isViewLoaded]) {
        return;
    }
    
    willShow.view.frame = CGRectMake(scrollView.contentOffset.x, 0, scrollView.frame.size.width, scrollView.frame.size.height);
    
    
    [self.contentScrollView addSubview:willShow.view];
    
    
    
}

/**
 *  实时监控scrollView 的滚动
 *
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
   
        if (scrollView.contentOffset.x == 0) {
            self.segmented.selectedSegmentIndex = 0;
                }else{
            self.segmented.selectedSegmentIndex = 1;
        }
    
        
 

    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
