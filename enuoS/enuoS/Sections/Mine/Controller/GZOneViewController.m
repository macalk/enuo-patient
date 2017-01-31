//
//  GZOneViewController.m
//  enuoS
//
//  Created by apple on 16/8/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "GZOneViewController.h"

#import "GZDocTableViewCell.h"

#import <AFNetworking.h>
#import "Macros.h"

#import <SVProgressHUD.h>
#import <UIImageView+WebCache.h>
#import "FindDocModel.h"
#import "DoctorViewController.h"
#import <Masonry.h>

@interface GZOneViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,copy)NSString *docID;
@end

@implementation GZOneViewController


- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        self.dataArr = [NSMutableArray array];
    }return _dataArr;
}


- (UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc]init];
        
    }return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD show];
    [self creatTableView];
    [self requestGZDoc];
}



- (void)creatTableView{
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GZDocTableViewCell" bundle:nil] forCellReuseIdentifier:@"Doccell"];
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 185;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GZDocTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Doccell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:247/255.0 alpha:1];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // [cell.contentView addSubview:imageD9];
    cell.bgView.layer.cornerRadius = 4.0;
    cell.bgView.layer.borderColor = [UIColor whiteColor].CGColor;
    //cell.bgView.layer.borderWidth = 1.0;
    
    
    cell.bgView.layer.shadowColor = [UIColor lightGrayColor].CGColor;//shadowColor阴影颜色
    cell.bgView.layer.shadowOffset = CGSizeMake(0,2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    cell.bgView.layer.shadowOpacity = 0.5;//阴影透明度，默认0
    cell.bgView.layer.shadowRadius = 4;
    FindDocModel *model = self.dataArr[indexPath.row];
    cell.nameLabel.text = model.name;
    cell.nuoNumber.text = model.nuo;
    
    NSString *str0ne = [NSString stringWithFormat:urlPicture,model.photo];
    

    
    [cell.photoImage sd_setImageWithURL:[NSURL URLWithString:str0ne] placeholderImage:nil];
    cell.photoImage.layer.borderWidth = 1;
    cell.photoImage.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    
    
    cell.proLabel.text = model.professional;
    cell.deskLabel.text = model.dep_name;
    cell.pepLaebl.text = model.zhen;
    cell.hosLabel.text = model.hos_name;
    [cell.gzBtn addTarget:self action:@selector(handelwithGZBtn: event:) forControlEvents:UIControlEventTouchUpInside];
    cell.gzBtn.layer.cornerRadius = 5;
    cell.gzBtn.clipsToBounds = YES;
    
//    [self.tableView setTableHeaderView:[[UIView alloc]initWithFrame:CGRectZero]];
//    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    return  cell;
}


- (void)handelwithGZBtn:(id *)sender event:(id)event{
    
    NSSet *touches =[event allTouches];
    UITouch *touch =[touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    NSIndexPath *indexPath= [self.tableView indexPathForRowAtPoint:currentTouchPosition];
    if (indexPath!= nil){
        FindDocModel *model = self.dataArr[indexPath.row];
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
    NSString *url = @"http://www.enuo120.com/index.php/app/patient/guanzhu";
    NSUserDefaults *stande = [NSUserDefaults standardUserDefaults];
    NSString *name = [stande objectForKey:@"name"];
    NSDictionary *headBody = @{@"username":name,@"type":@"0",@"did":dic};
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
        [self requestGZDoc];
    }else{
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"取消成功" preferredStyle:UIAlertControllerStyleAlert];
        [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.dataArr removeAllObjects];
            [self requestGZDoc];
        }]];
        
        
        [self presentViewController:alertView animated:YES completion:^{
            
        }];
    }

    
}



- (void)requestGZDoc{
    NSString *url  = @"http://www.enuo120.com/index.php/app/Patient/doc_guanzhu_list";
    NSUserDefaults *stand = [NSUserDefaults standardUserDefaults];
    NSString *name = [stand objectForKey:@"name"];
    NSDictionary *headBody = @{@"username":name};
    
    AFHTTPSessionManager *mager =[ AFHTTPSessionManager manager];
    
    [mager POST:url parameters:headBody progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handelWithData:responseObject];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
 
}


- (void)handelWithData:(NSDictionary *)dic{
    if ([dic[@"data"]isKindOfClass:[NSNull class]]) {
        [self creatnullView];
    }else{
    NSArray *arr = dic[@"data"];
    for (NSDictionary *temp in arr) {
        FindDocModel *model = [FindDocModel findDocModelInitWithDic:temp];
        [self.dataArr addObject:model];
        
    }[self.tableView reloadData];
    
    if (self.dataArr.count ==0) {
        [self creatnullView];
    }else{
          self.view = self.tableView;
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
    
    DoctorViewController *docVC = [[DoctorViewController alloc]init];
    UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:docVC];
    FindDocModel *model = self.dataArr[indexPath.row];
    docVC.receiver = model.cid;
    [self presentViewController:naNC animated:YES completion:^{
        
    }];
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
