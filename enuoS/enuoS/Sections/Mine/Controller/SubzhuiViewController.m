//
//  SubzhuiViewController.m
//  enuoS
//
//  Created by apple on 16/8/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SubzhuiViewController.h"
#import <AFNetworking.h>
@interface SubzhuiViewController ()<UITextViewDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation SubzhuiViewController






- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"登录返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleWithBack:)];
        self.navigationItem.leftBarButtonItem = leftItem;
        
        
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(handleWithSubmit:)];
        
        self.navigationItem.rightBarButtonItem = rightItem;
    }return self;
}









- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self creatTextView];
}

- (void)creatTextView{
       self.textView.delegate = self;
    
    
    self.textView.textColor
    = [UIColor blackColor];//设置textview里面的字体颜色
    
    self.textView.font
    = [UIFont fontWithName:@"Arial" size:18.0];//设置字体名字和字体大小
    
    self.textView.delegate =
    self;//设置它的委托方法
    
    self.textView.backgroundColor
    = [UIColor whiteColor];//设置它的背景颜色
    
   self.textView.text = @"请输入评论内容";
    self.textView.returnKeyType
    = UIReturnKeyDefault;//返回键的类型
    
    self.textView.keyboardType
    = UIKeyboardTypeDefault;//键盘类型
    
    self.textView.scrollEnabled
    = YES;//是否可以拖动
    
    
    
    self.textView.autoresizingMask
    = UIViewAutoresizingFlexibleHeight;//自适应高度
    
    
}




- (void)handleWithBack:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)handleWithSubmit:(UIBarButtonItem *)sender{
    
    NSString *url = @"http://www.enuo120.com/index.php/app/patient/submit_zhui";
    
    NSDictionary *heardBody = @{@"type":self.receiver,@"id":self.cidReceiver};
    
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger POST:url parameters:heardBody progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleWithData: responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
    
}




- (void)handleWithData:(NSDictionary *)dic{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:dic[@"data"][@"message"] delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alert show];
    }else{
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:dic[@"data"][@"message"] preferredStyle:UIAlertControllerStyleAlert];
        [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }]];
        [self presentViewController:alertView animated:YES completion:^{
            
        }];
    }

   
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}









- (void)textViewDidBeginEditing:(UITextView *)textView{
    NSLog(@"lalla");
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.textView resignFirstResponder];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
