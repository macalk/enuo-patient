//
//  VipArrangeTableController.m
//  enuo4
//
//  Created by apple on 16/5/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "VipArrangeTableController.h"
#import "vipArrangeModel.h"
#import "VipArrangeViewCell.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import "Macros.h"
#import <Masonry.h>

#import "SearchILLDocController.h"
//#import "VipDoctorViewController.h"

@interface VipArrangeTableController ()
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)UIAlertView *alertViewOne;
@property (nonatomic,strong)UIAlertController *alertViewTwo;
@property (nonatomic,strong)UIView *aaaaView;
@end

@implementation VipArrangeTableController


- (UIView *)aaaaView{
    if (!_aaaaView) {
        self.aaaaView = [[UIView alloc]init];
    }return _aaaaView;
}


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
    }return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
      self.navigationItem.title =@"使用范围";
    [self.tableView registerNib:[UINib nibWithNibName:@"VipArrangeViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航条底图"] forBarMetrics:0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self requestData];
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

    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VipArrangeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    vipArrangeModel *model  = self.dataArray[indexPath.row];
    NSTimeInterval time = [model.end_time doubleValue];
    NSDate *datailDate = [NSDate dateWithTimeIntervalSince1970:time];
    NSLog(@"date:%@",datailDate);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    cell.endTimeLabel.text = [dateFormatter stringFromDate:datailDate];
    cell.illLabel.text = model.ill;
    cell.priceLabel.text = [NSString stringWithFormat:@"%@元",model.bargin_price];
    cell.hospitalLabel.text = model.hospital_name;
    cell.categoryLabel.text = model.category;
    cell.treatLabel.text = model.treat;
    cell.oldPriceLabel.text = model.price;
    NSString *str = [NSString stringWithFormat:urlPicture,model.photo];
    [cell.photoImage sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"index1_02"]];

    
    return cell;
}
//数据请求
- (void)requestData{
    NSString *str = @"http://www.enuo120.com/index.php/phone/json/viparange";
    
    BaseRequest *request = [[BaseRequest alloc]init];
    [request POST:str params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [self handleWithDic:responseObject];

    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}
- (void)handleWithDic:(NSDictionary *)dic{
    
        NSArray *arr = dic[@"data"];
    
    if([dic[@"data"]isKindOfClass:[NSNull class]]){
        [self.tableView reloadData];
        [self creatnullView];
    }else{

    for (NSDictionary *temp in arr) {
        vipArrangeModel *model = [vipArrangeModel vipArrangeWithDic:temp];
        [self.dataArray addObject:model];
    
    }
        [self.tableView reloadData];
}
    
}
- (void)creatnullView{
    UILabel *nullLabel = [[UILabel alloc]init];
    self.aaaaView.backgroundColor = [UIColor whiteColor];
    nullLabel.text = @"暂无数据";
    nullLabel.textColor = [UIColor lightGrayColor];
    nullLabel.font = [UIFont systemFontOfSize:24];
    [self.aaaaView addSubview:nullLabel];
    __weak typeof(self) weakSelf = self;
    
    [nullLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.aaaaView);
        make.centerY.equalTo (weakSelf.aaaaView).with.offset(-100);
        
    }];
    self.aaaaView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeigth);
    [self.tableView addSubview:self.aaaaView];
}

//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    vipArrangeModel *model  = self.dataArray[indexPath.row];
    
    SearchILLDocController *VC = [[SearchILLDocController alloc]init];
    VC.illReceiver = model.ill;
    VC.hid = model.hos_id;
    VC.category = model.category;
    VC.treat = model.treat;
    VC.dep_id = model.dep_id;
    VC.PID = model.PID;
    VC.mb_id = model.mb_id;
    VC.VIP = @"VIP";
    [self.navigationController pushViewController:VC animated:YES];
    
    
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
