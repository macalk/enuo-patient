//
//  ChangePhoneVC.m
//  enuoS
//
//  Created by apple on 16/12/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ChangePhoneVC.h"
#import <AFNetworking.h>
#import "RSAEncryptor.h"


@interface ChangePhoneVC ()

@property (nonatomic,strong) NSString *publickey;

@end

@implementation ChangePhoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self getPublicKey];
}

//公钥加密
- (void)getPublicKey {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:@"http://www.enuo120.com/Public/rsa/pub.key" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",str);
        self.publickey = str;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"shibai!!!");
        
    }];
    
    
    
}

- (IBAction)getYZCodeBtn:(UIButton *)sender {
    //加密(手机号码)
    NSString *phone = [RSAEncryptor encryptString:self.phoneTextField.text publicKey:self.publickey];
    
    NSLog(@"%@",phone);
    
    
    NSString * regex1 = @"[1][3578]\\d{9}";
    NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES  %@", regex1];
    
    
    if ([pred1 evaluateWithObject: self.phoneTextField.text]){
        
        NSString *uuid = [[UIDevice currentDevice].identifierForVendor UUIDString];
        
        NSLog(@"%@~~~%@",phone,uuid);
        NSString *str1= @"http://www.enuo120.com/index.php/app/public/send_msg";
        AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:phone forKey:@"phone"];
        [dic setValue:uuid forKey:@"uuid"];
        [dic setValue:@"patient_change_phone" forKey:@"action"];
        [dic setValue:@"1.0" forKey:@"ver"];
        [manger POST:str1 parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"responseObject = %@",responseObject);
            [self handleCodeMImaWithData:responseObject];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
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
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"发送成功" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
                [alert show];
            }else{
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"发送成功" preferredStyle:UIAlertControllerStyleAlert];
                [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
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


- (IBAction)makeSureBtn:(UIButton *)sender {
    [self.view endEditing:YES];
    
    NSString *name = [[NSUserDefaults standardUserDefaults]objectForKey:@"name"];
    
    NSString *str1= @"http://www.enuo120.com/index.php/app/public/check_code";
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:name forKey:@"username"];
    [dic setValue:self.phoneTextField.text forKey:@"phone"];
    [dic setValue:self.yzCodeTextField.text forKey:@"code"];
    [dic setValue:@"patient_change_phone" forKey:@"action"];
    [dic setValue:@"1.0" forKey:@"ver"];
    [manger POST:str1 parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject = %@",responseObject);
        [self changePhoneWithData:responseObject];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}

- (void)changePhoneWithData:(NSDictionary *)data{
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
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"修改成功" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
                [alert show];
            }else{
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"修改成功" preferredStyle:UIAlertControllerStyleAlert];
                [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    [[NSUserDefaults standardUserDefaults]setObject:self.phoneTextField.text forKey:@"name"];

                    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
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