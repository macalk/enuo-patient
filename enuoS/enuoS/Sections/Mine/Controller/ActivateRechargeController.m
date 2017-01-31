//
//  ActivateRechargeController.m
//  enuo4
//
//  Created by apple on 16/5/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ActivateRechargeController.h"
#import <AFNetworking.h>
#import "Macros.h"
@interface ActivateRechargeController ()<UIAlertViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *cardTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UILabel *optionLabel;

@property (nonatomic,strong)UIAlertView *alert;
@property (nonatomic,strong)UIAlertController *alertView;
@property (nonatomic,copy)NSString *arrStr;
@end

@implementation ActivateRechargeController


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"绿色返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleBack)];
        self.navigationItem.leftBarButtonItem = leftItem;
    }return self;
}






- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    [self.cardTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [self.cardTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [self.cardTextField setReturnKeyType:UIReturnKeyDone];
    [self.cardTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    
    [self.cardTextField setHighlighted:YES];
    self.cardTextField.delegate = self;
    [self.passwordField setKeyboardType:UIKeyboardTypeNumberPad];
    [self.passwordField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [self.passwordField setReturnKeyType:UIReturnKeyDone];
    [self.passwordField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    
    [self.passwordField setHighlighted:YES];
    self.passwordField.delegate = self;
//富文本 图文混排
    NSString *str = @"持卡须知:\n1.本卡仅在e诺监管平台中合作的医疗机构使用\n2.本卡为现金充值卡，不兑现、不找零，可充值使用\n3.本卡一次只能用一张，不叠加使用\n4.仅限于在e诺平台中有“";
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:str];
     NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    attch.image = [UIImage imageNamed:@"star"];
    // 设置图片大小
    attch.bounds = CGRectMake(0, 0, 32, 32);
    
    // 创建带有图片的富文本
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
   //NSString *strOne= [NSString stringWithFormat:attri,string];
    [attri appendAttributedString:string];
    NSString *strTwo = @"”标的病种的医疗机构使用\n5.本卡须在有效期内使用，过期无效\n6.杭州景诺健康科技有限公司有最终解释权";
    NSMutableAttributedString *attriOne = [[NSMutableAttributedString alloc] initWithString:strTwo];

    [attri appendAttributedString:attriOne];
    self.optionLabel.attributedText = attri;
}

- (void)handleBack{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.cardTextField resignFirstResponder];
    [self.passwordField resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.cardTextField resignFirstResponder];
    [self.passwordField resignFirstResponder];
    return YES;
}

//确认激活按钮！
- (IBAction)handleSureCode:(UIButton *)sender {
    [self.cardTextField resignFirstResponder];
    [self.passwordField resignFirstResponder];
    NSString *str = @"http://www.enuo120.com/index.php/app/Patient/add_vip";
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
     NSString *name = [user objectForKey:@"name"];
    NSString *url = [NSString stringWithFormat:str,name,self.cardTextField.text,self.passwordField.text];
    NSDictionary *heardBody = @{@"username":name,@"cardno":self.cardTextField.text,@"password":self.passwordField.text};
    
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger POST:url parameters:heardBody progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleWithData:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}
- (void)handleWithData:(NSDictionary *)data{
  self.arrStr = data[@"data"][@"message"];
    if ([self.cardTextField.text isEqualToString:@""]||[self.passwordField.text isEqualToString:@""]) {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请补全信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        }else{
            UIAlertController *alertView =[UIAlertController alertControllerWithTitle:@"提示" message:@"请补全信息" preferredStyle:UIAlertControllerStyleAlert];
          [alertView addAction:[UIAlertAction actionWithTitle:@"提示" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
              
          }]];
            [self.navigationController presentViewController:alertView animated:YES completion:nil];
        }
        
        
    }else{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
        self.alert = [[UIAlertView alloc]initWithTitle:@"提示" message:_arrStr delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
    
        [self performSelector:@selector(popVC) withObject:nil afterDelay:0.5];
        
    }else{
        self.alertView = [UIAlertController alertControllerWithTitle:@"提示" message:_arrStr preferredStyle:UIAlertControllerStyleAlert];
        [self.alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
              if ([self.arrStr isEqualToString:@"该vip充值卡激活成功"]) {
                  [self.navigationController dismissViewControllerAnimated:YES completion:nil];
              }
        }]];
        [self performSelector:@selector(popVCcc) withObject:nil afterDelay:
         0.5];

    
      }
    }
}
- (void)popVC{
    [self.alert show];
}
- (void)popVCcc{
  
        [self presentViewController:self.alertView animated:YES completion:^{
            
        }];
    
 
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            if ([self.arrStr isEqualToString:@"该vip充值卡激活成功"]) {
                [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            }
            break;
            
        default:
            break;
    }
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
