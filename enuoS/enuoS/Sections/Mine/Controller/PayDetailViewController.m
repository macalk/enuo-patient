//
//  PayDetailViewController.m
//  enuo4
//
//  Created by apple on 16/4/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "PayDetailViewController.h"
#import <AFNetworking.h>
#import "RootTabBarViewController.h"
#import "PayDetailModel.h"
@interface PayDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *methodLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation PayDetailViewController

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        self.dataArr = [NSMutableArray array];
    }return _dataArr;
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
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航条底图"] forBarMetrics:0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
       [self requsestData];
    
    
    
    // Do any additional setup after loading the view from its nib.
}
- (void)handleWithBack:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)handleBackBarItem{
    RootTabBarViewController *rooVC = [[RootTabBarViewController alloc]init];
    [self presentViewController:rooVC animated:YES completion:^{
        
    }];
}



- (void)requsestData{
    NSUserDefaults *userDefaults= [NSUserDefaults standardUserDefaults];
    NSString *name = [userDefaults objectForKey:@"name"];
    NSString *str = @"http://www.enuo120.com/index.php/phone/Json/succed?username=%@&orderNo=%@";
    NSString *strUrl = [NSString stringWithFormat:str,name,self.resever];
    
    BaseRequest *request = [[BaseRequest alloc]init];
    [request POST:strUrl params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [self handleWithData:responseObject];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}


- (void)handleWithData:(NSDictionary *)data{
    NSArray *arr = data[@"data"];
    for (NSDictionary *temp in arr) {
        PayDetailModel *model = [PayDetailModel payDetailModelWithDic:temp];
        [self.dataArr addObject:model];
        self.methodLabel.text = model.method;
        self.numberLabel.text = model.orderNo;
        self.usernameLabel.text = model.remark;
        self.moneyLabel.text = [NSString stringWithFormat:@"￥%@",model.sum];
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
