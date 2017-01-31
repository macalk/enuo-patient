//
//  hosHomePageVC.m
//  enuoS
//
//  Created by apple on 16/11/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "hosHomePageVC.h"
#import "HosHomePageView.h"
#import <AFNetworking.h>
#import "HosModel.h"
#import "SZKAlterView.h"
#import "Macros.h"
#import "UIColor+Extend.h"
#import <Masonry.h>
#import "hosHomePageCellTableViewCell.h"
#import "HosDocViewController.h"
#import "DoctorViewController.h"
#import <SDWebImage/UIButton+WebCache.h>

@interface hosHomePageVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic,strong)HosHomePageView *headView;
@property (nonatomic,strong)HosModel *hoseDataModel;
@property (nonatomic,strong)HosModel *deskDataModel;

@property (nonatomic,strong)NSMutableArray *hoseDataArr;
@property (nonatomic,strong)NSMutableArray *deskListArr;
@property (nonatomic,strong)NSMutableArray *docListArr;
@property (nonatomic,strong)NSMutableArray *commentListArr;


@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIView *baseView;

@property (nonatomic,strong)UIPageControl *deskPage;
@property (nonatomic,strong)UIPageControl *docPage;

@property (nonatomic,assign) BOOL open;

@end

@implementation hosHomePageVC

- (UIView *)baseView {
    if (!_baseView) {
        _baseView = [[UIView alloc]init];
        
        [self.view addSubview:_baseView];
        
        [_baseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.view);
            make.height.mas_offset(@100);
        }];
    }return _baseView;
}

- (NSMutableArray *)hoseDataArr {
    if (!_hoseDataArr) {
        _hoseDataArr = [NSMutableArray array];
    }return _hoseDataArr;
}

- (NSMutableArray *)deskListArr {
    if (!_deskListArr) {
        _deskListArr = [NSMutableArray array];
    }return _deskListArr;
}
- (NSMutableArray *)docListArr {
    if (!_docListArr) {
        _docListArr = [NSMutableArray array];
    }return _docListArr;
}
- (NSMutableArray *)commentListArr {
    if (!_commentListArr) {
        _commentListArr = [NSMutableArray array];
    }return _commentListArr;
}


//- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"绿色返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleWithBack:)];
//        self.navigationItem.title = @"医院主页";
//        self.navigationItem.leftBarButtonItem = leftItem;
//        
//    }return self;
//}

