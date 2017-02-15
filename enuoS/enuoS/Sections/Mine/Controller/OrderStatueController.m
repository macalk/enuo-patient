//
//  OrderStatueController.m
//  enuoS
//
//  Created by apple on 16/8/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "OrderStatueController.h"
#import <AFNetworking.h>
#import "Macros.h"
#import "OrderStateModel.h"
#import "OrderStateViewCell.h"
#import <SVProgressHUD.h>
#import <Masonry.h>
#import "OrderStateOneViewCell.h"
@interface OrderStatueController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation OrderStatueController


- (UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc]init];
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


- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD show];
    self.view.backgroundColor =[ UIColor whiteColor];
    [self creatTableView];
    [self requestData];
}
- (void)handleWithBack:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
//tableView创建
- (void)creatTableView{
    self.tableView .delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"OrderStateViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"OrderStateOneViewCell" bundle:nil] forCellReuseIdentifier:@"cell2"];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    OrderStateModel *model = self.dataArray[indexPath.row];
       if ([model.yue_statue_name isEqualToString:@"预约已取消"]) {
           OrderStateOneViewCell*cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
           UILabel *nameLabel = [[UILabel alloc]init];
           UILabel *leftLabel  = [[UILabel alloc]init];
           nameLabel.font = [UIFont systemFontOfSize:13.0];
           leftLabel.font = [UIFont systemFontOfSize:13.0];
           nameLabel.text = @"取消原因:";
           cell.hosLabel.text = model.hos_name;
           cell.statueLabel.text = model.yue_statue_name;
           cell.deskLabel.text = model.department;
           cell.docLabel.text = model.doc_name;
           cell.illLabel.text = model.ill;
           cell.dnumberLabel.text = model.dnumber;
           cell.timeLabel.text = model.yue_time;
           cell.categoryLabel.text = model.category;
           cell.treateLabel.text = model.treat;
           cell.BgView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
           cell.selectionStyle = UITableViewCellSelectionStyleNone;
           cell.statueLabel.backgroundColor=  [UIColor whiteColor];
           cell.leftLabel.text = model.delete_reason;

        
 
        return cell;
       }else{
            OrderStateViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
           UILabel *nameLabel = [[UILabel alloc]init];
           UILabel *leftLabel  = [[UILabel alloc]init];
           nameLabel.font = [UIFont systemFontOfSize:13.0];
           leftLabel.font = [UIFont systemFontOfSize:13.0];
           nameLabel.text = @"取消原因:";
           cell.hos_name.text = model.hos_name;
           cell.statue_label.text = model.yue_statue_name;
           cell.desk_label.text = model.department;
           cell.doc_label.text = model.doc_name;
           cell.ill_label.text = model.ill;
           cell.dnumber_label.text = model.dnumber;
           cell.time_label.text = model.yue_time;
           cell.categoryLabel.text = model.category;
           cell.treateLabel.text = model.treat;
           cell.bgView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
           cell.selectionStyle = UITableViewCellSelectionStyleNone;
           cell.statue_label.backgroundColor=  [UIColor whiteColor];
           leftLabel.text = model.delete_reason;
              return cell;
       }
    
    
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.dataArray.count !=0) {
        OrderStateModel *model = self.dataArray[indexPath.row];
        
        if([model.yue_statue_name isEqualToString:@"预约已取消"]){
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13.0f], NSParagraphStyleAttributeName:paragraphStyle.copy};
        CGRect rectOne = [model.delete_reason boundingRectWithSize:CGSizeMake(kScreenWidth - 100, 2000)options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        
            
            return rectOne .size.height +180;
            
        }else{
            return 200;
        }
    }else{
        return 0;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (void)requestData{
    NSString *url = @"http://www.enuo120.com/index.php/app/patient/appoint";
    
    
    NSUserDefaults *userStand = [NSUserDefaults standardUserDefaults];
    NSString *name = [userStand objectForKey:@"name"];
    
    NSDictionary *dic = @{@"username":name};
    
    BaseRequest *request = [[BaseRequest alloc]init];
    [request POST:url params:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        [self handleWithData:responseObject];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
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

- (void)handleWithData:(NSDictionary *)dic{
    NSArray *arr = dic[@"data"];
    for (NSDictionary *temp in arr) {
        OrderStateModel *model = [OrderStateModel orderInitWithDic:temp];
        [self.dataArray addObject:model];
    }[self.tableView reloadData];
    
    
    if (self.dataArray.count ==0) {
        [self creatnullView];
    }else{
        self.view = self.tableView;
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
