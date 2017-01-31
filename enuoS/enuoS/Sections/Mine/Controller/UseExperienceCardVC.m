//
//  UseExperienceCardVC.m
//  enuoS
//
//  Created by apple on 16/12/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UseExperienceCardVC.h"
#import "UIColor+Extend.h"
#import "Macros.h"
#import <Masonry.h>
#import "SZKAlterView.h"
#import <AFHTTPSessionManager.h>
@interface UseExperienceCardVC ()<UIScrollViewDelegate>

@property (nonatomic,strong)UILabel *weekTitleLabel;

@property (nonatomic,strong)NSMutableArray *WeekListArr;
@property (nonatomic,strong)NSMutableArray *dayListArr;
@property (nonatomic,strong)NSMutableArray *apmListArr;

@property (nonatomic,strong)UIPageControl *pageControl;

@property (nonatomic,strong)NSString *selectDate;
@property (nonatomic,strong)UIButton *selectBtn;


@end

@implementation UseExperienceCardVC

- (NSMutableArray *)apmListArr {
    if (!_apmListArr) {
        _apmListArr = [NSMutableArray array];
    }return _apmListArr;
}
- (NSMutableArray *)WeekListArr {
    if (!_WeekListArr) {
        _WeekListArr = [NSMutableArray array];
    }return _WeekListArr;
}
- (NSMutableArray *)dayListArr {
    if (!_dayListArr) {
        _dayListArr = [NSMutableArray array];
    }return _dayListArr;
}

- (void)customNavView {
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.center = self.navigationItem.titleView.center;
    titleLabel.bounds = CGRectMake(0, 0, 100, 20);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"预约";
    self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"白色返回"] style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonClick:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}
- (void)leftBarButtonClick:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self customNavView];
    [self dateRequest];
}

//获取时间
- (void)dateRequest {
    NSString *url = @"http://www.enuo120.com/index.php/app/Patient/experience_guahao";
    NSDictionary *dic = @{@"cardno":self.cardno};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self dateRequestWithData:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)dateRequestWithData:(NSDictionary *)dic {
    NSDictionary *scheduleListDic = dic[@"data"][@"content"][@"schedule_list"];

    NSArray *oneAmArr = scheduleListDic[@"now_list"][@"am_list"];
    NSArray *onePmArr = scheduleListDic[@"now_list"][@"pm_list"];
    NSArray *oneWeekArr = scheduleListDic[@"now_list"][@"week_list"];
    NSArray *oneDayArr = scheduleListDic[@"now_list"][@"day_list"];

    
    [self.WeekListArr addObject:oneWeekArr];
    [self.dayListArr addObject:oneDayArr];
    
    NSMutableArray *oneAPmArr = [NSMutableArray array];
    for (int i =0; i<oneAmArr.count; i++) {
        NSDictionary *dic = oneAmArr[i];
        [oneAPmArr addObject:dic[@"date"]];
    }
    for (int i =0; i<onePmArr.count; i++) {
        NSDictionary *dic = onePmArr[i];
        [oneAPmArr addObject:dic[@"date"]];
    }
    
    
    NSArray *twoAmArr = scheduleListDic[@"one_week_list"][@"am_list"];
    NSArray *twoPmArr = scheduleListDic[@"one_week_list"][@"pm_list"];
    NSArray *twoWeekArr = scheduleListDic[@"one_week_list"][@"week_list"];
    NSArray *twoDayArr = scheduleListDic[@"one_week_list"][@"day_list"];
    
    [self.WeekListArr addObject:twoWeekArr];
    [self.dayListArr addObject:twoDayArr];
    
    NSMutableArray *twoAPmArr = [NSMutableArray array];
    for (int i =0; i<twoAmArr.count; i++) {
        NSDictionary *dic = twoAmArr[i];
        [twoAPmArr addObject:dic[@"date"]];
    }
    for (int i =0; i<twoPmArr.count; i++) {
        NSDictionary *dic = twoPmArr[i];
        [twoAPmArr addObject:dic[@"date"]];
    }
    

    NSArray *threeAmArr = scheduleListDic[@"two_week_list"][@"am_list"];
    NSArray *threePmArr = scheduleListDic[@"two_week_list"][@"pm_list"];
    NSArray *threeWeekArr = scheduleListDic[@"two_week_list"][@"week_list"];
    NSArray *threeDayArr = scheduleListDic[@"two_week_list"][@"day_list"];
    
    [self.WeekListArr addObject:threeWeekArr];
    [self.dayListArr addObject:threeDayArr];
    
    NSMutableArray *threeAPmArr = [NSMutableArray array];
    for (int i =0; i<threeAmArr.count; i++) {
        NSDictionary *dic = threeAmArr[i];
        [threeAPmArr addObject:dic[@"date"]];
    }
    for (int i =0; i<threePmArr.count; i++) {
        NSDictionary *dic = threePmArr[i];
        [threeAPmArr addObject:dic[@"date"]];
    }
    

    [self.apmListArr addObject:oneAPmArr];
    [self.apmListArr addObject:twoAPmArr];
    [self.apmListArr addObject:threeAPmArr];
    
    [self createCustomView];

}

