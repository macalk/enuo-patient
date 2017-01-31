//
//  AboutEnuoController.m
//  enuo4
//
//  Created by apple on 16/5/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AboutEnuoController.h"
#import "FunctionController.h"
@interface AboutEnuoController ()
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@property (weak, nonatomic) IBOutlet UIButton *telephButton;
@property (weak, nonatomic) IBOutlet UIView *functionLabel;
@property (weak, nonatomic) IBOutlet UIButton *webButton;

@end

@implementation AboutEnuoController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"绿色返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleBackBarItem)];
        self.navigationItem.leftBarButtonItem = leftItem;

    }return self;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航条底图"] forBarMetrics:0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];

        self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor =  [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    [self creatView];
}

- (void)handleBackBarItem{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)handleTelePhone:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://95105120"]];
    
}
- (IBAction)handleWebiteWithButton:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.enuo120.com"]];
 
    
    
}

- (void)creatView{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    CFShow(CFBridgingRetain(infoDictionary));
    // app名称
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    // app build版本
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    self.versionLabel.text = [NSString stringWithFormat:@"%@",app_build];
    NSLog(@"app_Name =%@,app_Version=%@,app_build=%@",app_Name,app_Version,app_build);
    
    UITapGestureRecognizer *tapGisizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handeWithTap:)];
    //设置轻拍次数  单击  双击  三连击。。。。。
    tapGisizer.numberOfTapsRequired = 1;//单击
    //设置触摸手指的个数
    tapGisizer.numberOfTouchesRequired = 1;//触摸手指的个数
    // 将轻拍手势添加到相应的视图上（也就是说将手势添加到视图上，那么点击该视图，就应该响应轻拍手势响应的事件）
    [self.functionLabel addGestureRecognizer:tapGisizer];
}

- (void)handeWithTap:(UITapGestureRecognizer *)sender{
    
    FunctionController *funVC = [[FunctionController alloc]init];
    UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:funVC];
    [self presentViewController:naNC animated:YES completion:^{
        
    }];
    
    
    
    
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
