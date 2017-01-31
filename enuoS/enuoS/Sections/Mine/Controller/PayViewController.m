//
//  PayViewController.m
//  enuo4
//
//  Created by apple on 16/4/27.
//  Copyright © 2016年 apple. All rights reserved.
//
#import "PayDetailViewController.h"
#import "PayViewController.h"
#import "Macros.h"
#import <AFNetworking.h>
#import "SureWeiXinModel.h"
#import "WXApi.h"
//#import "LLPaySdk.h"
#import "LLPayUtil.h"
@interface PayViewController ()<UIAlertViewDelegate>
@property (nonatomic,strong )UIButton *oneButton;
@property (nonatomic,strong)UIButton *twoButton;
@property (nonatomic,strong)UILabel *oneLabel;
@property (nonatomic,strong)UILabel *twoLabel;
@property (nonatomic,strong)UIButton *threeButton;
@property (nonatomic,strong)NSMutableArray *dataWXArr;
@property (nonatomic,copy)NSString *strTocken;
@property (nonatomic,copy)NSMutableDictionary *orderDic;

@property (nonatomic,strong)  UIAlertView *alert;

@property (nonatomic,strong)UIAlertController *alertView;

@property (nonatomic,copy)NSString *passNo;
@property (nonatomic,copy)NSString *msg;

@end

@implementation PayViewController

- (NSMutableDictionary *)orderDic{
    if (!_orderDic) {
        self.orderDic = [NSMutableDictionary dictionaryWithCapacity:1];
    }return _orderDic;
}

- (NSMutableArray *)dataWXArr{
    if (!_dataWXArr) {
        self.dataWXArr = [NSMutableArray array];
    }return _dataWXArr;
}

static NSString *kLLOidPartner = @"201603311000791507";   // 商户号
static NSString *kLLPartnerKey = @"201604011433_hzjn_qbz";   // 密钥

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"绿色返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleWithBack:)];
        self.navigationItem.leftBarButtonItem = leftItem;
    }return self;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航条底图"] forBarMetrics:0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    self.navigationItem.title =@"支付方式";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    [self creatView];
    self.orderDic = [self createOrder];
    NSLog(@"self.oneUrl = %@",self.oneUrl);
    NSLog(@"self.twoUrl = %@",self.twoUrl);
    NSLog(@"self.threeUrl = %@",self.threeUrl);
    // Do any additional setup after loading the view from its nib.
}

