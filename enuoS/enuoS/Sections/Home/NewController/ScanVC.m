//
//  ScanVC.m
//  enuoS
//
//  Created by apple on 17/3/13.
//  Copyright © 2017年 apple. All rights reserved.

#import "ScanVC.h"
#import "Macros.h"

#import <AVFoundation/AVFoundation.h>

//AVFoundation 是一个很大的基础库,用来创建基于时间的视听媒体,可以使用它来检查,创建,编辑或媒体文件,也可以输入流从设备和操作视频和回放
@interface ScanVC ()<AVCaptureMetadataOutputObjectsDelegate>

//AVCaptureDevice代表了物理捕获设备:如摄像头
@property (strong,nonatomic)AVCaptureDevice *device;

//AVCaptureDeviceInput是AVCaptureDeviceInput 的一个子类,处理输入捕获回话,
@property (strong,nonatomic)AVCaptureDeviceInput *input;

//AVCaptureMetadataOutput 处理输出的捕获会话,捕获的对象传递给一个代理AVCaptureMetadataOutputObjectsDelegate.协议方法在指定的派发队列上执行
@property (strong,nonatomic)AVCaptureMetadataOutput *outPut;

//管理输入和输出流,包含开启和停止会话方法
@property (strong,nonatomic) AVCaptureSession *session;

//CALayer的子类, 显示捕获到的相机输出流
@property (strong,nonatomic) AVCaptureVideoPreviewLayer *preview;

//使用ios自带的二维码扫描

@end

@implementation ScanVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //开始
    [self.session startRunning];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createCustomNavViewWithTitle:@"扫一扫 便捷约定" andLeftImage:@"白色返回" withLeftTitle:nil andRightImage:nil withRightTitle:nil];
    self.navigationController.navigationBar.translucent = YES;

    //二维码扫描
    [self setupCamera];
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"扫描框_N"];
    imageView.center = CGPointMake(self.view.center.x, self.view.center.y);
    imageView.bounds = CGRectMake(0, 0, 140, 140);
    [self.view addSubview:imageView];
}

- (void)setupCamera {
    
    //Device 获取   Video:摄像头
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    //Input初始化一个输入流
    NSError * error;
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:&error];
    
    //Output 创建实例 并实现代理
    self.outPut = [[AVCaptureMetadataOutput alloc] init];
    //主队列里代理
    [self.outPut setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    
    //Session
    self.session = [[AVCaptureSession alloc] init];
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    
    if ([self.session canAddInput:self.input]) {
        [self.session addInput:self.input];
    }
    if ([self.session canAddOutput:self.outPut]) {
        [self.session addOutput:self.outPut];
    }
    
    //条码类型
    _outPut.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode128Code];
    //Preview
    self.preview = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.preview.frame = CGRectMake(0, 64, 414, 736-64);
    [self.view.layer addSublayer:self.preview];
    
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    
    NSString *stringValue;
    
    
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        stringValue = metadataObj.stringValue;
        
        NSLog(@"stringValue:%@",stringValue);
        
        UIWebView *webView = [[UIWebView alloc]init];
        webView.frame = CGRectMake(0, 64,kScreenWidth , kScreenHeigth-64);
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",stringValue]]]];
        [self.view addSubview:webView];
    }
    
    [_session stopRunning];
    
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
