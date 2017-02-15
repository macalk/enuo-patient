//
//  PLDetailViewController.m
//  enuoS
//
//  Created by apple on 16/8/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "PLDetailViewController.h"
#import "Macros.h"
#import "PromiseHosViewCell.h"
#import <MJRefresh.h>
#import <SVProgressHUD.h>
#import <AFNetworking.h>
#import "HosViewController.h"
#import "hosHomePageVC.h"
#import "FindHosModel.h"
#import <UIImageView+WebCache.h>

@interface PLDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)UITableView *tableView;
//医生信息
@property (nonatomic,assign)NSInteger num;
@property (nonatomic,copy)NSString *dep_id;
@property (nonatomic,copy)NSString *sdep_id;
@property (nonatomic,copy)NSString *sort_order;//类型排序
@end

@implementation PLDetailViewController

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }return _dataArray;
}

- (UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc]init];
    }return _tableView;
}


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"绿色返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleWithBack:)];
        self.navigationItem.leftBarButtonItem = leftItem;
        

    }return self;
}



- (void)handleWithBack:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:255/255.0 green:192/255.0 blue:202/255.0 alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.num = 1;
    self.sdep_id = @"";
    self.dep_id = @"";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
       [self.tableView registerNib:[UINib nibWithNibName:@"PromiseHosViewCell" bundle:nil] forCellReuseIdentifier:@"Hoscell"];
    self.view = self.tableView;
    //[self creatSegement];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    //默认【上拉加载】
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    [self requestData];

}


- (void)refresh{
    //NSLog(@"你是个大逗逼");
    [self.dataArray removeAllObjects];
    _num = 1;
    [self requestData];
}

- (void)loadMore{
    // NSLog(@"都比都比");
    _num ++;
    [self requestData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PromiseHosViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Hoscell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:247/255.0 alpha:1];
    cell.bgView.layer.cornerRadius = 4.0;
    cell.bgView.layer.borderColor = [UIColor clearColor].CGColor;
    cell.bgView.layer.borderWidth = 1.0;
    
    cell.bgView.layer.shadowColor = [UIColor lightGrayColor].CGColor;//shadowColor阴影颜色
    cell.bgView.layer.shadowOffset = CGSizeMake(0,2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    cell.bgView.layer.shadowOpacity = 0.5;//阴影透明度，默认0
    cell.bgView.layer.shadowRadius = 4;
    FindHosModel *model = self.dataArray[indexPath.row];
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    cell.hosNameLabel.text = model.name;
    cell.zhenLabel.text = model.zhen;
    cell.rankLabel.text = model.rank;
    cell.ybLabel.text = model.yb;
    cell.addressLabel.text = model.address;
    cell.illLabel.text = model.ill;
    
    NSString *str = [NSString stringWithFormat:urlPicture,model.photo];
    [cell.photoImage sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:nil];
    
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 138;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    hosHomePageVC *hosVC = [[hosHomePageVC alloc]init];
        FindHosModel *model = self.dataArray[indexPath.row];
    hosVC.receiver = model.cid;

    
    UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:hosVC];
    [self presentViewController:naNC animated:YES completion:nil];
}


- (void)requestData{
    NSString *url = @"http://www.enuo120.com/index.php/app/index/find_keshi_hos";
    
    //    NSString *sort = @"sort_order";
    //    NSString *sdep = @"sdep_id";
    //    NSString *dep = @"dep_id";
    
    NSLog(@"%@",self.receiver);
    NSString * page = [NSString stringWithFormat:@"%ld",(long)self.num];
    NSDictionary *heardBody = @{@"page":page, @"dep_id":@"11",@"sdep_id":self.receiver};
    
    BaseRequest *request = [[BaseRequest alloc]init];
    [request POST:url params:heardBody success:^(NSURLSessionDataTask *task, id responseObject) {
        [self handleWithDataWithDoc:responseObject];

    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}
- (void)handleWithDataWithDoc:(NSDictionary *)data{
    if ([data[@"data"]isKindOfClass:[NSNull class]]
        ) {
        NSLog(@"无数据");
        [self endRefresh];
    }else{
        NSArray *arr = data[@"data"];
        
        
        
        for (NSDictionary *temp in arr) {
            FindHosModel *model = [FindHosModel findHosModelInithWithDic:temp];
            
            [self.dataArray addObject:model];
        }
    }[self.tableView reloadData];
    [self endRefresh];
    
}

- (void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
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
