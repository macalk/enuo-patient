//
//  HomeVC.m
//  enuoS
//
//  Created by apple on 17/3/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "HomeVC.h"
#import "Macros.h"
#import "LZScrollView.h"
#import "HomeView.h"
#import <Masonry.h>
#import "CarrModel.h"
#import "DeskModel.h"
#import <UIButton+WebCache.h>
#import "UIColor+Extend.h"
#import "FindDeskViewController.h"
#import "CarrWebController.h"
#import "ExaminaViewController.h"
#import "BaiduMapViewController.h"
#import "FindDocTableViewController.h"
#import "FindHosVC.h"
#import "ScanVC.h"

@interface HomeVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic,strong)LZScrollView *scrollView;
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIView *mainView;
@property (nonatomic,strong)HomeView *homeView;


@property (nonatomic,strong)NSMutableArray *scrollDataArr;
@property (nonatomic,strong)NSMutableArray *deskDataArr;

@end

/*
 科室button.tag = 20+
 轮播图.tag = 10+
 
 */

@implementation HomeVC

- (NSMutableArray *)scrollDataArr {
    if (!_scrollDataArr) {
        _scrollDataArr = [NSMutableArray array];
    }return _scrollDataArr;
}
- (NSMutableArray *)deskDataArr {
    if (!_deskDataArr) {
        _deskDataArr = [NSMutableArray array];
    }return _deskDataArr;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setUpTimer];
    
    self.navigationController.navigationBarHidden = YES;

}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //停止定时器
    [self.timer invalidate];
    self.timer = nil;
    
    self.navigationController.navigationBarHidden = NO;

    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createTableView];
    [self createMainView];
    
    [self shufflingFigureRequest];
    [self deskRequest];
    
}

#pragma mark---tableview
- (void)createTableView {
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeigth) style:UITableViewStylePlain];
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    return cell;
}
//创建主视图
- (void)createMainView {
    UIView *mainView = [[UIView alloc]init];
    self.mainView = mainView;
    self.tableView.tableHeaderView = mainView;
    
    [self createLZScrollView];
    
    self.homeView = [[HomeView alloc]init];
    [mainView addSubview:self.homeView];
    [self.homeView createHomeView];
    [self.homeView.uncomfortableBtn addTarget:self action:@selector(uncomfortableBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.homeView.beautifulBtn addTarget:self action:@selector(beautifulBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.homeView.conventionBtn addTarget:self action:@selector(conventionBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.homeView.findDocBtn addTarget:self action:@selector(findDocBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.homeView.findHosBtn addTarget:self action:@selector(findHosBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.homeView.arroundHosBtn addTarget:self action:@selector(arroundHosBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.homeView.deskMoreBtn addTarget:self action:@selector(deskMoreBtnClick) forControlEvents:UIControlEventTouchUpInside];



    [self.homeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView.mas_bottom);
        make.left.right.equalTo(mainView);
        make.height.mas_equalTo(self.homeView.viewHeight);
    }];

    
    mainView.frame = CGRectMake(0, 0, kScreenWidth, self.scrollView.frame.size.height+self.homeView.viewHeight);

}

#pragma mark--scrollview
- (void)createLZScrollView {
    self.scrollView = [[LZScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeigth*280/1334)];
    [self.mainView addSubview:self.scrollView];
    self.scrollView.scroll.delegate = self;
    
    
    __weak __typeof__(self) weakSelf = self;
    [self.scrollView addButtonAction:^(UIButton *sender) {
        
        CarrWebController *carrVC = [[CarrWebController alloc]init];
        CarrModel *model = weakSelf.scrollDataArr[sender.tag - 10];
        
        carrVC.receiver  = model.url;
        UINavigationController *naVC = [[UINavigationController alloc]initWithRootViewController:carrVC];
        naVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        carrVC.title  = model.title;
        
        [weakSelf  presentViewController: naVC animated:YES completion:^{
        }];
        
        NSLog(@"活动页面");
        
    }];
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.scrollView.pageControl.currentPage = self.scrollView.scroll.contentOffset.x/self.view.frame.size.width;
}

- (void)setUpTimer{
    self.timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(timerChanged) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
}
- (void)timerChanged{
    int page = (self.scrollView.pageControl.currentPage +1)%3;
    self.scrollView.pageControl.currentPage = page;
    [self pageChanger:self.scrollView.pageControl];
}

- (void)pageChanger:(UIPageControl *)pageControl{
    CGFloat x = (pageControl.currentPage)*self.scrollView.bounds.size.width;
    [self.scrollView.scroll setContentOffset:CGPointMake(x, 0) animated:YES];
    
}

#pragma mark ==== 按钮点击事件
//哪里不舒服
- (void)uncomfortableBtnClick {
    ExaminaViewController *exminVC = [[ExaminaViewController alloc]init];
    UINavigationController *naNc = [[UINavigationController alloc]initWithRootViewController:exminVC];
    
    naNc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:naNc animated:YES completion:^{
        
    }];
}
//美啦美啦
- (void)beautifulBtnClick {
    
}
//便捷约定
- (void)conventionBtnClick {
    ScanVC *scanVC = [[ScanVC alloc]init];
//    scanVC.view.backgroundColor = [UIColor whiteColor];
    scanVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:scanVC animated:YES];
}
//找医生
- (void)findDocBtnClick {
    FindDocTableViewController *proVC  = [[FindDocTableViewController alloc]init];
    UINavigationController *naVC = [[UINavigationController alloc]initWithRootViewController:proVC];
    naVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self  presentViewController: naVC animated:YES completion:^{
    }];
}
//找医院
- (void)findHosBtnClick {
    FindHosVC *proVC = [[FindHosVC alloc]init];
    UINavigationController *naVC = [[UINavigationController alloc]initWithRootViewController:proVC];
    naVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:naVC animated:YES completion:^{
        
    }];
}
//周边医院
- (void)arroundHosBtnClick {
    BaiduMapViewController *baiVC = [[BaiduMapViewController alloc]init];
    UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:baiVC];
    naNC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:naNC animated:YES completion:^{
        
    }];
}
//更多
- (void)deskMoreBtnClick {
    
}
//所有科室
- (void)deskBtnClick:(UIButton *)sender {
    DeskModel *model;
    for (int i = 0; i<self.deskDataArr.count; i++) {
        model = self.deskDataArr[sender.tag-20];
    }
    
    FindDeskViewController *dinVC = [[FindDeskViewController alloc]init];
    dinVC.receiver = model.cid;
    dinVC.retitle = model.department;
    UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:dinVC];
    naNC.navigationItem.title = model.department;
    [self presentViewController:naNC animated:YES completion:^{
        
    }];
}

