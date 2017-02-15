//
//  RegisterTwoVC.m
//  enuoS
//
//  Created by apple on 16/12/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "RegisterTwoVC.h"
#import <Masonry.h>
#import "Macros.h"
#import "UIColor+Extend.h"
#import <AFNetworking.h>
#import "RSAEncryptor.h"

@interface RegisterTwoVC ()

@property (nonatomic,strong)UITextField *pasWordTextField;
@property (nonatomic,strong)UITextField *rePasWordTextField;
@property (nonatomic,copy)NSString *publickKey;

@end

@implementation RegisterTwoVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"绿色返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleWithBack:)];
        self.navigationItem.leftBarButtonItem = leftItem;
    }return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getPublicKey];
    [self creatRegisterView];
}

- (void)creatRegisterView{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageBelow = [[UIImageView alloc]initWithFrame:self.view.frame];
    
    [self.view addSubview: imageBelow];
    
    imageBelow.userInteractionEnabled = YES;//打开响应者链
    imageBelow.image = [UIImage imageNamed:@"e诺背景"];
    
    UIView *passWordView = [[UIView alloc]init];
    passWordView.backgroundColor = [UIColor whiteColor];
    passWordView.layer.cornerRadius = 20;
    passWordView.clipsToBounds = YES;
    passWordView.alpha = 0.7;
    [imageBelow addSubview:passWordView];
    
    UILabel *passWordLabel = [[UILabel alloc]init];
    passWordLabel.text = @"密码";
    passWordLabel.backgroundColor = [UIColor clearColor];
    [passWordView addSubview:passWordLabel];
    
    UITextField *pasWordTextField = [[UITextField alloc]init];
    pasWordTextField.placeholder = @"6~16位字符，区分大小写";
    pasWordTextField.font = [UIFont systemFontOfSize:13];
    self.pasWordTextField = pasWordTextField;
    [passWordView addSubview:pasWordTextField];
    
    UIView *rePassWordView = [[UIView alloc]init];
    rePassWordView.backgroundColor = [UIColor whiteColor];
    rePassWordView.layer.cornerRadius = 20;
    rePassWordView.clipsToBounds = YES;
    rePassWordView.alpha = 0.7;
    [imageBelow addSubview:rePassWordView];
    
    UILabel *rePassWordLabel = [[UILabel alloc]init];
    rePassWordLabel.text = @"确认密码";
    rePassWordLabel.backgroundColor = [UIColor clearColor];
    [rePassWordView addSubview:rePassWordLabel];
    
    UITextField *rePasWordTextField = [[UITextField alloc]init];
    rePasWordTextField.placeholder = @"区分大小写";
    rePasWordTextField.font = [UIFont systemFontOfSize:13];
    self.rePasWordTextField = rePasWordTextField;
    [rePassWordView addSubview:rePasWordTextField];

    
    
    UIButton *doneRegisterBtn = [[UIButton alloc]init];
    [doneRegisterBtn setBackgroundColor:[UIColor stringTOColor:@"#2fbcaf"]];
    [doneRegisterBtn setTitle:@"完成注册" forState:normal];
    doneRegisterBtn.layer.cornerRadius = 20;
    doneRegisterBtn.clipsToBounds = YES;
    [doneRegisterBtn addTarget:self action:@selector(doneRegisterBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageBelow addSubview:doneRegisterBtn];
    
    [passWordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo (imageBelow);
        make.centerY.mas_equalTo(imageBelow).with.offset(-80);
        make.width.mas_equalTo(@250);
        make.height.mas_equalTo(@40);
    }];
    
    [passWordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(passWordView.mas_left).with.offset(20);
        make.centerY.equalTo(passWordView);
        make.height.mas_equalTo(@40);
        
        
    }];
    
    [pasWordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(passWordView.mas_left).with.offset(95);
        make.right.equalTo(passWordView.mas_right);
        make.centerY.equalTo(passWordView);
        make.height.mas_equalTo(@40);
        make.width.mas_equalTo(@85);
        
    }];
    
    //第二个
    [rePassWordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(passWordView);
        make.top.equalTo(passWordView.mas_bottom).with.offset(23);
        make.width.mas_equalTo(@250);
        make.height.mas_equalTo(@40);
    }];
    
    [rePassWordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(rePassWordView.mas_left).with.offset(20);
        make.centerY.equalTo(rePassWordView);
        make.height.mas_equalTo(@40);
        
        
    }];
    
    [rePasWordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(rePassWordView.mas_left).with.offset(95);
        make.right.equalTo(rePassWordView.mas_right);
        make.centerY.equalTo(rePassWordView);
        make.height.mas_equalTo(@40);
        make.width.mas_equalTo(@85);
        
    }];

    
    [doneRegisterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo (imageBelow);
        make.top.equalTo(rePassWordView.mas_bottom).with.offset(23);
        make.width.mas_equalTo(@250);
        make.height.mas_equalTo(@40);
    }];

}

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
//- (NSString *)RSAEncryptorWithStr:(NSString *)str {
//    
//    //使用字符串格式的公钥私钥加密解密
//    self.rsaAccountStr = [RSAEncryptor encryptString:dnumber publicKey:self.publickKey];
//    
//    
//}


//注册按钮!!!!!!!!!!!!!!!
- (void)doneRegisterBtnClick:(UIButton *)sender {
    
    //对密码RSA加密
    NSString *RSAPasWord = [RSAEncryptor encryptString:self.pasWordTextField.text publicKey:self.publickKey];
    
    NSString *reRSAPasWord = [RSAEncryptor encryptString:self.rePasWordTextField.text publicKey:self.publickKey];
    
    NSString *RSAAccount = [RSAEncryptor encryptString:self.accountText publicKey:self.publickKey];
    
    NSString *urlText = [NSString stringWithFormat:@"phone=%@|password=%@|repassword=%@",RSAAccount,RSAPasWord,reRSAPasWord];
    
    NSLog(@"%@----",urlText);
    
    //[self.markStr isEqualToString:@"2"]
        if (YES) {
        NSString * regex2 = @"^[a-zA-Z0-9]{6,16}$";
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES  %@", regex2];
        if (![pred2 evaluateWithObject: self.pasWordTextField.text]&&self.pasWordTextField.text.length>0){
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
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            //登陆成功后把用户名和密码存储到UserDefault
            [userDefaults setObject:self.accountText forKey:@"nameOne"];

            NSLog(@"%@",urlText);
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:@"1.0" forKey:@"ver"];
            [dic setObject:urlText forKey:@"url"];

            BaseRequest *request = [[BaseRequest alloc]init];
            [request POST:url params:dic success:^(NSURLSessionDataTask *task, id responseObject) {
                [self handleWithRegisterOfData:responseObject];

            } fail:^(NSURLSessionDataTask *task, NSError *error) {
                
            }];
                        
        }
    }else{
        
        
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)handleWithBack:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
