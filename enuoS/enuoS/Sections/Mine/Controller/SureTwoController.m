//
//  SureTwoController.m
//  enuo4
//
//  Created by apple on 16/4/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SureTwoController.h"
#import <AFNetworking.h>
#import "Macros.h"
#import "SureTwoModel.h"
#import "LrdAlertTabeleView.h"
#import "WXApi.h"
#import "SureWeiXinModel.h"
#import "PayViewController.h"
#import "RootTabBarViewController.h"
#import <SVProgressHUD.h>
#import "ZxdAlertTabeleView.h"
@interface SureTwoController ()<ZxdAlertTabeleViewDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *doctorLabel;
@property (weak, nonatomic) IBOutlet UILabel *illLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *monryLabel;
@property (weak, nonatomic) IBOutlet UILabel *howLabel;
@property (weak, nonatomic) IBOutlet UILabel *needpayLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property (nonatomic,strong)NSArray *dataArr;
@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic,copy)NSString *quanStr;
@property (nonatomic,copy)NSString *quanUrl;
@property (nonatomic,copy)NSArray *quanArr;
@property (nonatomic,copy)NSString *moneyStr;
@property (nonatomic,copy)NSArray *moneyArr;
@property (nonatomic,copy)NSString *payIii;
@property (nonatomic,strong)NSMutableArray *weiXinArr;
@property (nonatomic,copy)NSString *strUrl;
@property (nonatomic,copy)NSString *singeKim;

@property (nonatomic,strong)NSArray *pidArr;
@property (nonatomic,copy)NSString *pidStr;
@end

@implementation SureTwoController


- (NSArray *)pidArr{
    if (!_pidArr) {
        self.pidArr = [NSArray array];
    }return _pidArr;
}

- (NSMutableArray *)weiXinArr{
    if (!_weiXinArr) {
        self.weiXinArr = [NSMutableArray array];
    }return _weiXinArr;
}



- (NSArray *)moneyArr{
    if (!_moneyArr) {
        self.moneyArr = [NSArray array];
        
    }return _moneyArr;
}


- (NSArray *)quanArr{
    if (!_quanArr) {
        self.quanArr = [NSArray array];
    }return _quanArr;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }return _dataSource;
}


- (NSArray *)dataArr{
    if (!_dataArr ) {
        self.dataArr = [NSArray array];
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
    self.navigationItem.title = @"确认约定";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航条底图"] forBarMetrics:0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [SVProgressHUD show];
    // Do any additional setup after loading the view from its nib.
    [self creatView];
    [self requestData];
}



- (void)handleWithBack:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)creatView{
  
    [self.selectButton setTitle:@"请选择" forState:UIControlStateNormal];
};
- (void)sendeId:(NSInteger)row{
    if (self.dataSource.count != 0) {
          SureTwoModel *model = self.dataSource[0];
        self.quanStr = self.dataArr[row];
        self.quanUrl = self.quanArr[row];
        self.moneyStr = self.moneyArr[row];
         self.pidStr = self.pidArr[row];
        float a = [model.pay_money floatValue] -[self.moneyStr floatValue] ;
        if (a<0) {
            self.needpayLabel.text = @"¥0";
        }else {
            self.needpayLabel.text = [NSString stringWithFormat:@"¥%.2f",a];
        }
        
        [self.selectButton setTitle:self.quanStr forState:UIControlStateNormal];
    }
}

- (IBAction)handleSelecteWith:(UIButton *)sender {
    
    ZxdAlertTabeleView*lrdVC = [[ZxdAlertTabeleView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeigth)];
    lrdVC.mydelegate = self;
    if (self.dataSource.count !=0) {
        SureTwoModel *model = self.dataSource[0];

        self.moneyArr = [model.money componentsSeparatedByString:@","];
        self.quanArr = [model.pid componentsSeparatedByString:@","];
        self.dataArr = [model.name componentsSeparatedByString:@","];
        self.pidArr = [model.pid componentsSeparatedByString:@","];
        lrdVC.dataArray = self.dataArr;
    }
    [lrdVC pop];
}
- (IBAction)handleSureWith:(UIButton *)sender {
     NSString * set =[self.needpayLabel.text substringFromIndex:1];
    
    if([set isEqualToString:@"0"]){
    
        [self requestZroData];
    
    }else{

    SureTwoModel *model = self.dataSource[0];
    
    NSString *str = @"http://www.enuo120.com/index.php/phone/Json/appid?pay_total=%ld&extra=%@;%@;%@*0";
    NSString *st1 = [self.needpayLabel.text substringFromIndex:1];
    NSInteger st = [st1 floatValue] *100;
    if (self.quanUrl == NULL) {
        self.quanUrl = @"0";
    }
    self.strUrl = [NSString stringWithFormat:str,st,model.cid,self.quanUrl,model.step];
    NSString *str1 = @"%@;%@;%@*0";
    self.singeKim = [NSString stringWithFormat:str1,model.cid,self.quanUrl,model.step];
    NSLog(@"strurl = %@",_strUrl);
    
    
    
    
    PayViewController *payVC = [[PayViewController alloc]init];
    payVC.twoUrl = self.strUrl;
    NSLog(@"two.strurl = %@",self.strUrl);
    NSString * set =[self.needpayLabel.text substringFromIndex:1];
        NSLog(@"Oneset = %@",set);
    payVC.oneUrl = set;
    payVC.threeUrl = self.singeKim;
      NSLog(@"three.strurl = %@",self.singeKim);
    [self.navigationController pushViewController:payVC animated:YES];
    
    
    }
    
}
//余额为零 直接支付完成
- (void)requestZroData{
     RootTabBarViewController *rooVC = [[RootTabBarViewController alloc]init];
      SureTwoModel *model = self.dataSource[0];
    NSString *str = @"http://www.enuo120.com/index.php/phone/Json/pay?payid=%@&step=%@&prefer=%@";
    
    NSString *url = [NSString stringWithFormat:str,model.cid,model.step,self.pidStr];
    
    
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"支付成功" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
                alert.delegate = self;
                [alert show];
            }else{
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"支付成功" preferredStyle:UIAlertControllerStyleAlert];
                [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self presentViewController:rooVC animated:YES completion:^{
                        
                    }];
                }]];
                [self presentViewController:alertView animated:YES completion:^{
                    
                }];
            }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
}



