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

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"登录返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleWithBack:)];
        self.navigationItem.leftBarButtonItem = leftItem;
    }return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:0];
    //    让黑线消失的方法
    self.navigationController.navigationBar.shadowImage=[UIImage new];
    

    [self creatViewlayout];
}



- (void)handleWithBack:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}






- (void)creatViewlayout{
    UIImageView *imageBack = [[UIImageView alloc]initWithFrame:self.view.bounds];
    
    [self.view addSubview:imageBack];
    
    imageBack.userInteractionEnabled = YES;
    imageBack.image = [UIImage imageNamed:@"组-4"];
   
    UIImageView *oneImage = [[UIImageView alloc]init];
    UIImageView *twoImage = [[UIImageView alloc]init];
    oneImage.userInteractionEnabled = YES;
    twoImage.userInteractionEnabled = YES;
    oneImage.image = [UIImage imageNamed:@"账号"];
    twoImage.image =[ UIImage imageNamed:@"密码"];
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
    UIView *twoView = [[UIView alloc]init];
    
    twoView.backgroundColor = [UIColor blueColor];
    
    
    
    self.passwordText.placeholder = @"6-16位字符，区分大小写";
    _passwordText.font = [UIFont systemFontOfSize:13];
    [self.passwordText setKeyboardType:UIKeyboardTypeASCIICapable];
    [self.passwordText setClearButtonMode:UITextFieldViewModeWhileEditing];
    [self.passwordText setReturnKeyType:UIReturnKeyDone];
    [self.passwordText setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [self.passwordText setAutocorrectionType:UITextAutocorrectionTypeNo];
    [self.passwordText setHighlighted:YES];
    
    self.passwordText.delegate = self;
    //self.passwordText.placeholder = @"请输入密码";
    self.passwordText.secureTextEntry = YES;
    UIButton *logonButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIButton *regiseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIButton *forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIButton *remberButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [logonButton setImage:[UIImage imageNamed:@"登录"] forState:UIControlStateNormal];
    [regiseButton setImage:[UIImage imageNamed:@"注册"] forState:UIControlStateNormal];
    
    [forgetButton setTitle:@"忘记密码?"forState:UIControlStateNormal];
 
    forgetButton.titleLabel.font = [UIFont systemFontOfSize:12];
    
    remberButton.backgroundColor = [UIColor blueColor];
    
    //forgetButton.backgroundColor = [UIColor redColor];
    
    [logonButton addTarget:self action:@selector(handleWithLogonButton:) forControlEvents:UIControlEventTouchUpInside];
    [regiseButton addTarget:self action:@selector(handleWithRegiseButton:) forControlEvents:UIControlEventTouchUpInside];
    [forgetButton addTarget:self action:@selector(handleForgetButton:) forControlEvents:UIControlEventTouchUpInside];
    
   
    [oneImage addSubview:_numText];
    
  
    [twoImage addSubview:_passwordText];
    
    [imageBack addSubview:oneImage];
    [imageBack addSubview:twoImage];
    [imageBack addSubview:logonButton];
    [imageBack addSubview:regiseButton];
    [imageBack addSubview:forgetButton];
    [imageBack addSubview:remberButton];
    

    
    
    
    [_numText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(oneImage.mas_left).with.offset(65);
        make.right.equalTo(oneImage.mas_right);
        make.top.equalTo(oneImage.mas_top);
        make.bottom.equalTo(oneImage.mas_bottom);
        
        
    }];
    
    
    [_passwordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(twoImage.mas_left).with.offset(65);
        make.right.equalTo(twoImage.mas_right);
        make.top.equalTo(twoImage.mas_top);
        make.bottom.equalTo(twoImage.mas_bottom);
        
        
    }];
    
    [oneImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo (imageBack);
        make.centerY.mas_equalTo(imageBack).with.offset(-80);
        make.width.mas_equalTo(@250);
        make.height.mas_equalTo(@40);
    }];
    [twoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo (imageBack);
        make.centerY.mas_equalTo(imageBack).with.offset(-30);
        make.width.mas_equalTo(@250);
        make.height.mas_equalTo(@40);
    }];
    [logonButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo (imageBack);
        make.centerY.mas_equalTo(imageBack).with.offset(20);
        make.width.mas_equalTo(@250);
        make.height.mas_equalTo(@40);
    }];
    [regiseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo (imageBack);
        make.centerY.mas_equalTo(imageBack).with.offset(70);
        make.width.mas_equalTo(@250);
        make.height.mas_equalTo(@40);
    }];
      [forgetButton mas_makeConstraints:^(MASConstraintMaker *make) {
          make.trailing.equalTo(regiseButton);
          make.top.equalTo(regiseButton.mas_bottom);
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
