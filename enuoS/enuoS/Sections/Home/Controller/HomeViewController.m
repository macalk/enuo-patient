//
//  HomeViewController.m
//  enuoNew
//
//  Created by apple on 16/6/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "HomeViewController.h"
#import "Macros.h"
#import <AFNetworking.h>
#import <Masonry.h>
#import "DeskCollectionCell.h"
#import "DeskHeaderView.h"
#import "UIViewController+NavBarHidden.h"
#import "DeskModel.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
#import "CarrModel.h"
#import "CarrWebController.h"
#import "FindDocTableViewController.h"
#import "LogonViewController.h"
#import "FindHosTableController.h"
#import "ExaminaViewController.h"
#import "BaiduMapViewController.h"
#import "AssistiveTouch.h"
#import "SearchViewController.h"
#import "PiaoLiangViewController.h"
#import "DanDanViewController.h"
#import "FindDeskViewController.h"
#import "EndPJNewViewController.h"
#import "ActiviceViewController.h"
#import "FindHosVC.h"
#import "SZKAlterView.h"
#import "BaseRequest.h"

#define APPURL @"http://itunes.apple.com/cn/lookup?id=1113857369"


@interface HomeViewController ()<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,AssistiveTouchDelegate>

{
    AssistiveTouch *mwindow;
}
@property (nonatomic,strong)UIWindow *window;
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)UIPageControl *pangeControl;
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,strong)UIView *bottView;
@property (nonatomic,weak)UICollectionView *deskView;

@property (nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic,strong)NSMutableArray *dataCarrArray;

@property (nonatomic,copy)NSString *acUrl;
@property (nonatomic,copy)NSString *acTitle;

@property (nonatomic,assign) NSInteger upData;
@property (nonatomic,copy)NSString *localVersion;//当前版本
@property (nonatomic,copy)NSString *newestVersion;//最新版本


@end

@implementation HomeViewController


- (NSMutableArray *)dataCarrArray{
    if (!_dataCarrArray) {
        self.dataCarrArray = [NSMutableArray array];
    }return _dataCarrArray;
    
}





- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }return _dataArray;
}


- (UIView *)bottView{
    if (!_bottView) {
        self.bottView = [[UIView alloc]init];
        
    }return _bottView;
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
      [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];
    [self requestActiveData];
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [mwindow removeFromSuperview];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD show];
      self.tabBarController.tabBar.tintColor =  [UIColor colorWithRed:0/255.0 green:179/255.0 blue:163/255.0 alpha:1];
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self requestDeskData];
    [self requestCarrData];

    self.view.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];
    [self creatFindDeskView];
  

    UIImageView *imager = [[UIImageView alloc]init];
    self.navigationItem.titleView  = imager;
    [imager mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenWidth-20);
        make.height.mas_equalTo(imager.mas_width).multipliedBy(0.09);
    }];
    imager.image = [UIImage imageNamed:@"搜索框"];
    UITapGestureRecognizer *tapMenger = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapWithSearchImage:)];
    imager.userInteractionEnabled = YES;
    [imager addGestureRecognizer:tapMenger];

    self.tabBarController.tabBar.translucent = NO;
    
    /*******版本更新********/
    [self MandatoryUp];
}
//判断是否强制更新
- (void)MandatoryUp {
    
    NSDictionary *dic = @{@"type":@"app"};
    
    NSString *url = @"http://www.enuo120.com/index.php/app/index/check_update";
    
    
    BaseRequest *request = [[BaseRequest alloc]init];
    [request POST:url params:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        [self MandatoryUpData:responseObject];

    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

- (void)MandatoryUpData:(NSDictionary *)dic {
    NSArray *dataArr = dic[@"data"];
    
    NSDictionary *localDic =[[NSBundle mainBundle] infoDictionary];
    NSString *localVersion =[localDic objectForKey:@"CFBundleVersion"];//当前app版本
    self.localVersion = localVersion;
        
    int currentVer = 0;//当前版本所在位置
    for (int i=0; i<dataArr.count; i++) {
        if ([localVersion isEqualToString:dataArr[i][@"versionName"]]) {
            currentVer = i;
        }
    }
    
    for (int i=0; i<dataArr.count; i++) {
        if (currentVer<i) {
            if ([dataArr[i][@"update_result"] isEqualToString:@"1"]) {
                self.upData = 1;
            }
        }
    }
    
    
    self.newestVersion = [dataArr lastObject][@"versionName"];
    
    if (![self.localVersion isEqualToString:self.newestVersion]) {
        [self requestVersions];//请求版本号
    }
    

}

//检测版本
- (void)requestVersions {
    
    BaseRequest *request = [[BaseRequest alloc]init];
    [request POST:APPURL params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [self VersionsData:responseObject];

    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

- (void)VersionsData:(NSDictionary *)dic {
    NSDictionary *inforDic = [dic[@"results"] objectAtIndex:0];
    NSString *storVersion = [inforDic objectForKey:@"version"];//appStor 版本号
    NSString *appURL = [inforDic objectForKey:@"trackViewUrl"];//app链接
    
    
       //如果版本不相等 证明要更新版本
    if (![self.localVersion isEqualToString:storVersion]) {
        
    
    
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"更新" message:[NSString stringWithFormat:@"检测到有新版本:v%@",storVersion] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSURL *url = [NSURL URLWithString:appURL];
            [[UIApplication sharedApplication] openURL:url];
            
            //重新检测
            [self MandatoryUp];
            
        }];
        
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        }];
        
        if (self.upData == 1) {//强制更新
            [alertVC addAction:action1];
        }else {
            [alertVC addAction:action1];
            [alertVC addAction:action2];
        }
        
        [self presentViewController:alertVC animated:YES completion:nil];

    
    }
    
}


