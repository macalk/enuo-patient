//
//  SureViewController.m
//  enuo4
//
//  Created by apple on 16/4/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SureViewController.h"
#import "SureTableViewCell.h"
#import "Macros.h"
#import <AFNetworking.h>
#import <Masonry.h>
#import "SureModel.h"
#import "SureOneController.h"
#import "SureTwoController.h"
#import <SVProgressHUD.h>
@interface SureViewController ()<UIAlertViewDelegate>
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong)UIAlertView *alert;
@property (nonatomic,strong)UIAlertController *alertView;
@end

@implementation SureViewController

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        self.dataArr = [NSMutableArray array];
    }return _dataArr;
}

- (instancetype)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if (self) {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"登录返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleWithBack:)];
        self.navigationItem.leftBarButtonItem = leftItem;
    }return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD show];
    [self requestData];
    [self.tableView registerNib:[UINib nibWithNibName:@"SureTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航条底图"] forBarMetrics:0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
  self.navigationItem.title = @"待约定";
}
- (void)handleWithBack:(UIBarButtonItem *)sender{
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    SureModel *model = self.dataArr[indexPath.row];
    cell.dnummberLabel.text = model.dnumber;
    cell.hospitalLabel.text = model.hospital;
    cell.priceLabel.text = model.price;
    cell.pay_statue.text = model.psy_statue;
    cell.jbLabel.text = model.jb;
    cell.cycleLabel.text = model.cycle;
    //cell.effecttLabel.text = model.effectt;
    //cell.underStandLabel.text = model.understand;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    NSString *strs = [model.effectt stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\n"];
    NSString *strss = [model.understand stringByReplacingOccurrencesOfString:@"<br/>" withString:@" "];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
//    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14.0f], NSParagraphStyleAttributeName:paragraphStyle.copy};
    cell.effecttLabel.text = strs;
    cell.underStandLabel.text = strss;
    

    [cell.seeButton addTarget:self action:@selector(oneCellBtnClicked:event:) forControlEvents:UIControlEventTouchUpInside];
    [cell.sureButton addTarget:self action:@selector(twoCellBtnClicked:event:) forControlEvents:UIControlEventTouchUpInside];
    [cell.passButton addTarget:self action:@selector(threeCellBtnClicked:event:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}
- (void)oneCellBtnClicked:(id)sender event:(id)event
{
    NSSet *touches =[event allTouches];
    UITouch *touch =[touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    NSIndexPath *indexPath= [self.tableView indexPathForRowAtPoint:currentTouchPosition];
    if (indexPath!= nil)
    {
        SureOneController *oneVC = [[SureOneController alloc]init];
         SureModel *model = self.dataArr[indexPath.row];
        UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:oneVC];
        oneVC.receiver = model.dnumber;
      [self presentViewController:naNC animated:YES completion:^{
          
      }];
    }
}

- (void)twoCellBtnClicked:(id)sender event:(id)event
{
    NSSet *touches =[event allTouches];
    UITouch *touch =[touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    NSIndexPath *indexPath= [self.tableView indexPathForRowAtPoint:currentTouchPosition];
    if (indexPath!= nil)
    {
        
        SureModel *model = self.dataArr[indexPath.row];
        SureTwoController *sureVC = [[SureTwoController alloc]init];
        sureVC.receiver = model.dnumber;
        [self.navigationController pushViewController:sureVC animated:YES];
        
        NSLog(@"确定订单");
    }
}
- (void)threeCellBtnClicked:(id)sender event:(id)event
{
    NSSet *touches =[event allTouches];
    UITouch *touch =[touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    NSIndexPath *indexPath= [self.tableView indexPathForRowAtPoint:currentTouchPosition];
    if (indexPath!= nil)
    {
        
        SureModel *model = self.dataArr[indexPath.row];
        [self requestTwoDataWith:model.dnumber];
        
       
    }
}


- (void)requestData{
    NSString * str = @"http://www.enuo120.com/index.php/phone/Json/Promise?username=%@";
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *name = [userDefaults objectForKey:@"name"];
    
    NSString *url = [NSString stringWithFormat:str,name];
    NSLog(@"url = %@",url);
    AFHTTPSessionManager *manger= [AFHTTPSessionManager manager];
    [manger GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleGetDataWithData:responseObject];
        [SVProgressHUD dismiss];
        // NSLog(@"respondObjct = %@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    

}

- (void)handleGetDataWithData:(NSDictionary *)dic{
    NSArray *arr= dic[@"data"];
    
    if ([dic[@"data"] isKindOfClass:[NSNull class]]|| [dic[@"data"] isEqual:@""]||[dic[@"data"]isKindOfClass:[NSNumber class]] )  {
        //NSLog(@"数据为空");
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
            self.alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"暂无数据" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [_alert show];
        }else{
            _alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"暂无数据" preferredStyle:UIAlertControllerStyleAlert];
            [_alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:YES];
                //[self.navigationController  popViewControllerAnimated:YES];
            }]];
            [self presentViewController:_alertView animated:YES completion:^{
                
            }];
        }

    }else{
    
    
    
    for (NSDictionary *temp in arr) {
        SureModel *model = [SureModel sureModelInitWithDic:temp];
        [self.dataArr addObject:model];
    }
    }[self.tableView reloadData];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            if (alertView.tag == 20) {
                [self.dataArr removeAllObjects];
                [self requestData];
            }else{
            [self.navigationController popViewControllerAnimated:YES];
            
            }
                break;
            
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 400;
}

- (void)requestTwoDataWith:(NSString *)str{
    NSString* strOne = @"http://www.enuo120.com/index.php/phone/Json/qxappoint?pro=%@";
    NSString *url = [NSString stringWithFormat:strOne,str];
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleWithDataWithQX:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)handleWithDataWithQX:(NSDictionary *)data{
    NSString*msg = data[@"data"];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
        UIAlertView * alertOne = [[UIAlertView alloc]initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
         alertOne.delegate = self;
         alertOne.tag = 20;
         [alertOne show];
    }else{
        UIAlertController *alertViewTwo = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
        [alertViewTwo addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         
            [self.dataArr removeAllObjects];
            [self requestData];
            //[self.navigationController  popViewControllerAnimated:YES];
            //[self.tableView reloadData];
        }]];
        [self presentViewController:alertViewTwo animated:YES completion:^{
    
        }];
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
