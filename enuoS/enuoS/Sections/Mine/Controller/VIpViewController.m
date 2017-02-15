//
//  VIpViewController.m
//  enuoS
//
//  Created by apple on 16/8/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "VIpViewController.h"
#import "Macros.h"
#import <AFNetworking.h>
#import <Masonry.h>
#import "VipTableViewCell.h"
#import "vipModel.h"
#import "VipArrangeTableController.h"
#import "ActivateRechargeController.h"
@interface VIpViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tabeleView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation VIpViewController


- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }return _dataArray;
}




- (UITableView *)tabeleView{
    if (!_tabeleView) {
        self.tabeleView = [[UITableView alloc]init];
    }return _tabeleView;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"绿色返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleWithBack:)];
        self.navigationItem.leftBarButtonItem = leftItem;
    }return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航条底图"] forBarMetrics:0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];
    [self.tabeleView registerNib:[UINib nibWithNibName:@"VipTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.view =self.tabeleView;
    [self creatabelView];
    [self requesetDataArray];
    
}
- (void)handleWithBack:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)creatabelView{
    self.tabeleView.delegate = self;
    self.tabeleView.dataSource = self;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kScreenWidth/3;
}




- (void)requesetDataArray{
    NSUserDefaults *stand =[ NSUserDefaults standardUserDefaults];
    NSString *name = [stand objectForKey:@"name"];
    NSString *url = @"http://www.enuo120.com/index.php/app/Patient/vip";
    NSDictionary *heardBody = @{@"username":name};
    BaseRequest *request = [[BaseRequest alloc]init];
    [request POST:url params:heardBody success:^(NSURLSessionDataTask *task, id responseObject) {
        [self handleWithData:responseObject];

    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

- (void)handleWithResponseObject:(NSDictionary *)dic{
    NSArray * arr = dic[@"data"];
    for (NSDictionary *temp in arr) {
        vipModel *model = [vipModel vipModelInitWhith:temp];
        [self.dataArray addObject:model];
    }
     [self.tabeleView reloadData];
}

- (void)handleWithData:(NSDictionary *)dic{
    if ([dic[@"data"]isKindOfClass:[NSNull class]]) {
        NSLog(@"sadaddasd");
    }else{
        NSArray *arr = dic[@"data"];
        for (NSDictionary *temp in arr) {
           vipModel *model =  [vipModel vipModelInitWhith:temp];
            [self.dataArray addObject:model];
        }[self.tabeleView reloadData];
//        if (self.dataArray.count == 0) {
//            [self creatnullView];
//        }else{
//            self.view = self.tabeleView;
//        }
    }
}


- (void)creatnullView{
    UILabel *nullLabel = [[UILabel alloc]init];
    
    nullLabel.text = @"暂无数据";
    nullLabel.textColor = [UIColor lightGrayColor];
    nullLabel.font = [UIFont systemFontOfSize:24];
    [self.view addSubview:nullLabel];
    __weak typeof(self) weakSelf = self;
    
    [nullLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view);
        make.centerY.equalTo (weakSelf.view).with.offset(-100);
        
    }];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *aView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    UIButton *oneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *twoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    aView.backgroundColor = [UIColor whiteColor];
    [oneButton setTitle:@"VIP使用范围" forState:UIControlStateNormal];
    [twoButton setTitle:@"VIP激活" forState:UIControlStateNormal];
    oneButton.layer.cornerRadius = 6.0;
    twoButton.layer.cornerRadius = 6.0;
    oneButton.backgroundColor = [UIColor blueColor];
    twoButton.backgroundColor = [UIColor blueColor];
    
    [oneButton addTarget:self action:@selector(handleWithOneBtn:) forControlEvents:UIControlEventTouchUpInside];
     [twoButton addTarget:self action:@selector(handleWithTwoBtn:) forControlEvents:UIControlEventTouchUpInside];
    [aView addSubview:oneButton];
    [aView addSubview:twoButton];
    
    [oneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(aView.mas_left).with.offset(15);
        make.centerY.equalTo (aView);
        make.height.mas_equalTo(@30);
        make.width.mas_equalTo((kScreenWidth-45)/2);
        
    }];
    [twoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(oneButton.mas_right).with.offset(15);
        make.centerY.equalTo (aView);
        make.height.mas_equalTo(@30);
        make.width.mas_equalTo((kScreenWidth-45)/2);
    }];
    
    
    return aView;
}
//使用范围
- (void)handleWithOneBtn:(UIButton *)sender{
    VipArrangeTableController *vipVC = [[VipArrangeTableController alloc]init];
    UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:vipVC];
    [self presentViewController:naNC animated:YES completion:^{
        
    }];
}

//激活
- (void)handleWithTwoBtn:(UIButton *)sender{
    ActivateRechargeController *activeVc = [[ActivateRechargeController alloc]init];
    UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:activeVc];
    
    [self presentViewController:naNC animated:YES completion:^{
        
    }];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VipTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [self.tabeleView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
  tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    vipModel *model = self.dataArray[indexPath.row];
    
    if ([model.is_delete isEqualToString:@"已使用"]) {
        cell.markImage.image = [UIImage imageNamed:@"已使用"];
        cell.vipImage.image = [UIImage imageNamed:@"灰色vip充值"];
    }else if ([model.is_delete isEqualToString:@"已失效"]){
        cell.markImage.image = [UIImage imageNamed:@"已过期"];
          cell.vipImage.image = [UIImage imageNamed:@"灰色vip充值"];
    }else{
        cell.markImage.image = [UIImage imageNamed:@""];
        cell.vipImage.image = [UIImage imageNamed:@"vip充值"];
    }
    cell.priceLabel.text = model.fee;
    cell.timeLabel.text = [NSString stringWithFormat:@"有效期到%@",model.etime];
    return cell;
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
