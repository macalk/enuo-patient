//
//  MyExperienceCardVC.m
//  enuoS
//
//  Created by apple on 16/12/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MyExperienceCardVC.h"
#import "UIColor+Extend.h"
#import "Macros.h"
#import "MyExperienceCardDetailVC.h"
#import "MyExperienceCardOrderVC.h"
#import <Masonry.h>

@interface MyExperienceCardVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation MyExperienceCardVC

- (void)customNavView {
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barTintColor = [UIColor stringTOColor:@"#22ccc6"];
        
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.center = self.navigationItem.titleView.center;
    titleLabel.bounds = CGRectMake(0, 0, 100, 20);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"我的特价体验劵";
    self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"白色返回"] style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonClick:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

}

- (void)leftBarButtonClick:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self customNavView];
    [self customTableView];
    
}
//创建tableview
- (void)customTableView {
    UITableView *tableView = [[UITableView alloc]init];
    tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeigth);
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView = tableView;
    [self.view addSubview:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImageView *imageView = [[UIImageView alloc]init];
    [cell.contentView addSubview:imageView];
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:15];
    [cell.contentView addSubview:label];
    
    if (indexPath.row == 0) {
        imageView.image = [UIImage imageNamed:@"我的现场充值劵"];
        label.text = @"我的特价体验劵";
    }else {
        imageView.image = [UIImage imageNamed:@"资料"];
        label.text = @"我的特价体验劵订单";
    }
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cell.contentView);
        make.left.equalTo(cell.contentView).with.offset(20);
        if (indexPath.row == 0) {
            make.size.mas_offset(CGSizeMake(20, 20));
        }else {
            make.size.mas_offset(CGSizeMake(20, 22));
        }
    }];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cell.contentView);
        make.left.equalTo(imageView.mas_right).with.offset(10);
    }];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        MyExperienceCardDetailVC *detailVC = [MyExperienceCardDetailVC new];
        [self.navigationController pushViewController:detailVC animated:YES];
    }else {
        MyExperienceCardOrderVC *orderVC = [MyExperienceCardOrderVC new];
        [self.navigationController pushViewController:orderVC animated:YES];
    }
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
