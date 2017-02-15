//
//  SarchDetailViewController.m
//  enuoS
//
//  Created by apple on 16/8/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SarchDetailViewController.h"
#import "Macros.h"
#import "UIColor+Extend.h"
#import "FindDocModel.h"
#import "FindHosModel.h"
#import "PromiseDocViewCell.h"
#import "PromiseHosViewCell.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import "illSeaModel.h"
#import "ILLSearchTableViewCell.h"
#import "DoctorViewController.h"
//#import "HosViewController.h"
#import "hosHomePageVC.h"
#import "SearchIllHosViewController.h"

@interface SarchDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArray;


@end

@implementation SarchDetailViewController


- (UITableView *)tableView{
    if (!_tableView) {
        self.tableView  = [[UITableView alloc]init];
    }return _tableView;
}


- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }return _dataArray;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"绿色返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleWithBack:)];
        
        self.navigationItem.leftBarButtonItem = leftItem;

    }return self;
}

- (void)customNavView {
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"白色返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleWithBack:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    [titleLable setTextAlignment:NSTextAlignmentCenter];
    [titleLable setTextColor:[UIColor whiteColor]];
    [titleLable setText:@"搜索结果"];
    titleLable.font = [UIFont boldSystemFontOfSize:18];
    self.navigationItem.titleView = titleLable;
    
    self.navigationController.navigationBar.barTintColor = [UIColor stringTOColor:@"#22ccc6"];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
}



- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self customNavView];
    [SVProgressHUD show];
    [self creatTableView];
    [self requestData];
}
- (void)handleWithBack:(UIBarButtonItem *)sender{
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)creatTableView{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //self.view = self.tableView;
   self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"ILLSearchTableViewCell" bundle:nil] forCellReuseIdentifier:@"illcell"];
        [self.tableView registerNib:[UINib nibWithNibName:@"PromiseHosViewCell" bundle:nil] forCellReuseIdentifier:@"hoscell"];
     [self.tableView registerNib:[UINib nibWithNibName:@"PromiseDocViewCell" bundle:nil] forCellReuseIdentifier:@"doccell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.receiveMark isEqualToString:@"0"] || [self.receiveMark isEqualToString:@"1"]) {
        return 140;
    }else {
        return 165;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.receiveMark isEqualToString:@"0"]) {
        ILLSearchTableViewCell *cell = [[ILLSearchTableViewCell alloc]init];
        
        NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"ILLSearchTableViewCell" owner:nil options:nil];
        for (id tempCell in array) {
            if ([tempCell isKindOfClass:[ILLSearchTableViewCell class]]) {
                cell = tempCell;
            }
        }
        
        
        cell.bgView.layer.cornerRadius = 4.0;
        cell.bgView.layer.borderColor = [UIColor clearColor].CGColor;
        cell.bgView.layer.borderWidth = 1.0;
        
        cell.bgView.layer.shadowColor = [UIColor lightGrayColor].CGColor;//shadowColor阴影颜色
        cell.bgView.layer.shadowOffset = CGSizeMake(0,2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
        cell.bgView.layer.shadowOpacity = 0.5;//阴影透明度，默认0
        cell.bgView.layer.shadowRadius = 4;
        illSeaModel *model = self.dataArray[indexPath.row];
        tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        
        NSString *str = [NSString stringWithFormat:urlPicture,model.photo];
        [cell.photoImage sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:nil];
        cell.illLabel.text = model.ill;
        cell.priceLabel.text = [NSString stringWithFormat:@"不高于%@元",model.heightprice];
        cell.cycleLabel.text = model.cycle;
     
    NSString *strOne = [model.effect stringByReplacingOccurrencesOfString:@"</p>" withString:@"\n"];
           cell.effectLabel.text = [strOne stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
        return cell;
        
    }else if ([self.receiveMark isEqualToString:@"1"]){
        PromiseHosViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hoscell" forIndexPath:indexPath];
        cell.contentView.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:247/255.0 alpha:1];
        cell.bgView.layer.cornerRadius = 4.0;
        cell.bgView.layer.borderColor = [UIColor clearColor].CGColor;
        cell.bgView.layer.borderWidth = 1.0;
        
        cell.bgView.layer.shadowColor = [UIColor lightGrayColor].CGColor;//shadowColor阴影颜色
        cell.bgView.layer.shadowOffset = CGSizeMake(0,2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
        cell.bgView.layer.shadowOpacity = 0.5;//阴影透明度，默认0
        cell.bgView.layer.shadowRadius = 4;
        FindHosModel *model = self.dataArray[indexPath.row];
        tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        
        cell.hosNameLabel.text = model.name;
        cell.zhenLabel.text = [NSString stringWithFormat:@"%@ 人",model.zhen];
        cell.rankLabel.text = model.rank;
        cell.ybLabel.text = model.yb;
        cell.addressLabel.text = model.address;
        cell.introduceLabel.text = model.introduce;
        cell.dunLabel.text = model.dun;
        cell.commentLabel.text = [NSString stringWithFormat:@"%ld",(long)model.comment_num];
        cell.phoneLabel.text = model.phone;
        
        NSString *str = [NSString stringWithFormat:urlPicture,model.photo];
        [cell.photoImage sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:nil];
        
        
        
        return cell;

    }else{
        PromiseDocViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"doccell" forIndexPath:indexPath];
        cell.contentView.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:247/255.0 alpha:1];
        
        
    
        
        // [cell.contentView addSubview:imageD9];
        cell.bgView.layer.cornerRadius = 4.0;
        cell.bgView.layer.borderColor = [UIColor whiteColor].CGColor;
        //cell.bgView.layer.borderWidth = 1.0;
        
        
        cell.bgView.layer.shadowColor = [UIColor lightGrayColor].CGColor;//shadowColor阴影颜色
        cell.bgView.layer.shadowOffset = CGSizeMake(0,2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
        cell.bgView.layer.shadowOpacity = 0.5;//阴影透明度，默认0
        cell.bgView.layer.shadowRadius = 4;
        FindDocModel *model = self.dataArray[indexPath.row];
        cell.nameLabel.text = model.name;
        cell.nuoNumber.text = model.nuo;
        
        NSString *str0ne = [NSString stringWithFormat:urlPicture,model.photo];
        
        cell.illLabel.text = model.treatment;
        
        [cell.photoImage sd_setImageWithURL:[NSURL URLWithString:str0ne] placeholderImage:nil];
        NSLog(@"model.professinaol = %@",model.professional);
        cell.proLabel.text = model.professional;
        cell.deskLabel.text = model.dep_name;
        cell.pepLaebl.text = [NSString stringWithFormat:@"%@ 人",model.zhen];
        cell.hosLabel.text = model.hos_name;
        cell.commentLabel.text = [NSString stringWithFormat:@"%ld",(long)model.comment_num];
        
        if (model.guanzhu == 0) {
            [cell.likeBtn setImage:[UIImage imageNamed:@"关注"] forState:normal];
        }else {
            [cell.likeBtn setImage:[UIImage imageNamed:@"关注-s"] forState:normal];
        }
        
        return  cell;

    }
}


