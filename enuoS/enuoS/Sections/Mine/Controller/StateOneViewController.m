//
//  StateOneViewController.m
//  enuo4
//
//  Created by apple on 16/5/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "StateOneViewController.h"
#import <AFNetworking.h>
#import "Macros.h"
#import "StateOneModel.h"
#import "StateTwoViewController.h"

#import <Masonry.h>

@interface StateOneViewController ()
@property (weak, nonatomic) IBOutlet UILabel *dnlabel;
@property (weak, nonatomic) IBOutlet UILabel *jblabel;
@property (weak, nonatomic) IBOutlet UILabel *hospitalLabel;
@property (weak, nonatomic) IBOutlet UIButton *yjBtn;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *cycleLabel;
@property (weak, nonatomic) IBOutlet UILabel *liaoXlabel;
@property (weak, nonatomic) IBOutlet UILabel *liangjieLabel;
@property (nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation StateOneViewController
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
        
    }return _dataArray;
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
       UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"登录返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleBackBarItem)];
        
        self.navigationItem.leftBarButtonItem = leftItem;
        
        
    }return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    [self requestData];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航条底图"] forBarMetrics:0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    // Do any additional setup after loading the view from its nib.
}

- (void)handleBackBarItem{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)handleBtn:(UIButton *)sender {
    StateOneModel *moel = self.dataArray[0];
    StateTwoViewController *twoVC = [[StateTwoViewController alloc]init];
    UINavigationController *naVC= [[UINavigationController alloc]initWithRootViewController:twoVC];
            twoVC.receiver = moel.dnumber;
    [self presentViewController:naVC animated:YES completion:^{

    }];
    
    
    
}


- (void)requestData{
    NSString *str = @"http://www.enuo120.com/index.php/phone/Json/Promise?username=%@&pro=%@";
    NSUserDefaults *userDe =[NSUserDefaults standardUserDefaults];
    NSString *name = [userDe objectForKey: @"name"];
    NSString *url = [NSString stringWithFormat:str,name,self.receiver];
    AFHTTPSessionManager *manger = [AFHTTPSessionManager  manager];
    [manger GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          NSLog(@"re = %@",responseObject);
        [self handleWithDic:responseObject];
      
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)handleWithDic:(NSDictionary *)dic{
    if ([dic[@"data"]isKindOfClass:[ NSNull class]]) {
        [self creatnullView];
    }else{
    NSArray *arr = dic[@"data"];
    for (NSDictionary *temp in arr) {
        StateOneModel *model =[StateOneModel stateOneModelInitWithDic:temp];
        [self.dataArray addObject:model];
        self.dnlabel.text = model.dnumber;
        self.hospitalLabel.text = model.hospital;
        self.priceLabel.text =model.price;
        self.jblabel.text = model.jb;
        NSString *str = [model.understand stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\n"];
        self.liangjieLabel.text = str;
        self.stateLabel.text = model.pay_statue;
        NSString *str1 = [model.effectt stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\n"];
        self.liaoXlabel.text = str1;
        self.cycleLabel.text = model.cycle;
        
        
    }
    }
}
- (void)creatnullView{
    UILabel *nullLabel = [[UILabel alloc]init];
    UIView *avIEW = [[UIView alloc]init];
    avIEW.backgroundColor = [UIColor whiteColor];
    nullLabel.text = @"暂无数据";
    nullLabel.textColor = [UIColor lightGrayColor];
    nullLabel.font = [UIFont systemFontOfSize:24];
    [avIEW addSubview:nullLabel];
    __weak typeof(self) weakSelf = self;
    
    [nullLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(avIEW);
        make.centerY.equalTo (avIEW).with.offset(-100);
        
    }];
    self.view = avIEW;
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
