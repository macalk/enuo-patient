//
//  RegisterViewController.m
//  enuoS
//
//  Created by apple on 16/7/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "RegisterViewController.h"
#import "Macros.h"
#import <AFNetworking.h>
#import <Masonry.h>
#import "UIColor+Extend.h"
#import "ReSSSSViewController.h"
#import "RegisterTwoVC.h"
#import "RSAEncryptor.h"


@interface RegisterViewController ()<UITextFieldDelegate,UIAlertViewDelegate>

@property (nonatomic,strong)UITextField *accountTextField;

@property (nonatomic,strong)UITextField *yzCodeText;
@property (nonatomic,strong)UITextField *passText;


@property (nonatomic,strong)NSDictionary *optionDic;//配置项；
@property (nonatomic,copy)NSString *nPhoneField;

@property (nonatomic,strong)UIButton *secButton;

@property (nonatomic,copy)NSString *markStr;
@property (nonatomic,copy)NSString *publickKey;
@property (nonatomic,copy)NSString *rsaAccountStr;



@end

@implementation RegisterViewController





- (NSDictionary *)optionDic{
    if (!_optionDic) {
        self.optionDic = [NSDictionary dictionary];
    }return _optionDic;
}

- (UITextField *)passText{
    if (!_passText) {
        self.passText = [[UITextField alloc]init];
    }return _passText;
}

- (UITextField *)accountTextField {
    if ( !_accountTextField) {
        _accountTextField = [[UITextField alloc]init];
    }return _accountTextField;
    
}


- (UITextField *)yzCodeText{
    if (!_yzCodeText) {
        _yzCodeText = [[UITextField alloc]init];
    }return _yzCodeText;
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
     self.optionDic =@{@"0":@"C",@"1":@"An",@"2":@"H@",@"3":@"D",@"4":@"R",@"5":@"Vc",@"6":@"XZ",@"7":@"J",@"8":@"m",@"9":@"Q"};
    self.markStr = @"1";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:0];
    //    让黑线消失的方法
    self.navigationController.navigationBar.shadowImage=[UIImage new];
    [self getPublicKey];
    [self creatRegisterView];
}

- (void)handleWithBack:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}