//活动页面
- (void)requestActiveData{
    NSString *str = @"http://www.enuo120.com/index.php/app/index/activity";
    
    BaseRequest *request = [[BaseRequest alloc]init];
    [request POST:str params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [self handleWithoNEActivity:responseObject];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];

}

- (void)handleWithoNEActivity:(NSDictionary *)dic{
    if ([dic[@"data"]isKindOfClass:[NSNull class]]) {
       // NSLog(@"diic =",dic[@"data"]);
    }else{
        self.acUrl = dic[@"data"][@"url"];
        self.acTitle = dic[@"data"][@"name"];
        mwindow = [[AssistiveTouch alloc]initWithFrame:CGRectMake(kScreenWidth - 70,kScreenHeigth-120, 70, 70) imageName:dic[@"data"][@"img_url"]];
   
        mwindow.assistiveDelegate =self;
        self.window = [[UIApplication sharedApplication] keyWindow];
        [self.window addSubview:mwindow];
    }
}

- (void)handleTapWithSearchImage:(UITapGestureRecognizer *)sender{
    SearchViewController *searchVC = [[SearchViewController alloc]init];
    searchVC.view.backgroundColor = [UIColor whiteColor];
    UINavigationController *naVC = [[UINavigationController alloc]initWithRootViewController:searchVC];
//        naVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:naVC animated:NO completion:nil];
    
    
    
}
#pragma 悬浮按钮点击事件
- (void)assistiveTocuhs{
    NSUserDefaults *users = [NSUserDefaults standardUserDefaults];
    NSLog(@"user = %@",users);
    NSString *name = [users objectForKey:@"name"];
    //  NSLog(@"name =%@",name);
    // NSDictionary *url2 = [NSDictionary dictionaryWithObject:name forKey:@"maic"];
    // NSLog(@"url2 = %@",url2);
    if (name ) {
        ActiviceViewController *carrVC = [[ActiviceViewController  alloc]init];
        carrVC.receiver = self.acUrl;
        carrVC.retitle =self.acTitle;
        UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:carrVC];
        [self presentViewController:naNC animated:YES completion:^{
            
        }];
       // acVC.receiver = self.array[1];
    }else{
       LogonViewController *loginVC = [[LogonViewController alloc]init];
        UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:loginVC];
        [self presentViewController:naNC animated:YES completion:^{
            
        }];
        
    }
    
}


