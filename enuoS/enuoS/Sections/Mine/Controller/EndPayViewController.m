//
//  EndPayViewController.m
//  enuo4
//
//  Created by apple on 16/4/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "EndPayViewController.h"
#import <AFNetworking.h>
#import "Macros.h"
#import "EvaluateTableController.h"
#import "EndPJNewViewController.h"
@interface EndPayViewController ()<UITextFieldDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *secretTextfield;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;
@property (nonatomic,strong)UIAlertView *alert;
@property (nonatomic,strong)UIAlertController *alertView;
@property (nonatomic,copy)NSString *strOne;

@end

@implementation EndPayViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
     
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"登录返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleBackBarItem)];
        self.navigationItem.leftBarButtonItem = leftItem;
        
    }return self;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航条底图"] forBarMetrics:0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    self.navigationController.navigationBar.translucent = NO;
    // 配置密码输入框
    [self.secretTextfield setKeyboardType:UIKeyboardTypeASCIICapable];
    [self.secretTextfield setClearButtonMode:UITextFieldViewModeWhileEditing];
    [self.secretTextfield setReturnKeyType:UIReturnKeyDone];
    [self.secretTextfield setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [self.secretTextfield setAutocorrectionType:UITextAutocorrectionTypeNo];
    [self.secretTextfield setHighlighted:YES];
    
    
    self.secretTextfield.placeholder = @"请输入支付密码";
    self.secretTextfield.secureTextEntry = YES;
    self.secretTextfield.delegate = self;
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)handleBackBarItem{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (IBAction)handleSureButton:(UIButton *)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *name = [userDefaults objectForKey:@"name"];
    NSString *str = @"http://www.enuo120.com/index.php/phone/Json/tran?username=%@&paypassword=%@&pro=%@";
    
    
    NSString *url = [NSString stringWithFormat:str,name,self.secretTextfield.text,self.oneReceiver];
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleViewWithData:responseObject];
        NSLog(@"responseObject = %@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

- (void)handleViewWithData:(NSDictionary *)data{
    self.strOne =  data[@"data"];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
        self.alert = [[UIAlertView alloc]initWithTitle:@"提示" message:_strOne delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
        self.alert.delegate =self;
        [self performSelector:@selector(popVC) withObject:nil afterDelay:0.5];
        
    }else{
        self.alertView = [UIAlertController alertControllerWithTitle:@"提示" message:_strOne preferredStyle:UIAlertControllerStyleAlert];
        [self.alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
     
            if ([_strOne isEqualToString:@"用户确认支付成功"]) {
               EndPJNewViewController *evaVC = [[EndPJNewViewController alloc]init];
                UINavigationController *naVC = [[UINavigationController alloc]initWithRootViewController:evaVC];
                    evaVC.receiver = self.oneReceiver;
                [self presentViewController:naVC animated:YES completion:^{
                    NSLog(@"汤四爷在此 跳到评价去");
                }];
            }else if ([_strOne isEqualToString:@"用户确认分期支付成功"]){
                [self popoverPresentationController];
            }else{
                NSLog(@"唐五爷在此，尔等前来受死");
            }
            
        }]];
        [self performSelector:@selector(popVCcc) withObject:nil afterDelay:0.5];
        
    }
    
    
    
    
    
    
    
    

}
- (void)popVCcc{
    [self presentViewController:self.alertView animated:YES completion:^{
    
    }];
}

- (void)popVC{
    [self.alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            if ([_strOne isEqualToString:@"用户确认支付成功"]) {
                EvaluateTableController *evaVC = [[EvaluateTableController alloc]init];
                UINavigationController *naVC = [[UINavigationController alloc]initWithRootViewController:evaVC];
                evaVC.reseiver = self.oneReceiver;
                [self presentViewController:naVC animated:YES completion:^{
                    NSLog(@"汤四爷在此 跳到评价去");
                }];
            }else if ([_strOne isEqualToString:@"用户确认分期支付成功"]){
                NSLog(@"跳到个人中心");
                    [self popoverPresentationController];
            }else{
                NSLog(@"唐五爷在此，尔等前来受死");
            }

            
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


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_secretTextfield resignFirstResponder];
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
