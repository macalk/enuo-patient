//
//  SelfInfoViewController.m
//  enuoS
//
//  Created by apple on 16/8/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SelfInfoViewController.h"



#import "Macros.h"
#import <AFNetworking.h>
#import <Masonry.h>
#import "NameViewController.h"
#import "IDNameViewController.h"
#import "EmailViewController.h"

#import "JobViewController.h"
#import "ILLLViewController.h"
#import <SVProgressHUD.h>

#define IOS8 [[[UIDevice currentDevice]systemVersion] floatValue] >= 8.0

@interface SelfInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UILabel *rightLabl;

@property (nonatomic,copy)NSString *nameSt;
@property (nonatomic,copy)NSString *sexStr;
@property (nonatomic,copy)NSString *cidStr;
@property (nonatomic,copy)NSString *emailStr;
@property (nonatomic,copy)NSString *jobStr;//职业accuoation
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *illStr;//过敏史allergic
@property (nonatomic,copy)NSString *ageStr;
@end

@implementation SelfInfoViewController

- (UILabel *)rightLabl{
    if (!_rightLabl) {
        self.rightLabl = [[UILabel alloc]init];
    }return _rightLabl;
}
- (UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc]init];
    }return _tableView;
}



- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"绿色返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleWithBack:)];
        self.navigationItem.leftBarButtonItem = leftItem;
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(handleWithSure:)];
        self.navigationItem.rightBarButtonItem = rightItem;
        
    }return self;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults *standUser = [NSUserDefaults standardUserDefaults];
    NSString *nameStr = [standUser objectForKey:@"nameStr"];
    NSString *sexS = [standUser objectForKey:@"sex"];
    NSString *cidS = [standUser objectForKey:@"cid"];
    NSString *emS= [standUser objectForKey:@"email"];
    NSString *jobS = [standUser objectForKey:@"job"];
    NSString *illS = [standUser objectForKey:@"ill"];

    if (emS) {
        self.emailStr = emS;
    }
    if (jobS) {
        self.jobStr = jobS;
    }
    if (illS) {
        self.illStr = illS;
    }
    NSLog(@"nameStr = %@",nameStr);
    
    [self creatTableView];
    //    [self.tableView reloadData];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD show];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航条底图"] forBarMetrics:0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    self.navigationController.navigationBar.translucent = NO;
    NSLog(@"ASDASD");
    [self requestDaTa];
    
    
}
- (void)handleWithBack:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)requestDaTa{
    NSString *url = @"http://www.enuo120.com/index.php/app/patient/personal_data";
     NSUserDefaults *standUser = [NSUserDefaults standardUserDefaults];
        NSString *nammme = [standUser objectForKey:@"name"];
    NSDictionary *heardBody =@{@"username":nammme};
    
    AFHTTPSessionManager *menger = [AFHTTPSessionManager manager];
    [menger POST:url parameters:heardBody progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleWithData:responseObject];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)handleWithData:(NSDictionary *)dic{
    NSDictionary *data = dic[@"data"];
    self.nameSt = data[@"name"];
    self.sexStr = data[@"sex"];
    self.emailStr = data[@"email"];
    self.jobStr = data[@"accupation"];
    self.illStr = data[@"allergic"];
    self.ageStr = data[@"age"];
    [self.tableView reloadData];
}




//SURE 、、、、、、、、sure,,,,,,,,,,,,,
- (void)handleWithSure:(UIBarButtonItem *)sender{
    NSString *url = @"http://www.enuo120.com/index.php/app/patient/change_information";
    NSUserDefaults *standUser = [NSUserDefaults standardUserDefaults];

    NSString *nammme = [standUser objectForKey:@"name"];
 
        self.name = nammme;
   
    if (self.nameSt &&self.emailStr) {
        NSDictionary *heardBody = @{@"username":self.name,@"email":self.emailStr,@"allergic":self.illStr,@"accupation":self.jobStr};
        AFHTTPSessionManager *mager = [AFHTTPSessionManager manager];
        
        [mager POST:url parameters:heardBody progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }else{
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请补全信息" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
            [alert show];
            
        }else{
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"请补全信息" preferredStyle:UIAlertControllerStyleAlert];
            [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self dismissViewControllerAnimated:YES completion:^{
                    
                }];
            }]];
            
            [self presentViewController:alertView animated:YES completion:^{
                
            }];
        }
        
    }
    
    
    
}

- (void)handleWithSureWithData:(NSDictionary *)dic{
    
}


- (void)creatTableView{
    //self.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeigth);
    self.tableView = [[UITableView alloc]init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    //    [self.view addSubview: self.tableView];
    self.view = self.tableView;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"1cell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *aView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 15)];
    aView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    return aView;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }else{
        return 3;
    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    self.tableView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        if (indexPath.row == 0) {
            [cell.contentView addSubview:[self creatView:@"真实姓名" right: self.nameSt]];
        }else if(indexPath.row == 1){
            [cell.contentView addSubview:[self creatView:@"性别" right: self.sexStr]];
        }else{
            [cell.contentView addSubview:[self creatView:@"年龄" right: self.ageStr]];
        }
        return cell;
        
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"1cell" forIndexPath:indexPath];
        if (indexPath.row == 0) {
            [cell.contentView addSubview:[self creatView:@"邮箱号" right: self.emailStr]];
        }else if(indexPath.row == 1){
            [cell.contentView addSubview:[self creatView:@"职业" right: self.jobStr]];
        }else{
            [cell.contentView addSubview:[self creatView:@"过敏史" right: self.illStr]];
        }
        return cell;
    }
    
    
    
}
- (UIView *)creatView:(NSString *)left right:(NSString *)right{
    UIView *aView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    UILabel *leftLabel = [[UILabel alloc]init];
    aView.backgroundColor = [UIColor whiteColor];
    leftLabel.font = [UIFont systemFontOfSize:14];
    self.rightLabl = [[UILabel alloc]init];
    self.rightLabl.font = [UIFont systemFontOfSize:11];
    self.rightLabl.textColor = [UIColor lightGrayColor];
    UIImageView *image = [[UIImageView alloc]init];
    
    self.rightLabl.textAlignment = NSTextAlignmentRight;
    image.image = [UIImage imageNamed:@"下一步"];
    [aView addSubview:leftLabel];
    [aView addSubview:self.rightLabl];
    [aView addSubview:image];
    [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo (aView);
        make.left.equalTo(aView.mas_left).with.offset(20);
        make.width.mas_equalTo(@75);
    }];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo (aView).with.offset(-10);
        make.centerY.equalTo(aView);
        make.width.mas_equalTo(@10);
        make.height.mas_equalTo(@15);
        
        
        
    }];
    [self.rightLabl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(image.mas_left).with.offset(-5);
        make.centerY.equalTo(aView);
        make.width.mas_equalTo(kScreenWidth/4);
        
    }];
    leftLabel.text = left;
    self.rightLabl.text = right;
    
    return aView;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1 ) {
                if (indexPath.row == 0) {
            EmailViewController *emVC = [[EmailViewController alloc]init];
            UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:emVC];
            [self presentViewController:naNC animated:YES completion:^{
                
            }];
        }else if (indexPath.row == 1){
            JobViewController *jobVC = [[JobViewController alloc]init];
            UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:jobVC];
            [self presentViewController:naNC animated:YES completion:^{
                
            }];
        }else{
            ILLLViewController *illVC = [[ILLLViewController alloc]init];
            UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:illVC];
            [self presentViewController:naNC animated:YES completion:^{
                
            }];
        }
    }
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