- (void)requestCarrData{
    NSString *url = @"http://www.enuo120.com/index.php/app/index/ads";
    
    BaseRequest *request = [[BaseRequest alloc]init];
    [request POST:url params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"reeeee  = %@",responseObject);
        [self handleCarrWithData:responseObject];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error = %@",error);
        NSLog(@"1111");
    }];

}

- (void)handleCarrWithData:(NSDictionary *)dic{
    
    if ([dic[@"data"]isKindOfClass:[NSNull class]]) {
        NSLog(@"没有数据");
    }else{
    
    NSArray *arr = dic[@"data"];
        
        for (NSDictionary *temp in arr) {
            CarrModel *model = [CarrModel carrModelInItWithDic:temp];
            [self.dataCarrArray addObject:model];
                }
        
        for (int i =0; i<3; i++) {
            CarrModel *model = self.dataCarrArray[i];
            UIImageView *_imageView= [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth*i, 0, kScreenWidth, kScreenHeigth*280/1334)];
            
            NSString *strImage = [NSString stringWithFormat:urlPicture,model.photo];
            [_imageView sd_setImageWithURL:[NSURL URLWithString:strImage] placeholderImage:nil];
            
            _imageView.tag =100 +i;
            _imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleWebTapView:)];
            
            [_imageView addGestureRecognizer:backTap];
            
            
            //添加imageView到滚动图上
            [_scrollView addSubview:_imageView];
            
        }
        


    }

}

- (void)handleWebTapView:(UIGestureRecognizer *)sender{
    CarrWebController *carrVC = [[CarrWebController alloc]init];
       CarrModel *model = self.dataCarrArray[sender.view.tag - 100];
    
      carrVC.receiver  = model.url;
    UINavigationController *naVC = [[UINavigationController alloc]initWithRootViewController:carrVC];
        naVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
  carrVC.title  = model.title;
   
    [self  presentViewController: naVC animated:YES completion:^{
     
      
    }];
 
   // NSLog(@"YYYYYYYY=====%d",sender.view.tag);
    NSLog(@"活动页面");
}

//设置轮播图
- (void)creatScrollView{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeigth*280/1334)];
    _scrollView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    //2.设置滚动视图所能显示的内容区域大小 contentSize (contentSize设置当前滑动视图控制所能展示的内容区域)
    _scrollView.contentSize = CGSizeMake(kScreenWidth*3, kScreenHeigth*280/1334);
    _scrollView.contentOffset = CGPointMake(0, 0);
    //4.设置滚动条的样式 （默认为黑色）
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
    [self.deskView addSubview:_scrollView];
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
    [self.deskView addSubview:_pangeControl];
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

#pragma mark__________-------------------------------------button-------------------------
- (void)creatButton{
    UIView *aview = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeigth*280/1334+5, kScreenWidth, kScreenHeigth*300/1334)];
    UIButton *oneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *twoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *threeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *fourButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    oneButton.backgroundColor = [UIColor blueColor];
