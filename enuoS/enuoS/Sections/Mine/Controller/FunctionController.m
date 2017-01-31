//
//  FunctionController.m
//  enuoS
//
//  Created by apple on 16/8/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "FunctionController.h"
#import <Masonry.h>
#import "Macros.h"
@interface FunctionController ()<UIScrollViewDelegate>

@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)UIPageControl *pangeControl;
@property (nonatomic,strong)NSTimer *timer;
@end

@implementation FunctionController



- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"绿色返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleWithBack:)];
               self.navigationItem.leftBarButtonItem = leftItem;
    }return self;
}

- (UIPageControl *)pangeControl{
    if (!_pangeControl) {
        self.pangeControl = [[UIPageControl alloc]init];
    }return _pangeControl;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        self.scrollView = [[UIScrollView alloc]init];
    }return _scrollView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    [self creatScrollView];
    [self creatPageControl];
     [self setUpTimer];
}

- (void)handleWithBack:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

//设置轮播图
- (void)creatScrollView{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth-20, kScreenHeigth-20)];
    //_scrollView.backgroundColor = [UIColor redColor];
    //2.设置滚动视图所能显示的内容区域大小 contentSize (contentSize设置当前滑动视图控制所能展示的内容区域)
    _scrollView.contentSize = CGSizeMake((kScreenWidth-20)*3, kScreenHeigth-20);
    _scrollView.contentOffset = CGPointMake(0, 0);
    //4.设置滚动条的样式 （默认为黑色）
    NSArray * arr = @[@"引导1.jpg",@"引导2.jpg",@"引导3.jpg"];
    for (int i = 0; i<3; i++) {
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-20) *i, 10, kScreenWidth-20, kScreenHeigth-20)];
        image.image = [UIImage imageNamed:arr[i]];
        
        [self.scrollView addSubview:image];
    }
    
    _scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    //5.整屏滚动
    _scrollView.pagingEnabled = YES;
    //6.关闭回弹效果
    _scrollView.bounces = NO;
    //关闭滚动条
    //水平方向
    _scrollView.showsHorizontalScrollIndicator = NO;
    //竖直方向
    _scrollView.showsVerticalScrollIndicator = NO;
    
    //设置代理对象
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
}
//标签点的使用
- (void)creatPageControl{
    
    self.pangeControl = [[UIPageControl alloc]initWithFrame:CGRectMake(kScreenWidth/2-10, self.scrollView.frame.size.height -30, 20, 15)];
    _pangeControl.numberOfPages = 3;
    _pangeControl.currentPage = 0;
    _pangeControl.currentPageIndicatorTintColor = [UIColor blackColor];
    _pangeControl.pageIndicatorTintColor = [UIColor grayColor];
    //添加响应事件
    [_pangeControl addTarget:self action:@selector(handlePageControl:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_pangeControl];
}
- (void)handlePageControl:(UIPageControl *)sender{
    [self.scrollView setContentOffset:CGPointMake(kScreenWidth*sender.currentPage , 0) animated:YES];
}



#pragma mark -UIScrollViewDelegate--



- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //停止定时器
    [self.timer invalidate];
}






- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"减速完成时%s,%d",__FUNCTION__,__LINE__);
    //根据当前滚动视图的偏移量得到当前分页对应的下标
    //将分页控件设置当前页为偏移量对应的分页数下标
    self.pangeControl.currentPage = self.scrollView.contentOffset.x/self.view.frame.size.width;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self setUpTimer];
}

- (void)setUpTimer{
    self.timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(timerChanged) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
}
- (void)timerChanged{
    int page = (self.pangeControl.currentPage +1)%3;
    self.pangeControl.currentPage = page;
    [self pageChanger:self.pangeControl];
}

- (void)pageChanger:(UIPageControl *)pageControl{
    CGFloat x = (pageControl.currentPage)*self.scrollView.bounds.size.width;
    [self.scrollView setContentOffset:CGPointMake(x, 0) animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}



@end