- (void)handleWithBack:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)creatView{
    
    
    self.oneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.twoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.threeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.oneButton addTarget:self action:@selector(handleOneButtonWith:) forControlEvents:UIControlEventTouchUpInside];
    [self.twoButton  addTarget:self action:@selector(handleTwoButtonWith:) forControlEvents:UIControlEventTouchUpInside];
    [self.threeButton addTarget:self action:@selector(handleThreeButtonWith:) forControlEvents:UIControlEventTouchUpInside];
    self.oneButton .frame = CGRectMake(20, 20, 30, 30);
    self.twoButton.frame = CGRectMake(20,60, 30, 30);
    self.oneLabel = [[UILabel alloc]initWithFrame:CGRectMake(55, 20,kScreenWidth - 40, 30)];
    self.twoLabel = [[UILabel alloc]initWithFrame:CGRectMake(55, 60, kScreenWidth - 40, 30)];
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 55, kScreenWidth, 1)];
    image.image = [UIImage imageNamed:@"com_02"];
    UIImageView *image2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 95, kScreenWidth, 1)];
    image2.image = [UIImage imageNamed:@"com_02"];
    self.threeButton.frame = CGRectMake(10, 120, kScreenWidth - 20, 40);
    self.oneLabel.text = @"银行卡支付";
    self.twoLabel.text = @"微信支付";
    self.oneLabel.textAlignment = NSTextAlignmentLeft;
    self.twoLabel.textAlignment = NSTextAlignmentLeft;
    [self.threeButton setTitle:@"支    付" forState:UIControlStateNormal];
    [self.oneButton setImage:[UIImage imageNamed:@"rb_uncheck"] forState:UIControlStateNormal];
    [self.twoButton setImage:[UIImage imageNamed:@"rb_uncheck"] forState:UIControlStateNormal];
    self.threeButton.backgroundColor =  [UIColor colorWithRed:0/255.0 green:179/255.0 blue:163/255.0 alpha:1];

    [self.view addSubview:image2];
    [self.view addSubview:image];
    [self.view addSubview:self.oneButton];
    [self.view addSubview:self.twoButton];
    [self.view addSubview:self.oneLabel];
    [self.view addSubview:self.twoLabel];
    [self.view addSubview:self.threeButton];
    
    
    
    
}
//连连支付
- (void)handleOneButtonWith:(UIButton *)sender{
    self.strTocken = @"0";
    [sender setImage:[UIImage imageNamed:@"rb_check"] forState:UIControlStateNormal];
    [self.twoButton setImage:[UIImage imageNamed:@"rb_uncheck"] forState:UIControlStateNormal];
    
}
- (NSMutableDictionary*)createOrder{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *name = [userDefault objectForKey:@"name"];
    
    NSString *partnerPrefix = @"LL"; // TODO: 修改成自己公司前缀
    
    NSString *signType = @"MD5";    // MD5 || RSA || HMAC
    
    NSString *user_id = name; //
    NSLog(@"%@",user_id);
    // user_id，一个user_id标示一个用户
    // user_id为必传项，需要关联商户里的用户编号，一个user_id下的所有支付银行卡，身份证必须相同
    // demo中需要开发测试自己填入user_id, 可以先用自己的手机号作为标示，正式上线请使用商户内的用户编号
    
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyyMMddHHmmss"];
    NSString *simOrder = [dateFormater stringFromDate:[NSDate date]];
    NSInteger a =   arc4random() %(999999-100000+1)+100000;
    self.passNo = [NSString stringWithFormat:@"no%ld%@",(long)a,simOrder];
    NSLog(@"self.passNo------------ =%@",self.passNo);
    // TODO: 请开发人员修改下面订单的所有信息，以匹配实际需求
    [param setDictionary:@{
                           @"sign_type":signType,
                           //签名方式	partner_sign_type	是	String	RSA  或者 MD5
                           @"busi_partner":@"101001",
                           //商户业务类型	busi_partner	是	String(6)	虚拟商品销售：101001
                           @"dt_order":simOrder,
                           //商户订单时间	dt_order	是	String(14)	格式：YYYYMMDDH24MISS  14位数字，精确到秒
                           //                           @"money_order":@"0.10",
                           //交易金额	money_order	是	Number(8,2)	该笔订单的资金总额，单位为RMB-元。大于0的数字，精确到小数点后两位。 如：49.65
                           @"money_order" : self.fee,
                           
                           @"no_order":self.passNo,
                           //商户唯一订单号	no_order	是	String(32)	商户系统唯一订单号
                           @"name_goods":@"订单名",
                           //商品名称	name_goods	否	String(40)
                           @"info_order":self.orderNo,
                           //订单附加信息	info_order	否	String(255)	商户订单的备注信息
                           @"valid_order":@"10080",
                           //分钟为单位，默认为10080分钟（7天），从创建时间开始，过了此订单有效时间此笔订单就会被设置为失败状态不能再重新进行支付。
                           //                           @"shareing_data":@"201412030000035903^101001^10^分账说明1|201310102000003524^101001^11^分账说明2|201307232000003510^109001^12^分账说明3"
                           // 分账信息数据 shareing_data  否 变(1024)
                           
                           @"notify_url":self.notify_url,
                           //服务器异步通知地址	notify_url	是	String(64)	连连钱包支付平台在用户支付成功后通知商户服务端的地址，如：http://payhttp.xiaofubao.com/back.shtml
                           
                           
                           @"risk_item":[ LLPayUtil jsonStringOfObj:@{@"user_info_dt_register":@"201603251110120"}],
                           //风险控制参数 否 此字段填写风控参数，采用json串的模式传入，字段名和字段内容彼此对应好
                      //   @"risk_item" : [LLPayUtil jsonStringOfObj:@{@"user_info_dt_register":@"20131030122130"}],
                           
                           @"user_id": user_id,
                           //商户用户唯一编号 否 该用户在商户系统中的唯一编号，要求是该编号在商户系统中唯一标识该用户
                           
                           
                           //                           @"flag_modify":@"1",
                           //修改标记 flag_modify 否 String 0-可以修改，默认为0, 1-不允许修改 与id_type,id_no,acct_name配合使用，如果该用户在商户系统已经实名认证过了，则在绑定银行卡的输入信息不能修改，否则可以修改
                           
                           //                           @"card_no":@"6227001540670034271",
                           //银行卡号 card_no 否 银行卡号前置，卡号可以在商户的页面输入
                           
                           //                           @"no_agree":@"2014070900123076",
                           //签约协议号 否 String(16) 已经记录快捷银行卡的用户，商户在调用的时候可以与pay_type一块配合使用
                           }];
    
    
    BOOL isIsVerifyPay = YES;
    
    if (isIsVerifyPay) {
        
        [param addEntriesFromDictionary:@{
                                          @"id_no":@"",
                                          //证件号码 id_no 否 String
                                          @"acct_name":@"",
                                          //银行账号姓名 acct_name 否 String
                                          }];
    }
    
    
    
    
    param[@"oid_partner"] = kLLOidPartner;
    
    
    return param;
}

