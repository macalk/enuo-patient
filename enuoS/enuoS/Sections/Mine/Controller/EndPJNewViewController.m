//
//  EndPJNewViewController.m
//  enuoS
//
//  Created by apple on 16/8/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "EndPJNewViewController.h"

#import <AFNetworking.h>
#import <Masonry.h>
#import "Macros.h"
#import "SYStarRatingView.h"
#import <UIImageView+WebCache.h>
#import "WXApi.h"
#import "SureWeiXinModel.h"
#import "DSMoneyModel.h"
#define IOS8 [[[UIDevice currentDevice]systemVersion] floatValue] >= 8.0
#import "MyPJViewController.h"

@interface EndPJNewViewController ()<StarRatingViewDelegate,UITextViewDelegate,UIAlertViewDelegate,UIActionSheetDelegate>
@property (nonatomic,strong)NSMutableArray *moneyArr;
@property (nonatomic,strong)NSMutableArray *dataWxArr;
@property (nonatomic,copy)NSString *servierStr;
@property (nonatomic,copy)NSString *leveStr;
@property (nonatomic,copy)NSString *hos_servierStr;
@property (nonatomic,copy)NSString *hos_enviorStr;

@property (nonatomic,strong)UIImageView *doc_image;
@property (nonatomic,strong)UIImageView *hos_image;

@property (nonatomic,strong)UILabel *doc_label;
@property (nonatomic,strong)UILabel *hos_label;

@property (nonatomic,copy)NSString *doc_pj;
@property (nonatomic,copy)NSString *hos_pj;

@property (nonatomic,strong)UITextView *doc_textView;
@property (nonatomic,strong)UITextView *hos_textView;

@end

@implementation EndPJNewViewController

- (UITextView *)doc_textView{
    if (!_doc_textView) {
        self.doc_textView = [[UITextView alloc]init];
    }return _doc_textView;
}

- (UITextView *)hos_textView{
    if (!_hos_textView) {
        self.hos_textView = [[UITextView alloc]init];
    }return _hos_textView;
}

- (NSMutableArray *)moneyArr{
    if (!_moneyArr) {
        self.moneyArr =[NSMutableArray array];
    }return _moneyArr;
}


- (NSMutableArray *)dataWxArr{
    if (!_dataWxArr) {
        self.dataWxArr = [NSMutableArray array];
    }return _dataWxArr;
}

- (UIImageView *)doc_image{
    if (!_doc_image) {
        self.doc_image = [[UIImageView alloc]init];
    }return _doc_image;
}
- (UIImageView *)hos_image{
    if (!_hos_image) {
        self.hos_image = [[UIImageView alloc]init];
    }return _hos_image;
}
- (UILabel *)doc_label{
    if (!_doc_label) {
        self.doc_label = [[UILabel alloc]init];
    }return _doc_label;
}

- (UILabel *)hos_label{
    if (!_hos_label) {
        self.hos_label = [[UILabel alloc]init];
    }return _hos_label;
}


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"绿色返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleWithBack:)];
        self.navigationItem.leftBarButtonItem = leftItem;
        self.navigationItem.title = @"发表评价";
        
     
    }return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatableView];
    [self requestData];
    [self creatBttomView];
    [self requestDataMoney];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.navigationItem.titleView.tintColor = [UIColor whiteColor];
     [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航条底图"] forBarMetrics:0];
     self.navigationController.toolbarHidden=NO;
    self.view.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
}

