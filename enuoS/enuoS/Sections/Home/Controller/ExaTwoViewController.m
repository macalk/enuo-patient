//
//  ExaTwoViewController.m
//  enuoS
//
//  Created by apple on 16/8/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ExaTwoViewController.h"
#import "Macros.h"
#import <AFNetworking.h>
#import "ExThreeModel.h"
#import "ExTwoModel.h"
#import "ExthreeTableCell.h"
#import <SVProgressHUD.h>

#import "ExaThreeController.h"

#import <Masonry.h>


@interface ExaTwoViewController ()<UITableViewDataSource,UITableViewDelegate>



@property (nonatomic,strong)NSMutableArray *oneDataArr;
@property (nonatomic,strong)NSMutableArray *twoDataArr;

@property (nonatomic,strong)UILabel *oneLabel;
@property (nonatomic,strong)UILabel *twoLabel;
@property (nonatomic,strong)UILabel *threeLabel;

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation ExaTwoViewController


- (UILabel *)oneLabel{
    
    if (!_oneLabel) {
        self.oneLabel = [[UILabel alloc]init];
    }return _oneLabel;
}

- (UILabel *)twoLabel{
    if (!_twoLabel) {
        self.twoLabel = [[UILabel alloc]init];
    }return _twoLabel;
}
- (UILabel *)threeLabel{
    if (!_threeLabel) {
        self.threeLabel = [[UILabel alloc]init];
    }return _threeLabel;
}



- (UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc]init];
    }return _tableView;
}


- (NSMutableArray *)oneDataArr{
    if (!_oneDataArr) {
        self.oneDataArr = [NSMutableArray array];
    }return _oneDataArr;
}

- (NSMutableArray *)twoDataArr{
    if (!_twoDataArr) {
        self.twoDataArr = [NSMutableArray array];
    }return _twoDataArr;
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
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航条底图"] forBarMetrics:0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [SVProgressHUD show];
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatTableView];
   // [self creatHeaderView];
    [self requestOneData];
   
    
    
    
    
    
}

- (void)handleWithBack:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}



-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
      cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
    [UIView animateWithDuration:1 animations:^{
        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}


//- (void)creatHeaderView{
//    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
//   
//    
//    [self.tableView.tableHeaderView addSubview:_oneLabel];
//    [self.tableView.tableHeaderView addSubview:_twoLabel];
//    
//}



- (void)creatTableView{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
     [self.tableView registerNib:[UINib nibWithNibName:@"ExthreeTableCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    
    self.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeigth);

    
    self.view = self.tableView;
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
        if (self.oneDataArr.count !=0) {
              ExTwoModel *model = self.oneDataArr[0];
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
            paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
            NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15.0f], NSParagraphStyleAttributeName:paragraphStyle.copy};
            CGRect rectOne = [model.introduce boundingRectWithSize:CGSizeMake(kScreenWidth, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
            
            return rectOne.size.height +60;
    
        }else{
            return 0;
        }

}






- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *aView = [[UIView alloc]init];
    aView.backgroundColor = [UIColor whiteColor];
    

  
//    self.oneLabel.frame = CGRectMake(0, 0, kScreenWidth, 30);
//    self.twoLabel.frame = CGRectMake(0, 30, kScreenWidth, 60);
    self.oneLabel.numberOfLines = 0;
    self.twoLabel.numberOfLines = 0;
    self.oneLabel.backgroundColor = [UIColor lightGrayColor];
    self.oneLabel.textColor = [UIColor colorWithRed:0/255.0 green:179/255.0 blue:163/255.0 alpha:1];
    
    self.oneLabel.font = [UIFont systemFontOfSize:14];
    self.twoLabel.font = [UIFont systemFontOfSize:13];
    self.threeLabel.font =[UIFont systemFontOfSize:13];
    self.threeLabel.text = @"您是否伴有以下症状";
    
//    self.threeLabel.frame = CGRectMake(0, 90, kScreenWidth, 30);
    self.threeLabel.textColor = [UIColor orangeColor];
    [aView addSubview:self.oneLabel];
    [aView addSubview:self.twoLabel];
    [aView addSubview:self.threeLabel];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15.0f], NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGRect rectOne = [self.twoLabel.text boundingRectWithSize:CGSizeMake(kScreenWidth, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    
    
    aView.frame = CGRectMake(0, 0, kScreenWidth, rectOne.size.height);
    __weak typeof (self) weakSelf = self;

[weakSelf.oneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(aView.mas_left);
    make.right.equalTo(aView.mas_right);
    make.top.equalTo (aView.mas_top);
    make.height.mas_equalTo(@30);
}];
    [weakSelf.twoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(aView.mas_left);
        make.right.equalTo(aView.mas_right);
        make.top.equalTo(weakSelf.oneLabel.mas_bottom);
        
        
        
    }];
    
    [weakSelf.threeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(aView.mas_left);
        make.right.equalTo(aView.mas_right);
        make.bottom.equalTo(aView.mas_bottom);
    
        make.height.mas_equalTo(@30);
    }];
    
    
    
    return aView;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ExthreeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    ExThreeModel *model = self.twoDataArr[indexPath.row];
    cell.exaLabel.text = model.explain;
    
    
    
    
    
    
    
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.twoDataArr.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ExThreeModel *model = self.twoDataArr[indexPath.row];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15.0f], NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGRect rectOne = [model.explain boundingRectWithSize:CGSizeMake(kScreenWidth, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    
    return rectOne.size.height+50;
}


- (void)requestOneData{
    NSString *url = @"http://www.enuo120.com/index.php/app/index/zcmaybe";
    NSDictionary *hearBody = @{@"zid":self.receiver};

    BaseRequest *request = [[BaseRequest alloc]init];
    [request POST:url params:hearBody success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        [self handleWithData:responseObject];
        NSLog(@"responseObject = %@",responseObject);
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (void)handleWithData:(NSDictionary *)dic{
    
    ExTwoModel *model = [ExTwoModel ecTwoModelInitWithData:dic[@"data"]];
   // NSLog(@"model========%@",model);
    
    
    [self.oneDataArr addObject:model];
    self.oneLabel.text = model.zz;
    self.twoLabel.text = model.introduce;
    NSLog(@"self.oneDataArr = %@",self.oneDataArr);
    NSArray *arr = dic[@"data"][@"maybe_list"];
    
    for (NSDictionary *temp in arr) {
        //NSLog(@"temp = %@",temp);
        ExThreeModel *model = [ExThreeModel exThreeModelInithDic:temp];
        [self.twoDataArr addObject:model];
       // NSLog(@"model = %@",model);
    }
      [self.tableView reloadData];
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        ExThreeModel *model = self.twoDataArr[indexPath.row];
    
    ExaThreeController *exVC = [[ExaThreeController alloc]init];
    exVC.receiver = model.cid;
    exVC.reExaple = model.mayzz;

    UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:exVC];
       naNC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    
    [self presentViewController:naNC animated:YES completion:^{
        
    }];
}


@end