- (void)pay{
        LLPayUtil *payUtil = [[LLPayUtil alloc] init];
    
    NSDictionary *sigedOrder = [payUtil signedOrderDic:self.orderDic
                                            andSignKey:kLLPartnerKey];
    [LLPaySdk sharedSdk].sdkDelegate = self;
    
    [[LLPaySdk sharedSdk]  presentQuickPaySdkInViewController:self withTraderInfo:sigedOrder];
}
#pragma -mark 支付结果 LLPaySdkDelegate
// 订单支付结果返回，主要是异常和成功的不同状态
// TODO: 开发人员需要根据实际业务调整逻辑
- (void)paymentEnd:(LLPayResult)resultCode withResultDic:(NSDictionary *)dic
{
    self.msg = @"支付异常";
    switch (resultCode) {
        case kLLPayResultSuccess:
        {
            _msg = @"支付成功";
            
            NSString* result_pay = dic[@"result_pay"];
            if ([result_pay isEqualToString:@"SUCCESS"])
            {
                //
                //NSString *payBackAgreeNo = dic[@"agreementno"];
                // TODO: 协议号
            }
            else if ([result_pay isEqualToString:@"PROCESSING"])
            {
                _msg = @"支付单处理中";
            }
            else if ([result_pay isEqualToString:@"FAILURE"])
            {
                _msg = @"支付单失败";
            }
            else if ([result_pay isEqualToString:@"REFUND"])
            {
               _msg = @"支付单已退款";
            }
        }
            break;
        case kLLPayResultFail:
        {
            _msg = @"支付失败";
        }
            break;
        case kLLPayResultCancel:
        {
           _msg = @"支付取消";
        }
            break;
        case kLLPayResultInitError:
        {
            _msg = @"sdk初始化异常";
        }
            break;
        case kLLPayResultInitParamError:
        {
            _msg = dic[@"ret_msg"];
        }
            break;
        default:
            break;
    }
    
   // NSString *showMsg = [msg stringByAppendingString:[LLPayUtil jsonStringOfObj:dic]];
    
//    [[[UIAlertView alloc] initWithTitle:@"结果"
//                                message:showMsg
//                               delegate:nil
//                      cancelButtonTitle:@"确认"
//                      otherButtonTitles:nil] show];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
        self.alert = [[UIAlertView alloc]initWithTitle:@"提示" message:_msg delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
        self.alert.delegate =self;
        [self performSelector:@selector(popVC) withObject:nil afterDelay:0.5];
        
    }else{
        self.alertView = [UIAlertController alertControllerWithTitle:@"提示" message:_msg preferredStyle:UIAlertControllerStyleAlert];
        [self.alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //NSLog(@"arr = %@",_arr);
            if ([_msg isEqualToString:@"支付成功"]) {
                PayDetailViewController *payVC = [[PayDetailViewController alloc]init];
                UINavigationController *naVC = [[UINavigationController alloc]initWithRootViewController:payVC];
                [self presentViewController:naVC animated:YES completion:^{
                    NSLog(@"汤五爷在此！尔等前来受死！");
                   
                }];
                 payVC.resever = self.passNo;
            }
            
                   }]];
        [self performSelector:@selector(popVCcc) withObject:nil afterDelay:0.5];
        
    }
}


