//
//  ExaThreeController.m
//  enuoS
//
//  Created by apple on 16/8/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ExaThreeController.h"
#import "PromiseDocViewCell.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import "Macros.h"
#import <SVProgressHUD.h>
#import "FindDocModel.h"
#import "DoctorViewController.h"
@interface ExaThreeController ()




@property (nonatomic,strong)NSMutableArray *dataArray;



@end

@implementation ExaThreeController



- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }return _dataArray;
}



- (instancetype)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if (self) {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"绿色返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleWithBack:)];
        
        self.navigationItem.leftBarButtonItem = leftItem;
        
        
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"刷新" style:UIBarButtonItemStyleDone target:self action:@selector(handleWithShaXin:)];
        self.navigationItem.rightBarButtonItem = rightItem;
        

        
        
    }return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD show];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航条底图"] forBarMetrics:0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.tableView registerNib:[UINib nibWithNibName:@"PromiseDocViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    
    
    [self requestData];
    
    
  
}


- (void)handleWithShaXin:(UIBarButtonItem *)sender{
    [self.dataArray removeAllObjects];
     [self requestData];
}
- (void)handleWithBack:(UIBarButtonItem *)sender{
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

    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 70;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *aView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 70)];
    UILabel *alabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    alabel.text = self.reExaple;
    aView.backgroundColor = [UIColor whiteColor];
    alabel.font = [UIFont systemFontOfSize:14];
    alabel.numberOfLines = 0;
    alabel.backgroundColor =  [UIColor colorWithRed:0/255.0 green:179/255.0 blue:163/255.0 alpha:1];
    alabel.textAlignment = NSTextAlignmentCenter;
    UILabel *bLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 35, kScreenWidth, 30)];
    bLabel.text = @"推荐医生";
    bLabel .font = [UIFont systemFontOfSize:14];
   // bLabel.backgroundColor = [UIColor orangeColor];
    
    bLabel.textColor = [UIColor orangeColor];
    bLabel.textAlignment = NSTextAlignmentCenter;
    
    
    [aView addSubview:alabel];
    [aView addSubview:bLabel];
    return aView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  PromiseDocViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    FindDocModel *model = self.dataArray[indexPath.row];
    cell.nameLabel.text = model.name;
    cell.nuoNumber.text = model.nuo;
    NSString *str0ne = [NSString stringWithFormat:urlPicture,model.photo];
    cell.illLabel.text = model.ill;
    [cell.photoImage sd_setImageWithURL:[NSURL URLWithString:str0ne] placeholderImage:nil];
    cell.proLabel.text = model.professional;
    cell.deskLabel.text = model.dep_name;
    cell.pepLaebl.text = model.zhen;
    cell.hosLabel.text = model.hos_name;
    
    return cell;
}


- (void)requestData{
    NSString *url = @"http://www.enuo120.com/index.php/app/index/zctj";
    NSDictionary *hearBody = @{@"id":self.receiver};
    
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger POST:url parameters:hearBody progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        [self handleWithData:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)handleWithData:(NSDictionary *)dic{
    NSArray *arr = dic[@"data"];
    
    
    for (NSDictionary *temp in arr) {
        FindDocModel *model = [FindDocModel findDocModelInitWithDic:temp];
        [self.dataArray addObject:model];
    }[self.tableView reloadData];
    
    

    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FindDocModel *model = self.dataArray[indexPath.row];
    DoctorViewController *doc = [[DoctorViewController alloc]init];
    UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:doc];
    doc.receiver = model.cid;
     naNC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:naNC animated:YES completion:^{
        
    }];
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
