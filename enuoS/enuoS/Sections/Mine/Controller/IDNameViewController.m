//
//  IDNameViewController.m
//  enuoS
//
//  Created by apple on 16/8/19.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "IDNameViewController.h"

@interface IDNameViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *idTextField;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@end

@implementation IDNameViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"绿色返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleWithBack:)];
        self.navigationItem.leftBarButtonItem = leftItem;
        
    }return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航条底图"] forBarMetrics:0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    self.navigationController.navigationBar.translucent = NO;
    [self.idTextField setKeyboardType: UIKeyboardTypeNumberPad];
    [self.idTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    //[self.idTextField setReturnKeyType:UIReturnKeyNext];
    [self.idTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    //关闭首字母大写
    [self.idTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
    
    [self.idTextField setHighlighted:YES];
    self.idTextField.delegate = self;
}
- (IBAction)handleWithSure:(UIButton *)sender {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //登陆成功后把用户名和密码存储到UserDefault
    [userDefaults setObject:self.idTextField.text forKey:@"cid"];

    
    [userDefaults synchronize];
    
    
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    
    
    
}
- (void)handleWithBack:(UIBarButtonItem *)sender{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //登陆成功后把用户名和密码存储到UserDefault
    [userDefaults setObject:self.idTextField.text forKey:@"cid"];
    
    [userDefaults synchronize];
    
    
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.idTextField resignFirstResponder];
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
