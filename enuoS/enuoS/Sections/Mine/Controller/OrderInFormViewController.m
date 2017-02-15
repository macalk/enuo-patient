//
//  OrderInFormViewController.m
//  enuo4
//
//  Created by apple on 16/4/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "OrderInFormViewController.h"
#import <AFNetworking.h>
#import <Masonry.h>
#import "Macros.h"
#include "ReFormaModel.h"
#import "OderInforViewCell.h"
#import "RootTabBarViewController.h"

@interface OrderInFormViewController ()
@property (nonatomic,strong)NSMutableArray *dataArr;

@property (nonatomic,strong)UILabel *oneLabel;
@property (nonatomic,strong)UILabel *twoLabel;
@property (nonatomic,strong)UILabel *threeLabel;
@property (nonatomic,strong)UILabel *frouLabel;
@property (nonatomic,strong)UILabel *fiveLabel;
@property (nonatomic,strong)UILabel *sixLabel;
@property (nonatomic,strong)UILabel *sevenLabel;
@property (nonatomic,strong)UILabel *eightLabel;



@property (nonatomic,strong)UILabel *oneTextLabel;
@property (nonatomic,strong)UILabel *twoTextLabel;
@property (nonatomic,strong)UILabel *threeTextLabel;
@property (nonatomic,strong)UILabel *frouTextLabel;
@property (nonatomic,strong)UILabel *fiveTextLabel;
@property (nonatomic,strong)UILabel *sixTextLabel;
@property (nonatomic,strong)UILabel *sevenTextLabel;
@property (nonatomic,strong)UILabel *eightTextLabel;


@end

@implementation OrderInFormViewController





- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        self.dataArr = [NSMutableArray array];
        
    }return _dataArr;
}


- (instancetype)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if (self) {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"登录返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleWithBack:)];
        self.navigationItem.leftBarButtonItem = leftItem;
    }return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航条底图"] forBarMetrics:0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"OderInforViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
 
    [self requestData];
}
- (void)handleWithBack:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSLog(@"self.dataArr.count = %ld",(unsigned long)self.dataArr.count);
    return self.dataArr.count;
}




- (void)requestData{
    NSString * str = @"http://www.enuo120.com/index.php/phone/Json/ptresult?username=%@";
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *name = [userDefaults objectForKey:@"name"];
    
    NSString *url = [NSString stringWithFormat:str,name];
    
    BaseRequest *request = [[BaseRequest alloc]init];
    [request POST:url params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [self handleGetDataWithData:responseObject];

    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
        
}




- (void)handleGetDataWithData:(NSDictionary *)data{
    if ([data[@"data"] isKindOfClass:[NSNull class]]|| [data[@"data"] isEqual:@""]||[data[@"data"]isKindOfClass:[NSNumber class]] )  {
        //NSLog(@"数据为空");
        
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
            UIAlertView * alert1 = [[UIAlertView alloc]initWithTitle:@"提示" message:@"暂无数据" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [alert1 show];
        }else{
            UIAlertController *alertView1 = [UIAlertController alertControllerWithTitle:@"提示" message:@"暂无数据" preferredStyle:UIAlertControllerStyleAlert];
            [alertView1 addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:YES];
                //  [self.navigationController popViewControllerAnimated:YES];
            }]];
            [self presentViewController:alertView1 animated:YES completion:^{
                
            }];
        }
    }else{
            
        
    NSArray *arr = data[@"data"];
    for (NSDictionary *temp in arr) {
        ReFormaModel *model = [ReFormaModel reFormaModelInitWithDic:temp];
        NSLog(@"model = %@",model);
        [self.dataArr addObject:model];
    }
        
        }
        NSLog(@"self.dataArr.count = %ld",(unsigned long)self.dataArr.count);
        [self.tableView reloadData];

}


//- (void)creatNavtionView{
//    UIBarButtonItem *ledtItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(handleSearchBarItem)];
//
//    self.navigationItem.leftBarButtonItem = leftItem;
//}






- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    OderInforViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    ReFormaModel *model = self.dataArr[indexPath.row];
//    NSLog(@"self.data.COUNT = %ld",self.dataArr.count);
//    self.oneLabel = [[UILabel alloc]init];
//    self.oneLabel.frame = CGRectMake(10, 0, 64, 30);
//    self.oneLabel.font = [UIFont systemFontOfSize:14];
//    self.oneLabel.text = @"约定医院";
//    
//    
//    self.twoLabel = [[UILabel alloc]init];
//    self.twoLabel.frame = CGRectMake(10, 30, 65, 30);
//    self.twoLabel.font = [UIFont systemFontOfSize:14];
//    self.twoLabel.text = @"约定科室";
//    
//    self.threeLabel = [[UILabel alloc]init];
//    self.threeLabel.frame = CGRectMake(10, 60, 65, 30);
//    self.threeLabel.font = [UIFont systemFontOfSize:14];
//    self.threeLabel.text = @"约定医生";
//    
//    self.frouLabel = [[UILabel alloc]init];
//    self.frouLabel.frame = CGRectMake(10, 90, 65, 30);
//    self.frouLabel.font = [UIFont systemFontOfSize:14];
//    self.frouLabel.text =@"约定疾病";
//    
//    self.fiveLabel = [[UILabel alloc]init];
//    self.fiveLabel.frame = CGRectMake(10, 120, 65, 30);
//    self.fiveLabel.font = [UIFont systemFontOfSize:14];
//    self.fiveLabel.text = @"约定时间";
//    
//    self.sixLabel = [[UILabel alloc]init];
//    self.sixLabel.frame = CGRectMake(10, 150, 65, 30);
//    self.sixLabel.font = [UIFont systemFontOfSize:14];
//    self.sixLabel.text = @"预约单号";
//    
//    
//    self.sevenLabel = [[UILabel alloc]init];
//    self.sevenLabel.frame = CGRectMake(10, 180, 65, 30);
//    self.sevenLabel.text =  @"约定排号";
//    self.sevenLabel.font = [UIFont systemFontOfSize:14];
//    
//    
//    self.eightLabel = [[UILabel alloc]init];
//    self.eightLabel.frame = CGRectMake(10, 210, 65, 30);
//    self.eightLabel.font = [UIFont systemFontOfSize:14];
//    self.eightLabel.text = @"预约状态";
//    
//    self.oneTextLabel = [[UILabel alloc]init];
//    self.oneTextLabel.frame = CGRectMake(75, 0, kScreenWidth - 75, 30);
//    self.oneTextLabel.font = [UIFont systemFontOfSize:14];
//    self.oneTextLabel.text = model.hospital;
//    
//    
//    self.twoTextLabel = [[UILabel alloc]init];
//    self.twoTextLabel.frame = CGRectMake(75, 30, kScreenWidth - 75, 30);
//    self.twoTextLabel.font = [UIFont systemFontOfSize:14];
//    self.twoTextLabel.text = model.department;
//    
//    
//    
//    
//    self.threeTextLabel = [[UILabel alloc]init];
//    self.threeTextLabel.frame = CGRectMake(75, 60, kScreenWidth - 75, 30);
//    self.threeTextLabel.font = [UIFont systemFontOfSize:14];
//    self.threeTextLabel.text = model.doctor_name;
//    
//    self.frouTextLabel = [[UILabel alloc]init];
//    self.frouTextLabel.frame = CGRectMake(75, 90, kScreenWidth - 75, 30);
//    self.frouTextLabel.font = [UIFont systemFontOfSize:14];
//    self.frouTextLabel.text = model.jb;
//    self.frouTextLabel.numberOfLines =  0;
//    
//    
//    self.fiveTextLabel  = [[UILabel alloc]init];
//    self.fiveTextLabel.frame = CGRectMake(75, 120, kScreenWidth-75, 30);
//    self.fiveTextLabel.font = [UIFont systemFontOfSize:14];
//    self.fiveTextLabel.text = model.date;
//    
//    
//    self.sixTextLabel = [[UILabel alloc]init];
//    self.sixTextLabel.frame = CGRectMake(75, 150, kScreenWidth - 75, 30);
//    self.sixTextLabel.font = [UIFont systemFontOfSize:14];
//    self.sixTextLabel.text = model.dnumber;
//    
//    self.sevenTextLabel = [[UILabel alloc]init];
//    self.sevenTextLabel.frame = CGRectMake(75, 180, kScreenWidth - 75, 30);
//    self.sevenTextLabel.font  = [UIFont systemFontOfSize:14];
//    if ([model.dsort isEqualToString:@"0"]) {
//        self.sevenTextLabel.text = @"预约待确认";
//    }else{
//        self.sevenTextLabel.text = model.dsort;
//    }
//    
//    self.eightTextLabel = [[UILabel alloc]init];
//    self.eightTextLabel.frame = CGRectMake(75, 210, kScreenWidth - 75, 30);
//    self.eightTextLabel.font = [UIFont systemFontOfSize:14];
//    self.eightTextLabel.text = model.statue;
//    
//    [cell.contentView addSubview:self.oneLabel];
//    [cell.contentView addSubview:self.twoLabel];
//    [cell.contentView addSubview:self.threeLabel];
//    [cell.contentView addSubview:self.frouLabel];
//    [cell.contentView addSubview:self.fiveLabel];
//    [cell.contentView addSubview:self.sixLabel];
//    [cell.contentView addSubview:self.sevenLabel];
//    [cell.contentView addSubview:self.eightLabel];
//    
//    [cell.contentView addSubview:self.oneTextLabel];
//    [cell.contentView addSubview:self.twoTextLabel];
//    [cell.contentView addSubview:self.threeTextLabel];
//    [cell.contentView addSubview:self.frouTextLabel];
//    [cell.contentView addSubview:self.sixTextLabel];
//    [cell.contentView addSubview:self.sevenTextLabel];
//    [cell.contentView addSubview:self.eightTextLabel];
//
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.hospital_nameLabel.text = model.hospital;
    cell.doctor_nameLabel.text = model.doctor_name;
    cell.keShiLabel.text = model.department;
    cell.illLabel.text = model.jb;
    cell.timeLabel.text = model.date;
    cell.numberLabel.text = model.dnumber;
        if ([model.dsort isEqualToString:@"0"]) {
            cell.paiNumberLabel.text = @"预约待确认";
        }else{
           cell.paiNumberLabel.text = model.dsort;
        }
    
    cell.zhuangTaiLabel.text = model.statue;
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 250;
}




@end