//    twoButton.backgroundColor = [UIColor yellowColor];
//    threeButton.backgroundColor = [UIColor redColor];
//    fourButton.backgroundColor = [UIColor greenColor];
    
    CGFloat aViewHeight = aview.frame.size.height;
    
    oneButton.frame = CGRectMake(0, 0, kScreenWidth*327/750, aViewHeight);
    twoButton.frame = CGRectMake(kScreenWidth*327/750, 0, kScreenWidth-kScreenWidth*327/750  , kScreenHeigth*138/1334);
    threeButton.frame = CGRectMake(kScreenWidth*327/750, kScreenHeigth*138/1334, kScreenWidth-kScreenWidth*538/750, aViewHeight - kScreenHeigth*138/1334);
    fourButton.frame = CGRectMake(kScreenWidth*539/750, kScreenHeigth*138/1334, kScreenWidth *211/750, aViewHeight - kScreenHeigth*138/1334);
    
    oneButton.layer.borderWidth =0.5;
    twoButton.layer.borderWidth = 0.5;
    threeButton.layer.borderWidth = 0.5;
    fourButton.layer.borderWidth = 0.5;
    
    oneButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
     twoButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
     threeButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
     fourButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    [aview addSubview:oneButton];
    [aview addSubview:twoButton];
    [aview addSubview:threeButton];
    [aview addSubview:fourButton];
    
    
    aview.backgroundColor= [UIColor whiteColor];
    [self.deskView addSubview:aview];
    //图片

    

    [oneButton setImage:[UIImage imageNamed:@"疾病自查"] forState:UIControlStateNormal];
    [twoButton setImage:[UIImage imageNamed:@"找医生"] forState:UIControlStateNormal];
    [threeButton setImage:[UIImage imageNamed:@"找医院"] forState:UIControlStateNormal];
    [fourButton setImage:[UIImage imageNamed:@"周边医院"] forState:UIControlStateNormal];
    
  
    
    [oneButton addTarget:self action:@selector(handlePassExamina:) forControlEvents:UIControlEventTouchUpInside];
    [twoButton addTarget:self action:@selector(handlePassFindDoc:) forControlEvents:UIControlEventTouchUpInside];
    [threeButton addTarget:self action:@selector(handlePassFindHos:) forControlEvents:UIControlEventTouchUpInside];
    
    [fourButton addTarget:self action:@selector(handlePassOreaHos:) forControlEvents:UIControlEventTouchUpInside];
    
}

//症状自查
- (void)handlePassExamina:(UIButton *)sender{
    ExaminaViewController *exminVC = [[ExaminaViewController alloc]init];
    UINavigationController *naNc = [[UINavigationController alloc]initWithRootViewController:exminVC];
    
        naNc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:naNc animated:YES completion:^{
        
    }];
}



//在周边医院

- (void)handlePassOreaHos:(UIButton *)sender{
    BaiduMapViewController *baiVC = [[BaiduMapViewController alloc]init];
    UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:baiVC];
        naNC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:naNC animated:YES completion:^{
        
    }];
}



//找医生
- (void)handlePassFindDoc:(UIButton *)sender{
    FindDocTableViewController *proVC  = [[FindDocTableViewController alloc]init];
    UINavigationController *naVC = [[UINavigationController alloc]initWithRootViewController:proVC];
        naVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self  presentViewController: naVC animated:YES completion:^{
    }];

}



//找医院
- (void)handlePassFindHos:(UIButton *)sender{
    FindHosVC *proVC = [[FindHosVC alloc]init];
    UINavigationController *naVC = [[UINavigationController alloc]initWithRootViewController:proVC];
       naVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:naVC animated:YES completion:^{
        
    }];
}


//丹丹发布
- (void)creatDanDanView{
    UIView *aView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeigth*602/1334, kScreenWidth, 60)];
    aView.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(5, 15, (kScreenWidth-15)/2,(kScreenWidth-15)/7+5 );
  
    [button setBackgroundImage:[UIImage imageNamed:@"丹丹发布-2"] forState:   UIControlStateNormal];
    
    button.backgroundColor = [UIColor whiteColor];
    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
    aButton.frame = CGRectMake(10+(kScreenWidth-15)/2 , 15,(kScreenWidth-15)/2 , (kScreenWidth-15)/7+5);
    
    [aButton setBackgroundImage:[UIImage imageNamed:@"我要更漂亮-2"] forState: UIControlStateNormal];
    [aButton addTarget:self action:@selector(handleWithPiaoLiang:) forControlEvents:UIControlEventTouchUpInside];
    
    [button addTarget:self action:@selector(handleWithDanDanWith:) forControlEvents:UIControlEventTouchUpInside];
    [aView addSubview:aButton];
    [aView addSubview:button];
 
    [self.deskView addSubview:aView];
    UIView *bView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeigth*602/1334 +80, kScreenWidth, 31)];
    bView.backgroundColor = [UIColor whiteColor];
    bView.layer.borderWidth = 0.5;
    bView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    UILabel *alabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, kScreenWidth, 31)];
    alabel.text = @"科室";
    [bView addSubview:alabel];
    [self.deskView addSubview:bView];
    
}

