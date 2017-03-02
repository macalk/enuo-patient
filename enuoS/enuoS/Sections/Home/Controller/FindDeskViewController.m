//
//  FindDeskViewController.m
//  enuoS
//
//  Created by apple on 16/8/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "FindDeskViewController.h"

#import "Macros.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <Masonry.h>
#import "WJDropdownMenu.h"
#import "DeskModel.h"
#import "PromiseHosViewCell.h"
#import <MJRefresh.h>
#import "FindHosModel.h"
#import "DeskTwoModel.h"
#import <UIImageView+WebCache.h>
#import "HosViewController.h"
#import "FindDocModel.h"
#import "PromiseDocViewCell.h"

#import "UIColor+Extend.h"
//使用这个cell和model
#import "SarchIllHosTableViewCell.h"
#import "SearchillHosModel.h"
#import "SearchILLDocController.h"

//筛选
#import "hosFiltrateTabVC.h"
#import "FiltrateVC.h"

#import "DoctorViewController.h"
@interface FindDeskViewController ()<UITableViewDataSource,UITableViewDelegate,WJMenuDelegate>

@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,weak)WJDropdownMenu *menu;
@property (nonatomic,assign)BOOL filt;

//医生信息
@property (nonatomic,assign)NSInteger num;
@property (nonatomic,copy)NSString *dep_id;
@property (nonatomic,copy)NSString *sdep_id;
@property (nonatomic,copy)NSString *sort_order;//类型排序
//
@property (nonatomic,strong)NSMutableArray *secondDataArray;
@property (nonatomic,strong)NSMutableArray *secondPIDArray;
@property (nonatomic,strong)NSMutableArray *secondIdArray;


//
@property (nonatomic,strong)NSMutableArray *firstDataArray;
@property (nonatomic,strong)NSMutableArray *firstImageArray;
@property (nonatomic,strong)NSMutableArray *firstIdArray;


@property (nonatomic,strong)NSMutableArray *illDataArray;
@property (nonatomic,strong)NSMutableArray *deskDataArray;
@property (nonatomic,strong)NSMutableArray *sunIllArray;

@property (nonatomic,strong)UIButton *selectDeskBtn;
@property (nonatomic,strong)UIButton *selectillBtn;
@property (nonatomic,copy)NSString *selectillBtnTitle;

@property (nonatomic,strong) UILabel *filtrate_deskLabel;
@property (nonatomic,strong) UILabel *filtrate_roundLabel;
@property (nonatomic,strong) UILabel *filtrate_illLabel;

@property (nonatomic,strong)hosFiltrateTabVC *filetTabVC;



@end

@implementation FindDeskViewController


- (NSMutableArray *)secondDataArray{
    if (!_secondDataArray) {
        self.secondDataArray = [NSMutableArray array];
    }return _secondDataArray;
}

- (NSMutableArray *)secondIdArray{
    if (!_secondIdArray) {
        self.secondIdArray = [NSMutableArray array];
    }return _secondIdArray;
}
- (NSMutableArray *)secondPIDArray{
    if (!_secondPIDArray) {
        self.secondPIDArray = [NSMutableArray array];
    }return _secondPIDArray;
}
- (NSMutableArray *)firstDataArray{
    if (!_firstDataArray) {
        self.firstDataArray = [NSMutableArray array];
    }return _firstDataArray;
}

- (NSMutableArray *)firstIdArray{
    if (!_firstIdArray) {
        self.firstIdArray = [NSMutableArray array];
    }return  _firstIdArray;
}

- (NSMutableArray *)firstImageArray{
    if (!_firstImageArray) {
        self.firstImageArray = [NSMutableArray array];
    }return _firstImageArray;
}

- (NSMutableArray *)illDataArray{
    if (!_illDataArray) {
        _illDataArray = [NSMutableArray array];
    }return _illDataArray;
}
- (NSMutableArray *)deskDataArray{
    if (!_deskDataArray) {
        _deskDataArray = [NSMutableArray array];
    }return _deskDataArray;
}
- (NSMutableArray *)sunIllArray{
    if (!_sunIllArray) {
        _sunIllArray = [NSMutableArray array];
    }return _sunIllArray;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }return _dataArray;
}



- (UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc]init];
    }return _tableView;
}

