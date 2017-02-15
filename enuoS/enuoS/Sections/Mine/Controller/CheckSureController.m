//
//  CheckSureController.m
//  enuo4
//
//  Created by apple on 16/5/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CheckSureController.h"
#import <AFNetworking.h>
#import "CheckTwoModel.h"
#import "PayViewController.h"
@interface CheckSureController ()
@property (weak, nonatomic) IBOutlet UILabel *dnumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *check_nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *hospitalLabel;
@property (weak, nonatomic) IBOutlet UILabel *doctor_nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *prepaidLabel;
@property (weak, nonatomic) IBOutlet UILabel *needpayLabel;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (nonatomic,copy)NSString *oneStr;
@property (nonatomic,copy)NSString *twoStr;
@property (nonatomic,copy)NSString *threeStr;
@property (nonatomic,copy)NSString *idStr;
@end

@implementation CheckSureController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"登录返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleWithBack:)];
        self.navigationItem.leftBarButtonItem = leftItem;

    }return self;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *backbutton = [[UIBarButtonItem alloc]init];
    backbutton.title = @"检查详情";
    self.navigationItem.backBarButtonItem = backbutton;
    [self requestData];
}

- (void)handleWithBack:(UIBarButtonItem*)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)requestData{
    NSString *str = @"http://www.enuo120.com/index.php/phone/Json/enuocheck?username=%@&pro=%@";
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *name = [userDefaults objectForKey: @"name"];
    NSString *url = [NSString stringWithFormat:str,name,self.receiver];
    BaseRequest *request = [[BaseRequest alloc]init];
    [request POST:url params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [self handleWithData:responseObject];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}
- (void)handleWithData:(NSDictionary *)data{
    NSArray *arr= data[@"data"];
    for (NSDictionary *temp in arr) {
        CheckTwoModel *model = [CheckTwoModel checkTwoModelWithDic:temp];
        self.dnumberLabel.text= model.dnumber;
        self.timeLabel.text = model.pretime;
        self.check_nameLabel.text = model.check_name;
        self.hospitalLabel.text = model.hospital;
        self.doctor_nameLabel.text = model.doctor_name;
        self.prepaidLabel.text =  [NSString stringWithFormat:@"%@元",model.prepaid];
        self.timeLabel.text = model.pretime;
        self.oneStr = model.prepaid;
        self.idStr = model.cid;
        
    
        self.needpayLabel.text =  [NSString stringWithFormat:@"%@元",model.prepaid];
    }
}

- (IBAction)handleSureBtn:(UIButton *)sender {
    PayViewController *payVC = [[PayViewController alloc]init];
    [self.navigationController pushViewController:payVC animated:YES];
    payVC.oneUrl = self.oneStr;
    NSInteger st = [self.oneStr floatValue] *100;
    payVC.threeUrl = [NSString stringWithFormat:@"%@*1",self.idStr];
    NSString *str= @"http://www.enuo120.com/index.php/phone/Json/appid?pay_total=%ld&extra=%@*1";
    NSString *stOne = [NSString stringWithFormat:str,st,self.idStr];
    payVC.twoUrl = stOne;
    
    
    

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
