//
//  FindHosVC.m
//  enuoS
//
//  Created by apple on 16/11/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "FindHosVC.h"

#import "PromiseHosViewCell.h"
#import "Macros.h"
#import <Masonry.h>
#import "UIColor+Extend.h"

#import <AFNetworking.h>
#import <MJRefresh.h>
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
//#import "HosViewController.h"
//#import "hosHomePageTabVC.h"
#import "hosHomePageVC.h"
#import "FindHosModel.h"
#import "hosFiltrateView.h"
#import "hosFiltrateTabVC.h"
#import "SarchDetailViewController.h"

@interface FindHosVC ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)NSMutableArray *areaArray;
@property (nonatomic,strong)NSMutableArray *sortArray;

@property (nonatomic,strong)hosFiltrateTabVC *hosFilTabVC;
@property (nonatomic,strong)UITableView *tableView;

@property (assign, nonatomic) NSInteger num;
@property (assign, nonatomic) BOOL filtrate;

@property (nonatomic,strong) UIButton *selectAreaBtn;
@property (nonatomic,strong) UIButton *selectSortBtn;

@property (nonatomic,strong) UILabel *filtrate_cityLabel;
@property (nonatomic,strong) UILabel *filtrate_roundLabel;
@property (nonatomic,strong) UILabel *filtrate_hosLabel;


@property (nonatomic,copy) NSString  *selectAreaId;
@property (nonatomic,copy) NSString  *selectSortId;


@end

@implementation FindHosVC

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }return _dataArray;
}
- (NSMutableArray *)areaArray{
    if (!_areaArray) {
        _areaArray = [NSMutableArray array];
    }return _areaArray;
}- (NSMutableArray *)sortArray{
    if (!_sortArray) {
        _sortArray = [NSMutableArray array];
    }return _sortArray;
}

- (void)customNavView {
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"白色返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleWithBack:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    [titleLable setTextAlignment:NSTextAlignmentCenter];
    [titleLable setTextColor:[UIColor whiteColor]];
    [titleLable setText:@"找医院"];
    titleLable.font = [UIFont boldSystemFontOfSize:18];
    self.navigationItem.titleView = titleLable;
    
    self.navigationController.navigationBar.barTintColor = [UIColor stringTOColor:@"#22ccc6"];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [super viewDidLoad];
    [self customNavView];
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航条底图"] forBarMetrics:0];
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    self.navigationController.navigationBar.translucent = NO;
    
    self.num = 1;
    
    [self createTableView];
    
    [self requestDataWithWhich:@"all"];
    
    //筛选请求
    [self requestFiltrateData];
    
}

- (void)createTableView {
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeigth-64) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellAccessoryNone;
    self.tableView = tableView;
    [self.view addSubview:tableView];
}

- (void)handleWithBack:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return self.dataArray.count;
    }else {
        return 0;
    }
}


