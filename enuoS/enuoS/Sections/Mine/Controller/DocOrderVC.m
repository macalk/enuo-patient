//
//  DocOrderVC.m
//  enuoS
//
//  Created by apple on 17/2/15.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DocOrderVC.h"

@interface DocOrderVC ()

@end

@implementation DocOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createCustomNavViewWithTitle:@"预约" andLeftImage:@"白色返回" withLeftTitle:nil andRightImage:nil withRightTitle:nil];

    
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