- (void)creatRegisterView{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageBelow = [[UIImageView alloc]initWithFrame:self.view.frame];
    
    [self.view addSubview: imageBelow];
    
    imageBelow.userInteractionEnabled = YES;//打开响应者链
    imageBelow.image = [UIImage imageNamed:@"e诺背景"];
    
    
    UIView *accountView = [[UIView alloc]init];//账号view
    accountView.backgroundColor = [UIColor whiteColor];
    accountView.alpha = 0.7;
    accountView.layer.cornerRadius = 20;
    accountView.clipsToBounds = YES;
    [imageBelow addSubview:accountView];
    
    UIView *yzCodeView = [[UIView alloc]init];//验证码view
    yzCodeView.backgroundColor = [UIColor whiteColor];
    yzCodeView.alpha = 0.7;
    yzCodeView.layer.cornerRadius = 20;
    yzCodeView.clipsToBounds = YES;
    [imageBelow addSubview:yzCodeView];
    
    UILabel *accountLabel = [[UILabel alloc]init];//
    accountLabel.text = @"账号";
    accountLabel.backgroundColor = [UIColor clearColor];
    [accountView addSubview:accountLabel];
    
    self.accountTextField.placeholder = @"请输入手机号";
    self.accountTextField.font = [UIFont systemFontOfSize:13.0];
    [accountView addSubview:self.accountTextField];

    
    UILabel *yzCodeLabel = [[UILabel alloc]init];
    yzCodeLabel.text = @"验证码";
    yzCodeLabel.backgroundColor = [UIColor clearColor];
    [yzCodeView addSubview:yzCodeLabel];
    
    self.yzCodeText.placeholder = @"请输入验证码";
    self.yzCodeText.font = [UIFont systemFontOfSize:13.0];
    [yzCodeView addSubview:self.yzCodeText];

    
    _secButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_secButton setImage:[UIImage imageNamed:@"点击获取"] forState:UIControlStateNormal];
    [_secButton addTarget:self action:@selector(handleWithVerify:) forControlEvents:UIControlEventTouchUpInside];
    [yzCodeView addSubview:_secButton];
    
    UIButton *nextStepBtn = [[UIButton alloc]init];
    nextStepBtn.layer.cornerRadius = 20;
    nextStepBtn.clipsToBounds = YES;
    [nextStepBtn setTitle:@"下一步" forState:normal];
    [nextStepBtn setTitleColor:[UIColor whiteColor] forState:normal];
    [nextStepBtn setBackgroundColor:[UIColor stringTOColor:@"#2fbcaf"]];
    [nextStepBtn addTarget:self action:@selector(nextStepBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageBelow addSubview:nextStepBtn];

    
    UIButton *pressButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [pressButton setImage:[UIImage imageNamed:@"勾"] forState:UIControlStateNormal];
    UIButton *pressTwoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [pressTwoButton setImage:[UIImage imageNamed:@"勾"] forState:UIControlStateNormal];

        
    UILabel *pressLabel = [[UILabel alloc]init];
    pressLabel.text = @"已阅读,并同意使用";
    pressLabel.textColor = [UIColor grayColor];
    pressLabel.font = [UIFont systemFontOfSize:11.0];
    UIButton *textButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [textButton setTitle:@"e诺平台使用条款" forState: UIControlStateNormal ];
    textButton.titleLabel.font = [UIFont systemFontOfSize:11.0];
    [textButton setTitleColor:[UIColor colorWithRed:35/255.0 green:157/255.0 blue:233/255.0 alpha:1] forState:UIControlStateNormal];
    [textButton addTarget:self action:@selector(handleWithtext:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *pressTwoLabel = [[UILabel alloc]init];
    pressTwoLabel.text = @"已阅读,并同意使用";
    pressTwoLabel.textColor = [UIColor grayColor];
    pressTwoLabel.font = [UIFont systemFontOfSize:11.0];
    UIButton *textTwoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [textTwoButton setTitle:@"医疗服务条款" forState: UIControlStateNormal ];
    textTwoButton.titleLabel.font = [UIFont systemFontOfSize:11.0];
    [textTwoButton setTitleColor:[UIColor colorWithRed:35/255.0 green:157/255.0 blue:233/255.0 alpha:1] forState:UIControlStateNormal];
    [textTwoButton addTarget:self action:@selector(handleWithtext:) forControlEvents:UIControlEventTouchUpInside];
    

//    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [registerButton setImage:[UIImage imageNamed:@"注册"] forState:UIControlStateNormal];
//    
//    
//    [registerButton addTarget:self action:@selector(handleWithRegister:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    [imageBelow addSubview:pressLabel];
    [imageBelow addSubview:pressButton];
    [imageBelow addSubview:textButton];
    
    [imageBelow addSubview:pressTwoLabel];
    [imageBelow addSubview:pressTwoButton];
    [imageBelow addSubview:textTwoButton];
    
    
        __weak typeof (self) weakSelf = self;
    
    [accountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo (imageBelow);
        make.centerY.mas_equalTo(imageBelow).with.offset(-80);
        make.width.mas_equalTo(@250);
        make.height.mas_equalTo(@40);
    }];
    [yzCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo (imageBelow);
        make.top.equalTo(accountView.mas_bottom).with.offset(23);
        make.width.mas_equalTo(@250);
        make.height.mas_equalTo(@40);
    }];
    
    [nextStepBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo (imageBelow);
        make.top.equalTo(yzCodeLabel.mas_bottom).with.offset(23);
        make.width.mas_equalTo(@250);
        make.height.mas_equalTo(@40);

    }];

    [accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(accountView);
        make.left.equalTo(accountView.mas_left).with.offset(20);
        make.height.mas_equalTo(@40);

    }];
    [yzCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(yzCodeView);
        make.left.equalTo(yzCodeView.mas_left).with.offset(20);
        make.height.mas_equalTo(@40);

    }];
    
    [weakSelf.accountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(accountView.mas_left).with.offset(85);
        make.right.equalTo(accountView.mas_right);
        make.centerY.equalTo(accountView);
        make.height.mas_equalTo(@40);
        
        
    }];
    
    [weakSelf.yzCodeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(yzCodeView.mas_left).with.offset(85);
        make.right.equalTo(weakSelf.secButton.mas_left);
        make.centerY.equalTo(yzCodeView);
        make.height.mas_equalTo(@40);
        make.width.mas_equalTo(@85);
        
        
    }];


    [ weakSelf.secButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo( weakSelf.yzCodeText.mas_right);
        make.top.equalTo (yzCodeView.mas_top);
        make.right.equalTo (yzCodeView.mas_right);
        make.bottom.equalTo (yzCodeView.mas_bottom);
        
    }];
    
    //第一组条款
    [pressButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nextStepBtn);
        make.top.equalTo(nextStepBtn.mas_bottom).with.offset(8);
        make.width.mas_equalTo(@15);
        make.height.mas_equalTo(@15);
    }];
    [pressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(pressButton);
        make.left.mas_equalTo (pressButton.mas_right).with.offset(5);
    }];
    [textButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(pressLabel);
        make.left.equalTo(pressLabel.mas_right);
    }];
    
    //第二组条款
    [pressTwoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(pressButton);
        make.top.equalTo(pressButton.mas_bottom).with.offset(5);
        make.width.mas_equalTo(@15);
        make.height.mas_equalTo(@15);
    }];
    [pressTwoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(pressTwoButton);
        make.left.mas_equalTo (pressTwoButton.mas_right).with.offset(5);
    }];
    [textTwoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(pressTwoLabel);
        make.left.equalTo(pressTwoLabel.mas_right);
    }];

    
    
}