- (void)requestDataWithWhich:(NSString *)whichOne {
    NSString *str = @"http://www.enuo120.com/index.php/app/index/find_hospital";
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if ([whichOne isEqualToString:@"all"]) {
        [dic setObject:@"1.0" forKey:@"ver"];
    }else {
        if (self.selectAreaId == nil) {
            self.selectAreaId = @"";
        }
        if (self.selectSortId == nil) {
            self.selectSortId = @"";
        }
        
        [dic setObject:self.selectAreaId forKey:@"area_id"];
        [dic setObject:self.selectSortId forKey:@"sort_id"];
        [dic setObject:@"1.0" forKey:@"ver"];
    }
    
    BaseRequest *request = [[BaseRequest alloc]init];
    [request POST:str params:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        [self handleWithDic:responseObject];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}
//请求筛选数据
- (void)requestFiltrateData {
    //地区
    NSString *str = @"http://www.enuo120.com/index.php/app/Index/get_area_list";
    BaseRequest *request = [[BaseRequest alloc]init];
    [request POST:str params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *name = @"area";
        [self FiltrateData:responseObject withWho:name];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    //地区下的科室
    NSString *docStr = @"http://www.enuo120.com/index.php/app/Index/get_sort_list";
    [request POST:docStr params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *name = @"sort";
        [self FiltrateData:responseObject withWho:name];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}
//筛选数据
- (void)FiltrateData:(NSDictionary *)dic withWho:(NSString *)who {
    if ([dic[@"data"]isKindOfClass:[NSNull class]]) {
        
    }else{
        NSArray *arr = dic[@"data"];
        
        if ([who isEqualToString:@"area"]) {//地区请求
            [self.areaArray removeAllObjects];
            for (NSDictionary *temp in arr) {
                FindHosModel *model = [FindHosModel findHosModelInithWithDic:temp];
                [self.areaArray addObject:model];
            }
        }else {//地区科室请求
            [self.sortArray removeAllObjects];
            for (NSDictionary *temp in arr) {
                FindHosModel *model = [FindHosModel findHosModelInithWithDic:temp];
                [self.sortArray addObject:model];
            }
        }
        
    }
    
}

- (void)handleWithDic:(NSDictionary *)dic{
    if ([dic[@"data"]isKindOfClass:[NSNull class]]) {
        self.dataArray = nil;
    }else{
        NSArray *arr = dic[@"data"];
        [self.dataArray removeAllObjects];
        for (NSDictionary *temp in arr) {
            FindHosModel *model = [FindHosModel findHosModelInithWithDic:temp];
            [self.dataArray addObject:model];
        }
    }
    
    [self.tableView reloadData];
    self.tableView.contentOffset = CGPointMake(0, 0);

}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        UIView *baseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 77)];
        
        UIView *searckView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
        [baseView addSubview:searckView];
        
        searckView.backgroundColor = [UIColor whiteColor];
        
        UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(20, 6, kScreenWidth-40, 30)];
        searchBar.layer.borderWidth = 1;
        searchBar.layer.cornerRadius = 5;
        searchBar.clipsToBounds = YES;
        searchBar.layer.borderColor = [[UIColor lightGrayColor]CGColor];
        searchBar.placeholder = @"搜索医院";
        searchBar.delegate = self;
        
        //移除searchbar的灰色背景  只留下textfield样式（需要iOS8.0以上版本 以下需要判断）
        for(int i =  0 ;i < searchBar.subviews.count;i++){
            
            UIView * backView = searchBar.subviews[i];
            
            if ([backView isKindOfClass:NSClassFromString(@"UISearchBarBackground")] == YES) {
                
                [backView removeFromSuperview];
                [searchBar setBackgroundColor:[UIColor clearColor]];
                break;
                
            }else{
                
                NSArray * arr = searchBar.subviews[i].subviews;
                
                for(int j = 0;j<arr.count;j++   ){
                    
                    UIView * barView = arr[i];
                    
                    if ([barView isKindOfClass:NSClassFromString(@"UISearchBarBackground")] == YES) {
                        
                        [barView removeFromSuperview];
                        [searchBar setBackgroundColor:[UIColor clearColor]];
                        break;
                        
                    }
                    
                }
                
            }
            
        }
        
        searchBar.keyboardType = UIKeyboardTypeDefault;
        
        [searckView addSubview:searchBar];
        
        
        //筛选
        UIView *filtrateView = [[UIView alloc]init];
        filtrateView.backgroundColor = [UIColor stringTOColor:@"#eeeeee"];
        filtrateView.frame = CGRectMake(0, 44, kScreenWidth, 33);
        [baseView addSubview:filtrateView];
        
        
        /***简介视图***/
        UILabel *verticalLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 6, 2, 21)];
        verticalLabel.backgroundColor = [UIColor stringTOColor:@"#22ccc6"];
        [filtrateView addSubview:verticalLabel];
        
        UILabel *cityLabel = [[UILabel alloc]init];
        
        if (self.filtrate_cityLabel.text == nil) {
            cityLabel.text = @"杭州市";
        }else {
            cityLabel.text = self.filtrate_cityLabel.text;
        }
        cityLabel.font = [UIFont systemFontOfSize:14];
        self.filtrate_cityLabel = cityLabel;
        [filtrateView addSubview:cityLabel];
        
        UILabel *roundLabel = [[UILabel alloc]init];
        roundLabel.backgroundColor = [UIColor stringTOColor:@"#22ccc6"];
        roundLabel.layer.cornerRadius = 2;
        roundLabel.clipsToBounds = YES;
        self.filtrate_roundLabel = roundLabel;
        [filtrateView addSubview:roundLabel];
        
        UILabel *hosLabel = [[UILabel alloc]init];
        if (self.filtrate_hosLabel.text == nil) {
           hosLabel.text = @"全部";
        }else {
            hosLabel.text = self.filtrate_hosLabel.text;
        }
        
        hosLabel.font = [UIFont systemFontOfSize:14];
        hosLabel.textColor  = [UIColor blackColor];
        self.filtrate_hosLabel = hosLabel;
        [filtrateView addSubview:hosLabel];
        
        [cityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(filtrateView);
            make.left.equalTo(verticalLabel.mas_right).with.offset(5);
        }];
        [roundLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cityLabel);
            make.left.equalTo(cityLabel.mas_right).with.offset(5);
            make.size.mas_offset(CGSizeMake(4, 4));
        }];
        [hosLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(roundLabel);
            make.left.equalTo(roundLabel.mas_right).with.offset(5);
        }];
        
        /***简介视图***/
        
        
        /***筛选视图***/
        UILabel *label = [[UILabel alloc]init];
        label.text = @"筛选";
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor stringTOColor:@"#959595"];
        [filtrateView addSubview:label];
        
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:@"漏斗筛选"];
        [filtrateView addSubview:imageView];
        
        UILabel *lineLabel = [[UILabel alloc]init];
        lineLabel.backgroundColor = [UIColor lightGrayColor];
        [filtrateView addSubview:lineLabel];
        
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(filtrateView.mas_centerY);
            make.right.equalTo(filtrateView.mas_right).with.offset(-20);
        }];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(filtrateView.mas_centerY);
            make.right.equalTo(label.mas_left).with.offset(-2);
            make.size.mas_offset(CGSizeMake(12,14));
        }];
        
        [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(filtrateView);
            make.height.mas_offset(@1);
        }];
        
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]init];
        [tapGes addTarget:self action:@selector(filtrateClick:)];
        [filtrateView addGestureRecognizer:tapGes];
        /***筛选视图***/

        
        
