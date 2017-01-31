//
//  CheckOrderController.m
//  enuo4
//
//  Created by apple on 16/7/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CheckOrderController.h"

@interface CheckOrderController ()<UIWebViewDelegate>
@property (nonatomic,strong)UIWebView *webView;
@end

@implementation CheckOrderController



- (UIWebView *)webView{
    if (!_webView) {
        self.webView = [[UIWebView alloc]init];
    }return _webView;
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"绿色返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleBack)];
        self.navigationItem.leftBarButtonItem = leftItem;
    }return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view = self.webView;
    self.webView.delegate = self;
    [self loadString];
}
- (void)handleBack{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)loadString
{
    NSUserDefaults *users = [NSUserDefaults standardUserDefaults];
    NSString *name = [users objectForKey:@"name"];
    NSMutableDictionary *url2 = [NSMutableDictionary dictionaryWithObject:name forKey:@"unique"];
    [url2 setObject:@"2" forKey:@"type"];
    NSLog(@"url2 = %@",url2);
    
    
    NSString *str = [NSString stringWithFormat:@"username=%@",name];
    //NSString *str2 = [NSString stringWithFormat:@"type=2"];
    //[array addObject:str];
    //NSString * str3 = [NSString stringWithFormat:@"%@&%@",str,str2];
    
    // 1. URL 定位资源,需要资源的地址
    NSString *urlStr = @"http://www.enuo120.com/index.php/Mobile/Patient/myhealth.html";
    // NSString *urlStr = @"http://www.enuo120.com/index.php/wechat/nurse_vote";
    NSURL *url = [NSURL URLWithString:urlStr];
    
    
    
    NSMutableURLRequest * re = [[NSMutableURLRequest alloc]initWithURL:url];
    
    [re setHTTPMethod:@"POST"];
    
    // NSError *parseError = nil;
    // NSLog(@"")
    //NSData *jsonData = [NSJSONSerialization dataWithJSONObject:url2 options:NSJSONWritingPrettyPrinted error:&parseError al];
    //   NSString *url3 = [self dictionaryToJson:url2];
    // NSLog(@"url3 = %@",url3);
    NSData * postData1 = [str dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    [re setHTTPBody:postData1];
    
    
    // 3. 发送请求给服务器
    NSLog(@"RE =%@",re);
    [self.webView loadRequest:re];
    
}

- (NSString*)dictionaryToJson:(NSMutableDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
  
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
  
    return YES;
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *str = @"javascript:function setHide(){document.getElementById('header').style.display='none';}setHide();";
    [webView stringByEvaluatingJavaScriptFromString:str];
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