- (void)customNavView {
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"白色返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleWithBack:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    [titleLable setTextAlignment:NSTextAlignmentCenter];
    [titleLable setTextColor:[UIColor whiteColor]];
    [titleLable setText:@"医院主页"];
    titleLable.font = [UIFont boldSystemFontOfSize:18];
    self.navigationItem.titleView = titleLable;
    
    self.navigationController.navigationBar.barTintColor = [UIColor stringTOColor:@"#22ccc6"];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)handleWithBack:(UIBarButtonItem *)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTableView];
    [self customNavView];
    self.view.backgroundColor = [UIColor whiteColor];
    [self requestData];
}
- (void)createTableView {
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor whiteColor];
    self.tableView = tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.commentListArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    hosHomePageCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    
    if (cell == nil) {
        
        NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"hosHomePageCellTableViewCell" owner:self options:nil];
        for (id tempCell in array) {
            if ([tempCell isKindOfClass:[hosHomePageCellTableViewCell class]]) {
                cell = tempCell;
            }
        }
        
    }
    cell.model = self.commentListArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HosModel *model = self.commentListArr[indexPath.row];
    NSString *commenStr = model.hos_content;
    CGRect size = [commenStr boundingRectWithSize:CGSizeMake(kScreenWidth-40, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
    return size.size.height+2+65;
    
}


//医院详情请求
- (void)requestData{
    
    NSString *str = @"http://www.enuo120.com/index.php/app/hospital/home";
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *username = [userDefault objectForKey:@"name"];
    if (username ==NULL) {
        username = @"";
    }
    NSLog(@"name = %@",username);
    NSDictionary *heardBody = @{@"username":username,@"hid":self.receiver,@"ver":@"1.0"};
    
    AFHTTPSessionManager *manegr = [AFHTTPSessionManager manager];
    
    [manegr POST:str parameters:heardBody progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject = %@",responseObject);
        
        [self handleWithHosData:responseObject];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
}
//医院详情页面数据处理
- (void)handleWithHosData:(NSDictionary *)dic{
    
    HosModel *model = [HosModel hosModelWithData:dic[@"data"]];
    self.hoseDataModel = model;
    
    [self.docListArr removeAllObjects];
    
    NSArray *docListArr = dic[@"data"][@"doc_list"];
    for (int i = 0; i<docListArr.count; i++) {
        HosModel *docModel = [HosModel hosModelWithData:docListArr[i]];
        [self.docListArr addObject:docModel];
    }
    
    
    NSArray *commentListArr = dic[@"data"][@"comment_list"];
    if ([commentListArr isEqual:[NSNull null]]) {
        NSLog(@"没有评论内容");
    }else {
        for (int i = 0; i<commentListArr.count; i++) {
            HosModel *commentModel = [HosModel hosModelWithData:commentListArr[i]];
            [self.commentListArr addObject:commentModel];
        }
    }
    
    
    //请求科室
    [self deskRequestData];
    
}
//请求科室
- (void)deskRequestData {
    NSLog(@"%@",self.receiver);
    NSString *str = @"http://www.enuo120.com/index.php/app/hospital/home_keshi";
    
    NSDictionary *heardBody = @{@"hid":self.receiver,@"ver":@"1.0"};
    
    AFHTTPSessionManager *manegr = [AFHTTPSessionManager manager];
    
    [manegr POST:str parameters:heardBody progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject = %@",responseObject);
        
        [self handleWithDeskData:responseObject];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

//科室数据处理
- (void)handleWithDeskData:(NSDictionary *)dic {
    
    NSArray *deskArr = dic[@"data"];
    
    [self.deskListArr removeAllObjects];
    
    for (int i = 0; i<deskArr.count; i++) {
        NSDictionary *dic = deskArr[i];
        HosModel *model = [HosModel hosModelWithData:dic];
        [self.deskListArr addObject:model];
    }
    
    [self createHeadViewWithType:nil];

    [self.tableView reloadData];
}

//关注数据请求
- (void)likeHosRequestWithType:(NSString *)type {
    NSString *name =[[NSUserDefaults standardUserDefaults]objectForKey:@"name"];
    if (name == nil) {
        name = @"";
    }
    
    NSString *str = @"http://www.enuo120.com/index.php/app/patient/guanzhuh";
    
    NSDictionary *heardBody = @{@"hid":self.receiver,@"ver":@"1.0",@"username":name,@"type":type};
    
    AFHTTPSessionManager *manegr = [AFHTTPSessionManager manager];
    
    [manegr POST:str parameters:heardBody progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self requestLikeHosData:responseObject];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)requestLikeHosData:(NSDictionary *)dic {
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeigth)];
    bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self.view addSubview:bgView];
    
    if ([dic[@"data"][@"errcode"] isEqualToString:@"0"]) {
        SZKAlterView *alterView = [SZKAlterView alterViewWithTitle:@"提示" content:dic[@"data"][@"message"] cancel:@"取消" sure:@"确定" cancelBtClcik:^{
            [bgView removeFromSuperview];
            [self requestData];
        } sureBtClcik:^{
            [bgView removeFromSuperview];
            [self requestData];
        }];
        
        [bgView addSubview:alterView];
    }else {
        SZKAlterView *alterView = [SZKAlterView alterViewWithTitle:@"提示" content:dic[@"data"][@"message"] cancel:@"取消" sure:@"确定" cancelBtClcik:^{
            [bgView removeFromSuperview];
        } sureBtClcik:^{
            [bgView removeFromSuperview];
        }];
        
        [bgView addSubview:alterView];

    }
}

//创建头视图
- (void)createHeadViewWithType:(NSString *)type {
    
    self.headView = [[HosHomePageView alloc]init];
    self.headView.userInteractionEnabled = YES;
    self.headView.model = self.hoseDataModel;
    
    self.tableView.tableHeaderView = self.headView;
    
    [self.headView createHeadViewWithType:type];
    
    [self.headView.likeBtn addTarget:self action:@selector(likeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.headView.moreBtn addTarget:self action:@selector(loadMoreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *view = self.tableView.tableHeaderView;
    view.frame = CGRectMake(0, 0, kScreenWidth, self.headView.viewHeight+265);
    self.tableView.tableHeaderView = view;
    
    
    //创建scrollview
    [self createSrcollView];
    
}
//关注医院点击事件
- (void)likeBtnClick:(UIButton *)sender {
    
    NSString *guanzhu;
    
    if (self.hoseDataModel.guanzhu == 0) {
        [sender setImage:[UIImage imageNamed:@"关注-s"] forState:normal];
        guanzhu = @"1";
    }else {
        guanzhu = @"0";
        [sender setImage:[UIImage imageNamed:@"关注"] forState:normal];
    }
    
    [self likeHosRequestWithType:guanzhu];
    
}

//加载更多内容
- (void)loadMoreBtnClick:(UIButton *)sender {
    self.open = !self.open;
    if (self.open) {
        [self createHeadViewWithType:@"more"];
    }else {
        [self createHeadViewWithType:nil];
    }
}

//创建scrollview
- (void)createSrcollView {
    
    NSArray *titleArr = @[@"科室",@"医院自荐专家"];
    for (int i = 0; i<2; i++) {
        
        UIScrollView *scrollView = [[UIScrollView alloc]init];
        scrollView.frame = CGRectMake(0, self.headView.viewHeight+133*i, kScreenWidth, 132);
        scrollView.tag = 10+i;
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        [self.headView addSubview:scrollView];
        
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.text = titleArr[i];
        [scrollView addSubview:titleLabel];
        titleLabel.font = [UIFont systemFontOfSize:13];
        titleLabel.textColor = [UIColor stringTOColor:@"#00afa1"];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(scrollView).with.offset(20);
            make.top.equalTo(scrollView).with.offset(10);
        }];
        
        UIPageControl *page = [[UIPageControl alloc]init];
        page.pageIndicatorTintColor = [UIColor grayColor];
        page.currentPageIndicatorTintColor = [UIColor orangeColor];
        page.tag = 20+i;
        [self.headView addSubview:page];
        [page mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(scrollView);
            make.bottom.equalTo(scrollView.mas_bottom);
            make.height.mas_offset(@25);
        }];
        
        
        CGFloat space = (kScreenWidth - 48*4)/5;//间距
        
        if (i == 0) {//科室scro
            scrollView.contentSize = CGSizeMake(kScreenWidth*(self.deskListArr.count/4+1), 0);
            
            page.numberOfPages = self.deskListArr.count/4+1;
            self.deskPage = page;
            
            for (int j = 0; j<self.deskListArr.count; j++) {
                
                HosModel *model= self.deskListArr[j];
                
                UIButton *deskBtn = [[UIButton alloc]init];
                deskBtn.frame = CGRectMake(kScreenWidth*(j/4)+space*(j%4+1)+j%4*48, 33, 48, 48);
                deskBtn.layer.cornerRadius = 24;
                deskBtn.clipsToBounds = YES;
                [deskBtn sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:urlPicture,model.photo]] forState:normal];
                [scrollView addSubview:deskBtn];
                
                UILabel *deskTitLabel = [[UILabel alloc]init];
                deskTitLabel.text = model.department;
                deskTitLabel.font = [UIFont systemFontOfSize:10];
                [scrollView addSubview:deskTitLabel];
                [deskTitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(deskBtn.mas_centerX);
                    make.top.equalTo(deskBtn.mas_bottom).with.offset(10);
                    make.height.mas_offset(@10);
                }];
            }
            
        }else {//专家scro
            
            scrollView.contentSize = CGSizeMake(kScreenWidth*(self.docListArr.count/4+1), 0);
            page.numberOfPages = self.docListArr.count/4+1;
            self.docPage = page;
            
            for (int j = 0; j<self.docListArr.count; j++) {
                NSLog(@"%ld",self.docListArr.count);
                
                HosModel *model= self.docListArr[j];
                
                UIButton *docNameBtn = [[UIButton alloc]init];
                docNameBtn.frame = CGRectMake(kScreenWidth*(j/4)+space*(j%4+1)+j%4*48, 33, 48, 48);
                docNameBtn.layer.cornerRadius = 24;
                docNameBtn.clipsToBounds = YES;
                docNameBtn.tag = 100+j;
                [docNameBtn sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:urlPicture,model.photo]] forState:normal];

                [docNameBtn addTarget:self action:@selector(docNameBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                [scrollView addSubview:docNameBtn];
                
                UILabel *nameLabel = [[UILabel alloc]init];
                nameLabel.text = model.name;
                nameLabel.font = [UIFont systemFontOfSize:10];
                [scrollView addSubview:nameLabel];
                [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(docNameBtn.mas_centerX);
                    make.top.equalTo(docNameBtn.mas_bottom).with.offset(10);
                    make.height.mas_offset(@10);
                }];
            }
            
        }
        
        UILabel *lineLabel = [[UILabel alloc]init];
        lineLabel.backgroundColor = [UIColor stringTOColor:@"#666666"];
        [self.headView addSubview:lineLabel];
        [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(scrollView);
            make.top.equalTo(scrollView.mas_bottom);
            make.height.mas_offset(@1);
        }];
    }
    
    self.tableView.tableHeaderView = self.headView;
    
}