- (void)createCustomView {
    
    UILabel *hosLabel = [[UILabel alloc]init];
    hosLabel.text = @"预约医院: ";
    hosLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:hosLabel];
    
    UILabel *hosTextLabel= [[UILabel alloc]init];
    hosTextLabel.font = [UIFont systemFontOfSize:15];
    hosTextLabel.text = self.hosName;
    [self.view addSubview:hosTextLabel];
    
    UILabel *numberLabel = [[UILabel alloc]init];
    numberLabel.text = @"编       号: ";
    numberLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:numberLabel];
    UILabel *numberTextLabel = [[UILabel alloc]init];
    numberTextLabel.font = [UIFont systemFontOfSize:15];
    numberTextLabel.text = self.cardno;
    [self.view addSubview:numberTextLabel];
    
    UILabel *productLabel = [[UILabel alloc]init];
    productLabel.text = @"产       品: ";
    productLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:productLabel];
    UILabel *productTextLabel = [[UILabel alloc]init];
    productTextLabel.text = self.product;
    productTextLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:productTextLabel];
    
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.backgroundColor = [UIColor stringTOColor:@"#fdab2c"];
    scrollView.contentSize = CGSizeMake(kScreenWidth*3, 0);
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    UILabel *weekTitleLabel = [[UILabel alloc]init];
    weekTitleLabel.text = @"本周";
    self.weekTitleLabel = weekTitleLabel;
    weekTitleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:weekTitleLabel];
    
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    pageControl.numberOfPages = 3;
    pageControl.pageIndicatorTintColor = [UIColor orangeColor];
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    self.pageControl = pageControl;
    [self.view addSubview:pageControl];
    
    UIButton *sureBtn = [[UIButton alloc]init];
    [sureBtn setTitle:@"确认" forState:normal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:normal];
    [sureBtn setBackgroundColor:[UIColor stringTOColor:@"#22cccf"]];
    [sureBtn addTarget:self action:@selector(sendDataClick:) forControlEvents:UIControlEventTouchUpInside];
    sureBtn.layer.cornerRadius = 5;
    sureBtn.clipsToBounds = YES;
    [self.view addSubview:sureBtn];
    
    
    //横间距
    float hDistance = (kScreenWidth-20)/8;
    
    for (int i = 0; i<3; i++) {
        
        UIView *weekView = [[UIView alloc]init];
        weekView.frame = CGRectMake(kScreenWidth*i, 30, kScreenWidth, 100);
        weekView.backgroundColor = [UIColor clearColor];
        [scrollView addSubview:weekView];
        
        for (int i = 0; i<9; i++) {
            //竖线
            UILabel *Vline = [[UILabel alloc]init];
            Vline.frame = CGRectMake(10+hDistance*i, 0, 1, 100);
            Vline.backgroundColor = [UIColor lightGrayColor];
            [weekView addSubview:Vline];
        }
        for (int i = 0; i<4; i++) {
            //横线
            UILabel *Hline = [[UILabel alloc]init];
            Hline.backgroundColor = [UIColor lightGrayColor];
            [weekView addSubview:Hline];
            if (i == 0) {
                Hline.frame = CGRectMake(10, 0, kScreenWidth-20, 1);
            }else {
                Hline.frame = CGRectMake(10, 40+(i-1)*30, kScreenWidth-20, 1);
            }
        }
        
        //排版 上午 下午
        NSArray *hintArr = @[@"排班",@"上午",@"下午"];
        for ( int i= 0; i<3; i++) {
            UILabel *label = [[UILabel alloc]init];
            label.text = hintArr[i];
            label.font = [UIFont systemFontOfSize:13];
            label.textAlignment = NSTextAlignmentCenter;
            [weekView addSubview:label];
            if (i == 0) {
                label.frame = CGRectMake(10, 0, hDistance, 40);
            }else {
                label.frame = CGRectMake(10, 40+30*(i-1), hDistance, 30);
            }
        }
        
        //周几 几号
        for (int j =0; j<7; j++) {
            UILabel *weekLabel = [[UILabel alloc]init];
            weekLabel.font = [UIFont systemFontOfSize:12];
            weekLabel.textAlignment = NSTextAlignmentCenter;
            weekLabel.text = self.WeekListArr[i][j];
            weekLabel.frame = CGRectMake(10+hDistance+hDistance*j, 0, hDistance, 20);
            [weekView addSubview:weekLabel];
            
            UILabel *dateLabel = [[UILabel alloc]init];
            dateLabel.font = [UIFont systemFontOfSize:11];
            dateLabel.textColor = [UIColor lightGrayColor];
            dateLabel.textAlignment = NSTextAlignmentCenter;
            dateLabel.text = self.dayListArr[i][j];
            dateLabel.frame = CGRectMake(10+hDistance+hDistance*j, 20, hDistance, 20);
            [weekView addSubview:dateLabel];
        }
        
        //坐诊
        for (int j = 0; j<14; j++) {
            UIButton *button = [[UIButton alloc]init];
            [button setTitle:@"坐诊" forState:normal];
            button.titleLabel.font = [UIFont systemFontOfSize:13];
            [button setTitleColor:[UIColor blackColor] forState:normal];
            button.frame = CGRectMake(10+hDistance+hDistance*(j%7), 40+30*(j/7), hDistance, 30);
            button.tag = 100*i+j;
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [weekView addSubview:button];
        }
        

    }
    
    
    [hosLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(40);
        make.left.equalTo(self.view).with.offset(20);
    }];
    [hosTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(hosLabel);
        make.left.equalTo(hosLabel.mas_right).with.offset(10);
    }];
    
    [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hosLabel.mas_bottom).with.offset(20);
        make.right.equalTo(hosLabel);
    }];
    [numberTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(numberLabel);
        make.left.equalTo(numberLabel.mas_right).with.offset(10);
    }];
    
    [productLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(numberLabel.mas_bottom).with.offset(20);
        make.right.equalTo(numberLabel);
    }];
    [productTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(productLabel);
        make.left.equalTo(productLabel.mas_right).with.offset(10);
    }];
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(productLabel.mas_bottom).with.offset(20);
        make.size.mas_offset(CGSizeMake(kScreenWidth, 160));
    }];
    
    [weekTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(scrollView);
        make.centerY.equalTo(scrollView.mas_top).with.offset(15);
    }];
    
    [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(scrollView.mas_bottom).with.offset(-15);
    }];
    
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(scrollView.mas_bottom).with.offset(20);
        make.width.mas_offset(@80);
    }];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (![scrollView isKindOfClass:[UITableView class]]) {
        NSArray *titleArr = @[@"本周",@"下周",@"下下周"];
        int page = scrollView.contentOffset.x/kScreenWidth;
        self.weekTitleLabel.text = [NSString stringWithFormat:@"%@",titleArr[page]];
        self.pageControl.currentPage = page;
    }
}

