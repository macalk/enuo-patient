//
//  LogonViewController.m
//  enuoS
//
//  Created by apple on 16/7/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LogonViewController.h"
#import <Masonry.h>
#import <AFNetworking.h>
#import "Macros.h"
#import <UIImageView+WebCache.h>
#import "RegisterViewController.h"
#import "ForgetMmViewController.h"
#import "BaseRequest.h"
#import <NIMSDK.h>

@interface LogonViewController ()<UITextFieldDelegate,UIAlertViewDelegate>
@property (nonatomic,strong)UITextField *numText;
@property (nonatomic,strong)UITextField *passwordText;
@property (nonatomic,strong)UIImageView *imageBack;
@end

@implementation LogonViewController

- (UITextField *)numText{
    if (!_numText) {
        self.numText = [[UITextField alloc]init];
    }return _numText;
}

- (UITextField *)passwordText{
    if (!_passwordText) {
        self.passwordText = [[UITextField alloc]init];
    }return _passwordText;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:0];
    //    让黑线消失的方法
    self.navigationController.navigationBar.shadowImage=[UIImage new];
    
    [self creatViewlayout];
    [self createBackBtn];
}

- (void)createBackBtn {
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10, 26, 21, 21);
    [backBtn setImage:[UIImage imageNamed:@"白色返回_N"] forState:normal];
    [backBtn addTarget:self action:@selector(handleWithBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageBack addSubview:backBtn];
    
}
- (void)handleWithBack:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)creatViewlayout{
    UIImageView *imageBack = [[UIImageView alloc]initWithFrame:self.view.bounds];
    self.imageBack = imageBack;
    [self.view addSubview:imageBack];
    
    imageBack.userInteractionEnabled = YES;
    imageBack.image = [UIImage imageNamed:@"e诺背景_N"];
    
    UIImageView *logoImageView = [[UIImageView alloc]init];
    logoImageView.image = [UIImage imageNamed:@"e诺图标_N"];
    [imageBack addSubview:logoImageView];
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imageBack);
        make.top.equalTo(imageBack).with.offset(60);
        make.size.mas_offset(CGSizeMake(80, 80));
    }];
    UILabel *logoLabel = [[UILabel alloc]init];
    logoLabel.textAlignment = NSTextAlignmentCenter;
    logoLabel.text = @"约定医疗";
    logoLabel.textColor = [UIColor whiteColor];
    logoLabel.font = [UIFont systemFontOfSize:20];
    [imageBack addSubview:logoLabel];
    [logoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(logoImageView);
        make.top.equalTo(logoImageView.mas_bottom).with.offset(8);
        make.width.mas_offset(100);
    }];
    
    UIView *accountView = [[UIView alloc]init];
    accountView.backgroundColor = [UIColor whiteColor];
    [imageBack addSubview:accountView];
    [accountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageBack).with.offset(45);
        make.right.equalTo(imageBack).with.offset(-45);
        make.top.equalTo(logoLabel.mas_bottom).with.offset(52);
        make.height.mas_equalTo(37);
    }];
    UIImageView *accountImageView = [[UIImageView alloc]init];
    accountImageView.image = [UIImage imageNamed:@"用户名_N"];
    [accountView addSubview:accountImageView];
    [accountImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(accountView).with.offset(11);
        make.centerY.equalTo(accountView);
        make.size.mas_equalTo(CGSizeMake(17, 19));
    }];
    UIView *passwordView = [[UIView alloc]init];
    passwordView.backgroundColor = [UIColor whiteColor];
    [imageBack addSubview:passwordView];
    [passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageBack).with.offset(45);
        make.right.equalTo(imageBack).with.offset(-45);
        make.top.equalTo(accountView.mas_bottom).with.offset(12);
        make.height.mas_equalTo(37);
    }];
    UIImageView *passwordImageView = [[UIImageView alloc]init];
    passwordImageView.image = [UIImage imageNamed:@"密码_N"];
    [passwordView addSubview:passwordImageView];
    [passwordImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(passwordView).with.offset(11);
        make.centerY.equalTo(passwordView);
        make.size.mas_equalTo(CGSizeMake(18, 22));
    }];
    
    self.numText.placeholder = @"请输入手机号/用户名";
    _numText.font = [UIFont systemFontOfSize:13];
    [self.numText setKeyboardType:UIKeyboardTypeASCIICapable];
    [self.numText setClearButtonMode:UITextFieldViewModeWhileEditing];
    [self.numText setReturnKeyType:UIReturnKeyDone];
    [self.numText setAutocapitalizationType:UITextAutocapitalizationTypeNone];//关闭首字母大写
    [self.numText setAutocorrectionType:UITextAutocorrectionTypeNo];
    //[oneField becomeFirstResponder];//默认打开键盘
    self.numText.delegate = self;
    [self.numText setHighlighted:YES];
    
    
    self.passwordText.font = [UIFont systemFontOfSize:13];
    [self.passwordText setKeyboardType:UIKeyboardTypeASCIICapable];
    [self.passwordText setClearButtonMode:UITextFieldViewModeWhileEditing];
    [self.passwordText setReturnKeyType:UIReturnKeyDone];
    [self.passwordText setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [self.passwordText setAutocorrectionType:UITextAutocorrectionTypeNo];
    [self.passwordText setHighlighted:YES];
    
    self.passwordText.delegate = self;
    self.passwordText.placeholder = @"请输入密码";
    self.passwordText.secureTextEntry = YES;
    
    [accountView addSubview:self.numText];
    [passwordView addSubview:self.passwordText];
//    UIImageView *oneImage = [[UIImageView alloc]init];
//    UIImageView *twoImage = [[UIImageView alloc]init];
//    oneImage.userInteractionEnabled = YES;
//    twoImage.userInteractionEnabled = YES;
//    oneImage.image = [UIImage imageNamed:@"账号"];
//    twoImage.image =[ UIImage imageNamed:@"密码"];
    
//    UIView *twoView = [[UIView alloc]init];
//    
//    twoView.backgroundColor = [UIColor blueColor];
    
    UIButton *logonButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIButton *regiseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIButton *forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIButton *remberButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [logonButton setTitle:@"登录" forState:normal];
    logonButton.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.3];
    logonButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [logonButton setTitleColor:[UIColor whiteColor] forState:normal];
    
    [regiseButton setTitle:@"注册e诺账户" forState:normal];
    regiseButton.backgroundColor = [UIColor clearColor];
    regiseButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [regiseButton setTitleColor:[UIColor whiteColor] forState:normal];
    
    [forgetButton setTitle:@"忘记密码?"forState:UIControlStateNormal];
 
    forgetButton.titleLabel.font = [UIFont systemFontOfSize:12];
    
    remberButton.backgroundColor = [UIColor blueColor];
    
    //forgetButton.backgroundColor = [UIColor redColor];
    
    [logonButton addTarget:self action:@selector(handleWithLogonButton:) forControlEvents:UIControlEventTouchUpInside];
    [regiseButton addTarget:self action:@selector(handleWithRegiseButton:) forControlEvents:UIControlEventTouchUpInside];
    [forgetButton addTarget:self action:@selector(handleForgetButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [imageBack addSubview:logonButton];
    [imageBack addSubview:regiseButton];
    [imageBack addSubview:forgetButton];
    [imageBack addSubview:remberButton];
    
    [_numText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(accountImageView.mas_right).with.offset(19);
        make.right.equalTo(accountView.mas_right);
        make.centerY.equalTo(accountView);
    }];
    
    [_passwordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(passwordImageView.mas_right).with.offset(18);
        make.right.equalTo(passwordView.mas_right);
        make.centerY.equalTo(passwordView);
    }];
    
    [logonButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo (imageBack);
        make.top.equalTo(passwordView.mas_bottom).with.offset(50);
        make.width.mas_equalTo(passwordView.mas_width);
        make.height.mas_equalTo(@37);
    }];
    [regiseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo (imageBack);
        make.top.mas_equalTo(logonButton.mas_bottom).with.offset(27);
        make.width.mas_equalTo(@250);
        make.height.mas_equalTo(@40);
    }];
    [forgetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(passwordView);
        make.top.equalTo(passwordView.mas_bottom).with.offset(5);
        make.width.mas_equalTo (@65);
        make.height.mas_equalTo(@30);
    }];
    