//自定义NavView
- (void)customNavView {
    
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;//默认为黑色
    self.navigationController.navigationBar.barTintColor = [UIColor stringTOColor:@"#22ccc6"];//自定义背景颜色
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"白色返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleWithBack:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.center = self.navigationItem.titleView.center;
    titleLabel.bounds = CGRectMake(0, 0, 100, 30);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = self.retitle;
    self.navigationItem.titleView = titleLabel;
    
    //设置返回按钮为白色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self customNavView];
    
    [SVProgressHUD show];
    self.num = 1;
    self.sdep_id = @"";
    self.dep_id = self.receiver;
    
    //页面数据（cell数据）
    [self requestDeskDetailDataWith:self.dep_id withWay:@"all"];
    
    //筛选(科室)
    [self requestAllHosData];

    //筛选(疾病)
    [self requestIllDataWithWay:@"all"];
    [self.selectDeskBtn setTitle:@"疾病" forState:normal];

    [self creatTableView];
    
    self.tableView.frame = CGRectMake(0, 44, kScreenWidth, kScreenHeigth-44-64);
    [self.view addSubview:self.tableView];
    self.navigationController.navigationBar.translucent = NO;
    
    //筛选
    [self filtrateView];
    
}
//筛选视图
- (void)filtrateView {
    UIView *filtrateView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    filtrateView.backgroundColor = [UIColor stringTOColor:@"#f4f4f7"];
    [self.view addSubview:filtrateView];
    
    /***简介视图***/
    UILabel *verticalLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 12, 2, 20)];
    verticalLabel.backgroundColor = [UIColor stringTOColor:@"#22ccc6"];
    [filtrateView addSubview:verticalLabel];
    
    UILabel *deskLabel = [[UILabel alloc]init];
    deskLabel.text = self.retitle;
    deskLabel.font = [UIFont systemFontOfSize:15];
    self.filtrate_deskLabel = deskLabel;
    [filtrateView addSubview:deskLabel];
    
    UILabel *roundLabel = [[UILabel alloc]init];
    roundLabel.backgroundColor = [UIColor stringTOColor:@"#22ccc6"];
    roundLabel.layer.cornerRadius = 2;
    roundLabel.clipsToBounds = YES;
    roundLabel.hidden = YES;
    self.filtrate_roundLabel = roundLabel;
    [filtrateView addSubview:roundLabel];
    
    UILabel *illLabel = [[UILabel alloc]init];
    illLabel.text = @"111";
    illLabel.font = [UIFont systemFontOfSize:15];
    illLabel.textColor  = [UIColor blackColor];
    illLabel.hidden = YES;
    self.filtrate_illLabel = illLabel;
    [filtrateView addSubview:illLabel];
    
    [deskLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(filtrateView);
        make.left.equalTo(verticalLabel.mas_right).with.offset(5);
    }];
    [roundLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(deskLabel);
        make.left.equalTo(deskLabel.mas_right).with.offset(5);
        make.size.mas_offset(CGSizeMake(4, 4));
    }];
    [illLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(roundLabel);
        make.left.equalTo(roundLabel.mas_right).with.offset(5);
    }];
    
    /***简介视图***/
    
    
    /***筛选视图***/
    UILabel *label = [[UILabel alloc]init];
    label.text = @"筛选";
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor stringTOColor:@"#959595"];
    [filtrateView addSubview:label];
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"漏斗筛选"];
    [filtrateView addSubview:imageView];
    
//    UILabel *lineLabel = [[UILabel alloc]init];
//    lineLabel.backgroundColor = [UIColor lightGrayColor];
//    [filtrateView addSubview:lineLabel];
    
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(filtrateView.mas_centerY);
        make.right.equalTo(filtrateView.mas_right).with.offset(-20);
    }];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(filtrateView.mas_centerY);
        make.right.equalTo(label.mas_left).with.offset(-2);
        make.size.mas_offset(CGSizeMake(12,14));
    }];
    
//    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.equalTo(filtrateView);
//        make.height.mas_offset(@1);
//    }];
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]init];
    [tapGes addTarget:self action:@selector(filtrateClick:)];
    [filtrateView addGestureRecognizer:tapGes];
    /***筛选视图***/
    
}