//        UILabel *filtrateLabel = [[UILabel alloc]init];
//        filtrateLabel.text = @"筛选";
//        filtrateLabel.textColor = [UIColor blackColor];
//        [filtrateView addSubview:filtrateLabel];
//        UIImageView *triangleImageView = [[UIImageView alloc]init];
//        triangleImageView.image = [UIImage imageNamed:@"筛选展开"];
//        [filtrateView addSubview:triangleImageView];
//        
//        [filtrateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(filtrateView.mas_left).with.offset(kScreenWidth/2);
//            make.centerY.equalTo(filtrateView.mas_centerY);
//        }];
//        [triangleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(filtrateView.mas_left).with.offset(kScreenWidth/2);
//            make.centerY.equalTo(filtrateView.mas_centerY);
//            make.size.mas_offset(CGSizeMake(14, 8));
//        }];
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]init];
        [gesture addTarget:self action:@selector(filtrateClick:)];
        [filtrateView addGestureRecognizer:gesture];
        
        return baseView;
        
    }else {
        UIView *searckView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 70)];
        
        searckView.backgroundColor = [UIColor stringTOColor:@"#f3f3f6"];
        
        UIButton *changeGroupBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        changeGroupBtn.backgroundColor = [UIColor stringTOColor:@"#00b09f"];
        changeGroupBtn.center = CGPointMake(searckView.center.x, searckView.center.y);
        changeGroupBtn.bounds = CGRectMake(0, 0, 100, 30);
        [changeGroupBtn setTitle:@"换一组" forState:normal];
        [changeGroupBtn setTitleColor:[UIColor whiteColor] forState:normal];
        changeGroupBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [changeGroupBtn addTarget:self action:@selector(changegroup:) forControlEvents:UIControlEventTouchUpInside];
        changeGroupBtn.layer.cornerRadius = 10;
        changeGroupBtn.clipsToBounds = YES;
        [searckView addSubview:changeGroupBtn];
        return searckView;
        
    }
    
}

