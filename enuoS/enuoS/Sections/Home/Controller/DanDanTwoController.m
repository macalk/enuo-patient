//
//  DanDanTwoController.m
//  enuoS
//
//  Created by apple on 16/8/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "DanDanTwoController.h"
#import <Masonry.h>
#import "Macros.h"
#import <AFNetworking.h>
#import "DanTwoTableViewCell.h"
#import "DanZdzzModel.h"
#import "UIColor+Extend.h"
@interface DanDanTwoController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView*tableView;

@property(nonatomic,strong)UIImageView *imageBg;
@property (nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation DanDanTwoController
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
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeigth-64) style:UITableViewStyleGrouped];
    }return _tableView;
}
//- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"绿色返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleWithBack:)];
//        self.navigationItem.leftBarButtonItem = leftItem;
//    }return self;
//    
//}

- (void)customNavView {
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"白色返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleWithBack:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    [titleLable setTextAlignment:NSTextAlignmentCenter];
    [titleLable setTextColor:[UIColor whiteColor]];
    [titleLable setText:self.titleStr];
    titleLable.font = [UIFont boldSystemFontOfSize:18];
    self.navigationItem.titleView = titleLable;
    
    self.navigationController.navigationBar.barTintColor = [UIColor stringTOColor:@"#22ccc6"];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self customNavView];
    self.view  = self.tableView;
    [self creatTableView];
    
    [self requestData];
}
- (void)handleWithBack:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)creatTableView{
    
    [self creatHeaderView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    [self.tableView setBackgroundView:self.imageBg];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DanTwoTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];

    
    
    
}
- (void)creatHeaderView{
    UIView *baseView = [[UIView alloc]init];
    
    UILabel *alable = [[UILabel alloc]init];
    alable.font = [UIFont systemFontOfSize:14];
    alable.textColor = [UIColor colorWithRed:0/255.0 green:179/255.0 blue:163/255.0 alpha:1];
    alable.textAlignment = NSTextAlignmentCenter;
    alable.text = self.receiver;
    alable.numberOfLines = 2;
    [baseView addSubview:alable];
    
    
    CGRect rect = [self.receiver boundingRectWithSize:CGSizeMake(kScreenWidth-20, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    
    baseView.frame = CGRectMake(0, 0, kScreenWidth, rect.size.height+12);
    
    alable.center = baseView.center;
    
    alable.bounds = CGRectMake(0, 0, kScreenWidth, rect.size.height+2);
    
    
    self.tableView.tableHeaderView = baseView;

    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dataArray.count !=0) {
        DanZdzzModel *model = self.dataArray[0];
        if (section == 0) {
            return 1;
        }else if (section == 1){
            return model.jc_list.count;
        }else{
            return model.ky_list.count;
        }

    }else{
        return 0;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DanTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    DanZdzzModel *model = self.dataArray[0];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
    if (indexPath.section == 0) {
        cell.titleLabel.text = model.judge;
    
    }else if (indexPath.section ==1){
        cell.titleLabel.text = model.jc_list[indexPath.row];
            cell.markImage.image = [UIImage imageNamed:@"绿勾"];
    }else{
        cell.titleLabel.text = model.ky_list[indexPath.row];
            cell.markImage.image = [UIImage imageNamed:@"红×"];
    }
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==0) {
        UIView *oneView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
        UILabel *oneLabel  = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, kScreenWidth-40, 25)];
        oneView.backgroundColor = [UIColor clearColor];
       oneLabel.text = @"鉴别诊断:";
        oneLabel.font = [UIFont systemFontOfSize:14];
        oneLabel.textColor = [UIColor whiteColor];
        
        UIImageView *oneImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 28, kScreenWidth-40, 2)];
        oneImage.image = [UIImage imageNamed:@"丹丹绿线"];
        [oneView addSubview:oneLabel];
        [oneView addSubview:oneImage];
        return oneView;
    }else if(section == 1){
        UIView *oneView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
          oneView.backgroundColor = [UIColor clearColor];
        UILabel *oneLabel  = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, kScreenWidth-40, 25)];
        UIImageView *oneImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 28, kScreenWidth-40, 2)];
        oneLabel.font = [UIFont systemFontOfSize:14];
        oneLabel.textColor = [UIColor whiteColor];
        oneLabel.text = @"建议检查项目:";
         oneImage.image = [UIImage imageNamed:@"丹丹绿线"];
        [oneView addSubview:oneLabel];
        [oneView addSubview:oneImage];
        return oneView;
    }else{
        UIView *oneView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
          oneView.backgroundColor = [UIColor clearColor];
        UILabel *oneLabel  = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, kScreenWidth-40, 25)];
        UIImageView *oneImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 28, kScreenWidth-40, 2)];
        oneLabel.font = [UIFont systemFontOfSize:14];
        oneLabel.textColor = [UIColor whiteColor];
        oneLabel.text = @"可疑检查项目:";
         oneImage.image = [UIImage imageNamed:@"丹丹绿线"];
        [oneView addSubview:oneLabel];
        [oneView addSubview:oneImage];
        return oneView;
    }
}


- (void)requestData{
    NSString *url = @"http://www.enuo120.com/index.php/app/publish/zdzz";
    
    NSDictionary *headBody = @{@"id":self.cidreceiver};
    
    AFHTTPSessionManager * mager =[AFHTTPSessionManager manager];
    [mager POST:url parameters:headBody progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleWithData:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)handleWithData:(NSDictionary *)dic{
    NSLog(@"dic = %@",dic);
    DanZdzzModel *model = [DanZdzzModel DanZdzzModelInitWithDic:dic[@"data"]];
    [self.dataArray addObject:model];
    
    [self.tableView reloadData];
    
    
    
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
