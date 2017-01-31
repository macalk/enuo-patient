//
//  ChangeDataVC.m
//  enuoS
//
//  Created by apple on 16/12/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ChangeDataVC.h"
#import "BaseRequest.h"
#import "Macros.h"
#import "SZKAlterView.h"

@interface ChangeDataVC ()<UITextFieldDelegate>

@end

@implementation ChangeDataVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(navRithClick)];
    
    [self requestDate];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    self.emailTextField.delegate = self;
    self.allergyTextField.delegate = self;
    self.professionTextField.delegate = self;
}

- (void)requestDate {
    
    NSString *userName = [[NSUserDefaults standardUserDefaults]objectForKey:@"name"];
    
    BaseRequest *request = [[BaseRequest alloc]init];
    
    NSString *url = @"http://www.enuo120.com/index.php/app/Patient/personal_data";
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:userName forKey:@"username"];
    
    [request POST:url params:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        [self dataWithDic:responseObject];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (void)dataWithDic:(NSDictionary *)dic {
    NSDictionary *dataDic=  dic[@"data"];
    
    if (![dataDic[@"name"] isEqual:[NSNull null]]) {
        self.nameTextLabel.text = dataDic[@"name"];
    }else {
        self.nameTextLabel.text = @"未填写";
    }
    
    if (![dataDic[@"sex"] isEqual:[NSNull null]]) {
        self.sexTextLabel.text = dataDic[@"sex"];
    }else {
        self.sexTextLabel.text = @"未填写";
    }
    
    if (![dataDic[@"phone"] isEqual:[NSNull null]]) {
        self.phoneNumLabel.text = dataDic[@"phone"];
    }else {
        self.phoneNumLabel.text = @"未填写";
    }
    if (![dataDic[@"ID_card"] isEqual:[NSNull null]]) {
        self.idNumLabel.text = dataDic[@"ID_card"];
    }else {
        self.idNumLabel.text = @"未填写";
    }
    if (![dataDic[@"email"] isEqual:[NSNull null]]) {
        self.emailTextField.text = dataDic[@"email"];
    }else {
        self.emailTextField.text = @"未填写";
    }
    if (![dataDic[@"accupation"] isEqual:[NSNull null]]) {
        self.professionTextField.text = dataDic[@"accupation"];
    }else {
        self.professionTextField.text = @"未填写";
    }
    if (![dataDic[@"allergic"] isEqual:[NSNull null]]) {
        self.allergyTextField.text = dataDic[@"allergic"];
    }else {
        self.allergyTextField.text = @"未填写";
    }

}

- (void)navRithClick {
    
    [self.view endEditing:YES];
    
    NSString *userName = [[NSUserDefaults standardUserDefaults]objectForKey:@"name"];
    
    BaseRequest *request = [[BaseRequest alloc]init];
    
    NSString *url = @"http://www.enuo120.com/index.php/app/Patient/change_information";
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:userName forKey:@"username"];
    [dic setValue:self.emailTextField.text forKey:@"email"];
    [dic setValue:self.allergyTextField.text forKey:@"allergic"];
    [dic setValue:self.professionTextField.text forKey:@"accupation"];

    
    [request POST:url params:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        [self dataWithSureDic:responseObject];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (void)dataWithSureDic:(NSDictionary *)dic {
    
    if ([dic[@"data"][@"errcode"] integerValue] == 0) {
        
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeigth)];
        bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [self.view addSubview:bgView];
        
        SZKAlterView *alterView = [SZKAlterView alterViewWithTitle:@"提示" content:dic[@"data"][@"message"] cancel:@"取消" sure:@"确定" cancelBtClcik:^{
            [bgView removeFromSuperview];
            [self.navigationController popViewControllerAnimated:YES];
        } sureBtClcik:^{
            [bgView removeFromSuperview];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
        [bgView addSubview:alterView];
    }
}


- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.view.frame = CGRectMake(0, -100, kScreenWidth, kScreenHeigth);

}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.view.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeigth-64);

}

//获取键盘高度
- (void)changeFrame:(NSNotification *)notif {
    
    NSDictionary *info = [notif userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    
    NSLog(@"%f",keyboardSize.height);
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