- (void)requestWIXData{
    SureTwoModel *model = self.dataSource[0];
    
    NSString *str = @"http://www.enuo120.com/index.php/phone/Json/appid?pay_total=%ld&extra=%@;%@;%@*0";
    NSInteger st = [self.needpayLabel.text floatValue] *100;
    if (self.quanUrl ==NULL) {
        self.quanUrl = @"0";
    }
   self.strUrl = [NSString stringWithFormat:str,st,model.cid,self.quanUrl,model.step];
    NSLog(@"strurl = %@",_strUrl);
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger GET:_strUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleWeixinWithDic:responseObject];
        NSLog(@"responseObject = %@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
    
    
}


- (void)handleWeixinWithDic:(NSDictionary *)dic{
    NSArray *arr = dic[@"data"];
    for (NSDictionary *temp in arr) {
        SureWeiXinModel *model = [SureWeiXinModel sureWXWithDic:temp];
        [self.weiXinArr  addObject:model];
      //  SureWeiXinModel *model =  self.weiXinArr[0];
        PayReq *request = [[PayReq alloc] init];
        
        /** 商家向财付通申请的商家id */
        request.partnerId = model.partnerid;
        /** 预支付订单 */
        request.prepayId = model.prepayid;
        //  request.prepayId= @"82010380001603250865be9c4c063c30";
        /** 商家根据财付通文档填写的数据和签名 */
        request.package = model.package;
        /** 随机串，防重发 */
        request.nonceStr= model.noncestr;
        /** 时间戳，防重发 */
        request.timeStamp= [model.timestamp intValue] ;
        /** 商家根据微信开放平台文档对数据做的签名 */
        request.sign= model.sign;
        /*! @brief 发送请求到微信，等待微信返回onResp
         *
         * 函数调用后，会切换到微信的界面。第三方应用程序等待微信返回onResp。微信在异步处理完成后一定会调用onResp。支持以下类型
         * SendAuthReq、SendMessageToWXReq、PayReq等。
         * @param req 具体的发送请求，在调用函数后，请自己释放。
         * @return 成功返回YES，失败返回NO。
         */
        [WXApi sendReq: request];

    }
}
- (void)requestData{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *name = [userDefaults objectForKey:@"name"];
    NSString *str = @"http://www.enuo120.com/index.php/phone/Json/penuo?username=%@&pro=%@";
    NSString *url = [NSString stringWithFormat:str,name,self.receiver];
    NSLog(@"urururrururu = %@",url);
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleGetWithRecponseObject:responseObject];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}

- (void)handleGetWithRecponseObject:(NSDictionary *)data{
    NSArray *arr = data[@"data"];
    for (NSDictionary *temp in arr) {
        SureTwoModel *model = [SureTwoModel sureTwoModelWithDic:temp];
        [self.dataSource addObject:model];
        self.timeLabel.text = model.date;
        self.doctorLabel.text = model.doctor_name;
        self.illLabel.text = model.jb;
        self.priceLabel.text = [NSString stringWithFormat:@"¥%@",model.price];
        self.howLabel.text = model.pay_method;
        self.monryLabel.text =[NSString stringWithFormat:@"¥%@", model.pay_money];
   
 
            self.needpayLabel.text = [NSString stringWithFormat:@"¥%@", model.pay_money];
     
       
    
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    RootTabBarViewController *rooVC = [[RootTabBarViewController alloc]init];

    switch (buttonIndex) {
        case 0:
          [self presentViewController:rooVC animated:YES completion:^{
              
          }];
            break;
            
        default:
            break;
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
