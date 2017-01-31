//
//  CheckTableController.m
//  enuo4
//
//  Created by apple on 16/5/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CheckTableController.h"
#import <AFNetworking.h>
#import "Macros.h"
#import "CheckOneModel.h"
#import "CheckOneViewCell.h"
#import <Masonry.h>
#import <SVProgressHUD.h>
#import "ConfircheckModel.h"
#import "ConfireCheckTableCell.h"
#import "CheckSureController.h"
#import "AppointChecKModel.h"
#import "AppointViewCell.h"

@interface CheckTableController ()<UIAlertViewDelegate>
@property (nonatomic,strong)NSMutableArray *dataOneArr;
@property (nonatomic,strong)UIAlertView *alert;
@property (nonatomic,strong)UIAlertController *alertView;
@property (nonatomic,copy)NSString *sate;
@end

@implementation CheckTableController
- (NSMutableArray *)dataOneArr{
    if (!_dataOneArr) {
        self.dataOneArr = [NSMutableArray array];
        
    }return _dataOneArr;
}


- (instancetype)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if (self) {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"登录返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleBackBarItem)];
        self.navigationItem.leftBarButtonItem = leftItem;
        UIBarButtonItem *backbutton = [[UIBarButtonItem alloc]init];
        backbutton.title = @"待约定";
        self.navigationItem.backBarButtonItem = backbutton;
    }return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航条底图"] forBarMetrics:0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [SVProgressHUD show];
    self.sate = @"0";
 
    [self.tableView registerNib:[UINib nibWithNibName:@"CheckOneViewCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ConfireCheckTableCell" bundle:nil] forCellReuseIdentifier:@"cell2"];
    [self.tableView registerNib:[UINib nibWithNibName:@"AppointViewCell" bundle:nil] forCellReuseIdentifier:@"cell3"];
    self.navigationController.navigationBar.translucent = NO;
    [self requsetOneData];

    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
        [self creatSegerement];
}




- (void)handleBackBarItem{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataOneArr.count;
}


- (void)requsetOneData{
    NSString *str = @"http://www.enuo120.com/index.php/phone/Json/resultcheck?username=%@";
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *name = [userDefaults objectForKey: @"name"];
    NSString *url = [NSString stringWithFormat:str,name];
    
    AFHTTPSessionManager *manegr = [AFHTTPSessionManager manager];
    [manegr GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleOneWithDic:responseObject];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
    
}

- (void)handleOneWithDic:(NSDictionary *)dic{
    if ([dic[@"data"] isKindOfClass:[NSNull class]]|| [dic[@"data"] isEqual: @""]||[dic[@"data"]isKindOfClass:[NSNumber class]] )  {
        NSLog(@"数据为空");
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
            self.alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"暂无数据" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
     
            [_alert show];
            
        }else{
            self.alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"暂无数据"preferredStyle:UIAlertControllerStyleAlert];
            [self.alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"sjahdgjasdlsajdksadk");
                // MIneViewController *minVC = [[MIneViewController alloc]ini
   

            }]];
            [self presentViewController:self.alertView animated:YES completion:^{
                
            }];
            
        }
    }else {

    NSArray *arr = dic[@"data"];
    for (NSDictionary *temp in arr) {
        CheckOneModel *model = [CheckOneModel checkOneModelWithDic:temp];
        [self.dataOneArr addObject:model];
    }
}[self.tableView reloadData];
}
- (void)popVCcc{
    
}
- (void)popVC{
    [self.alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            if ([self.sate isEqualToString: @"0"]) {
                [self.dataOneArr removeAllObjects];
                [self requsetOneData];
            }else if ([self.sate isEqualToString:@"1"]){
          
                [self.dataOneArr removeAllObjects];
                [self requsetTwoData];
            }else{
                [self.dataOneArr removeAllObjects];
                [self requestThreeData];
            }
           
            break;
            
        default:
            break;
    }
}

