//
//  MyOrderNewController.m
//  enuoS
//
//  Created by apple on 16/8/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MyOrderNewController.h"
#import "Macros.h"
#import "OrderInFormViewController.h"
#import "SureViewController.h"
#import "SureEndTableController.h"
#import "CheckTableController.h"
#import "StateTableController.h"
#import "UIColor+Extend.h"

@interface MyOrderNewController ()




@end

@implementation MyOrderNewController

- (instancetype)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if (self) {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"绿色返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleWithBack:)];
        self.navigationItem.leftBarButtonItem = leftItem;
        
        UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
        [titleLable setTextAlignment:NSTextAlignmentCenter];
        [titleLable setTextColor:[UIColor stringTOColor:@"#00b09f"]];
        [titleLable setText:@"我的订单"];
        titleLable.font = [UIFont boldSystemFontOfSize:18];
        
        self.navigationItem.titleView = titleLable;
        
    }return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航条底图"] forBarMetrics:0];
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
}

- (void)handleWithBack:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    UIView *aView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    UILabel *aLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, kScreenWidth-100, 40)];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
    UIImageView *aimage = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-30, 10, 10, 15)];
    aimage.image = [UIImage imageNamed:@"下一步"];
    [aView addSubview:aimage];
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
   // tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    aView.backgroundColor = [UIColor whiteColor];
    aLabel.font = [UIFont systemFontOfSize:14];
    [aView addSubview:aLabel
     ];
    [aView addSubview:imageView];
    if (indexPath.row == 0) {
        
        aLabel.text = @"订单信息";
        imageView.image = [UIImage imageNamed:@"订单"];
        
        [cell.contentView addSubview:aView];
    }else if (indexPath.row == 1)  {
        aLabel.text = @"待约定";
        imageView.image = [UIImage imageNamed:@"约诊记录"];
        
         [cell.contentView addSubview:aView];
    }else if(indexPath.row ==2){
        aLabel.text = @"确定约定结果";
        imageView.image = [UIImage imageNamed:@"充值"];
         [cell.contentView addSubview:aView];
    }else if (indexPath.row == 3){
        aLabel.text = @"约定状态";
        imageView.image = [UIImage imageNamed:@"修改密码"];
        [cell.contentView addSubview:aView];
    }else{
        aLabel.text = @"检查约定";
        imageView.image = [UIImage imageNamed:@"vip充值"];
        [cell.contentView addSubview:aView];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        OrderInFormViewController *ordetvc = [[OrderInFormViewController alloc]init];
        [self.navigationController pushViewController:ordetvc animated:YES];
    }else if (indexPath.row ==1){
        SureViewController *sureVC = [[SureViewController alloc]init];
        [self.navigationController pushViewController:sureVC animated:YES];
    }else if (indexPath.row == 2){
        SureEndTableController *sureVC = [[SureEndTableController alloc]init];
        UINavigationController *naVC = [[UINavigationController alloc]initWithRootViewController:sureVC];
        [self presentViewController:naVC animated:YES completion:^{
            NSLog(@"NISHI DA DOU BO");
        }];
    }else if(indexPath.row ==3){
        StateTableController *statVc = [[StateTableController alloc]init];
        UINavigationController *naVC = [[UINavigationController alloc]initWithRootViewController:statVc];
        [self presentViewController:naVC animated:YES completion:^{
            //NSLog(@"I L O V E Y O U");
        }];
    }else{
        CheckTableController *checkVc = [[CheckTableController alloc]init];
        UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:checkVc];
        
        [self presentViewController:navc animated:YES completion:^{
            
        }];
    }
    
    
}





/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