- (void)docNameBtnClick:(UIButton *)sender {
    HosModel *model  = self.docListArr[sender.tag-100];
    
    DoctorViewController *hosDocVC = [[DoctorViewController alloc]init];
    hosDocVC.receiver = model.cid;
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:hosDocVC];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (![scrollView isKindOfClass:[UITableView class]]) {
        
        NSLog(@"11111");
        
        switch (scrollView.tag) {
            case 10:
            {
                UIPageControl *page = [self.view viewWithTag:20];
                page.currentPage = scrollView.contentOffset.x/kScreenWidth;
                page.pageIndicatorTintColor = [UIColor grayColor];
                page.currentPageIndicatorTintColor = [UIColor orangeColor];
            }
                break;
            case 11:
            {
                UIPageControl *page = [self.view viewWithTag:21];
                page.currentPage = scrollView.contentOffset.x/kScreenWidth;
                page.pageIndicatorTintColor = [UIColor grayColor];
                page.currentPageIndicatorTintColor = [UIColor orangeColor];
            }
                break;
                
            default:
                break;
        }
    }
 
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 53;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *secHeadView = [[UIView alloc]init];
    secHeadView.frame = CGRectMake(0, 0, kScreenWidth, 53);
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"评论";
    titleLabel.frame = CGRectMake(20, 10, 100, 13);
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.textColor = [UIColor stringTOColor:@"#00afa1"];
    [secHeadView addSubview:titleLabel];
    
    UILabel *label = [[UILabel alloc]init];
    label.text = [NSString stringWithFormat:@"全部(%ld)",self.commentListArr.count];
    label.frame = CGRectMake(20, 33, 100, 10);
    label.font = [UIFont systemFontOfSize:10];
    [secHeadView addSubview:label];
    
    UILabel *lineLabel = [[UILabel alloc]init];
    lineLabel.backgroundColor = [UIColor stringTOColor:@"#666666"];
    [secHeadView addSubview:lineLabel];
    lineLabel.frame = CGRectMake(0, 52, kScreenWidth, 1);
    
    return secHeadView;
    

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
