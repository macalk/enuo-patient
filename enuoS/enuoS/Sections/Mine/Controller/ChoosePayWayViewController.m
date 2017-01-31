//
//  ChoosePayWayViewController.m
//  enuoS
//
//  Created by apple on 16/11/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ChoosePayWayViewController.h"
#import "PayDetailViewController.h"
#import "SureWeiXinModel.h"
#import "PayViewController.h"
#import "BaseRequest.h"
#import "RSAEncryptor.h"
#import "ALiPayModel.h"
#import "DataSigner.h"
#import "Macros.h"
#import "SZKAlterView.h"

#import "DataSigner.h"

#import "WXApi.h"
#import "LLPayUtil.h"
#import <AlipaySDK/AlipaySDK.h>

@interface ChoosePayWayViewController ()<UIAlertViewDelegate,LLPaySdkDelegate>

@property (nonatomic,strong)NSMutableDictionary *infoMutableDic;

@property (nonatomic,strong)NSArray *imageArr;

@property (nonatomic,strong)BaseRequest *request;

@property (nonatomic,strong)UIButton *selectBtn;//选中支付方式

@property (nonatomic,strong)NSString *publickKey;
@property (nonatomic,strong)NSString *resever;

//连连参数
@property (nonatomic,strong)NSString *notify_url;
@property (nonatomic,strong)NSString *orderNo;
@property (nonatomic,strong)NSString *fee;


//支付宝参数
@property (nonatomic,strong)NSString *sign;
@property (nonatomic,strong)NSMutableDictionary *aliDataDic;
@property (nonatomic,strong)NSString *orderSpec;





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

@implementation ChoosePayWayViewController

- (NSMutableDictionary *)aliDataDic {
    if (!_aliDataDic) {
        _aliDataDic = [NSMutableDictionary dictionary];
    }return _aliDataDic;
}
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

- (NSMutableDictionary *)infoMutableDic {
    if (!_infoMutableDic) {
        _infoMutableDic = [NSMutableDictionary dictionary];
    }return _infoMutableDic;
}

- (BaseRequest *)request {
    if (!_request) {
        _request = [[BaseRequest alloc]init];
    }return _request;
}


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"绿色返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleWithBack:)];
        self.navigationItem.title =@"选择支付方式";
        self.navigationItem.leftBarButtonItem = leftItem;
        
    }return self;
}

- (void)handleWithBack:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.imageArr = @[self.firstImageView,self.secondImageView,self.thirdImageView];
    
    [self getPublicKey];//获得公钥
    
    self.view.backgroundColor = [UIColor whiteColor];

}


- (void)getPublicKey {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:@"http://www.enuo120.com/Public/rsa/pub.key" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",str);
        self.publickKey = str;
        
        //利用公钥对订单RSA加密
        [self RSAEncryptor];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"shibai!!!");
        
    }];
    
    
    
}
//RSA加密
- (void)RSAEncryptor {
    
    self.infoMutableDic = [NSMutableDictionary dictionaryWithDictionary:self.infoDic];
    
    NSString *dnumber =  self.infoMutableDic[@"dnumber"];
    
    //使用字符串格式的公钥私钥加密解密
    NSString *encryptStr = [RSAEncryptor encryptString:dnumber publicKey:self.publickKey];
    
    [self.infoMutableDic setObject:encryptStr forKey:@"dnumber"];
    
    
}


//选择支付银行按钮
- (IBAction)payBtnClick:(UIButton *)sender {
    for (int i = 0; i<3; i++) {
        UIImageView *imageView = self.imageArr[i];
        if (sender.tag-10 == i ) {
            imageView.image = [UIImage imageNamed:@"支付_选中"];
        }else {
            imageView.image = [UIImage imageNamed:@"支付_未选中"];
        }
    }
    
    self.selectBtn = sender;
    
    switch (sender.tag) {
        case 10:
        {//微信支付
            /******直接在确认支付按钮里操作了******/
        }
            break;
        case 11:
        {//银行卡支付
            [self bankCardPay];
        }
            break;
        case 12:
        {//支付宝支付
            [self ALiPay];
        }
            break;
            
        default:
            break;
    }

    
}



//微信支付
- (void)WXPay {
    
    [self.request POST:@"http://www.enuo120.com/index.php/app/Payment/wx_pay" params:self.infoMutableDic success:^(NSURLSessionDataTask *task, id responseObject) {
        
                [self handleWXWithData:responseObject];
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"失败啊啊啊啊");
    }];

}