- (void)handleWithBack:(UIBarButtonItem*)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
//金钱取得
- (void)requestDataMoney{
    NSString *url = @"http://www.enuo120.com/index.php/app/patient/doc_money";
    AFHTTPSessionManager *mager = [AFHTTPSessionManager manager];
    [mager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleWithMoneyWith:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)handleWithMoneyWith:(NSDictionary *)dic{
    NSArray *arr = dic[@"data"];
    for (NSDictionary *temp in arr) {
        DSMoneyModel *mondel = [DSMoneyModel dsModelInitWithDic: temp];
        
        [self.moneyArr addObject:mondel];
        
    }
    
}


- (void)creatBttomView{
    UIView *aView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    aView.backgroundColor = [UIColor colorWithRed:0/255.0 green:179/255.0 blue:163/255.0 alpha:1];
    UIButton *Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *orderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [Btn setImage:[UIImage imageNamed:@"黄色赏"] forState:UIControlStateNormal];
    [orderBtn setTitle:@"提交评价" forState:UIControlStateNormal];
    Btn.frame = CGRectMake(0, 0, kScreenWidth/3, 44);
    orderBtn.frame = CGRectMake(kScreenWidth*2/3, 0, kScreenWidth/3, 44);
    [Btn addTarget:self action:@selector(handleWithDS:) forControlEvents:UIControlEventTouchUpInside];
    [orderBtn addTarget:self action:@selector(handleWithSubBtn:) forControlEvents:UIControlEventTouchUpInside];
    [aView addSubview:Btn];
    [aView addSubview:orderBtn];
      [self.navigationController.toolbar addSubview: aView];
}
- (void)handleWithDS:(UIButton *)sender{
    if(IOS8){
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        // Create the actions.
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            NSLog(@"0");
        }];
        for (int i = 0; i<self.moneyArr.count; i ++) {
            DSMoneyModel *model = self.moneyArr[i];
            UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:model.money style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                NSLog(@"1");
                
                if ([WXApi isWXAppInstalled]&&[WXApi isWXAppSupportApi]) {
                    [self requsetTwoData:model.money];
                    
                    
                    if (self.dataWxArr.count !=0) {
                    }else{
                        NSLog(@"没有事，没有值");
                    }
                    
                }else if(![WXApi isWXAppSupportApi]&&[WXApi isWXAppInstalled]){
                    NSLog(@"微信版本不支持");
                }else {
                    NSLog(@"没有装微信");
                }
                
                
                
            }];
            [alertController addAction:destructiveAction];
            
        }
        // Add the actions.
        [alertController addAction:cancelAction];
        
        
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    }else{
        
        UIActionSheet *actionSheet = [[UIActionSheet alloc]init];
        [actionSheet addButtonWithTitle:@"取消"];
        
        for (int i = 0; i<self.moneyArr.count; i ++) {
            DSMoneyModel *model = self.moneyArr[i];
            [actionSheet addButtonWithTitle:model.money];
        }
        
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        [actionSheet showInView:self.view];
    }
    


}

- (void)handleWithSubBtn:(UIButton *)sender{
    [self requestSubPJTextView];
}





