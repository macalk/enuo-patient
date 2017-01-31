//
//  ForgetPassworldTwoVC.m
//  enuoS
//
//  Created by apple on 16/12/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ForgetPassworldTwoVC.h"
#import "BaseRequest.h"
#import "SZKAlterView.h"
#import "Macros.h"

@interface ForgetPassworldTwoVC ()

@end

@implementation ForgetPassworldTwoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)makeSureClick:(UIButton *)sender {
    [self.view endEditing:YES];
    
    if ([self.passwordTextField.text isEqualToString:self.surePassworldTextField.text]) {
    
    NSString *userName = [[NSUserDefaults standardUserDefaults]objectForKey:@"name"];
    
    BaseRequest *request = [[BaseRequest alloc]init];
    
    NSString *url = @"http://www.enuo120.com/index.php/app/Patient/set_pay_pwd";
        
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:userName forKey:@"username"];
    [dic setValue:self.passwordTextField.text forKey:@"paypassword"];
    [dic setValue:self.surePassworldTextField.text forKey:@"repaypassword"];
    [dic setValue:@"1.0" forKey:@"ver"];
    
    [request POST:url params:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        [self dataWithSureDic:responseObject];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
        
    }else {
        NSLog(@"两次密码不对");
    }

    
}
- (void)dataWithSureDic:(NSDictionary *)dic {
    if ([dic[@"data"][@"errcode"] integerValue] == 0) {
        
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeigth)];
        bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [self.view addSubview:bgView];
        
        SZKAlterView *alterView = [SZKAlterView alterViewWithTitle:@"提示" content:dic[@"data"][@"message"] cancel:@"取消" sure:@"确定" cancelBtClcik:^{
            [bgView removeFromSuperview];
            [self.navigationController popToRootViewControllerAnimated:YES];
        } sureBtClcik:^{
            [bgView removeFromSuperview];
            [self.navigationController popToRootViewControllerAnimated:YES];

        }];
        
        [bgView addSubview:alterView];
        
    }else {
        NSLog(@"失败");
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
