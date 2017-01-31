//
//  StateTwoViewController.m
//  enuo4
//
//  Created by apple on 16/5/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "StateTwoViewController.h"
#import <AFNetworking.h>
#import "StateTwoModel.h"

@interface StateTwoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *zhenLabel;
@property (weak, nonatomic) IBOutlet UILabel *zhusuLabel;
@property (weak, nonatomic) IBOutlet UILabel *xianBinLabel;
@property (weak, nonatomic) IBOutlet UILabel *tiGeLabel;

@property (weak, nonatomic) IBOutlet UILabel *shiYanLabel;
@property (weak, nonatomic) IBOutlet UILabel *fuZhuLaBel;

@property (nonatomic,strong)NSMutableArray *dataArr;

@end


@implementation StateTwoViewController

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        self.dataArr = [NSMutableArray array];
    }return _dataArr;
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"绿色返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleBackBarItem)];
        self.navigationItem.leftBarButtonItem = leftItem;
        
        
    }return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航条底图"] forBarMetrics:0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [self requestDara];
    self.navigationController.navigationBar.translucent = NO;
}
- (void)handleBackBarItem{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}



- (void)requestDara{
    NSString *str = @"http://www.enuo120.com/index.php/phone/Json/zhen?pro=%@";
    NSString *url = [NSString stringWithFormat:str,self.receiver];
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleWithDic:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    

}
- (void)handleWithDic:(NSDictionary *)dic{
    
    
    
    if ([dic[@"data"] isKindOfClass:[NSNull class]]|| [dic[@"data"] isEqual: @""]||[dic[@"data"]isKindOfClass:[NSNumber class]] )  {
        NSLog(@"数据为空");
    
    
    
    }else{
    NSArray *arr = dic[@"data"];
    
    
    
    
    for (NSDictionary *temp in arr) {
        StateTwoModel *model = [StateTwoModel stateTwoModelWithDic:temp];
       // [self.dataArr addObject:model];
        self.zhenLabel.text = model.zhenduan;
        self.zhusuLabel.text = model.main_say;
        self.xianBinLabel.text = model.now_disease;
        self.tiGeLabel.text = model.dody_check;
        self.shiYanLabel.text = model.lab_check;
        self.fuZhuLaBel.text = model.he_check;
        
    }
    }
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//http://www.enuo120.com/index.php/phone/Json/zhen?pro=429118885195634
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
