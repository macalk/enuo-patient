//
//  PerfectViewController.m
//  enuoS
//
//  Created by apple on 16/8/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "PerfectViewController.h"
#import "Macros.h"
#import <AFNetworking.h>
#import <Masonry.h>
#import "NameViewController.h"
#import "IDNameViewController.h"
#import "EmailViewController.h"

#import "JobViewController.h"
#import "ILLLViewController.h"

#import "SZKAlterView.h"


#define IOS8 [[[UIDevice currentDevice]systemVersion] floatValue] >= 8.0

@interface PerfectViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UILabel *rightLabl;

@property (nonatomic,copy)NSString *nameSt;
@property (nonatomic,copy)NSString *sexStr;
@property (nonatomic,copy)NSString *cidStr;
@property (nonatomic,copy)NSString *emailStr;
@property (nonatomic,copy)NSString *jobStr;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *illStr;
@end

@implementation PerfectViewController

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
    if (nameStr) {
        self.nameSt = nameStr;
    }
    if (sexS) {
        self.sexStr = sexS;
    }
    
    if (cidS) {
        self.cidStr = cidS;
    }
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
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航条底图"] forBarMetrics:0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.translucent = NO;
    NSLog(@"ASDASD");
  
    self.sexStr = @"男";

}
- (void)handleWithBack:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
//SURE 、、、、、、、、sure,,,,,,,,,,,,,
- (void)handleWithSure:(UIBarButtonItem *)sender{
    
    NSString *url = @"http://www.enuo120.com/index.php/app/patient/perfect";
    NSUserDefaults *standUser = [NSUserDefaults standardUserDefaults];
    self.name = [standUser objectForKey:@"nameOne"];
    NSString *nammme = [standUser objectForKey:@"name"];
    if (nammme) {
        self.name = nammme;
    }
    NSLog(@"%@~~~%@~~%@~~~~%@",self.nameSt,self.sexStr,self.cidStr,self.emailStr);
    if (![self.nameSt isEqualToString:@""] && ![self.sexStr isEqualToString:@""]&&![self.cidStr isEqualToString:@""]&&![self.emailStr isEqualToString:@""]&& ![self.jobStr isEqualToString:@""] && ![self.illStr isEqualToString:@""]) {
        
        NSDictionary *heardBody = @{@"username":self.name,@"name":self.nameSt,@"sex":self.sexStr,@"ID_card":self.cidStr,@"email":self.emailStr,@"allergic":self.illStr,@"accupation":self.jobStr};
        AFHTTPSessionManager *mager = [AFHTTPSessionManager manager];
        
        [mager POST:url parameters:heardBody progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self handleWithSureWithData:responseObject];
            
           
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }else{
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请补全信息" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
            [alert show];
            
        }else{
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"请补全信息" preferredStyle:UIAlertControllerStyleAlert];
            [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [alertView removeFromParentViewController];
            }]];
            
            [self presentViewController:alertView animated:YES completion:^{
                
            }];
        }

    }
   
    
    
}

- (void)handleWithSureWithData:(NSDictionary *)dic{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeigth)];
    bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    SZKAlterView *alertView = [SZKAlterView alterViewWithTitle:@"提示" content:dic[@"data"][@"message"] cancel:@"取消" sure:@"确认" cancelBtClcik:^{
        [bgView removeFromSuperview];
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    } sureBtClcik:^{
        [bgView removeFromSuperview];
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];

    }];
    
    if ([dic[@"data"][@"erroct"] integerValue] == 0) {
        //储蓄名字
        [[NSUserDefaults standardUserDefaults] setObject:self.nameSt forKey:@"mz"];
    }
    
    [bgView addSubview:alertView];
    [self.view addSubview:bgView];
    
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
            [cell.contentView addSubview:[self creatView:@"身份证号" right: self.cidStr]];
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
    if (indexPath.section == 0 ) {
        if (indexPath.row == 0) {
            NameViewController *naVC = [[NameViewController alloc]init];
            
            UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:naVC];
            [self presentViewController:naNC animated:YES completion:^{
                
            }];
        }else if (indexPath.row == 1){
            if(IOS8){
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
                
                // Create the actions.
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                

                }];
                
                UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
                    [userDefaults setObject:action.title forKey:@"sex"];
                    
                    [userDefaults synchronize];
                    [self viewWillAppear:YES];
                }];
                UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                    
                    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                    
                    [userDefaults setObject:action.title forKey:@"sex"];
                    
                    [userDefaults synchronize];
                    [self viewWillAppear:YES];
                }];
                
                // Add the actions.
                [alertController addAction:cancelAction];
                [alertController addAction:otherAction];
                [alertController addAction:destructiveAction];
                
                
                [self presentViewController:alertController animated:YES completion:nil];
                

            }else{
                UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@""delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"男" otherButtonTitles:@"女", nil];
                
                actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
                [actionSheet showInView:self.view];
            }
       
    }else  {
        IDNameViewController *idVC = [[IDNameViewController alloc]init];
        UINavigationController *naVC = [[UINavigationController alloc]initWithRootViewController:idVC];
        [self presentViewController:naVC animated:YES completion:^{
            
        }];
    }
    }else{
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
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    

    
    if (buttonIndex == 0) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        [userDefaults setObject:actionSheet.title forKey:@"sex"];
        
        [userDefaults synchronize];
       [self viewWillAppear:YES];
    }else if(buttonIndex == 1) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        [userDefaults setObject:actionSheet.title forKey:@"sex"];
        
        [userDefaults synchronize];
      [self viewWillAppear:YES];
    }else{
        NSLog(@"取消");
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