- (void)requsetTwoData:(NSString *)sender{
    
    NSString *str = @"http://www.enuo120.com/index.php/app/patient/wx_doc_pay";
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    
    
    NSDictionary *heardBody = @{@"dnumber":self.receiver,@"type":@"apk",@"pay_total":sender};
    NSLog(@"heardBody = %@",heardBody);
    [ manger POST:str parameters:heardBody progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleWXWithData:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
- (void)handleWXWithData:(NSDictionary *)data{
    NSArray *arr=  data[@"data"];
    for (NSDictionary *temp in arr) {
        SureWeiXinModel *model = [SureWeiXinModel sureWXWithDic:temp];
        [self.dataWxArr addObject:model];
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




- (void)creatableView{
    UIView *doc_view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeigth/5)];
    UIView *doc_starView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeigth/5, kScreenWidth, kScreenHeigth/10 +10)];
    UIView *hos_view = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeigth*3/10 + 10, kScreenWidth, kScreenHeigth/5)];
    UIView *hos_starView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeigth*5/10 +10, kScreenWidth, kScreenHeigth/10 +10)];
    self.doc_textView = [[UITextView alloc]init];
    self.hos_textView = [[UITextView alloc]init];
    _doc_textView.layer.borderWidth =1.0;//该属性显示外边框
    _doc_textView.layer.cornerRadius = 6.0;//通过该值来设置textView边角的弧度
    _doc_textView.layer.masksToBounds = YES;
    _doc_textView.delegate = self;
    _doc_textView.text = self.doc_pj;
    _doc_textView.layer.borderColor =[UIColor colorWithRed:245/255.0 green:245/255.5 blue:245/255.0 alpha:1.0].CGColor;
    self.doc_label.font = [UIFont systemFontOfSize:13];
    self.hos_label.font = [UIFont systemFontOfSize:13];
    self.doc_label.textAlignment = NSTextAlignmentCenter;
    self.hos_label.textAlignment = NSTextAlignmentCenter;
    
    _hos_textView.layer.borderColor = [UIColor colorWithRed:245/255.0 green:245/255.5 blue:245/255.0 alpha:1.0].CGColor;
    _hos_textView.layer.borderWidth =1.0;//该属性显示外边框
    _hos_textView.layer.cornerRadius = 6.0;//通过该值来设置textView边角的弧度
    _hos_textView.layer.masksToBounds = YES;
    _hos_textView.delegate = self;
    _hos_textView.text = self.hos_pj;
    
    UILabel *labelone = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 70,  kScreenHeigth/20)];
    UILabel *labelTwo = [[UILabel alloc]initWithFrame:CGRectMake(20, kScreenHeigth/20 +5, 70,  kScreenHeigth/20)];
    UILabel *labelThree= [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 70,  kScreenHeigth/20)];
    UILabel *labelFour = [[UILabel alloc]initWithFrame:CGRectMake(20, kScreenHeigth/20, 70,  kScreenHeigth/20)];
    labelone.text = @"服务评价:";
    labelTwo.text = @"技能评价:";
    labelThree.text = @"环境评价:";
    labelFour.text = @"服务评价:";
    
     labelone.font = [UIFont systemFontOfSize:13];
     labelTwo.font = [UIFont systemFontOfSize:13];
     labelThree.font = [UIFont systemFontOfSize:13];
     labelFour.font = [UIFont systemFontOfSize:13];
    
    SYStarRatingView *syStarRatingViewOne = [[SYStarRatingView alloc]initWithFrame:CGRectMake(100, 0, 100, 20) numberOfStar:5 ];
    SYStarRatingView *syStarRatingViewtwo = [[SYStarRatingView alloc]initWithFrame:CGRectMake(100, kScreenHeigth/20 +5, 100 ,20) numberOfStar:5 ];
    SYStarRatingView *syStarRatingViewThree = [[SYStarRatingView alloc]initWithFrame:CGRectMake(100, 0, 100,20) numberOfStar:5 ];
    SYStarRatingView *syStarRatingViewFour = [[SYStarRatingView alloc]initWithFrame:CGRectMake(100, kScreenHeigth/20 +5, 100, 20) numberOfStar:5 ];
       syStarRatingViewOne.tag = 101;
    syStarRatingViewOne.delegate = self;
    syStarRatingViewOne.foregroundViewColor = [UIColor orangeColor];
    [syStarRatingViewOne setScore:1.0 withAnimation:NO];
 
    
     syStarRatingViewtwo.tag = 102;
    syStarRatingViewtwo.delegate = self;
    syStarRatingViewtwo.foregroundViewColor = [UIColor orangeColor];
    [syStarRatingViewtwo setScore:1.0 withAnimation:NO];
   
    syStarRatingViewThree.tag = 103;
    syStarRatingViewThree.delegate = self;
    syStarRatingViewThree.foregroundViewColor = [UIColor orangeColor];
    [syStarRatingViewThree setScore:1.0 withAnimation:NO];
  
    syStarRatingViewFour.tag = 104;
    syStarRatingViewFour.delegate = self;
    syStarRatingViewFour.foregroundViewColor = [UIColor orangeColor];
    [syStarRatingViewFour setScore:1.0 withAnimation:NO];
   
    
    [doc_starView addSubview:labelone];
    [doc_starView addSubview:labelTwo];
    [doc_starView addSubview:syStarRatingViewOne];
    [doc_starView addSubview:syStarRatingViewtwo];
    
    [hos_starView addSubview:labelThree];
    [hos_starView addSubview:labelFour];
    [hos_starView addSubview:syStarRatingViewThree];
    [hos_starView addSubview:syStarRatingViewFour];
    
    
    
 
    doc_starView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    hos_starView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    //hos_view.backgroundColor = [UIColor greenColor];

    
    [self.view addSubview:doc_view];
    [self.view addSubview:doc_starView];
    [self.view addSubview:hos_view];
    [self.view addSubview:hos_starView];
    [doc_view addSubview:self.doc_label];
    [doc_view addSubview:self.doc_image];
    [doc_view addSubview:self.doc_textView];
    
    
    
    [hos_view addSubview:self.hos_label];
    [hos_view addSubview:self.hos_image];
    [hos_view addSubview:self.hos_textView];
    
    __weak typeof(self) weakSelf = self;
   