- (void)handleWithtext:(UIButton *)sender{
    ReSSSSViewController *ssVC = [[ReSSSSViewController alloc]init];
    
    ssVC.type = sender.currentTitle;
    
    UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:ssVC];
    [self presentViewController:naNC animated:YES completion:^{
        
    }];
}


//下一步点击事件
- (void)nextStepBtnClick:(UIButton *)sender {
    
    NSString *url= @"http://www.enuo120.com/index.php/app/patient/next_register";
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:self.accountTextField.text forKey:@"username"];
    [dic setValue:@"patient_register" forKey:@"action"];
    [dic setValue:self.yzCodeText.text forKey:@"code"];
    [dic setValue:@"1.0" forKey:@"ver"];
    
    BaseRequest *request = [[BaseRequest alloc]init];
    [request POST:url params:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        [self nextStepWithData:responseObject];

    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

- (void)nextStepWithData:(NSDictionary *)dic {
    
    NSString *str = dic[@"data"][@"message"];
    
    if ([str isEqualToString:@"操作成功"]) {
    RegisterTwoVC *registerTwoVC = [[RegisterTwoVC alloc]init];
    registerTwoVC.accountText = self.accountTextField.text;
    registerTwoVC.yzCodeText = self.yzCodeText.text;
    [self.navigationController pushViewController:registerTwoVC animated:YES];
    }else {
        NSLog(@"%@",str);
    }
}

//注册按钮!!!!!!!!!!!!!!!
- (void)handleWithRegister:(UIButton *)sender{
    if ([self.markStr isEqualToString:@"2"]) {
        NSString * regex2 = @"^[a-zA-Z0-9]{6,16}$";
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES  %@", regex2];
        if (![pred2 evaluateWithObject: _passText.text]&&_passText.text.length>0){
            if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"密码格式不对" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
                [alert show];
            }else{
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"密码格式不对" preferredStyle:UIAlertControllerStyleAlert];
                [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];
                [self presentViewController:alertView animated:YES completion:^{
                    
                }];
            }
        }else
        {
            NSString *url  = @"http://www.enuo120.com/index.php/app/Patient/insert";
            NSMutableDictionary *str3 = [NSMutableDictionary dictionaryWithObject:self.accountTextField.text forKey:@"username"];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            //登陆成功后把用户名和密码存储到UserDefault
            [userDefaults setObject:self.accountTextField.text forKey:@"nameOne"];
            [str3 setValue:self.passText.text forKey:@"password"];
            [str3 setValue:self.yzCodeText.text forKey:@"code"];
            
            BaseRequest *request = [[BaseRequest alloc]init];
            [request POST:url params:str3 success:^(NSURLSessionDataTask *task, id responseObject) {
                [self handleWithRegisterOfData:responseObject];
            } fail:^(NSURLSessionDataTask *task, NSError *error) {
                
            }];
            
        }
    }else{
        NSLog(@"");
    }
}
//处理注册返回信息
- (void)handleWithRegisterOfData:(NSDictionary *)data{
    NSLog(@"data = %@",data);
    if ([data[@"data"] isKindOfClass:[NSNull class]]){
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"系统故障" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [alert show];
        }else{
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"系统故障" preferredStyle:UIAlertControllerStyleAlert];
            [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:alertView animated:YES completion:^{
                
            }];
        }
        
    }else{
        
        if (  [ data[@"data"][@"errcode"] integerValue] == 0 ) {
            if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"注册成功" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
                [alert show];
            }else{
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"注册成功" preferredStyle:UIAlertControllerStyleAlert];
                [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self dismissViewControllerAnimated:YES completion:^{
                        
                    }];
                }]];
                [self presentViewController:alertView animated:YES completion:^{
                    
                }];
            }
            
        }else{
            if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:data[@"data"][@"message"] delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
                [alert show];
            }else{
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:data[@"data"][@"message"] preferredStyle:UIAlertControllerStyleAlert];
                [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];
                [self presentViewController:alertView animated:YES completion:^{
                    
                }];
            }

        }
    }
}