//银行卡支付
- (void)bankCardPay {
    
    NSLog(@"%@",self.infoMutableDic);
    
    
    
    
//    [self.infoMutableDic setObject:inforOrder forKey:@"info_order"];
    
    [self.request POST:@"http://www.enuo120.com/index.php/app/Payment/ll_pay" params:self.infoMutableDic success:^(NSURLSessionDataTask *task, id responseObject) {
        
        self.notify_url = responseObject[@"data"][@"notify_url"];
        self.orderNo = responseObject[@"data"][@"orderNo"];
        self.fee = self.infoMutableDic[@"fee"];
        
        self.orderDic = [self createOrder];
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"失败啊啊啊啊");
    }];
}

//支付宝支付
- (void)ALiPay {
    
    self.aliDataDic = [NSMutableDictionary dictionaryWithDictionary:[self AliPayDataDic]];
    NSLog(@"%@",self.aliDataDic);
    [self.request POST:@"http://www.enuo120.com/index.php/app/Payment/ali_pay" params:self.aliDataDic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        NSLog(@"%@",responseObject[@"data"][@"encode_url"]);
        NSLog(@"%@",responseObject[@"data"][@"url"]);
        NSString *sign = responseObject[@"data"][@"encode_url"];
        self.sign = sign;
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"失败啊啊啊啊");
    }];
}

//确认支付按钮
- (IBAction)surePayBtnClick:(UIButton *)sender {
    
    if (self.selectBtn.tag == 10) {//微信支付
        if ([WXApi isWXAppInstalled]&&[WXApi isWXAppSupportApi]) {
            
            [self WXPay];
            
            if (self.dataWXArr.count !=0) {
            }else{
                NSLog(@"没有事，没有值");
            }
            
        }else if(![WXApi isWXAppSupportApi]&&[WXApi isWXAppInstalled]){
            UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeigth)];
            bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
            [self.view addSubview:bgView];
            
            SZKAlterView *alterView = [SZKAlterView alterViewWithTitle:@"提示" content:@"微信版本不支持" cancel:@"取消" sure:@"确定" cancelBtClcik:^{
                [bgView removeFromSuperview];
            } sureBtClcik:^{
                [bgView removeFromSuperview];
            }];
            [bgView addSubview:alterView];
            
        }else {
            UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeigth)];
            bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
            [self.view addSubview:bgView];
            
            SZKAlterView *alterView = [SZKAlterView alterViewWithTitle:@"提示" content:@"没有装微信" cancel:@"取消" sure:@"确定" cancelBtClcik:^{
                [bgView removeFromSuperview];
            } sureBtClcik:^{
                [bgView removeFromSuperview];
            }];
            [bgView addSubview:alterView];
        }
        
    }else if(self.selectBtn.tag == 11) {//连连支付
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
        
    }else if (self.selectBtn.tag == 12){//支付宝支付
        
        //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
        NSString *appScheme = @"enuoS";
        
        NSLog(@"%@",self.sign);
        
        //支付宝支付成功并回调
            [[AlipaySDK defaultService] payOrder:self.sign fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                
                NSLog(@"%@",resultDic);
                
                [self.navigationController popViewControllerAnimated:YES];
//                UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeigth)];
//                bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
//                SZKAlterView *alterView = [SZKAlterView alterViewWithTitle:@"提示" content:@"支付成功" cancel:@"取消" sure:@"确认" cancelBtClcik:^{
//                    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
//                } sureBtClcik:^{
//                    [self.navigationController popViewControllerAnimated:YES];
//                }];
//                [bgView addSubview:alterView];
//                [self.view addSubview:bgView];
                
            }];
        


    }else {
        NSLog(@"请选择支付方式");
    }
    
    
    
}
- (NSString*)urlEncodedString:(NSString *)string
{
    NSString * encodedString = (__bridge_transfer  NSString*) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)string, NULL, (__bridge CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8 );
    
    return encodedString;
}


              /*********************以下为支付代码************************/



static NSString *kLLOidPartner = @"201603311000791507";   // 商户号
static NSString *kLLPartnerKey = @"201604011433_hzjn_qbz";   // 密钥