//待约定数据请求
- (void)requsetTwoData{
    NSString *str = @"http://www.enuo120.com/index.php/phone/Json/confircheck?username=%@";
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *name = [userDefaults objectForKey: @"name"];
    NSString *url = [NSString stringWithFormat:str,name];
    AFHTTPSessionManager *mager= [AFHTTPSessionManager manager];
    [mager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleWithTwoData:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}
- (void)handleWithTwoData:(NSDictionary *)dic{
    if ([dic[@"data"] isKindOfClass:[NSNull class]]|| [dic[@"data"] isEqual: @""]||[dic[@"data"]isKindOfClass:[NSNumber class]] )  {
        NSLog(@"数据为空");
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
            self.alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"暂无数据" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [self.alert show];
            
        }else{
            self.alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"暂无数据"preferredStyle:UIAlertControllerStyleAlert];
            [self.alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"sjahdgjasdlsajdksadk");
//                 MIneViewController *minVC = [[MIneViewController alloc]ini
      
                
            }]];
           [self presentViewController:self.alertView animated:YES completion:^{
               
           }];
        }
    }else {
        
        NSArray *arr = dic[@"data"];
        for (NSDictionary *temp in arr) {
            ConfircheckModel *model = [ConfircheckModel confircheckModelInitWithDic:temp];
            
            [self.dataOneArr addObject:model];
        }
    }[self.tableView reloadData];


}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.sate isEqualToString:@"0"]) {
        CheckOneViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        CheckOneModel *model  = self.dataOneArr[indexPath.row];
        cell.doctorLabel.text = model.doctor_name;
        cell.hospitalLabel.text = model.hospital;
        cell.dnnumberLabel.text = model.dnumber;
        cell.dateLabel.text = model.pretime;
        cell.priceLabel.text = model.prepaid;
        cell.checkLabel.text = model.check_name;
        cell.statueLabel.text  = model.order_statue_name;
        return cell;
    }else if([self.sate isEqualToString:@"1"]){
        ConfireCheckTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        ConfircheckModel *model = self.dataOneArr[indexPath.row];
        cell.dnumberLabel.text = model.dnumber;
        cell.hospitalLabel.text = model.hospital;
        cell.doctorLabel.text = model.doctor_name;
        cell.main_sayLabel.text = model.main_say;
        cell.now_diseaseLabel.text = model.now_disease;
        cell.check_nameLabel.text = model.check_name;
        cell.prepaidLabel.text = [NSString stringWithFormat:@"%@元",model.prepaid];
        [cell.sureBtn addTarget:self action:@selector(sureBtnClicked:event:) forControlEvents:UIControlEventTouchUpInside];
        [cell.passBtn addTarget:self action:@selector(passBtnClicked:event:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else{
        AppointViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
        AppointChecKModel *model = self.dataOneArr[indexPath.row];
        cell.dnumberLabel.text = model.dnumber;
        cell.hospitalLabel.text = model.hospital;
        cell.doctorLabel.text = model.doctor_name;
        cell.check_nameLabel.text = model.check_name;
        cell.prepaidLabe.text = [NSString stringWithFormat:@"%@元",model.prepaid];
        
        cell.timeLabel.text = model.pretime;
        [cell.passBtn addTarget:self action:@selector(appointPassBtnClicked:event:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    
}
//申请退款给
- (void)appointPassBtnClicked:(id)sender event:(id)event{
    NSSet *touches =[event allTouches];
    UITouch *touch =[touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    NSIndexPath *indexPath= [self.tableView indexPathForRowAtPoint:currentTouchPosition];
    if (indexPath!= nil){
         AppointChecKModel *model = self.dataOneArr[indexPath.row];
       NSString *str = @"http://www.enuo120.com/index.php/phone/Json/backapply?dnumber=%@";
        NSString *url = [NSString stringWithFormat:str,model.dnumber];
        AFHTTPSessionManager *manegr = [AFHTTPSessionManager manager];
        [manegr GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
        
        
    }
}
- (void)handleSurePassWithAppoint:(NSDictionary *)dic{
    NSString *arr= dic[@"data"];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
        UIAlertView *alertOne = [[UIAlertView alloc]initWithTitle:@"提示" message:arr delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        alertOne.delegate = self;
        [alertOne show];
    }else{
        UIAlertController *alertTwo = [UIAlertController alertControllerWithTitle:@"提示" message:arr preferredStyle:UIAlertControllerStyleAlert];
        [alertTwo addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.tableView reloadData];
        }]];
        [self presentViewController:alertTwo animated:YES completion:^{
            
        }];
    }
    if ([arr isEqualToString:@"申请退款成功"]) {
        
    }

}

//确认检查
- (void)sureBtnClicked:(id)sender event:(id)event{
    NSLog(@"汤五爷在此！尔等前来受死！");
    NSSet *touches =[event allTouches];
    UITouch *touch =[touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    NSIndexPath *indexPath= [self.tableView indexPathForRowAtPoint:currentTouchPosition];
    if (indexPath!= nil){
        ConfircheckModel *model = self.dataOneArr[indexPath.row];
        CheckSureController *checkVC = [[CheckSureController alloc]init];
        checkVC.receiver = model.dnumber;
        [self.navigationController pushViewController:checkVC animated:YES];
        
        
    }
}
- (void)passBtnClicked:(id)sender event:(id)event{
    NSLog(@"汤五爷在此！尔等前来受死！");
    NSSet *touches =[event allTouches];
    UITouch *touch =[touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    NSIndexPath *indexPath= [self.tableView indexPathForRowAtPoint:currentTouchPosition];
    if (indexPath!= nil){
        ConfircheckModel *model = self.dataOneArr[indexPath.row];
        NSString *str = @"http://www.enuo120.com/index.php/phone/Json/qxcheck?pro=%@";
        NSString *url = [NSString stringWithFormat:str,model.dnumber];
        AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
        [manger GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self handleWithPassBtn:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];

    }
}

- (void)handleWithPassBtn:(NSDictionary *)data{
    NSString *arr= data[@"data"];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
        UIAlertView *alertOne = [[UIAlertView alloc]initWithTitle:@"提示" message:arr delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        alertOne.delegate = self;
        [alertOne show];
    }else{
        UIAlertController *alertTwo = [UIAlertController alertControllerWithTitle:@"提示" message:arr preferredStyle:UIAlertControllerStyleAlert];
        [alertTwo addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.dataOneArr removeAllObjects];
            [self requsetTwoData];
        }]];
    [self presentViewController:alertTwo animated:YES completion:^{
        
    }];
    }
}


- (void)creatSegerement{
        UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:@[@"诊疗信息",@"待约定",@"退款"]
                                       ];
   
    segment.layer.masksToBounds = YES;
    segment.layer.cornerRadius = 6.0;
    
    [segment addTarget:self action:@selector(handleChangeWithValue:) forControlEvents:UIControlEventValueChanged];
    segment.selectedSegmentIndex = 0;
    [self.tableView.tableHeaderView addSubview:segment];
       __weak typeof (self) weakSelf = self;
    [segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.tableView.tableHeaderView);
        make.top.equalTo(weakSelf.tableView.tableHeaderView).with.offset(10);
    }];
    
}
- (void)handleChangeWithValue:(UISegmentedControl *)sender{
    switch (sender.selectedSegmentIndex) {
        case 0:
            NSLog(@"诊疗信息");
            self.sate = @"0";
            [self.dataOneArr removeAllObjects];
            [self requsetOneData];
            break;
            case 1:
            NSLog(@"待约定");
            self.sate = @"1";
            [self.dataOneArr removeAllObjects];
            [self requsetTwoData];
            break;
            case 2:
            self.sate = @"2";
            [self.dataOneArr removeAllObjects];
            [self requestThreeData];
            NSLog(@"退款");
            break;
        default:
            break;
    }
}
//退款
- (void)requestThreeData{
    NSString *str= @"http://www.enuo120.com/index.php/phone/Json/appointcheck?username=%@";
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *name = [userDefaults objectForKey: @"name"];
    NSString *url = [NSString stringWithFormat:str,name];
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleAppointWithDic:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
- (void)handleAppointWithDic:(NSDictionary *)dic{
    if ([dic[@"data"] isKindOfClass:[NSNull class]]|| [dic[@"data"] isEqual: @""]||[dic[@"data"]isKindOfClass:[NSNumber class]] )  {
        NSLog(@"数据为空");
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
            self.alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"暂无数据" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [self.alert show];
            
        }else{
            self.alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"暂无数据"preferredStyle:UIAlertControllerStyleAlert];
            [self.alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"sjahdgjasdlsajdksadk");
                // MIneViewController *minVC = [[MIneViewController alloc]ini
                
                
            }]];
            [self presentViewController:self.alertView animated:YES completion:^{
                
            }];
        }
    }else {
        
        NSArray *arr = dic[@"data"];
        for (NSDictionary *temp in arr) {
            AppointChecKModel *model = [AppointChecKModel appointInitWithDic:temp];
            [self.dataOneArr addObject:model];
        }
    }[self.tableView reloadData];

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.sate isEqualToString:@"0"]) {
        return 200;
    }else if([self.sate isEqualToString:@"1"]){
        ConfircheckModel *model = self.dataOneArr[indexPath.row];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15], NSParagraphStyleAttributeName:paragraphStyle.copy};
        CGRect rectOne = [model.main_say boundingRectWithSize:CGSizeMake(kScreenWidth - 70, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        CGRect rectTwo = [model.check_name boundingRectWithSize:CGSizeMake(kScreenWidth - 70, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
       CGRect rectThree = [model.now_disease boundingRectWithSize:CGSizeMake(kScreenWidth - 70, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        return 170 + rectOne.size.height + rectThree.size.height + rectTwo.size.height;
    }else{
        return 207;
    }
    
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
