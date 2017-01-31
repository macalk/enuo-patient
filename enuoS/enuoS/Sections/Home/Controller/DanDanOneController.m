//
//  DanDanOneController.m
//  enuoS
//
//  Created by apple on 16/8/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "DanDanOneController.h"

#import "UIColor+Extend.h"
#import "Macros.h"
#import <AFNetworking.h>
#import <Masonry.h>

#import "DanZdIntroModel.h"
#import "DanOneTableViewCell.h"
#import "DanDanTwoController.h"
@interface DanDanOneController ()<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)UIImageView *imageBg;
@property (nonatomic,strong)NSMutableArray *dataArray;
@end



@implementation DanDanOneController

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }return _dataArray;
}


- (UIImageView *)imageBg{
    if (!_imageBg) {
        self.imageBg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"图层-4"]];
        self.imageBg.userInteractionEnabled = YES;
    }return _imageBg;
}


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeigth-64) style:UITableViewStyleGrouped];
    }return _tableView;
}

- (void)customNavView {
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"白色返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleWithBack:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    [titleLable setTextAlignment:NSTextAlignmentCenter];
    [titleLable setTextColor:[UIColor whiteColor]];
    [titleLable setText:self.receiver];
    titleLable.font = [UIFont boldSystemFontOfSize:18];
    self.navigationItem.titleView = titleLable;
    
    self.navigationController.navigationBar.barTintColor = [UIColor stringTOColor:@"#22ccc6"];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationController.navigationBar.tintColor =  [UIColor colorWithRed:0/255.0 green:179/255.0 blue:163/255.0 alpha:1];
    
    [self customNavView];
    
    [self.view addSubview:self.tableView];
    [self creatTableView];
    
    [self requestData];
    
    
}


- (void)creatTableView{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setBackgroundView:self.imageBg];

    self.tableView.backgroundColor = [UIColor clearColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DanOneTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArray.count != 0) {
        DanZdIntroModel *model = self.dataArray[indexPath.row];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15], NSParagraphStyleAttributeName:paragraphStyle.copy};
        
        CGRect rectOne = [model.bszz boundingRectWithSize:CGSizeMake(kScreenWidth-50, 20000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        return 30 + rectOne.size.height;
    }else{
        return 0;
    }
  
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  DanOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    DanZdIntroModel *model = self.dataArray[indexPath.row];
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.titleLabel.text = model.bszz;
    cell.titleLabel.numberOfLines = 0;
    cell.backgroundColor = [UIColor clearColor];
    cell.bgView.layer.cornerRadius = 5;
    cell.bgView.clipsToBounds = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *aView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    aView.backgroundColor= [UIColor clearColor];
    UILabel *alable = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, kScreenWidth-40, 25)];
    alable.text = @"选择伴随症状";
    alable.textColor = [UIColor whiteColor];
    alable.font = [UIFont systemFontOfSize:15];
    alable.textAlignment = NSTextAlignmentLeft;
    UIImageView *imageBa = [[UIImageView alloc]initWithFrame:CGRectMake(20, 27, kScreenWidth-40, 2)];
    imageBa.image = [UIImage imageNamed:@"白线"];
    
    [aView addSubview:alable];
    [aView addSubview:imageBa];
    return aView;
  
}

- (void)handleWithBack:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)requestData{
   NSString *url = @"http://www.enuo120.com/index.php/app/publish/zdintro";
    NSDictionary *headBody = @{@"id":self.cidReceiver};
    AFHTTPSessionManager *mager = [AFHTTPSessionManager manager];
    [mager POST:url parameters:headBody progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleWithData:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)handleWithData:(NSDictionary *)dic{
    NSArray *arr = dic[@"data"];
    for (NSDictionary *temp in arr) {
        DanZdIntroModel *model = [DanZdIntroModel DanZdIntroModelWithDic:temp];
        [self.dataArray addObject:model];
        
    }[self.tableView reloadData];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DanZdIntroModel *model = self.dataArray[indexPath.row];
    
    DanDanTwoController *danVC = [[DanDanTwoController alloc]init];
    danVC.titleStr = self.title;
    danVC.receiver = model.bszz;
    danVC.cidreceiver = model.cid;
    
    [self.navigationController pushViewController:danVC animated:YES];
    
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
