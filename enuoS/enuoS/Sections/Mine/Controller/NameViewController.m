//
//  NameViewController.m
//  enuoS
//
//  Created by apple on 16/8/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "NameViewController.h"

@interface NameViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@end

@implementation NameViewController


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
    [self.nameText setKeyboardType:UIKeyboardTypeDefault];
    [self.nameText setClearButtonMode:UITextFieldViewModeWhileEditing];
    [self.nameText setReturnKeyType:UIReturnKeyDefault];
    [self.nameText setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    //关闭首字母大写
    [self.nameText setAutocorrectionType:UITextAutocorrectionTypeNo];
    
    [self.nameText setHighlighted:YES];
    self.nameText.delegate = self;

    
   
}



- (void)handleWithBack:(UIBarButtonItem *)sender{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //登陆成功后把用户名和密码存储到UserDefault
    [userDefaults setObject:self.nameText.text forKey:@"nameStr"];
  
    [userDefaults synchronize];
    

    
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];


}



- (IBAction)handleWithSureBtn:(UIButton *)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //登陆成功后把用户名和密码存储到UserDefault
    [userDefaults setObject:self.nameText.text forKey:@"nameStr"];
    
    [userDefaults synchronize];
    

    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
   

}
- (void)returnText:(ReturnTextBlock)block {
    self.returnTextBlock = block;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.nameText resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
}



@end
