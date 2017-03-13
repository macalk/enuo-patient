//
//  RootTabBarViewController.m
//  enuoNew
//
//  Created by apple on 16/6/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "RootTabBarViewController.h"
#import "HomeViewController.h"
#import "PromisesViewController.h"
#import "MineTableController.h"
#import "PromiseScrollController.h"
#import "HomeVC.h"
@interface RootTabBarViewController ()

@end

@implementation RootTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self creatViewController];
}


- (void)creatViewController{
    HomeVC *homeVc = [[HomeVC alloc]init];
    UINavigationController *homeNc = [[UINavigationController alloc]initWithRootViewController:homeVc];
    
    homeNc.tabBarItem =[[UITabBarItem alloc]initWithTitle:@"首页" image:[[UIImage imageNamed:@"灰色主页"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"绿色主页"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    PromiseScrollController *promVc = [[PromiseScrollController alloc]init];
    UINavigationController *promNc = [[UINavigationController alloc]initWithRootViewController:promVc];
    
    promNc.tabBarItem =[[UITabBarItem alloc]initWithTitle:@"约定医疗" image:[[UIImage imageNamed:@"灰色医疗"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"绿色医疗"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
 
    
    MineTableController *mineVc = [[MineTableController alloc]init];
    UINavigationController *minNc = [[UINavigationController alloc]initWithRootViewController:mineVc];
    
    minNc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我的e诺" image:[[UIImage imageNamed:@"个人-(1)"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"个人-(2)"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    self.viewControllers = @[homeNc,promNc,minNc];
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