//勾选同意协定
- (void)handleWithPress:(UIButton *)sender{
    if(sender.isSelected == NO){
        //记得昨晚操作之后，改变按钮的点击状态
        [sender setImage:[UIImage imageNamed:@"勾"] forState:UIControlStateNormal];
        //self.registerButton.backgroundColor = [UIColor colorWithRed:0/255.0 green:179/255.0 blue:163/255.0 alpha:1];
   self.markStr = @"2";
        sender.selected = YES;
    }else{
        
           [sender setImage:[UIImage imageNamed:@"勾-(1)"] forState:UIControlStateNormal];
       // self.imageAcc.image = [UIImage imageNamed:@"check"];
       self.markStr = @"1";
        
        sender.selected = NO;
    }

    
    
}

//对手机号码加密
- (void)getPublicKey {
    
    BaseRequest *request = [[BaseRequest alloc]init];
    [request POST:@"http://www.enuo120.com/Public/rsa/pub.key" params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",str);
        self.publickKey = str;
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}
//RSA加密
- (void)RSAEncryptor {
    
    
    
    NSString *dnumber =  self.accountTextField.text;
    
    //使用字符串格式的公钥私钥加密解密
    self.rsaAccountStr = [RSAEncryptor encryptString:dnumber publicKey:self.publickKey];
    
    
}

//验证码
- (void)handleWithVerify:(UIButton *)sender{
    
    [self RSAEncryptor];
    
    NSString * regex1 = @"[1][3578]\\d{9}";
    NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES  %@", regex1];
    if ([pred1 evaluateWithObject: self.accountTextField.text]){
        //        if ([sender.titleLabel.text isEqualToString:@"免费获取"]||[sender.titleLabel.text isEqualToString:@"重新发送"]) {
        NSArray *keys = self.optionDic.allKeys;
        self.nPhoneField = self.accountTextField.text;
        for (int i = 0; i < keys.count; i++) {
            //逐个的获取键
            NSString * key = [keys objectAtIndex:i];
            
            //通过键，找到相对应的值
            NSString * value = [self.optionDic valueForKey:key];
            //或者
            // NSString * value = [dict objectForKey:key];
            NSLog(@"key = %@，value = %@",key,value);
            self.nPhoneField = [self.nPhoneField stringByReplacingOccurrencesOfString:key withString:value];
            
        }
        
        NSString *uuid = [[UIDevice currentDevice].identifierForVendor UUIDString];
        
        
//        NSString *uuid = [NSString stringWithFormat:@"ios%@",identifierForVendor];
        
        NSLog(@"%@~~%@",uuid,self.rsaAccountStr);

        
        NSString *url= @"http://www.enuo120.com/index.php/app/public/send_msg";
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:self.rsaAccountStr forKey:@"phone"];
        [dic setValue:uuid forKey:@"uuid"];
        [dic setValue:@"patient_register" forKey:@"action"];
        [dic setValue:@"1.0" forKey:@"ver"];

        BaseRequest *request = [[BaseRequest alloc]init];
        [request POST:url params:dic success:^(NSURLSessionDataTask *task, id responseObject) {
            [self handleCodeMImaWithData:responseObject];
        } fail:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"error = %@",error);
            if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"验证过于频繁，请稍后再试" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
                [alert show];
            }else{
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"验证过于频繁，请稍后再试" preferredStyle:UIAlertControllerStyleAlert];
                [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];
                [self presentViewController:alertView animated:YES completion:^{
                    
                }];
            }
        }];
                
    }else{
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入正确手机号" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [alert show];
        }else{
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入正确手机号" preferredStyle:UIAlertControllerStyleAlert];
            [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:alertView animated:YES completion:^{
                
            }];
        }
    }
}

