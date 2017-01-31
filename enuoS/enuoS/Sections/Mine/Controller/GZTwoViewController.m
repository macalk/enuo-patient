//
//  GZTwoViewController.m
//  enuoS
//
//  Created by apple on 16/8/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GZTwoViewController.h"

#import "GZHosTableViewCell.h"
#import "FindHosModel.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <UIImageView+WebCache.h>
#import "HosViewController.h"
#import "hosHomePageVC.h"
#import "Macros.h"
#import <Masonry.h>

@interface GZTwoViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>


@property (nonatomic ,strong)NSMutableArray *dataArr;

@property (nonatomic,strong)UITableView *tabeleView;
@property (nonatomic,copy)NSString *docID;
@end

@implementation GZTwoViewController

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        self.dataArr = [NSMutableArray array];
    }return _dataArr;
}
-(UITableView *)tabeleView{
    if (!_tabeleView) {
        self.tabeleView =[[UITableView alloc]init];
    }return _tabeleView;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD show];
    [self creataTableView];
    [self requestData];
}

- (void)creataTableView{
    
    self.tabeleView.delegate = self;
    self.tabeleView.dataSource = self;
    self.tabeleView.separatorStyle = UITableViewCellSelectionStyleNone;

    
     [self.tabeleView registerNib:[UINib nibWithNibName:@"GZHosTableViewCell" bundle:nil] forCellReuseIdentifier:@"Hoscell"];
    
}



- (void)requestData{
    NSString *url  = @"http://www.enuo120.com/index.php/app/Patient/hos_guanzhu_list";
    NSUserDefaults *stand = [NSUserDefaults standardUserDefaults];
    NSString *name = [stand objectForKey:@"name"];
    NSDictionary *headBody = @{@"username":name};
    
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    
    [manger POST:url parameters:headBody progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleWithData:responseObject];
        NSLog(@"ress = %@",responseObject);
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
}

- (void)handleWithData:(NSDictionary *)dic{
    if ([dic[@"data"]isKindOfClass:[NSNull class]]) {
        [self creatnullView];
    }else{
    NSArray *arr = dic[@"data"];
    
    for (NSDictionary *temp in arr) {
        FindHosModel *model = [FindHosModel findHosModelInithWithDic:temp];
        [self.dataArr addObject:model];
    
    }[self.tabeleView reloadData];
    if (self.dataArr.count ==0) {
        [self creatnullView];
    }else{
        self.view =  self.tabeleView;
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






- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 211;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GZHosTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Hoscell" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:247/255.0 alpha:1];
    cell.bgView.layer.cornerRadius = 4.0;
    cell.bgView.layer.borderColor = [UIColor clearColor].CGColor;
    cell.bgView.layer.borderWidth = 1.0;
    
    cell.bgView.layer.shadowColor = [UIColor lightGrayColor].CGColor;//shadowColor阴影颜色
    cell.bgView.layer.shadowOffset = CGSizeMake(0,2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    cell.bgView.layer.shadowOpacity = 0.5;//阴影透明度，默认0
    cell.bgView.layer.shadowRadius = 4;
    FindHosModel *model = self.dataArr[indexPath.row];
    
    cell.hosNameLabel.text = model.hos_name;
    cell.numLabel.text = model.zhen;
    cell.rankLabel.text = model.rank;
    cell.ybLabel.text = model.yb;
    cell.addressLabel.text = model.address;
    cell.illLabel.text = model.ill;
    [self.tabeleView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    NSString *str = [NSString stringWithFormat:urlPicture,model.photo];
    [cell.photoImage sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:nil];
    
    [cell.gzBtn addTarget:self action:@selector(handelwithGZBtn: event:) forControlEvents:UIControlEventTouchUpInside];
    cell.gzBtn.layer.cornerRadius = 5;
    cell.gzBtn.clipsToBounds = YES;
    
    return cell;

}


- (void)handelwithGZBtn:(id *)sender event:(id)event{
    
    NSSet *touches =[event allTouches];
    UITouch *touch =[touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tabeleView];
    NSIndexPath *indexPath= [self.tabeleView indexPathForRowAtPoint:currentTouchPosition];
    if (indexPath!= nil){
       FindHosModel *model = self.dataArr[indexPath.row];
        self.docID = model.cid;
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"取消关注" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: @"取消",nil];
            [alert show];
        }else{
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"取消关注" preferredStyle:UIAlertControllerStyleAlert];
            [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self requestPassGz:self.docID];
            }]];
            [alertView addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"取消");
            }]];
            
            [self presentViewController:alertView animated:YES completion:^{
                
            }];
        }
        
        
    }
    
    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [self requestPassGz:self.docID];
            break;
        case 1:
            NSLog(@"取消");
            break;
        default:
            break;
    }
}

- (void)requestPassGz:(NSString*)dic{
    NSString *url = @"http://www.enuo120.com/index.php/app/patient/guanzhuh";
    NSUserDefaults *stande = [NSUserDefaults standardUserDefaults];
    NSString *name = [stande objectForKey:@"name"];
    NSDictionary *headBody = @{@"username":name,@"type":@"0",@"hid":dic};
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger POST:url parameters:headBody progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handelWithPassGz:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
- (void)handelWithPassGz:(NSDictionary *)dic{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"取消成功" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alert show];
        [self.dataArr removeAllObjects];
        [self requestData];
    }else{
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"取消成功" preferredStyle:UIAlertControllerStyleAlert];
        [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.dataArr removeAllObjects];
            [self requestData];
        }]];
        
        
        [self presentViewController:alertView animated:YES completion:^{
            
        }];
    }
    
    
}










- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    hosHomePageVC *hosVC = [[hosHomePageVC alloc]init];
    UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:hosVC];
    FindHosModel *model = self.dataArr[indexPath.row];
    hosVC.receiver = model.cid;
    [self presentViewController:naNC animated:YES completion:^{
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}



@end