//    [doc_view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo (weakSelf.view.mas_left);
//        make.top.equalTo(weakSelf.view.mas_top);
//        make.right.equalTo (weakSelf.view.mas_right);
//        make.height.mas_equalTo(kScreenWidth/5);
//    }];
//    [doc_starView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo (weakSelf.view.mas_left);
//        make.topMargin.equalTo(doc_view.mas_bottom);
//        make.right.equalTo (weakSelf.view.mas_right);
//        make.height.mas_equalTo(kScreenWidth/10);
//    }];
//    [hos_view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo (weakSelf.view.mas_left);
//        make.top.equalTo(doc_starView.mas_bottom);
//        make.right.equalTo (weakSelf.view.mas_right);
//        make.height.mas_equalTo(kScreenWidth/5);
//    }];
//    [hos_starView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo (weakSelf.view.mas_left);
//        make.topMargin.equalTo(hos_view.mas_bottom);
//        make.right.equalTo (weakSelf.view.mas_right);
//        make.height.mas_equalTo(kScreenWidth/10);
//    }];

   
    
    [weakSelf.doc_image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(doc_view.mas_left).with.offset(10);
        make.top.equalTo(doc_view.mas_top).with.offset(5);
        make.width.mas_equalTo(@100);
        make.height.mas_equalTo(@70);
    }];
    [weakSelf.doc_label mas_makeConstraints:^(MASConstraintMaker *make) {
      
        make.left.equalTo(doc_view.mas_left).with.offset(10);
        make.top.equalTo(weakSelf.doc_image.mas_bottom).with.offset(5);
        make.width.mas_equalTo(@100);
        make.height.mas_equalTo(@25);

    }];
   
    [weakSelf.doc_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.doc_image.mas_right).with.offset(10);
        make.right.equalTo(doc_view.mas_right).with.offset(-10);
        make.top.equalTo(doc_view.mas_top).with.offset(10);
        make.bottom.equalTo (doc_view.mas_bottom).with.offset(-10);
    }];
    
    
   
    [weakSelf.hos_image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hos_view.mas_left).with.offset(5);
        make.top.equalTo(hos_view.mas_top).with.offset(10);
        make.width.mas_equalTo(@100);
        make.height.mas_equalTo(@70);
    }];
    [weakSelf.hos_label mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(hos_view.mas_left).with.offset(10);
        make.top.equalTo(weakSelf.hos_image.mas_bottom).with.offset(5);
        make.width.mas_equalTo(@100);
        make.height.mas_equalTo(@40);
        
    }];
    [weakSelf.hos_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.hos_image.mas_right).with.offset(10);
        make.right.equalTo(hos_view.mas_right).with.offset(-10);
        make.top.equalTo(hos_view.mas_top).with.offset(10);
        make.bottom.equalTo (hos_view.mas_bottom).with.offset(-10);
    }];
    
    
    
}


