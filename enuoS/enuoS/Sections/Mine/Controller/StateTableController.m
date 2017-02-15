//
//  StateTableController.m
//  enuo4
//
//  Created by apple on 16/5/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "StateTableController.h"
#import <AFNetworking.h>
#import "Macros.h"
#import "StateModel.h"
#import "StateViewCell.h"
#import "StateOneViewController.h"
@interface StateTableController ()<UIAlertViewDelegate>
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong)UIAlertView *alert;
@property (nonatomic,strong)UIAlertController *alertView;
@end

@implementation StateTableController

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        self.dataArr = [NSMutableArray array];
        
    }return _dataArr;
}

- (instancetype)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if (self) {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"登录返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleBackBarItem)];
        
        self.navigationItem.leftBarButtonItem =leftItem;
        
    }return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航条底图"] forBarMetrics:0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.tableView registerNib:[UINib nibWithNibName:@"StateViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
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
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *name = [userDefaults objectForKey:@"name"];
    NSString *str = @"http://www.enuo120.com/index.php/phone/Json/ptrecord?username=%@";
    NSString *url = [NSString stringWithFormat:str,name];
    
    BaseRequest *request = [[BaseRequest alloc]init];
    [request POST:url params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [self handleWithDic:responseObject];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
        
}
- (void)handleWithDic:(NSDictionary *)dic{
    if ([dic[@"data"] isKindOfClass:[NSNull class]]|| [dic[@"data"] isEqual: @""]||[dic[@"data"]isKindOfClass:[NSNumber class]] )  {
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
        StateModel *model = [StateModel stateModelWithDic:temp];
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
    StateViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    StateModel *model = self.dataArr[indexPath.row];
    cell.jblabel.text = model.jb;
    cell.doctorLabel.text = model.doctor_name;
    cell.payStateLabel.text  = model.pay_situation;
    cell.priceLabel.text = model.price;
    cell.timeLabel.text = model.date;
    cell.dnlabel.text = model.dnumber;
    
    [cell.jlBtn addTarget:self action:@selector(oneCellBtnClicked:event:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    return cell;
}
- (void)oneCellBtnClicked:(id)sender
                    event:(id)event{
    NSLog(@"汤五爷在此！尔等前来受死！");
    NSSet *touches =[event allTouches];
    UITouch *touch =[touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    NSIndexPath *indexPath= [self.tableView indexPathForRowAtPoint:currentTouchPosition];
    if (indexPath!= nil)
    {
        StateModel *model = self.dataArr[indexPath.row];
        StateOneViewController *oneBC = [[StateOneViewController alloc]init];
        UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:oneBC];
                   oneBC.receiver = model.dnumber;
        [self presentViewController:navc animated:YES completion:^{
 
            NSLog(@"oneBc.receiber = %@",oneBC.receiver);
        }];
        NSLog(@"走不走");
        
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
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
