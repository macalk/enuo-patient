//
//  ForgetMmViewController.m
//  enuo4
//
//  Created by apple on 16/5/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ForgetMmViewController.h"
#import "ForgetMmOneViewController.h"
#import <AFNetworking.h>
#import "RSAEncryptor.h"
#import "Macros.h"
@interface ForgetMmViewController ()<UITextFieldDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *llTextField;
@property (nonatomic,strong)UIAlertView *alertView1;
@property (weak, nonatomic) IBOutlet UITextField *checkCodeField;
@property (nonatomic,strong)UIAlertController *alertView2;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (nonatomic,copy)NSString *dataStr;
@property (nonatomic,copy)NSString *publicKey;

@property (nonatomic,strong)NSDictionary *optionDic;//配置项；
@property (nonatomic,copy)NSString *nPhoneField;


@end

@implementation ForgetMmViewController


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"绿色返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleWithBack:)];
        self.navigationItem.leftBarButtonItem = leftItem;
    }return self;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"忘记密码";
     self.optionDic =@{@"0":@"C",@"1":@"An",@"2":@"H@",@"3":@"D",@"4":@"R",@"5":@"Vc",@"6":@"XZ",@"7":@"J",@"8":@"m",@"9":@"Q"};
    
    [self.llTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [self.llTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [self.llTextField setReturnKeyType:UIReturnKeyDone];
    [self.llTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    //关闭首字母大写
    [self.llTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
    
    [self.llTextField setHighlighted:YES];
    self.llTextField.delegate = self;
    self.navigationController.navigationBar.translucent = NO;
    [self.checkCodeField setKeyboardType:UIKeyboardTypeNumberPad];
    [self.checkCodeField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [self.checkCodeField setReturnKeyType:UIReturnKeyDone];
    [self.checkCodeField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    //关闭首字母大写
    //[self.l setAutocorrectionType:UITextAutocorrectionTypeNo];
    
    [self.checkCodeField setHighlighted:YES];
     self.checkCodeField.delegate = self;
    
    [self getPublicKey];
    
}

- (void)handleWithBack:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
//取消键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.llTextField resignFirstResponder];
    [self.checkCodeField resignFirstResponder];
}

//公钥加密
- (void)getPublicKey {
    BaseRequest *request = [[BaseRequest alloc]init];
    [request POST:@"http://www.enuo120.com/Public/rsa/pub.key" params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",str);
        self.publicKey = str;
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}
//验证码
- (IBAction)handleSendCodeBtn:(UIButton *)sender {
    
    //加密(手机号码)
    NSString *phone = [RSAEncryptor encryptString:self.llTextField.text publicKey:self.publicKey];

    
    NSString * regex1 = @"[1][3578]\\d{9}";
    NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES  %@", regex1];
    
    
    if ([pred1 evaluateWithObject: self.llTextField.text]){
        NSArray *keys = self.optionDic.allKeys;
        self.nPhoneField = self.llTextField.text;
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
        
        NSString *str1= @"http://www.enuo120.com/index.php/app/public/send_msg";
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:phone forKey:@"phone"];
        [dic setValue:uuid forKey:@"uuid"];
        [dic setValue:@"patient_forget_pwd" forKey:@"action"];
        [dic setValue:@"1.0" forKey:@"ver"];
        NSLog(@"%@~~~%@~",phone,uuid);
        BaseRequest *request = [[BaseRequest alloc]init];
        [request POST:str1 params:dic success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"responseObject = %@",responseObject);
            [self handleCodeMImaWithData:responseObject];
        } fail:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
        
    }else{
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"手机号格式错误" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [alert show];
        }else{
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"手机号格式错误" preferredStyle:UIAlertControllerStyleAlert];
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
        
    }else {

        
            if (  [ data[@"data"][@"errcode"] integerValue] == 0 ) {
                if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:data[@"data"][@"message"] delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
                    [alert show];
                }else{
                    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:data[@"data"][@"message"] preferredStyle:UIAlertControllerStyleAlert];
                    [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                        [alertView removeFromParentViewController];
                        
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
                        [alertView removeFromParentViewController];
                    }]];
                    [self presentViewController:alertView animated:YES completion:^{
                        
                    }];
                }
                
            }
        
    }
}

- (IBAction)handlePassEmail:(UIButton *)sender {
     [self.llTextField resignFirstResponder];
    [self.checkCodeField resignFirstResponder];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:self.llTextField.text forKey:@"username"];
    [dic setValue:@"patient_forget_pwd" forKey:@"action"];
    [dic setValue:self.checkCodeField.text forKey:@"code"];
    [dic setValue:@"1.0" forKey:@"ver"];
    
    NSString *str = @"http://www.enuo120.com/index.php/app/patient/next_register";
    NSString *url = [NSString stringWithFormat:str,self.llTextField.text,self.checkCodeField.text];
    BaseRequest *request = [[BaseRequest alloc]init];
    [request POST:url params:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        [self handleRequestData: responseObject];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
- (void)handleRequestData:(NSDictionary *)data{
    
    self.dataStr = [data[@"data"]objectForKey:@"errcode"];
    
    if ([self.dataStr integerValue] == 0) {
        
        ForgetMmOneViewController *forGet = [[ForgetMmOneViewController alloc]init];
        forGet.receiver = self.llTextField.text;
        [self.navigationController pushViewController:forGet animated:YES];
        
    }else {
        
        NSLog(@"失败");
    }
 
}
- (void)popVCcc{
    [self presentViewController:self.alertView2 animated:YES completion:^{
        
    }];
}
- (void)popVC{
    [self.alertView1 show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
      ForgetMmOneViewController *forGet = [[ForgetMmOneViewController alloc]init];
    switch (buttonIndex) {
        case 0:
            if ([self.dataStr isEqualToString:@"0"]) {
                 [self.navigationController pushViewController:forGet animated:YES];
                   forGet.receiver = self.llTextField.text;
            }
           // [self.navigationController popViewControllerAnimated:YES];
            break;
            
        default:
            break;
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.llTextField resignFirstResponder];
    [self.checkCodeField resignFirstResponder];
    return YES;
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