#pragma mark ---- 数据请求
//轮播图
- (void)shufflingFigureRequest {
    NSString *url = @"http://www.enuo120.com/index.php/app/index/ads";
    
    BaseRequest *request = [[BaseRequest alloc]init];
    [request POST:url params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"reeeee  = %@",responseObject);
        [self shufflingFigureRequestData:responseObject];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error = %@",error);
        NSLog(@"1111");
    }];
}
- (void)shufflingFigureRequestData:(NSDictionary *)dic {
    if ([dic[@"data"]isKindOfClass:[NSNull class]]) {
        NSLog(@"没有数据");
    }else{
        
        NSArray *arr = dic[@"data"];
        NSMutableArray *scrollImageUlrArr = [NSMutableArray array];
        
        for (NSDictionary *temp in arr) {
            CarrModel *model = [CarrModel carrModelInItWithDic:temp];
            [self.scrollDataArr addObject:model];
            [scrollImageUlrArr addObject:[NSString stringWithFormat:urlPicture,model.photo]];
            
            NSLog(@"%@",model.photo);
        }
        
        
        [self.scrollView createScrollViewAndPagControllWithImageUrlArr:scrollImageUlrArr];
    }
}

//科室
- (void)deskRequest {
    NSString *url = @"http://www.enuo120.com/index.php/app/index/find_keshi";
    BaseRequest *request = [[BaseRequest alloc]init];
    [request POST:url params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [self deskRequestData:responseObject];
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"1111");
        
    }];
}

- (void)deskRequestData:(NSDictionary *)data{
    NSArray *array = data[@"data"];
    
    for (NSDictionary *temp in array) {
        DeskModel *model = [DeskModel deskModelInitWithDic:temp];
        [self.deskDataArr addObject:model];
    }
    
    for (int i = 0; i<self.homeView.deskButtonArr.count;i++ ) {
        
        DeskModel *model = self.deskDataArr[i];
        
        UIButton *button = self.homeView.deskButtonArr[i];
        button.tag = 20+i;
        [button sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:urlPicture,model.photo]] forState:normal];
        [button addTarget:self action:@selector(deskBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *label = self.homeView.deskButtonTitleArr[i];
        label.text = [NSString stringWithFormat:@"%@",model.department];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
