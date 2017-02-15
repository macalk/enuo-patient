//
//  MakePayMiMaViewController.m
//  enuo4
//
//  Created by apple on 16/5/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MakePayMiMaViewController.h"
#import <AFNetworking.h>
@interface MakePayMiMaViewController ()<UITextFieldDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *oneTextField;
@property (weak, nonatomic) IBOutlet UITextField *twoTextField;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (strong,nonatomic)UIAlertView *alertView1;
@property (strong,nonatomic)UIAlertController *alertView2;
@property (strong,nonatomic)UIAlertView *alertView3;
@property (strong,nonatomic)UIAlertController *alertView4;
@end

@implementation MakePayMiMaViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"绿色返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleBack)];
        self.navigationItem.leftBarButtonItem = leftItem;
        self.navigationItem.title = @"设置支付密码";
    }return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
}
//注册
- (void)handleBack{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)handleSureBtn:(UIButton *)sender {
    
    if (![self.oneTextField.text isEqualToString:self.twoTextField.text]) {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
            self.alertView3 = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请保持修改密码一致"delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [self.alertView3 show];
            
        }else{
            self.alertView4 = [UIAlertController alertControllerWithTitle:@"提示" message:@"请保持修改密码一致"
                                                           preferredStyle:UIAlertControllerStyleAlert];
            [self.alertView4 addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:self.alertView4 animated:YES completion:^{
                
            }];
            
        }

    }else{
    
        NSString *str = @"http://www.enuo120.com/index.php/phone/Json/setppw?username=%@&pass=%@";
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *name = [user objectForKey:@"name"];
        NSString *url = [NSString stringWithFormat:str,name,self.oneTextField.text];
        
        BaseRequest *request = [[BaseRequest alloc]init];
        [request POST:url params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            [self handelWithDic:responseObject];
            
        } fail:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    
    }
    
}

- (void)handelWithDic:(NSDictionary *)data{
    NSString *arr = data[@"data"];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
        self.alertView1 = [[UIAlertView alloc]initWithTitle:@"提示" message:arr delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
        //self.alertView1.delegate =self;
        [self performSelector:@selector(popVC) withObject:nil afterDelay:0.5];
        
    }else{
        self.alertView2 = [UIAlertController alertControllerWithTitle:@"提示" message:arr
                                                       preferredStyle:UIAlertControllerStyleAlert];
        [self.alertView2 addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           [self.navigationController popViewControllerAnimated:YES];
            
        }]];
        [self performSelector:@selector(popVCcc) withObject:nil afterDelay:0.5];
        
    }
}
- (void)popVC{
    [self.alertView1 show];
}
- (void)popVCcc{
    [self presentViewController:self.alertView2 animated:YES completion:^{
        
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
            break;
            
        default:
            break;
    }
}


- (void)creatView{
    //原密码
    [self.oneTextField setKeyboardType:UIKeyboardTypeNumberPad];
    self.oneTextField.secureTextEntry = YES;
    [self.oneTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [self.oneTextField setReturnKeyType:UIReturnKeyDone];
    [self.oneTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    //关闭首字母大写
    [self.oneTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
    
    [self.oneTextField setHighlighted:YES];
    self.oneTextField.delegate = self;
    //新密码
    [self.twoTextField setKeyboardType:UIKeyboardTypeNumberPad];
    self.twoTextField.secureTextEntry = YES;
    [self.twoTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [self.twoTextField setReturnKeyType:UIReturnKeyDone];
    [self.twoTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    //关闭首字母大写
    [self.twoTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
    
    [self.twoTextField setHighlighted:YES];
    self.twoTextField.delegate = self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.oneTextField resignFirstResponder];
    [self.twoTextField resignFirstResponder];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.oneTextField resignFirstResponder];
    [self.twoTextField resignFirstResponder];
    
    return YES;
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