//我要更漂亮
- (void)handleWithPiaoLiang:(UIButton *)sender{
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeigth)];
    bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self.view addSubview:bgView];
    
    SZKAlterView *alterView = [SZKAlterView alterViewWithTitle:@"提示" content:@"敬请期待" cancel:@"取消" sure:@"确定" cancelBtClcik:^{
        [bgView removeFromSuperview];
    } sureBtClcik:^{
        [bgView removeFromSuperview];
    }];
    [bgView addSubview:alterView];
    
    /****关闭功能****/
//    PiaoLiangViewController *pVC = [[PiaoLiangViewController alloc]init];
//    UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:pVC];
//    
//    
//    [self.navigationController presentViewController:naNC animated:YES completion:^{
//        
//    }];

    
    
}


- (void)handleWithDanDanWith:(UIButton *)sender{
    DanDanViewController *danVc = [[DanDanViewController alloc]init];
    UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:danVc];
    
      naNC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:naNC animated:YES completion:^{
        
    }];
    
    
    
    
}

//找科室
- (void)creatFindDeskView{
    
    UICollectionViewFlowLayout *_layout = [[UICollectionViewFlowLayout alloc]init];
  
    UICollectionView *collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeigth-44-64) collectionViewLayout:_layout];
    //设置item属性
    _layout.itemSize = CGSizeMake(kScreenWidth/4-5, kScreenWidth/4-5);
    _layout.minimumInteritemSpacing = 0;
     _layout.sectionInset = UIEdgeInsetsMake(kScreenHeigth*612/1334 +120, 20, 20, 20);
    //5.设置最小item的间距
 
    self.deskView= collectView;
    
    [self.view addSubview: self.deskView];
    
    self.deskView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
   
    [self creatScrollView];
    [self creatPageControl];
    [self setUpTimer];
    [self creatButton];
    [self creatDanDanView];
    collectView.delegate = self;
    collectView.dataSource = self;
    collectView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    [collectView registerNib:[UINib nibWithNibName:@"DeskCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];

}



#pragma mark -------------------找科室数据请求

- (void)requestDeskData{
    NSString *url = @"http://www.enuo120.com/index.php/app/index/find_keshi";
    BaseRequest *request = [[BaseRequest alloc]init];
    [request POST:url params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [self handleWithDeskData:responseObject];
        
        [SVProgressHUD dismiss];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"1111");

    }];
}

- (void)handleWithDeskData:(NSDictionary *)data{
    NSArray *array = data[@"data"];
    for (NSDictionary *temp in array) {
        DeskModel *model = [DeskModel deskModelInitWithDic:temp];
        [self.dataArray addObject:model];
    }[self.deskView reloadData];
}





#pragma mark _集合视图delegate
//
//返回集合视图的分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;//返回20个分区
}
//返回不同分区对应的item的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;//每个分区返回23个item
}

//配置不同分区的item内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
   DeskCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    DeskModel *model = self.dataArray[indexPath.row];
    cell.labelDesk.text = model.department;
    NSString * url = [NSString stringWithFormat:urlPicture,model.photo];
    [cell.imageDesk sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
      DeskModel *model = self.dataArray[indexPath.row];
    FindDeskViewController *dinVC = [[FindDeskViewController alloc]init];
    dinVC.receiver = model.cid;
    dinVC.retitle = model.department;
    UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:dinVC];
    naNC.navigationItem.title = model.department;
    [self presentViewController:naNC animated:YES completion:^{
        
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
