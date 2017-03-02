//
//  RootViewController.m
//  enuoDoctor
//
//  Created by apple on 16/12/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "RootViewController.h"
#import <Masonry.h>
#import "UIColor+Extend.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self AFNetworkStatus];
}

- (void)createCustomNavViewWithTitle:(NSString *)titleStr andLeftImage:(NSString *)leftImageStr withLeftTitle:(NSString *)leftTitleStr andRightImage:(NSString *)rightImageStr withRightTitle:(NSString *)rightTitleStr {
    
    if (leftTitleStr == nil) {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:leftImageStr] style:UIBarButtonItemStyleDone target:self action:@selector(leftItemBack)];
        self.navigationItem.leftBarButtonItem = leftItem;
    }else {
        
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leftItemBack)];
        
        UIView *leftView = [[UIView alloc]init];
        leftView.frame = CGRectMake(0, 0, self.navigationItem.leftBarButtonItem.width,44);
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftView];
        
        [leftView addGestureRecognizer:tapGes];
        
        UIImageView *leftImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:leftImageStr]];
        [leftView addSubview:leftImageView];
        
        UILabel *leftLabel = [[UILabel alloc]init];
        leftLabel.textColor = [UIColor whiteColor];
        leftLabel.text = leftTitleStr;
        leftLabel.font = [UIFont systemFontOfSize:15];
        [leftView addSubview:leftLabel];
        
        
        [leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(leftView);
            make.centerY.equalTo(leftView);
            make.size.mas_offset(CGSizeMake(15, 15));
        }];
        [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(leftImageView);
            make.left.equalTo(leftImageView.mas_right).with.offset(10);
        }];

    }
    
    if (rightTitleStr == nil) {
        UIBarButtonItem *rigtItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:rightImageStr] style:UIBarButtonItemStyleDone target:self action:@selector(rightItemClick)];
        self.navigationItem.rightBarButtonItem = rigtItem;
    }else {
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:rightTitleStr style:UIBarButtonItemStyleDone target:self action:@selector(rightItemClick)];
        self.navigationItem.rightBarButtonItem = rightItem;
        
        [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:13], NSFontAttributeName, nil] forState:UIControlStateNormal];
    }
    
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.center = self.navigationItem.titleView.center;
    titleLabel.bounds = CGRectMake(0, 0, 100, 20);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = titleStr;
    self.navigationItem.titleView = titleLabel;
    
    self.navigationController.navigationBar.barTintColor = [UIColor stringTOColor:@"#22ccc6"];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)leftItemBack {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightItemClick {
    NSLog(@"1111");
}

#pragma mark---提示框

- (void)createAlterViewWithMessage:(NSString *)message withSureBtn:(BOOL)sureYON withCancelBtn:(BOOL)cancelYON withDeleteBtn:(BOOL)deleteYON {
    UIAlertController *alertControll=[UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    if (sureYON == YES) {

        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertControll addAction:sure];
 
    }
    
    if (cancelYON == YES) {
        UIAlertAction *cancelButton=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertControll addAction:cancelButton];
    }
    
    if (deleteYON == YES) {
        UIAlertAction *deleteButton=[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:nil];
        [alertControll addAction:deleteButton];
    }
    
    
    [self presentViewController:alertControll animated:YES completion:nil];
    

}

- (void)AFNetworkStatus{
    
    //1.创建网络监测者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    /*枚举里面四个状态  分别对应 未知 无网络 数据 WiFi
     typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
     AFNetworkReachabilityStatusUnknown          = -1,      未知
     AFNetworkReachabilityStatusNotReachable     = 0,       无网络
     AFNetworkReachabilityStatusReachableViaWWAN = 1,       蜂窝数据网络
     AFNetworkReachabilityStatusReachableViaWiFi = 2,       WiFi
     };
     */
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //这里是监测到网络改变的block  可以写成switch方便
        //在里面可以随便写事件
        
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络状态");
                break;
            case AFNetworkReachabilityStatusNotReachable:
            {
                UIAlertController *alertControll = [UIAlertController alertControllerWithTitle:@"提示" message:@"当前网络不可用" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [alertControll addAction:sureAction];
                [self presentViewController:alertControll animated:YES completion:nil];
            }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"蜂窝数据网");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi网络");
                
                break;
                
            default:
                break;
        }
        
    }] ;
    
    [manager startMonitoring];
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
