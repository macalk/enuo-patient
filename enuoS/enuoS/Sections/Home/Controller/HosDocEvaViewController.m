//
//  HosDocEvaViewController.m
//  enuoS
//
//  Created by apple on 16/8/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "HosDocEvaViewController.h"
#import <AFNetworking.h>
#import <Masonry.h>
#import "Macros.h"
#import "HosZhuPjModel.h"
#import "SYStarRatingView.h"


@interface HosDocEvaViewController ()<UITableViewDelegate,UITableViewDataSource,StarRatingViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)NSArray *arrCent;

@property (nonatomic,copy)NSString *pjNum;
@property (nonatomic,copy)NSString *ave_huanjing;
@property (nonatomic,copy)NSString *ave_servive;


@end

@implementation HosDocEvaViewController


- (NSArray *)arrCent{
    if (!_arrCent) {
        self.arrCent = [NSArray array];
    }return _arrCent;
}

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


- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"PLARR = %@",self.pjArr);
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航条底图"] forBarMetrics:0];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    if ([self.markStr isEqualToString:@"1"]) {
        [self requestData];
    }
    [self creattableView];
}
- (void)handleWithBack:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)creattableView{
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    self.view = self.tableView;
   self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellOne"];

    
    
}

- (void)requestData{
    NSString *str = @"http://www.enuo120.com/index.php/app/hospital/home_keshi_pj";
    NSDictionary *heardBody = @{@"hid":self.receiver};
    AFHTTPSessionManager *mager= [AFHTTPSessionManager manager ];
    [mager POST:str parameters:heardBody progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleWithDic:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

- (void)handleWithDic:(NSDictionary *)dic{
    NSDictionary *data = dic[@"data"];
    if (![data[@"pj"]isKindOfClass:[NSNull class]]) {
          self.arrCent = data[@"pj"];
    }
  
    self.pjNum =[NSString stringWithFormat:@"%ld",[data[@"pj_num"]integerValue]];
    self.ave_huanjing  = [NSString stringWithFormat:@"%ld",[data[@"ave_huanjing"]integerValue]];
    self.ave_servive = [NSString stringWithFormat:@"%ld",[data[@"ave_service"]integerValue]];
    
    [self.tableView reloadData];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.markStr isEqualToString:@"1"]) {
        
        if (self.arrCent.count != 0) {
            return self.arrCent.count;
        }else{
            return 0;
        }
      
    }else{
        if (![self.pjArr isEqual:[NSNull null]] ) {
            return self.pjArr.count;
        }else{
            return 0;
        }
       
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 75)];
    
    UILabel *oneLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 65, 30)];
    UILabel *twoLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 40, 65, 30)];
  
    
    oneLabel.textColor = [UIColor orangeColor];
    twoLabel.textColor = [UIColor orangeColor];
    oneLabel.font = [UIFont systemFontOfSize:13];
    twoLabel.font = [UIFont systemFontOfSize:13];
    
    UILabel *rightOne = [[UILabel alloc]initWithFrame:CGRectMake(75, 5, 65, 30)];
    UILabel *rightTwo = [[UILabel alloc]initWithFrame:CGRectMake(75, 40, 65, 30)];
    
    rightOne .textColor = [UIColor orangeColor];
    rightTwo.textColor = [UIColor orangeColor];
    rightOne.font = [UIFont systemFontOfSize:17];
    rightTwo.font = [UIFont systemFontOfSize:17];
    if ([self.markStr isEqualToString:@"1"]) {
        oneLabel.text = @"服务分数:";
        twoLabel.text = @"环境分数:";
        rightOne .text = self.ave_servive;
        rightTwo .text =self.ave_huanjing;
    }else{
        oneLabel.text = @"服务分数:";
        twoLabel.text = @"技能分数:";
        rightOne .text = self.service;
        rightTwo .text =self.leve;
    }
   
    
    [view addSubview:oneLabel];
    [view addSubview:twoLabel];
    [view addSubview:rightTwo];
    [view addSubview:rightOne];
    
    view.backgroundColor = [UIColor whiteColor];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 75;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.markStr isEqualToString:@"1"]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        UILabel *uerlabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, kScreenWidth, 20)];
        uerlabel.text = self.arrCent[indexPath.row][@"user"];
        uerlabel.font = [UIFont systemFontOfSize:13];
        UILabel *hosOne = [[UILabel alloc]initWithFrame:CGRectMake(5, 25, 55, 20)];
        hosOne.text = @"评论:";
        hosOne.font = [UIFont systemFontOfSize:12];
        UILabel *hos_content = [[UILabel alloc]initWithFrame:CGRectMake(65, 25, kScreenWidth -70, 40)];
        hos_content.text = self.arrCent[indexPath.row][@"hos_content"];
        hos_content.font = [UIFont systemFontOfSize:11];
        hos_content.numberOfLines = 0;
        
        
        UILabel *hostwo = [[UILabel alloc]initWithFrame:CGRectMake(5, 65, 55, 20)];
        hostwo.text = @"追评:";
        hostwo.font = [UIFont systemFontOfSize:12];
        UILabel *hos_zhui = [[UILabel alloc]initWithFrame:CGRectMake(65, 65, kScreenWidth - 70, 40)];
       
        
        
        [cell.contentView addSubview:uerlabel];
        [cell.contentView addSubview:hosOne];
        [cell.contentView addSubview:hos_content];
        if (![self.arrCent[indexPath.row][@"hos_zhui"] isEqualToString:@""]||![self.arrCent[indexPath.row][@"hos_zhui"]isKindOfClass:[NSNull class] ]) {
            hos_zhui.text = self.arrCent[indexPath.row][@"hos_zhui"];
            hos_zhui.font = [UIFont systemFontOfSize:11];
            hos_zhui.numberOfLines = 0;
            [cell.contentView addSubview:hostwo];
            [cell.contentView addSubview:hos_zhui];
            
            
        }
        return cell;
    }else{
         UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellOne" forIndexPath:indexPath];
        UILabel *uerlabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, kScreenWidth, 20)];
        uerlabel.text = self.pjArr[indexPath.row][@"user"];
        uerlabel.font = [UIFont systemFontOfSize:13];
        UILabel *hosOne = [[UILabel alloc]initWithFrame:CGRectMake(5, 25, 55, 20)];
        hosOne.text = @"评论:";
        hosOne.font = [UIFont systemFontOfSize:12];
        UILabel *hos_content = [[UILabel alloc]initWithFrame:CGRectMake(65, 25, kScreenWidth -70, 40)];
        hos_content.text = self.pjArr[indexPath.row][@"content"];
        hos_content.font = [UIFont systemFontOfSize:11];
        hos_content.numberOfLines = 0;
        
        
        UILabel *hostwo = [[UILabel alloc]initWithFrame:CGRectMake(5, 65, 55, 20)];
        hostwo.text = @"追评:";
        hostwo.font = [UIFont systemFontOfSize:12];
        UILabel *hos_zhui = [[UILabel alloc]initWithFrame:CGRectMake(65, 65, kScreenWidth - 70, 40)];
    
        
        
        [cell.contentView addSubview:uerlabel];
        [cell.contentView addSubview:hosOne];
        [cell.contentView addSubview:hos_content];
        if (![self.pjArr[indexPath.row][@"zhui"]isKindOfClass:[NSNull class] ]||![self.pjArr[indexPath.row][@"zhui"] isEqualToString:@""]) {
            hos_zhui.text = self.pjArr[indexPath.row][@"zhui"];
            hos_zhui.font = [UIFont systemFontOfSize:11];
            hos_zhui.numberOfLines = 0;
            [cell.contentView addSubview:hostwo];
            [cell.contentView addSubview:hos_zhui];
            
            
        }
        return cell;
        
    }
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