- (void)handleCodeMImaWithData:(NSDictionary *)data{
    NSLog(@"data = %@",data);
    if ([data[@"data"] isKindOfClass:[NSNull class]]){
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"系统故障" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [alert show];
        }else{
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"系统故障" preferredStyle:UIAlertControllerStyleAlert];
            [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:alertView animated:YES completion:^{
                
            }];
        }
        
    }else{
        
       // NSArray *arr  = data[@"data"];
        if (  [ data[@"data"][@"errcode"] integerValue] == 0 ) {
              //  NSLog(@"更换图片！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！");
            __block int timeout = 60; //倒计时时间
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout<=0){ //倒计时结束，关闭
                    dispatch_source_cancel(_timer);
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //设置界面的按钮显示 根据自己需求设置
                        self.secButton.enabled = YES;
                        [self.secButton setTitle:nil forState:UIControlStateNormal];
                        [self.secButton setImage:[UIImage imageNamed:@"点击重新获取"] forState:UIControlStateNormal];
                        NSLog(@"更换图片！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！");
                        //self.secButton.backgroundColor = [UIColor colorWithRed:0/255.0 green:179/255.0 blue:163/255.0 alpha:1];
                    });
                }else{
                    
                    NSString *strTime = [NSString stringWithFormat:@"%d秒",timeout];
                    dispatch_async(dispatch_get_main_queue(), ^{
                       //  NSLog(@"第一次更换图片！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！");
                        
                        
                        
                        [self.secButton setImage:[UIImage imageNamed:@"圆角矩形-4"] forState:UIControlStateNormal];
                        self.secButton.titleLabel.font = [UIFont systemFontOfSize:11.0];
                        [self.secButton setTitle:strTime forState:UIControlStateNormal];
                        _secButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
                        [self.secButton setTitleEdgeInsets:UIEdgeInsetsMake(0 ,-self.secButton.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
                        [_secButton setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0,0.0, -_secButton.titleLabel.bounds.size.width)];//图片距离右边框距离减少图片的宽度，其它不边
                        //self.secButton.backgroundColor = [UIColor grayColor];
                        self.secButton.enabled = NO;
                        
                    });
                    timeout--;
                    
                }
            });
            dispatch_resume(_timer);
            
            if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"发送成功" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
                [alert show];
            }else{
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"发送成功" preferredStyle:UIAlertControllerStyleAlert];
                [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];
                [self presentViewController:alertView animated:YES completion:^{
                    
                }];
            }
        
        }else {
            if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:data[@"data"][@"message"] delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
                [alert show];
            }else{
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:data[@"data"][@"message"] preferredStyle:UIAlertControllerStyleAlert];
                [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];
                [self presentViewController:alertView animated:YES completion:^{
                    
                }];
            }
        }
    }

}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
            break;
            
        default:
            break;
    }
}

// 配置键盘协议
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.yzCodeText resignFirstResponder];
    [self.accountTextField resignFirstResponder];
    [self.passText resignFirstResponder];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