//    [remberButton mas_makeConstraints:^(MASConstraintMaker *make) {
//       
//        make.leading.equalTo(regiseButton);
//        make.top.equalTo(regiseButton.mas_bottom);
//        make.width.mas_equalTo (@65);
//        make.height.mas_equalTo(@30);
//    }];
    
    
}
//忘记密码
- (void)handleForgetButton:(UIButton *)sender{
    ForgetMmViewController *fVc = [[ForgetMmViewController alloc]init];
    UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:fVc];
    [self presentViewController:naNC animated:YES completion:^{
        
    }];
}
//登录
- (void)handleWithLogonButton:(UIButton *)sender{
 
    [self requestLogoData];
}
//注册
- (void)handleWithRegiseButton:(UIButton *)sender{
    NSLog(@"注册");
    RegisterViewController *reVC = [[RegisterViewController alloc]init];
    UINavigationController *naVC = [[UINavigationController alloc]initWithRootViewController:reVC];
    [self presentViewController:naVC animated:YES completion:^{
        
    }];
    
}

// 配置键盘协议
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_passwordText resignFirstResponder];
    [_numText resignFirstResponder];
    
}

//登陆
- (void)requestLogoData{
    NSString *url = @"http://www.enuo120.com/index.php/app/patient/log";
    
    NSDictionary *heardBody  = @{@"username":self.numText.text,@"password":self.passwordText.text};
    
    BaseRequest *request = [[BaseRequest alloc]init];
    [request POST:url params:heardBody success:^(NSURLSessionDataTask *task, id responseObject) {
        [self handleWithLogoData:responseObject];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

- (void)handleWithLogoData:(NSDictionary *)dic{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *data = dic[@"data"];
    NSDictionary *content = data[@"content"];
    NSString *name = content[@"name"];
    NSString *token = content[@"chat_token"];
    [userDefaults setObject:name forKey:@"mz"];//用户名字
    
    
    if (![token isEqual:[NSNull null]]) {
        [userDefaults setObject:token forKey:@"token"];
    }

    if ([data[@"message"]isEqualToString:@"登陆成功"]) {
        
        //登陆成功后把用户名和密码存储到UserDefault
        [userDefaults setObject:self.numText.text forKey:@"name"];//这是username
        [userDefaults setObject:self.passwordText.text forKey:@"password"];
        [userDefaults setObject:self.numText.text forKey:@"onename"];
        [userDefaults setObject:self.passwordText.text forKey:@"onepassword"];
        [userDefaults synchronize];
        
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:data[@"message"] delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
            [alert show];
            
        }else{
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:data[@"message"] preferredStyle:UIAlertControllerStyleAlert];
            [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self dismissViewControllerAnimated:YES completion:^{
                    
                }];
            }]];
            
            [self presentViewController:alertView animated:YES completion:^{
                
            }];
        }

    }else{
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:data[@"message"] delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alert show];
        
    }else{
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:data[@"message"] preferredStyle:UIAlertControllerStyleAlert];
        [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        
        [self presentViewController:alertView animated:YES completion:^{
            
        }];
    }
}

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }else{
        NSLog(@"完善信息");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
