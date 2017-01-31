//
//  MyRechargeableCardVC.m
//  enuoS
//
//  Created by apple on 16/12/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MyRechargeableCardVC.h"
#import "Macros.h"
#import <Masonry.h>
#import "UIColor+Extend.h"
#import <AFNetworking.h>
#import "MyRechargeableCardModel.h"

@interface MyRechargeableCardVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArr;

@end

@implementation MyRechargeableCardVC
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }return _dataArr;
}


- (void)customNavView {
    self.navigationController.navigationBar.barTintColor = [UIColor stringTOColor:@"#22ccc6"];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.center = self.navigationItem.titleView.center;
    titleLabel.bounds = CGRectMake(0, 0, 100, 20);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"我的现场充值劵";
    self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"白色返回"] style:UIBarButtonItemStyleDone target:self action:@selector(backClick:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)backClick:(UIBarButtonItem *)item {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self customNavView];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.frame];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    [self requestData];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    MyRechargeableCardModel *model = self.dataArr[indexPath.row];
    
    UIImageView *imageView = [[UIImageView alloc]init];
    [cell.contentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell.contentView.mas_top).with.offset(5);
        make.bottom.equalTo(cell.contentView.mas_bottom).with.offset(-5);
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_equalTo(kScreenWidth*0.3);
    }];
    
    UILabel *moneyLabel = [[UILabel alloc]init];
    moneyLabel.text = model.fee;
    moneyLabel.textColor = [UIColor lightGrayColor];
    moneyLabel.font = [UIFont systemFontOfSize:20];
    [cell.contentView addSubview:moneyLabel];
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView).with.offset(30);
        make.centerX.equalTo(imageView).with.offset(-10);
    }];
    
    UILabel *timeLabel = [[UILabel alloc]init];
    timeLabel.text = [NSString stringWithFormat:@"有效时间到%@",model.end_time];
    timeLabel.font = [UIFont systemFontOfSize:10];
    [cell.contentView addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(imageView).with.offset(-10);
        make.left.equalTo(imageView.mas_centerX).with.offset(-40);
    }];
    
    if ([model.is_delete isEqualToString:@"已使用"]) {
        
        imageView.image = [UIImage imageNamed:@"劵-已使用"];
        
    }else if ([model.is_delete isEqualToString:@"已失效"]) {
        
        imageView.image = [UIImage imageNamed:@"劵-已过期"];
        
    }else {
        
        imageView.image = [UIImage imageNamed:@"劵-未使用"];
        moneyLabel.textColor = [UIColor stringTOColor:@"#809ebf"];

    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kScreenWidth*0.3+10;
}

- (void)requestData {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *name = [[NSUserDefaults standardUserDefaults]objectForKey:@"name"];
    NSDictionary *dic = @{@"username":name};
    [manager POST:@"http://www.enuo120.com/index.php/app/Patient/scene" parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self requestOfData:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)requestOfData:(NSDictionary *)dic {
    
    if (![dic[@"data"] isEqual:[NSNull null]]) {
        
        NSArray *array = dic[@"data"];
        for (NSDictionary *tempDic in array) {
            MyRechargeableCardModel *model = [MyRechargeableCardModel MyRechargeableCardModelInitWithDic:tempDic];
            [self.dataArr addObject:model];
        }
    }
    
    [self.tableView reloadData];
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
