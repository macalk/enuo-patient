//
//  MoreViewController.m
//  enuoS
//
//  Created by apple on 16/8/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MoreViewController.h"
#import <Masonry.h>
#import "Macros.h"
#import "AboutEnuoController.h"
#import "ServeViewController.h"
@interface MoreViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation MoreViewController

- (UITableView *)tableView{
    if (!_tableView) {
        self.tableView  = [[UITableView alloc]init];
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
    [self creatTaBleView];
}

- (void)creatTaBleView{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航条底图"] forBarMetrics:0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    self.tableView.dataSource =self;
    self.tableView.delegate  = self;
    self.view = self.tableView;
    //self.tableView .backgroundColor =[UIColor whiteColor];
    self.tableView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    
    
    
}

- (void)handleWithBack:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    UIView *aView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    UILabel *aLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, kScreenWidth-100, 40)];
   // UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
    UIImageView *aimage = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-30, 10, 10, 15)];
    aimage.image = [UIImage imageNamed:@"下一步"];
    aView.backgroundColor = [UIColor whiteColor];
    [aView addSubview:aimage];
    
    aView.backgroundColor = [UIColor whiteColor];
    aLabel.font = [UIFont systemFontOfSize:14];
    
    [aView addSubview:aLabel];
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    [cell.contentView addSubview:aView];
    if (indexPath.row == 0) {
        
        aLabel.text = @"服务条款";
        
    }else if (indexPath.row == 1) {
        aLabel.text = @"医疗条款";
        
    }else {
        aLabel.text = @"关于e诺";
    }
    return cell;

    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 ||indexPath.row == 1) {
        ServeViewController * serVC = [[ServeViewController alloc]init];
        
        UINavigationController *naVC = [[UINavigationController alloc]initWithRootViewController:serVC];
        if (indexPath.row == 0) {
            serVC.type = @"服务条款";
        }else {
            serVC.type = @"医疗条款";
        }
        [self presentViewController:naVC animated:YES completion:^{
            
        }];
    }else{
        AboutEnuoController *abvc = [[AboutEnuoController alloc]init];
        UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:abvc];
        
        [self presentViewController:naNC animated:YES completion:^{
            
        }];
    }
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
