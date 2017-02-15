//
//  DanZlIntroViewController.m
//  enuoS
//
//  Created by apple on 16/8/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "DanZlIntroViewController.h"
#import "DanZlIntroModel.h"
#import "Macros.h"
#import <AFNetworking.h>
#import <Masonry.h>
#import "DanOneTableViewCell.h"
#import <SVProgressHUD.h>
#import "UIColor+Extend.h"
@interface DanZlIntroViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UIImageView *imageBg;

@end

@implementation DanZlIntroViewController

- (UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc]init];
        
    }return _tableView;
}
- (UIImageView *)imageBg{
    if (!_imageBg) {
        self.imageBg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"图层-4"]];
        self.imageBg.userInteractionEnabled = YES;
    }return _imageBg;
}


- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
        
    }return _dataArray;
}
//- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"绿色返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleWithBack:)];
//        self.navigationItem.leftBarButtonItem = leftItem;
//    }return self;
//}

- (void)customNavView {
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"白色返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleWithBack:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.navigationController.navigationBar.barTintColor = [UIColor stringTOColor:@"#22ccc6"];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self customNavView];
    [SVProgressHUD show];
    self.view  = self.tableView;
    
    [self creatTableView];
    [self requestData];
}
- (void)handleWithBack:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)creatTableView{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    [self.tableView setBackgroundView:self.imageBg];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DanOneTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    
    [self creatHeaderView];
    
    
    
    
}
- (void)creatHeaderView{
    UIImageView *imageBg = [[UIImageView alloc]init];
    UILabel *label = [[UILabel alloc]init];
    imageBg.image = [UIImage imageNamed:@"症状标题"];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = self.receiver;
    label.font = [UIFont systemFontOfSize:13];
    [self.tableView.tableHeaderView addSubview:imageBg];
    [imageBg addSubview:label];
    __weak typeof(self) weakSelf = self;
    
    
    [imageBg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(weakSelf.tableView.tableHeaderView);
        make.centerY.equalTo (weakSelf.tableView.tableHeaderView);
        make.width.mas_equalTo(@120);
        make.height.mas_equalTo(@40);
        
    }];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(imageBg);
        make.centerX.equalTo(imageBg);
        
    }];
    
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArray.count != 0) {
        DanZlIntroModel *model = self.dataArray[0];
        
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15], NSParagraphStyleAttributeName:paragraphStyle.copy};
        if (indexPath.section == 0) {
              NSString *str1 = [model.zl_method stringByReplacingOccurrencesOfString:@"；" withString:@"\n"];
            CGRect rectOne = [str1 boundingRectWithSize:CGSizeMake(kScreenWidth-50, 20000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
            return 30 + rectOne.size.height;
        
        
    }else if(indexPath.section == 1){
        NSString *str1 = [model.inspect stringByReplacingOccurrencesOfString:@"；" withString:@"\n"];
        CGRect rectOne = [str1 boundingRectWithSize:CGSizeMake(kScreenWidth-50, 20000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        return 30 + rectOne.size.height;
    }else if(indexPath.section == 3){
        NSString *str1 = [model.drug_choice stringByReplacingOccurrencesOfString:@"；" withString:@"\n"];
        CGRect rectOne = [str1 boundingRectWithSize:CGSizeMake(kScreenWidth-50, 20000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        return 30 + rectOne.size.height;
    }else{
        return 35;
    }
    }else{
        return 0;
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==0) {
        UIView *oneView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
        UILabel *oneLabel  = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, kScreenWidth-40, 25)];
        oneView.backgroundColor = [UIColor clearColor];
        oneLabel.text = @"治疗方案:";
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
        oneLabel.text = @"检查项目:";
        oneImage.image = [UIImage imageNamed:@"丹丹绿线"];
        [oneView addSubview:oneLabel];
        [oneView addSubview:oneImage];
        return oneView;
    }else if(section == 2){
        UIView *oneView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
        oneView.backgroundColor = [UIColor clearColor];
        UILabel *oneLabel  = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, kScreenWidth-40, 25)];
        UIImageView *oneImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 28, kScreenWidth-40, 2)];
        oneLabel.font = [UIFont systemFontOfSize:14];
        oneLabel.textColor = [UIColor whiteColor];
        oneLabel.text = @"住院时间:";
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
        oneLabel.text = @"药物选择:";
        oneImage.image = [UIImage imageNamed:@"丹丹绿线"];
        [oneView addSubview:oneLabel];
        [oneView addSubview:oneImage];
        return oneView;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   DanOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
 cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
    if (self.dataArray.count != 0) {
        DanZlIntroModel *model = self.dataArray[0];
        
        if (indexPath.section == 0) {
             NSString *str1 = [model.zl_method stringByReplacingOccurrencesOfString:@"；" withString:@"\n"];
            cell.titleLabel.text = str1;
        }else if (indexPath.section == 1){
                NSString *str1 = [model.inspect stringByReplacingOccurrencesOfString:@"；" withString:@"\n"];
            cell.titleLabel.text = str1;
        }else if (indexPath.section == 2){
            cell.titleLabel.text = model.zl_time;
        }else{
             NSString *str1 = [model.drug_choice stringByReplacingOccurrencesOfString:@"；" withString:@"\n"];
            cell.titleLabel.text = str1;
        }
        
        
        
        
    }
    
    
    
    
    
    return cell;
}
- (void)requestData{
    NSString *url = @"http://www.enuo120.com/index.php/app/publish/zlintro";
    NSDictionary *heardBody = @{@"id":self.cidReceiver};
    
    BaseRequest *request = [[BaseRequest alloc]init];
    [request POST:url params:heardBody success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        [self handleWithData:responseObject];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 30;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

- (void)handleWithData:(NSDictionary *)dic{
    
    DanZlIntroModel *model = [DanZlIntroModel danZlIntroModelWithDic:dic[@"data"]];
    
    [self.dataArray addObject:model];
    [self.tableView reloadData];
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