//筛选展开视图
- (void)openFiltrateView {
    NSMutableArray *titleArr = [NSMutableArray arrayWithObjects:@"科室",@"疾病", nil];
    NSMutableArray *deskArr = [NSMutableArray array];
    NSMutableArray *sunIllArr = [NSMutableArray array];
    
    for (int i = 0; i<self.deskDataArray.count; i++) {
        SearchillHosModel *model = self.deskDataArray[i];
        UIButton *button = [[UIButton alloc]init];
        button.tag = 100+i;
        [button setTitleColor:[UIColor stringTOColor:@"#00afa1"] forState:UIControlStateSelected];
        [button setTitle:model.name forState:normal];
        [button addTarget:self action:@selector(deskBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [deskArr addObject:button];
    }
    for (int i = 0; i<self.sunIllArray.count; i++) {
        SearchillHosModel *model = self.sunIllArray[i];
        UIButton *button = [[UIButton alloc]init];
        button.tag = 200+i;
        [button setTitleColor:[UIColor stringTOColor:@"#00afa1"] forState:UIControlStateSelected];
        [button setTitle:model.ill forState:normal];
        [button addTarget:self action:@selector(sunillBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [sunIllArr addObject:button];
    }
    
    hosFiltrateTabVC *filetTabVC = [[hosFiltrateTabVC alloc]initWithAreaArray:deskArr andSortArr:sunIllArr andTitleArr:titleArr];
    self.filetTabVC = filetTabVC;
    filetTabVC.view.frame = CGRectMake(0, 44, kScreenWidth, kScreenHeigth-32-44);
    filetTabVC.view.tag = 1001;

}

//筛选展开（点击功能）
- (void)filtrateClick:(UITapGestureRecognizer *)sender {
    _filt = !_filt;
    if (_filt) {
    
        [self openFiltrateView];
        [self.view addSubview:self.filetTabVC.view];
        
    }else {
        self.selectDeskBtn.selected = NO;
       UIView *view = [self.view viewWithTag:1001];
        [view removeFromSuperview];
    }
    
}
//筛选里科室点击事件
- (void)deskBtnClick:(UIButton *)sender {
    self.selectDeskBtn.selected = NO;
    self.selectillBtn.selected = NO;
    self.selectDeskBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    
    sender.selected = YES;
    sender.titleLabel.font = [UIFont systemFontOfSize:15];
    
    self.selectDeskBtn = sender;
    self.selectDeskBtn.tag = sender.tag;
    
    SearchillHosModel *model = self.deskDataArray[sender.tag-100];
    self.sdep_id = model.ID;
    [self requestIllDataWithWay:@"desk"];
    
    self.filtrate_deskLabel.text = sender.currentTitle;
}
//筛选里疾病点击事件
- (void)sunillBtnClick:(UIButton *)sender {
    
    if (self.selectDeskBtn.selected == YES || self.deskDataArray.count == 0) {
    
    self.selectillBtn.selected = NO;
    self.selectillBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    
    sender.selected = YES;
    sender.titleLabel.font = [UIFont systemFontOfSize:15];
    
    self.selectillBtn = sender;
    self.selectillBtnTitle = sender.currentTitle;
    
    UIView *view = [self.view viewWithTag:1001];
    [view removeFromSuperview];
    [self requestDeskDetailDataWith:self.dep_id withWay:@"ill"];
        
        self.filtrate_illLabel.text = sender.currentTitle;
        self.filtrate_deskLabel.hidden = NO;
        self.filtrate_roundLabel.hidden = NO;
        self.filtrate_illLabel.hidden = NO;
        
    }else {
        NSLog(@"请选择科室");
    }
    
}

- (void)handleWithBack:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)creatTableView{
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (void)refresh{
    [self.illDataArray removeAllObjects];
    _num = 1;
    [self requestAllHosData];
}

- (void)loadMore{
    _num ++;
    [self requestAllHosData];
}


//疾病（页面cell数据）
- (void)requestDeskDetailDataWith:(NSString *)Cid withWay:(NSString *)way {
    NSString *str = @"http://www.enuo120.com/index.php/app/index/find_keshi_ill";
    NSLog(@"%@~~%@~~~%@",Cid,self.sdep_id,self.selectillBtnTitle);
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:Cid forKey:@"dep_id"];
    [dic setValue:@"1.0" forKey:@"ver"];
    if (![way isEqualToString:@"all"]) {
        [dic setValue:self.sdep_id forKey:@"sdep_id"];
        [dic setValue:self.selectillBtnTitle forKey:@"ill"];
    }
    
    BaseRequest *request = [[BaseRequest alloc]init];
    [request POST:str params:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        [self handleDataWithIllDetailWith:responseObject];
        
        NSLog(@"self.secondDataArray  = %@",self.secondDataArray);
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}


- (void)handleDataWithIllDetailWith:(NSDictionary *)data{
    
    if ([data[@"data"]isKindOfClass:[NSNull class]]
        ) {
        NSLog(@"无数据");
        [self endRefresh];
    }else{
        NSArray *arr = data[@"data"];
        [self.illDataArray removeAllObjects];
        for (NSDictionary *temp in arr) {
            SearchillHosModel *model = [SearchillHosModel searchillHosModelInitWithDic:temp];
            
            [self.illDataArray addObject:model];
        }
    }[self.tableView reloadData];
    [self endRefresh];
    
    
}


//暂时用来筛选(筛选中的科室)
- (void)requestAllHosData{
    NSString *url = @"http://www.enuo120.com/index.php/App/index/get_sdep_list";
    NSDictionary *heardBody = @{@"dep_id":self.receiver,@"ver":@"1.0"};

    BaseRequest *request = [[BaseRequest alloc]init];
    [request POST:url params:heardBody success:^(NSURLSessionDataTask *task, id responseObject) {
        [self handleWithDocDataWithDoc: responseObject];
        [SVProgressHUD dismiss];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (void)handleWithDocDataWithDoc:(NSDictionary *)data{
    if ([data[@"data"]isKindOfClass:[NSNull class]]
        ) {
        NSLog(@"无数据");
        [self endRefresh];
    }else{
        NSArray *arr = data[@"data"];
        
        [self.deskDataArray removeAllObjects];
        for (NSDictionary *temp in arr) {
           SearchillHosModel *model = [SearchillHosModel searchillHosModelInitWithDic:temp];
            
            [self.deskDataArray addObject:model];
        }
    }
    
}

//暂时用来筛选(筛选中的疾病)
- (void)requestIllDataWithWay:(NSString *)way {
    NSString *url = @"http://www.enuo120.com/index.php/App/index/get_dep_mb_list";
    NSDictionary *heardBody = @{@"dep_id":self.dep_id,@"sdep_id":self.sdep_id,@"ver":@"1.0"};
    
    BaseRequest *request = [[BaseRequest alloc]init];
    [request POST:url params:heardBody success:^(NSURLSessionDataTask *task, id responseObject) {
        [self handleWithIllDataWithDoc: responseObject withWay:way];
        [SVProgressHUD dismiss];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];

}

- (void)handleWithIllDataWithDoc:(NSDictionary *)data withWay:(NSString *)way {
    if ([data[@"data"]isKindOfClass:[NSNull class]]
        ) {
        NSLog(@"无数据");
        [self endRefresh];
    }else{
        NSArray *arr = data[@"data"];
        
        [self.sunIllArray removeAllObjects];
        
        for (NSDictionary *temp in arr) {
            SearchillHosModel *model = [SearchillHosModel searchillHosModelInitWithDic:temp];
            [self.sunIllArray addObject:model];
        }
    }
    
    //为通过科室筛选的ill
    if (![way isEqualToString:@"all"]) {
        //刷新view 采用的是先删除在加载
        UIView *view = [self.view viewWithTag:1001];
        [view removeFromSuperview];
        
        [self openFiltrateView];
        [self.view addSubview:self.filetTabVC.view];
        UIButton *button = [self.view viewWithTag:self.selectDeskBtn.tag];
        button.selected = YES;
    }
    
}


- (void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}


#pragma mark -----dataSource ------delegate---------------------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.illDataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 124;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    SarchIllHosTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"SarchIllHosTableViewCell" owner:self options:nil];
        for (id tempCell in array) {
            if ([tempCell isKindOfClass:[SarchIllHosTableViewCell class]]) {
                cell = tempCell;
            }
        }
    }
    
    
    cell.contentView.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:247/255.0 alpha:1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    
    SearchillHosModel *model = self.illDataArray[indexPath.row];
    
    
    [cell.photoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:urlPicture,model.photo]] placeholderImage:nil];

    cell.illLabel.text = model.ill;
    cell.cycleLabel.text = model.cycle;
    cell.treatLabel.text = model.treat;
    cell.priceLabel.text = [NSString stringWithFormat:@"¥%@-%@",model.lowprice,model.heightprice];
    cell.hosNameLabel.text = model.hos_name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SearchillHosModel *model =self.illDataArray[indexPath.row];

    
   SearchILLDocController *hosVC = [[SearchILLDocController alloc]init];
    
    hosVC.mb_id = model.ID;
    hosVC.illReceiver = model.ill;
    hosVC.hid = model.hos_id;
    hosVC.category = model.category;
    hosVC.treat = model.treat;
    
    UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:hosVC];
    
    [self presentViewController:naNC animated:YES completion:^{
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

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
