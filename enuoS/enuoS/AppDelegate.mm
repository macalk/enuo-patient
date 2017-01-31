//
//  AppDelegate.m
//  enuoS
//
//  Created by apple on 16/7/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "RootTabBarViewController.h"
#import "Macros.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <AFNetworking.h>
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
#import "PayDetailViewController.h"
#import <NIMSDK.h>


#define _IPHONE80_ 80000
#define NUM 3
#define kWidth_Page 100
BMKMapManager* _mapManager;



@interface AppDelegate ()<UIAlertViewDelegate,WXApiDelegate,UIScrollViewDelegate>
@property (nonatomic,copy)NSString *strMsg;
@property (nonatomic,copy)NSString *updateIos;


@property (nonatomic,strong) UIView *FirstLaunchView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *page;
@property (nonatomic, strong) NSArray *array;

@end

@implementation AppDelegate


- (NSArray *)array{
    if (!_array) {
        self.array = @[@"引导1.jpg",@"引导2.jpg",@"引导3.jpg"];
    }return _array;
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
   [UINavigationBar appearance].barTintColor=[UIColor whiteColor];
    
    
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:@"tNyUHdWqQ3Rt80TEpyDqexpbKTZRXILR" generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    

    RootTabBarViewController *rootVC = [[RootTabBarViewController alloc]init];
    self.window.rootViewController = rootVC;
    [self.window makeKeyAndVisible];
    
    
       [WXApi registerApp:@"wx0e5f661a5a2acbe8"];
    
    
    
    
    //用户引导页
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    if([userDefaults objectForKey:@"FirstLoad"] == nil) {
        [userDefaults setBool:NO forKey:@"FirstLoad"];
        [self layoutLaunchView];
    }
    
    [[NIMSDK sharedSDK] registerWithAppID:@"449d6a0b04eba71fb27db182af4ac7ae"
                                  cerName:nil];

    return YES;
}

#pragma mark ---引导页


- (void)layoutLaunchView {
    //布局首次登陆视图
    self.FirstLaunchView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds] ;
    _FirstLaunchView.backgroundColor = [UIColor whiteColor];
    [self.window addSubview:self.FirstLaunchView];
    //布局滚动视图
    self.scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds] ;
    _scrollView.contentSize = CGSizeMake(kScreenWidth * NUM, kScreenHeigth);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.delegate = self;
    [self.FirstLaunchView addSubview:_scrollView];
    //布局图片
    for (int i = 0; i < NUM; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth * i, 0, kScreenWidth, kScreenHeigth)];
        imageView.image = [UIImage imageNamed:self.array[i]];
        [self.scrollView addSubview:imageView];
       
        
        if (i == NUM - 1) {
            //布局进入按钮
            imageView.userInteractionEnabled = YES;
            UIButton *enterBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            enterBtn.frame = CGRectMake(0, kScreenHeigth - 125,kScreenWidth, 64);
            //[enterBtn setTitle:@"进入应用" forState:UIControlStateNormal];
            //enterBtn.backgroundColor = [UIColor grayColor];
            [enterBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [enterBtn addTarget:self action:@selector(handleEnter:) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:enterBtn];
        }
    }
    //布局分页索引
    self.page = [[UIPageControl alloc] initWithFrame:CGRectMake((kScreenWidth - kWidth_Page) / 2, kScreenHeigth - 80, kWidth_Page, 40)] ;
    _page.numberOfPages = 3;
    _page.currentPageIndicatorTintColor = [UIColor brownColor];
    _page.pageIndicatorTintColor = [UIColor grayColor];
    [_page addTarget:self action:@selector(handlePage) forControlEvents:UIControlEventValueChanged];
    [self.FirstLaunchView addSubview:_page];
}

- (void)handlePage {
    CGFloat x = self.page.currentPage * kScreenWidth;
    self.scrollView.contentOffset = CGPointMake(x, 0);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.page.currentPage = scrollView.contentOffset.x / kScreenWidth;
}

- (void)handleEnter:(UIButton *)sender {
    self.FirstLaunchView.hidden = YES;
}








- (void)onGetNetworkState:(int)iError{
    if (0 == iError) {
        NSLog(@"联网成功");
    }else{
        NSLog(@"onGetNetworkState %d",iError);
    }
}

- (void)onGetPermissionState:(int)iError{
    if (0 == iError) {
        NSLog(@"授权成功");
    }else{
        NSLog(@"onGetPermissionState %d",iError);
    }
}


- (BOOL)application:(UIApplication *)application
             openURL:(NSURL *)url
   sourceApplication:(NSString *)sourceApplication
          annotation:(id)annotation {
    
          //跳转支付宝钱包进行支付，处理支付结果
           [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                             NSLog(@"result = %@",resultDic);
                 }];
    
        return YES;}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return  [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    return [WXApi handleOpenURL:url delegate:self];
}
- (void)onResp:(BaseResp *)resp{
    //支付返回结果，实际支付结果需要去微信服务端查询
    self.strMsg = [NSString stringWithFormat:@"支付结果"];
    switch (resp.errCode) {
        case WXSuccess:
            _strMsg =@"支付结果：成功";
            NSLog(@"支付成功-PaySuccess,retcode = %d",resp.errCode);
            break;
            
        default:
            _strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d,retstr = %@",resp.errCode,resp.errStr];
            NSLog(@"错误！retcode = %d,retstr = %@",resp.errCode,resp.errStr);
            break;
    }
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"支付结果" message:_strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.delegate = self;
        [alert show];
        //PayDetailViewController *payVC = [[PayDetailViewController alloc]init];
    }else{
        //        PayDetailViewController *payVC = [[PayDetailViewController alloc]init];
        //        UINavigationController *naVC = [[UINavigationController alloc]initWithRootViewController:payVC];
        RootTabBarViewController *rooVC = [[RootTabBarViewController alloc]init];
        
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"支付结果" message:_strMsg preferredStyle:UIAlertControllerStyleAlert];
        [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if ([_strMsg isEqualToString:@"支付结果：成功"]) {
                
                [self.window.rootViewController presentViewController:rooVC animated:YES completion:^{
                    
                }];
            }
            
        }]];
        [self.window.rootViewController presentViewController:alertView animated:YES completion:^{
            
        }];
        
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    //    PayDetailViewController *payVC = [[PayDetailViewController alloc]init];
    //    UINavigationController *naVC = [[UINavigationController alloc]initWithRootViewController:payVC];
    RootTabBarViewController *rooVC = [[RootTabBarViewController alloc]init];
    
    switch (buttonIndex) {
        case 0:
            if ([_strMsg isEqualToString:@"支付结果：成功"]) {
                [self.window.rootViewController presentViewController:rooVC animated:YES completion:^{
                    
                }];
            }
            
            break;
        case 1:
            
            if ( alertView.tag ==20) {
                NSString *url = @"https://appsto.re/cn/z1bzcb.i";
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:url]];
                
            }
            
            
            
            break;
            
        default:
            break;
    }
}





- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.enuo120.enuoS" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"enuoS" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"enuoS.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