- (void)requestData{
    NSString *url = @"http://www.enuo120.com/index.php/app/patient/pj";
    NSDictionary *headBody = @{@"dnumber":self.receiver};
    AFHTTPSessionManager *mager = [AFHTTPSessionManager manager];
    [mager POST:url parameters:headBody progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleWithData:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

- (void)handleWithData:(NSDictionary *)dic{
    NSDictionary *data = dic[@"data"];
    self.doc_label.text = data[@"doc_name"];
    self.hos_label.text = data[@"hos_name"];
    NSString *str0ne = [NSString stringWithFormat:urlPicture,data[@"doc_photo"][@"doctor_photo"]];
    
    [self.doc_image sd_setImageWithURL:[NSURL URLWithString:str0ne] placeholderImage:nil];
    NSString *strTwo = [NSString stringWithFormat:urlPicture,data[@"hos_photo"][@"hospital_photo"]];
    [self.hos_image sd_setImageWithURL:[NSURL URLWithString:strTwo] placeholderImage:nil];


}

-(void)starRatingView:(SYStarRatingView *)view score:(float)score
{
NSString *str = [NSString stringWithFormat:@"%0.2f",score * 5 ];
    NSLog(@"str = %@",str);
    
    
    if (view.tag == 101) {
        self.servierStr = [NSString stringWithFormat:@"%0.2f",score * 5 ];
        NSLog(@"self.ser = %@",self.servierStr);

    }else if (view.tag == 102){
        self.leveStr = [NSString stringWithFormat:@"%0.2f",score * 5 ];

    }else if (view.tag == 103){
        self.hos_enviorStr = [NSString stringWithFormat:@"%0.2f",score * 5 ];

    }else{
        self.hos_servierStr = [NSString stringWithFormat:@"%0.2f",score * 5 ];

    }
}



- (void)requestSubPJTextView{
    NSString *url = @"http://www.enuo120.com/index.php/app/patient/submit_pj";
    NSLog(@"self.doc = %@",self.doc_textView.text);
    NSLog(@"self.hos = %@",self.hos_textView.text);
    NSLog(@"ser = %@",self.servierStr);
     NSLog(@"ser = %@",self.hos_servierStr);
     NSLog(@"ser = %@",self.leveStr);
    if (![self.doc_pj isEqualToString:@"" ]&&![self.hos_pj isEqualToString:@""]) {
        NSDictionary *heardBody = @{@"dnumber":self.receiver,@"doc_content":self.doc_textView.text,@"hos_content":self.hos_textView.text,@"doc_service":self.servierStr,@"hos_service":self.hos_servierStr,@"level":self.leveStr,@"huanjing":self.hos_enviorStr};
        NSLog(@"heardBoy =%@",heardBody);
        AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
        [manger POST:url parameters:heardBody progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"respon = %@",responseObject);
            [self handleWithSubPj:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"err = %@",error);
        }];
    }else{
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请完成评价" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [alert show];
        }else{
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"请完成评价" preferredStyle:UIAlertControllerStyleAlert];
            [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:alertView animated:YES completion:^{
                
            }];
        }
    }
  
    
}

- (void)handleWithSubPj:(NSDictionary *)dic{
    if ([dic[@"data"][@"message"]isEqualToString:@"评价提交成功"]) {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"评价成功" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [alert show];
        }else{
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"评价成功" preferredStyle:UIAlertControllerStyleAlert];
            [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                MyPJViewController *pjVC = [[MyPJViewController alloc]init];
                [self.navigationController pushViewController:pjVC animated:YES];
            }]];
            [self presentViewController:alertView animated:YES completion:^{
                
            }];
        }

    }else{
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:dic[@"data"][@"message"] delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [alert show];
        }else{
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:dic[@"data"][@"message"] preferredStyle:UIAlertControllerStyleAlert];
            [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:alertView animated:YES completion:^{
                
            }];
        }
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([actionSheet.title isEqualToString:@"取消"]) {
        NSLog(@"五爷五爷五爷！！！！");
    }else{
        if ([WXApi isWXAppInstalled]&&[WXApi isWXAppSupportApi]) {
            [self requsetTwoData:actionSheet.title];
            
            
            if (self.dataWxArr.count !=0) {
            }else{
                NSLog(@"没有事，没有值");
            }
            
        }else if(![WXApi isWXAppSupportApi]&&[WXApi isWXAppInstalled]){
            NSLog(@"微信版本不支持");
        }else {
            NSLog(@"没有装微信");
        }
        
        
    }
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    MyPJViewController *pjVC = [[MyPJViewController alloc]init];
   // [self.navigationController pushViewController:pjVC animated:YES];
    switch (buttonIndex) {
        case 0:
           [self.navigationController pushViewController:pjVC animated:YES];
            break;
            
        default:
            break;
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.doc_textView resignFirstResponder];
    [self.hos_textView resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
