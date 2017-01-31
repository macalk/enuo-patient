//
//  SureEndTableController.m
//  enuo4
//
//  Created by apple on 16/4/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SureEndTableController.h"
#import "Macros.h"
#import <AFNetworking.h>
#import "SureEndModel.h"
#import "SureEndViewCell.h"
#import "EndPayViewController.h"
#import "EvaluateTableController.h"
#import <SVProgressHUD.h>
@interface SureEndTableController ()<UIAlertViewDelegate>
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong)UIAlertView *alert;
@property (nonatomic,strong)UIAlertController *alertView;
@end

@implementation SureEndTableController
- (NSMutableArray *)dataArr{
    if (!_dataArr ) {
        self.dataArr = [NSMutableArray array];
    }return _dataArr;
}


- (instancetype)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if (self) {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"登录返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleBackBarItem)];
        self.navigationItem.leftBarButtonItem = leftItem;
        
    }return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航条底图"] forBarMetrics:0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.tableView registerNib:[UINib nibWithNibName:@"SureEndViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [SVProgressHUD show];
    [self requestData];

}
- (void)handleBackBarItem{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArr.count;
}

- (void)requestData{
    NSString *str = @"http://www.enuo120.com/index.php/phone/Json/pconfirm?username=%@";
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *name = [userDefaults objectForKey:@"name"];
    NSString *url = [NSString stringWithFormat:str,name];
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    NSLog(@"url = %@",url);
    [manger GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleWithData:responseObject];
         [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];


}
- (void)handleWithData:(NSDictionary *)dic{
     NSArray *arr = dic[@"data"];
    if ([dic[@"data"] isKindOfClass:[NSNull class]]|| [dic[@"data"] isEqual:@""]||[dic[@"data"]isKindOfClass:[NSNumber class]]||arr.count==0 )  {
        NSLog(@"数据为空");
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
            self.alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"暂无数据" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
            self.alert.delegate = self;
            [self performSelector:@selector(popVC) withObject:nil afterDelay:0.5];
            
        }else{
            self.alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"暂无数据"preferredStyle:UIAlertControllerStyleAlert];
            [self.alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"sjahdgjasdlsajdksadk");
                // MIneViewController *minVC = [[MIneViewController alloc]ini
                [self dismissViewControllerAnimated:YES completion:^{
                    
                }];
                //[self presentingViewController];
                //[self presentedViewController];
            }]];
            [self performSelector:@selector(popVCcc) withObject:nil afterDelay:0.5];
            
            
        }
    }else {

    NSArray *arr = dic[@"data"];
    for (NSDictionary *temp in arr) {
        SureEndModel *model = [SureEndModel sureEndModelInitWithDic:temp];
        [self.dataArr addObject:model];
    }[self.tableView reloadData];
}
}
- (void)popVCcc{
    [self presentViewController:self.alertView animated:YES completion:^{
        
    }];
}
- (void)popVC{
    [self.alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
            break;
            
        default:
            break;
    }
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SureEndViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    SureEndModel *model = self.dataArr[indexPath.row];
    cell.proIdLabel.text = model.pro_ID;
    cell.jbLbael.text = model.jb;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.ybmoneyLabel.text = [NSString stringWithFormat:@"%@元",model.yb_money];
       cell.priceLabel.text = [NSString stringWithFormat:@"%@元",model.price];
   // cell.promoneyLabel.text = model.premoney;
    cell.zfMoneyLabel.text = [NSString stringWithFormat:@"%@元",model.zf_money];
    [cell.endButton addTarget:self action:@selector(oneCellBtnClicked:event:) forControlEvents:UIControlEventTouchUpInside];
    cell.promoneyLabel.numberOfLines = 0;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (model.prepaid ==0) {
           cell.promoneyLabel.text = model.premoney;
    }else{
        NSString *str = @"%@元\n(含检查费用%ld元）";
        cell.promoneyLabel.text = [NSString stringWithFormat:str,model.premoney,model.prepaid];
        
    }
   // NSLog(@"model.prepaid = %@",model.prepaid);
    
    return cell;
}

- (void)oneCellBtnClicked:(id)sender event:(id)event{
    NSLog(@"汤五爷在此！尔等前来受死！");
    NSSet *touches =[event allTouches];
    UITouch *touch =[touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    NSIndexPath *indexPath= [self.tableView indexPathForRowAtPoint:currentTouchPosition];
    if (indexPath!= nil)
    {   SureEndModel *model = self.dataArr[indexPath.row];
       // EvaluateTableController *EvVC = [[EvaluateTableController alloc]init];
        EndPayViewController *endVC = [[EndPayViewController alloc]init];
        UINavigationController *naVC = [[UINavigationController alloc]initWithRootViewController:endVC];
        [self presentViewController:naVC animated:YES completion:^{
            endVC.oneReceiver = model.pro_ID;
        }];
        
   }

}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArr !=NULL) {
        SureEndModel *model = self.dataArr[indexPath.row];
        if (model.prepaid ==0) {
            return 220;
        }else{
            return 250;
        }

    }else{
        return 44;
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
