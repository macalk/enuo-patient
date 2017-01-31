//
//  MImaViewController.m
//  enuo4
//
//  Created by apple on 16/5/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MImaViewController.h"
#import <AFNetworking.h>
@interface MImaViewController ()<UITextFieldDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *olderPassTextField;
@property (weak, nonatomic) IBOutlet UITextField *changPassTextField;
@property (weak, nonatomic) IBOutlet UITextField *SurePassTextField;
@property (weak, nonatomic) IBOutlet UIButton *SureBtn;
@property (strong,nonatomic)UIAlertView *alertView1;
@property (strong,nonatomic)UIAlertController *alertView2;
@property (strong,nonatomic)UIAlertView *alertView3;
@property (strong,nonatomic)UIAlertController *alertView4;
@end

@implementation MImaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    [self ceatView];

}
- (IBAction)handleSureButton:(id)sender {
    NSUserDefaults *users = [NSUserDefaults standardUserDefaults];
    NSString *name = [users objectForKey:@"name"];
    
    NSString *strs = @"http://www.enuo120.com/index.php/app/patient/change_pwd";
    if (![self.changPassTextField.text isEqualToString: self.SurePassTextField.text]) {
        NSLog(@"aaaa == %@     bbbbb=%@",self.changPassTextField.text,self.SurePassTextField.text);
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
        NSString *url = [NSString stringWithFormat:strs,name,self.olderPassTextField.text,self.changPassTextField.text];
        
        NSDictionary *heardBody  = @{@"username":name,@"ypassword":self.olderPassTextField.text,@"password":self.changPassTextField.text};
        AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
        [manger POST:url parameters:heardBody progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self handelWithDic:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }



}

- (void)handelWithDic:(NSDictionary *)data{
    NSString *arr = data[@"data"][@"message"];
    
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
             [self.navigationController popViewControllerAnimated:YES];
            break;
            
        default:
            break;
    }
}

- (void)ceatView{
    //原密码
    [self.olderPassTextField setKeyboardType:UIKeyboardTypeASCIICapable];
    self.olderPassTextField.secureTextEntry = YES;
    [self.olderPassTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [self.olderPassTextField setReturnKeyType:UIReturnKeyDone];
    [self.olderPassTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    //关闭首字母大写
    [self.olderPassTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
    
    [self.olderPassTextField setHighlighted:YES];
    self.olderPassTextField.delegate = self;
    //新密码
    [self.changPassTextField setKeyboardType:UIKeyboardTypeASCIICapable];
    self.changPassTextField.secureTextEntry = YES;
    [self.changPassTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [self.changPassTextField setReturnKeyType:UIReturnKeyDone];
    [self.changPassTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    //关闭首字母大写
    [self.changPassTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
    
    [self.changPassTextField setHighlighted:YES];
    self.changPassTextField.delegate = self;
    
//确认密码
    
    [self.SurePassTextField setKeyboardType:UIKeyboardTypeASCIICapable];
    self.SurePassTextField.secureTextEntry = YES;
    [self.SurePassTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [self.SurePassTextField setReturnKeyType:UIReturnKeyDone];
    [self.SurePassTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    //关闭首字母大写
    [self.SurePassTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
    
    [self.SurePassTextField setHighlighted:YES];
    self.SurePassTextField.delegate = self;
    


}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.olderPassTextField  resignFirstResponder];
       [self.SurePassTextField  resignFirstResponder];
       [self.changPassTextField  resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.olderPassTextField  resignFirstResponder];
    [self.SurePassTextField  resignFirstResponder];
    [self.changPassTextField  resignFirstResponder];
    return YES;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