- (void)popVCcc{
    [self presentViewController:_alertView animated:YES completion:^{
        
    }];
}
- (void)popVC{
    [_alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    PayDetailViewController *payVC = [[PayDetailViewController alloc]init];
    UINavigationController *naVC = [[UINavigationController alloc]initWithRootViewController:payVC];
    
    
    switch (buttonIndex) {
        case 0:
            
            
            
              if ([_msg isEqualToString:@"支付成功"]) {
    [self presentViewController:naVC animated:YES completion:^{
    
}];
            payVC.resever = self.passNo;
              }else{
                  NSLog(@"kakkaka");
              }
            break;
            
        default:
            break;
    }
}



//微信支付
- (void)handleTwoButtonWith:(UIButton *)sender{
    self.strTocken = @"1";
    [sender setImage:[UIImage imageNamed:@"rb_check"] forState:UIControlStateNormal];
    [self.oneButton setImage:[UIImage imageNamed:@"rb_uncheck"] forState:UIControlStateNormal];
    
}
//确认提交付款！
- (void)handleThreeButtonWith:(UIButton *)sender{
    if ([self.strTocken isEqualToString:@"0"]) {
        
        LLPayUtil *payUtil = [[LLPayUtil alloc] init];
        
        // 进行签名
        NSDictionary *signedOrder = [payUtil signedOrderDic:self.orderDic
                                                 andSignKey:kLLPartnerKey];
        
        
        [LLPaySdk sharedSdk].sdkDelegate = self;
        
        // TODO: 根据需要使用特定支付方式
        
        // 快捷支付
        [[LLPaySdk sharedSdk]  presentQuickPaySdkInViewController:self withTraderInfo:signedOrder];
        
        // 认证支付
        // [[LLPaySdk sharedSdk] presentVerifyPaySdkInViewController:self withTraderInfo:signedOrder];
        
        // 预授权
        //[self.sdk presentPreAuthPaySdkInViewController:self withTraderInfo:signedOrder];
        

    }else if([self.strTocken isEqualToString:@"1"]) {
        
            if ([WXApi isWXAppInstalled]&&[WXApi isWXAppSupportApi]) {
                [self requsetTwoData];

        
                if (self.dataWXArr.count !=0) {
                }else{
                    NSLog(@"没有事，没有值");
                }
        
            }else if(![WXApi isWXAppSupportApi]&&[WXApi isWXAppInstalled]){
                NSLog(@"微信版本不支持");
            }else {
                NSLog(@"没有装微信");
            }
    }else{
        NSLog(@"请选择支付方式");
    }
}
- (void)requsetTwoData{

    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger GET:self.twoUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleWXWithData:responseObject];
        NSLog(@"responseObject = %@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
- (void)handleWXWithData:(NSDictionary *)data{
      NSArray *arr=  data[@"data"];
    for (NSDictionary *temp in arr) {
        SureWeiXinModel *model = [SureWeiXinModel sureWXWithDic:temp];
        [self.dataWXArr addObject:model];
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





- (void)requestOneData{
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger GET:self.oneUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}



- (void)handleLianlianPayWithData:(NSDictionary *)data{
    
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