//连连支付需要发送的参数
- (NSMutableDictionary*)createOrder{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *name = [userDefault objectForKey:@"name"];
    
//    NSString *partnerPrefix = @"LL"; // TODO: 修改成自己公司前缀
    
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
    
    NSString *inforOrder = [NSString stringWithFormat:@"%@|%@|%@",self.infoDic[@"is_check"],self.infoDic[@"dnumber"],self.infoDic[@"step"]];
    
    [param setDictionary:@{
                           @"sign_type":signType,
                           //签名方式	partner_sign_type	是	String	RSA  或者 MD5
                           @"busi_partner":@"101001",
                           //商户业务类型	busi_partner	是	String(6)	虚拟商品销售：101001
                           @"dt_order":simOrder,
                           //商户订单时间	dt_order	是	String(14)	格式：YYYYMMDDH24MISS  14位数字，精确到秒
                           //                           @"money_order":@"0.10",
                           //交易金额	money_order	是	Number(8,2)	该笔订单的资金总额，单位为RMB-元。大于0的数字，精确到小数点后两位。 如：49.65
                           @"money_order" :self.fee,
                           
                           @"no_order":self.orderNo,
                           //商户唯一订单号	no_order	是	String(32)	商户系统唯一订单号
                           @"name_goods":@"订单名",
                           //商品名称	name_goods	否	String(40)
                           @"info_order":inforOrder,
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
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
        self.alert = [[UIAlertView alloc]initWithTitle:@"提示" message:_msg delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
        self.alert.delegate =self;
        [self performSelector:@selector(popVC) withObject:nil afterDelay:0.5];
        
    }else{
        self.alertView = [UIAlertController alertControllerWithTitle:@"提示" message:_msg preferredStyle:UIAlertControllerStyleAlert];
        [self.alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //NSLog(@"arr = %@",_arr);
            if ([_msg isEqualToString:@"支付成功"]) {
                
                [self.navigationController popViewControllerAnimated:YES];
                
//                PayDetailViewController *payVC = [[PayDetailViewController alloc]init];
//                UINavigationController *naVC = [[UINavigationController alloc]initWithRootViewController:payVC];
//                [self presentViewController:naVC animated:YES completion:^{
//                    NSLog(@"汤五爷在此！尔等前来受死！");
//                    
//                }];
//                payVC.resever = self.passNo;
                
                
                [self.navigationController popViewControllerAnimated:YES];
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



//微信支付数据
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


//阿里支付数据dic
- (NSDictionary *)AliPayDataDic {
    
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyyMMddHHmmss"];
    NSString *simOrder = [dateFormater stringFromDate:[NSDate date]];
    NSInteger a =   arc4random() %(999999-100000+1)+100000;
    self.passNo = [NSString stringWithFormat:@"no%ld_%@",(long)a,simOrder];
    
    NSString *price = self.infoDic[@"fee"];
    NSString *ill = self.infoDic[@"body"];
    
    NSString *dnumber = self.infoDic[@"dnumber"];
    NSLog(@"%@",dnumber);
    
    NSString *prefer = self.infoDic[@"prefer"];
    NSString *step = self.infoDic[@"step"];
    NSString *isCheck = self.infoDic[@"is_check"];
    
    [dateFormater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *nowDateStr = [dateFormater stringFromDate:[NSDate date]];
    
    ALiPayModel *model = [[ALiPayModel alloc]init];
    
    model.app_id = @"2016110102456427";
    model.passback_params = [NSString stringWithFormat:@"%@|%@|%@",isCheck,dnumber,step];
    model.charset = @"utf-8";
    model.method = @"alipay.trade.app.pay";
    model.notify_url = @"http://www.enuo120.com/index.php/app/Payment/ali_query";
    model.sign_type = @"RSA";
    model.timestamp = nowDateStr;
    model.version = @"1.0";
    
    model.biz_content = [NSMutableDictionary dictionary];
    [model.biz_content setValue:@"30m" forKey:@"timeout_express"];
    [model.biz_content setValue:@"QUICK_MSECURITY_PAY" forKey:@"product_code"];
    [model.biz_content setValue:price forKey:@"total_amount"];
    [model.biz_content setValue:ill forKey:@"subject"];
    [model.biz_content setValue:@"11" forKey:@"body"];
    [model.biz_content setValue:dnumber forKey:@"dnumber"];
    [model.biz_content setValue:isCheck forKey:@"is_check"];
    [model.biz_content setValue:self.passNo forKey:@"out_trade_no"];
    
    if ([self.status isEqualToString:@"确认治疗"]) {
        [model.biz_content setValue:prefer forKey:@"prefer"];
        [model.biz_content setValue:step forKey:@"step"];
    }
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:model.biz_content options:0 error:nil];
    NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    //拼接成字符串
    self.orderSpec = [model description];
    NSLog(@"%@",self.orderSpec);
    
    NSDictionary *dic = @{@"app_id":model.app_id,@"biz_content":str,@"passback_params":model.passback_params,@"charset":model.charset,@"method":model.method,@"notify_url":model.notify_url,@"sign_type":model.sign_type,@"timestamp":model.timestamp,@"version":model.version};
    
    return dic;
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
