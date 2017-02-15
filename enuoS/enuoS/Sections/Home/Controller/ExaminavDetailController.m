//
//  ExaminavDetailController.m
//  enuoS
//
//  Created by apple on 16/8/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ExaminavDetailController.h"

#import "Macros.h"
#import <SVProgressHUD.h>

#import <AFNetworking.h>
#import "BodyModel.h"
#import "BodyTableViewCell.h"

#import "BodyIllmodel.h"
#import "ExaTwoViewController.h"


@interface ExaminavDetailController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *oneTableView;
@property (nonatomic,strong)UITableView *twoTableView;
@property (nonatomic,strong)NSMutableArray *oneArray;
@property (nonatomic,strong)NSMutableArray *twoArray;

@end

@implementation ExaminavDetailController



- (NSMutableArray *)oneArray{
    if (!_oneArray) {
        self.oneArray = [NSMutableArray array];
    }return _oneArray;
}

- (NSMutableArray *)twoArray{
    if (!_twoArray) {
        self.twoArray = [NSMutableArray array];
    }return _twoArray;
}


- (UITableView *)oneTableView{
    if (!_oneTableView) {
        self.oneTableView = [[UITableView alloc]init];
    }return _oneTableView;
}
- (UITableView *)twoTableView{
    if (!_twoTableView) {
        self.twoTableView  = [[UITableView alloc]init];
    }return _twoTableView;
}






- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"绿色返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleWithBack:)];
        
        self.navigationItem.leftBarButtonItem = leftItem;
    }return self;
    
}








- (void)viewDidLoad {
   [super viewDidLoad];
    [SVProgressHUD show];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航条底图"] forBarMetrics:0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [self creatOneTableView];
    [self requestBodyData];
    self.navigationController.navigationBar.translucent = NO;

}


- (void)creatOneTableView{
    self.twoTableView.delegate = self;
    self.twoTableView.dataSource = self;

    self.oneTableView .delegate = self;
    self.oneTableView.dataSource = self;
    
    self.oneTableView.layer.borderWidth = 1.0;
    self.oneTableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.twoTableView .frame =CGRectMake(kScreenWidth/3, 0, kScreenWidth*2/3, kScreenHeigth-64);
    
    
    self.oneTableView.frame = CGRectMake(0, 0, kScreenWidth/3, kScreenHeigth-64);
   
    
    //[self.oneTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.oneTableView registerNib:[UINib nibWithNibName:@"BodyTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
      [self.twoTableView registerNib:[UINib nibWithNibName:@"BodyTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    
    [self.view addSubview:self.oneTableView];
    
    [self.view addSubview:self.twoTableView];
    

    
    
}


- (void)handleWithBack:(UIBarButtonItem*)sender{
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    if(tableView == self.oneTableView){
         return self.oneArray.count;
    }else{
        return self.twoArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   

    // tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (tableView == self.oneTableView) {
        
         BodyTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        BodyModel *model = self.oneArray[indexPath.row];
        cell1.bodyLabel.text = model.body;
        [self.oneTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
        
       
        NSIndexPath *firstPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.oneTableView selectRowAtIndexPath:firstPath animated:YES scrollPosition:UITableViewScrollPositionTop];
        return cell1;
    
    }else{
            BodyTableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        
         [self.twoTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
         BodyIllmodel *model = self.twoArray[indexPath.row];
        cell2.bodyLabel.text = model.zz;
        return cell2;
    }
    
    
    
   
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.oneTableView) {
  
        BodyModel *model = self.oneArray[indexPath.row];
        [self.twoArray removeAllObjects];
        [SVProgressHUD show];
        [self requestTwoBodyData:model.cid];
        
    }else{
        BodyIllmodel *model = self.twoArray[indexPath.row];
        ExaTwoViewController *exVC = [[ExaTwoViewController alloc]init];
        exVC.receiver = model.cid;
        
        UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:exVC];
      
          naNC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
        [self presentViewController:naNC animated:YES completion:^{
            
        }];
        
    }
    
    
    
    
    
}


#pragma mark - 数据处理————————————————————————————————————————————————————————————————————————————————----



- (void)requestTwoBodyData:(NSString *)cid{
    NSString *url = @"http://www.enuo120.com/index.php/app/index/zczz";
    
      NSDictionary *heardBody = @{@"bid":cid,@"sex":self.receiver};
    BaseRequest *request = [[BaseRequest alloc]init];
    [request POST:url params:heardBody success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"responseObject = %@",responseObject);
        [self handleWithBodyIllData:responseObject];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
  
}
- (void)handleWithBodyIllData:(NSDictionary *)dic{
    NSArray *arr = dic[@"data"];
    if ([dic[@"data"]isEqual:[NSNull null]]) {
        NSLog(@"");
    }else{
    
    for (NSDictionary *temp in arr) {
        BodyIllmodel *model = [BodyIllmodel BodyIllModelInItWithDic:temp];
        
        [self.twoArray addObject:model];
    }
}
    [self.twoTableView reloadData];
    
    
}






- (void)requestBodyData{
    NSString *url = @"http://www.enuo120.com/index.php/app/index/zcbody";
    NSDictionary *heardBody = @{@"pbody":self.pbody};

    BaseRequest *request = [[BaseRequest alloc]init];
    [request POST:url params:heardBody success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        [self handleWithBodyData:responseObject];
        if (self.oneArray.count !=0) {
            BodyModel *model = self.oneArray[0];
            [self requestTwoBodyData:model.cid];
        }

    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

- (void)handleWithBodyData:(NSDictionary *)dic{
    NSArray *arr = dic[@"data"];
    for (NSDictionary *temp in arr) {
        
        BodyModel *model = [BodyModel bodyModelInitWithDic:temp];
        [self.oneArray addObject:model];
    }[self.oneTableView reloadData];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

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