//坐诊按钮点击事件
- (void)buttonClick:(UIButton *)sender {
    if (sender.tag<100) {
        self.selectDate = self.apmListArr[0][sender.tag];
    }else if (100<=sender.tag && sender.tag<200) {
        self.selectDate = self.apmListArr[1][sender.tag-100];
    }else {
        self.selectDate = self.apmListArr[2][sender.tag-200];
    }
    
    [self.selectBtn setBackgroundColor:[UIColor clearColor]];
    sender.backgroundColor = [UIColor greenColor];
    self.selectBtn = sender;
    
}

//确认按钮
- (void)sendDataClick:(UIButton *)sender {
    if (self.selectDate == nil) {
        
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeigth)];
        bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [self.view addSubview:bgView];
        
        SZKAlterView *alterView = [SZKAlterView alterViewWithTitle:@"提示" content:@"请选择时间" cancel:@"取消" sure:@"确定" cancelBtClcik:^{
            [bgView removeFromSuperview];
        } sureBtClcik:^{
            [bgView removeFromSuperview];
        }];
        [bgView addSubview:alterView];
        
    }else {
        [self requestWithSureBtn];
    }
}



#pragma mark---提交按钮事件
- (void)requestWithSureBtn {
    
    
    
    NSString *username = [[NSUserDefaults standardUserDefaults]objectForKey:@"name"];
    
    NSLog(@"%@~~%@~~%@",self.cardno,self.selectDate,self.hosID);
    
    NSString *url = @"http://www.enuo120.com/index.php/app/Patient/experience_kanb";
    NSDictionary *dic = @{@"cardno":self.cardno,@"date":self.selectDate,@"username":username,@"hos_id":self.hosID};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self requestWithSureBtnData:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)requestWithSureBtnData:(NSDictionary *)dic {
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeigth)];
    bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self.view addSubview:bgView];
    
    NSString *message = [NSString stringWithFormat:@"%@",dic[@"data"][@"message"]];
    SZKAlterView *alterView = [SZKAlterView alterViewWithTitle:@"提示" content:message cancel:@"取消" sure:@"确定" cancelBtClcik:^{
        [bgView removeFromSuperview];
        [self.navigationController popViewControllerAnimated:YES];
    } sureBtClcik:^{
        [bgView removeFromSuperview];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [bgView addSubview:alterView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
