//
//  CarrWebController.m
//  enuoNew
//
//  Created by apple on 16/7/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CarrWebController.h"
#import "ZLCWebView.h"
#define isiOS8 __IPHONE_OS_VERSION_MAX_ALLOWED>=__IPHONE_8_0
#import "Macros.h"
@interface CarrWebController ()<ZLCWebViewDelegate>

@end

@implementation CarrWebController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createCustomNavViewWithTitle:nil andLeftImage:@"白色返回" withLeftTitle:nil andRightImage:nil withRightTitle:nil];
    
    ZLCWebView *my = [[ZLCWebView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth , kScreenHeigth)];
    NSLog(@"self.left = %@",self.receiver);
    NSString * str = [self.receiver stringByReplacingOccurrencesOfString:@"amp;" withString:@""];
    [my loadURLString:str];
//    NSString    *str= @"http://mp.weixin.qq.com/s?__biz=MzI0NDA1NzQxMw==&amp;mid=2649775638&amp;idx=1&amp;sn=0781b5e10a4aa35f46bedaad4b3dfcb6&amp;scene=0#wechat_redirect";
    my.delegate = self;
    [self.view addSubview:my];
    

}

- (void)leftItemBack {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
- (void)zlcwebViewDidStartLoad:(ZLCWebView *)webview
{
    NSLog(@"页面开始加载");
}

- (void)zlcwebView:(ZLCWebView *)webview shouldStartLoadWithURL:(NSURL *)URL
{
    NSLog(@"截取到URL：%@",URL);
}
- (void)zlcwebView:(ZLCWebView *)webview didFinishLoadingURL:(NSURL *)URL
{
    NSLog(@"页面加载完成");
    
}

- (void)zlcwebView:(ZLCWebView *)webview didFailToLoadURL:(NSURL *)URL error:(NSError *)error
{
    NSLog(@"加载出现错误");
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