- (void)requestData{
    NSLog(@"%@~~~%@",self.receiveMark,self.resualt);
    NSString *url = @"http://www.enuo120.com/index.php/app/search/search_result";
    NSDictionary *heardBody = @{@"type":self.receiveMark,@"search_val":self.resualt,@"ver":@"1.0"};
    
    BaseRequest *request = [[BaseRequest alloc]init];
    [request POST:url params:heardBody success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        [self handleWithDic:responseObject];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

- (void)handleWithDic:(NSDictionary *)dic{
    NSArray *arr = dic[@"data"];
    if ([dic[@"data"]isEqual:[NSNull null]]) {
        [self creatnullView];
    }else{
        self.view = self.tableView;
    if ([self.receiveMark isEqualToString:@"0"]) {
        for (NSDictionary *temp  in arr) {
            illSeaModel *model = [illSeaModel IllinItWithDic:temp];
            [self.dataArray addObject:model];
        }
        [self.tableView reloadData];
    }else if ([self.receiveMark isEqualToString:@"1"]){
        for (NSDictionary *temp  in arr) {
           FindHosModel *model = [FindHosModel findHosModelInithWithDic:temp];
            [self.dataArray addObject:model];
        }
        [self.tableView reloadData];
       
    }else{
        for (NSDictionary *temp  in arr) {
           FindDocModel *model = [FindDocModel findDocModelInitWithDic: temp];
            [self.dataArray addObject:model];
        }
        [self.tableView reloadData];
    }
    }
}

- (void)creatnullView{
    UILabel *nullLabel = [[UILabel alloc]init];
    
    nullLabel.text = @"暂无数据";
    nullLabel.textColor = [UIColor lightGrayColor];
    nullLabel.font = [UIFont systemFontOfSize:24];
    [self.view addSubview:nullLabel];
    __weak typeof(self) weakSelf = self;
    
    [nullLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view);
        make.centerY.equalTo (weakSelf.view).with.offset(-100);
        
    }];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.receiveMark isEqualToString:@"0"]) {
        illSeaModel *model = self.dataArray[indexPath.row];
        SearchIllHosViewController *sar = [[SearchIllHosViewController alloc]init];
        sar.receiver = model.ill;
        UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:sar];
        [self presentViewController:naNC animated:YES completion:^{
            
        }];
    }else if ([self.receiveMark isEqualToString:@"1"]){
        hosHomePageVC *hosVC = [[hosHomePageVC alloc]init];
        
        UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:hosVC];
        
        FindHosModel *model =self.dataArray[indexPath.row];
        
        hosVC.receiver = model.cid;
        
        [self presentViewController:naNC animated:YES completion:^{
            
        }];
        
    }else{
        DoctorViewController *docVC = [[DoctorViewController alloc]init];
        
        UINavigationController *navNC = [[UINavigationController alloc]initWithRootViewController:docVC];
        FindDocModel *monder = self.dataArray[indexPath.row];
        docVC.receiver = monder.cid;
        
        [self presentViewController:navNC animated:YES completion:^{
            
        }];

    }

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