//筛选按钮点击事件
- (void)filtrateClick:(UITapGestureRecognizer *)sender {
    self.filtrate = !self.filtrate;
    if (self.filtrate) {
        
        NSMutableArray *areaBtnListArr = [NSMutableArray array];
        NSMutableArray *sortBtnListArr = [NSMutableArray array];
        
        for (int i = 0; i<self.areaArray.count+1; i++) {
            UIButton *button = [[UIButton alloc]init];
            button.tag = 100+i;
            [button addTarget:self action:@selector(areaBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [button setTitleColor:[UIColor stringTOColor:@"#00afa1"] forState:UIControlStateSelected];
            [areaBtnListArr addObject:button];

            if (i == 0) {
                [button setTitle:@"杭州市" forState:normal];
            }else {
                FindHosModel *model = self.areaArray[i-1];
                [button setTitle:model.name forState:normal];
            }
                    }
        for (int i = 0; i<self.sortArray.count+1; i++) {
            UIButton *button = [[UIButton alloc]init];
            button.tag = 200+i;
            [button addTarget:self action:@selector(sortBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [button setTitleColor:[UIColor stringTOColor:@"#00afa1"] forState:UIControlStateSelected];
            [sortBtnListArr addObject:button];
            if (i == 0) {
                [button setTitle:@"全部" forState:normal];
            }else {
                FindHosModel *model = self.sortArray[i-1];
                [button setTitle:model.name forState:normal];
            }
        }
        
        
        hosFiltrateTabVC *filtrateView = [[hosFiltrateTabVC alloc]initWithAreaArray:areaBtnListArr andSortArr:sortBtnListArr andTitleArr:nil];
        
        
        self.hosFilTabVC = filtrateView;
        
        self.hosFilTabVC.view.frame = CGRectMake(0, 77, kScreenWidth, kScreenHeigth-77-64);
        [self.view addSubview:self.hosFilTabVC.view];
    }else {
        self.selectAreaBtn = nil;
        [self.hosFilTabVC.view removeFromSuperview];
    }
    
    
}
//筛选里城市按钮
- (void)areaBtnClick:(UIButton *)sender {
    
    if (!(self.selectSortBtn == nil)) {
        self.selectSortBtn.selected = NO;
        self.selectSortBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        self.selectSortBtn = nil;
    }
    
    self.selectAreaBtn.selected = NO;
    self.selectAreaBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    
    sender.selected = YES;
    sender.titleLabel.font = [UIFont systemFontOfSize:15];
    
    self.selectAreaBtn = sender;
    
    if (sender.tag == 100) {
        self.selectAreaId = @"0";
    }else {
        FindHosModel *model = self.areaArray[sender.tag-100-1];
        self.selectAreaId = model.cid;
    }
    
    self.filtrate_cityLabel.text = sender.currentTitle;
}
//筛选里医院按钮
- (void)sortBtnClick:(UIButton *)sender {
    if (self.selectAreaBtn.selected == YES) {
        
        self.selectSortBtn.selected = NO;
        self.selectSortBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        
        sender.selected = YES;
        sender.titleLabel.font = [UIFont systemFontOfSize:15];
        
        self.selectSortBtn = sender;
        
        if (sender.tag == 200) {
            self.selectSortId = @"0";
        }else {
            FindHosModel *model = self.sortArray[sender.tag-200-1];
            self.selectSortId = model.cid;
        }
        
        [self requestDataWithWhich:@"filtrate"];
        self.selectAreaBtn = nil;
        [self.hosFilTabVC.view removeFromSuperview];
    
    }else {
        NSLog(@"没有选择地区");
    }
    
    self.filtrate_hosLabel.text = sender.currentTitle;
}

//换一组
- (void)changegroup:(UIButton *)sender {
    [self requestDataWithWhich:@"filtrate"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 77;
        
    }else {
        return 70;
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    SarchDetailViewController *saVC = [[SarchDetailViewController alloc]init];
    UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:saVC];
    
    saVC.receiveMark = @"1";
    saVC.resualt = searchBar.text;
    [self presentViewController:naNC animated:YES completion:^{
        
    }];
    
    
    
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    return YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PromiseHosViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"PromiseHosViewCell" owner:self options:nil];
        for (id tempCell in array) {
            if ([tempCell isKindOfClass:[PromiseHosViewCell class]]) {
                cell = tempCell;
            }
        }
    }
    
    
    FindHosModel *model = self.dataArray[indexPath.row];
    
    
    cell.hosNameLabel.text = model.name;
    cell.zhenLabel.text = [NSString stringWithFormat:@"%@ 人",model.zhen];
    cell.rankLabel.text = model.rank;
    cell.ybLabel.text = model.yb;
    cell.phoneLabel.text = model.phone;
    cell.introduceLabel.text = model.introduce;
    cell.commentLabel.text = [NSString stringWithFormat:@"%ld",model.comment_num];
    cell.dunLabel.text = model.dun;
    NSString *str = [NSString stringWithFormat:urlPicture,model.photo];
    [cell.photoImage sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:nil];
    
    cell.contentView.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:247/255.0 alpha:1];
    
    
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    cell.bgView.layer.cornerRadius = 4.0;
    cell.bgView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    
    cell.bgView.layer.shadowColor = [UIColor lightGrayColor].CGColor;//shadowColor阴影颜色
    cell.bgView.layer.shadowOffset = CGSizeMake(0,2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    cell.bgView.layer.shadowOpacity = 0.5;//阴影透明度，默认0
    cell.bgView.layer.shadowRadius = 4;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    hosHomePageVC *hosVC = [[hosHomePageVC alloc]init];
    UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:hosVC];
    
    FindHosModel *model =self.dataArray[indexPath.row];
    
    hosVC.receiver = model.cid;
    [self presentViewController:naNC animated:YES completion:^{
        
    }];
    
    
    
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
