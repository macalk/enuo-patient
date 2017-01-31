//
//  MyExperienceCardDetailVC.m
//  enuoS
//
//  Created by apple on 16/12/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MyExperienceCardDetailVC.h"
#import "MyExperienceCardDetailCell.h"
#import "TitleButtomView.h"
#import "Macros.h"
#import <AFNetworking.h>
#import "UseExperienceCardVC.h"

@interface MyExperienceCardDetailVC ()<titleButtonDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)TitleButtomView *titleButtonView;
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)NSMutableArray *canUseArr;
@property (nonatomic,strong)NSMutableArray *hadUseArr;
@property (nonatomic,strong)NSMutableArray *loseUseArr;

@end

@implementation MyExperienceCardDetailVC
- (NSMutableArray *)canUseArr {
    if (!_canUseArr) {
        _canUseArr = [NSMutableArray array];
    }return _canUseArr;
}
- (NSMutableArray *)hadUseArr {
    if (!_hadUseArr) {
        _hadUseArr = [NSMutableArray array];
    }return _hadUseArr;
}
- (NSMutableArray *)loseUseArr {
    if (!_loseUseArr) {
        _loseUseArr = [NSMutableArray array];
    }return _loseUseArr;
}


- (void)customNavView {
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.center = self.navigationItem.titleView.center;
    titleLabel.bounds = CGRectMake(0, 0, 100, 20);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"我的特价体验劵";
    self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"白色返回"] style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonClick:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

}

- (void)leftBarButtonClick:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [self requestWithStatus:@"0"];
    [self requestWithStatus:@"1"];
    [self requestWithStatus:@"2"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self customNavView];
    [self customTitleView];
    [self createScrollView];
    
    //请求数据--无力吐槽后台大兄弟 -_-
    [self requestWithStatus:@"0"];
    [self requestWithStatus:@"1"];
    [self requestWithStatus:@"2"];
}

//刷新tableView
- (void)refreshTableView {
    for (int i = 0; i<3; i++) {
        UITableView *tableView = [self.view viewWithTag:50+i];
        [tableView reloadData];
    }
}

- (void)customTitleView {
    NSArray *titleArray = @[@"可用",@"已用",@"失效"];
    TitleButtomView *titleButtonView = [[TitleButtomView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 37)];
    titleButtonView.delegate = self;
    self.titleButtonView = titleButtonView;
    [titleButtonView createTitleBtnWithBtnArray:titleArray];
    [self.view addSubview:titleButtonView];

}

#pragma mark---TitleButtomView代理方法
- (void)titleButtonClickDelegate:(NSInteger)btnTag {
    self.scrollView.contentOffset = CGPointMake(btnTag*kScreenWidth, 0);
}

- (void)createScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 37, kScreenWidth, kScreenHeigth-37-64)];
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(kScreenWidth*3, 0);
    scrollView.pagingEnabled = YES;
    self.scrollView = scrollView;
    [self.view addSubview:scrollView];
    
    for (int i =0; i<3; i++) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(kScreenWidth*i, 0, kScreenWidth, scrollView.bounds.size.height) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tag = 50+i;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [scrollView addSubview:tableView];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kScreenWidth/2+10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (tableView.tag) {
        case 50:
        {
            return self.canUseArr.count;
        }
            break;
        case 51:
        {
            return self.hadUseArr.count;
        }
            break;
        case 52:
        {
            return self.loseUseArr.count;
        }
            break;
            
        default:return 0;
            break;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyExperienceCardDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
      NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"MyExperienceCardDetailCell" owner:self options:nil];
        for (id tempCell in array) {
            if ([tempCell isKindOfClass:[MyExperienceCardDetailCell class]]) {
                cell = tempCell;
            }
        }
    }
    
    MyExperienceCardDetailModel *model;

    if (tableView.tag == 50) {
        model = self.canUseArr[indexPath.row];
        if (model.is_yue == 1) {
            [cell.statusButton setTitle:@"预约中" forState:normal];
        }else {
            [cell.statusButton setTitle:@"使用" forState:normal];
            [cell.statusButton addTarget:self action:@selector(statusButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }else if (tableView.tag == 51) {
        [cell.statusButton setTitle:@"已使用" forState:normal];
        model = self.hadUseArr[indexPath.row];
    }else {
        [cell.statusButton setTitle:@"已失效" forState:normal];
        model = self.loseUseArr[indexPath.row];
    }
    cell.model = model;

    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//使用按钮点击功能
- (void)statusButtonClick:(UIButton *)sender {
    
    for (UIView *next = [sender superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[MyExperienceCardDetailCell class]]) {
            MyExperienceCardDetailCell *cell = (MyExperienceCardDetailCell *)nextResponder;
            
            UseExperienceCardVC *useVC = [[UseExperienceCardVC alloc]init];
            useVC.cardno = cell.model.cardno;
            useVC.hosID = cell.model.hos_id;
            useVC.hosName = cell.model.hos_name;
            useVC.product = cell.model.product;
            [self.navigationController pushViewController:useVC animated:YES];
        }
    }
    
   
}

#pragma mark---scrollView代理事件
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (![scrollView isKindOfClass:[UITableView class]]) {
        [self.titleButtonView changeButtonState:scrollView.contentOffset.x/kScreenWidth];
    }
    
}


- (void)requestWithStatus:(NSString *)status {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *name = [[NSUserDefaults standardUserDefaults]objectForKey:@"name"];
    NSString *url = @"http://www.enuo120.com/index.php/app/Patient/experience";
    NSDictionary *dic = @{@"statue":status,@"username":name};
    
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self requestDataWithStatus:status withData:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)requestDataWithStatus:(NSString *)status withData:(NSDictionary *)dic{
    
    if ([status isEqualToString:@"0"]) {
        [self.canUseArr removeAllObjects];
    }else if ([status isEqualToString:@"1"]) {
        [self.hadUseArr removeAllObjects];
    }else {
        [self.loseUseArr removeAllObjects];
    }
        
    if (![dic[@"data"] isEqual:[NSNull null]]) {
        
        NSArray *dataArr = dic[@"data"];
        for (int i = 0; i<dataArr.count; i++) {
            MyExperienceCardDetailModel *model = [MyExperienceCardDetailModel MyExperienceCardDetailModelInitWithDic:dataArr[i]];
            
            if ([status isEqualToString:@"0"]) {
                [self.canUseArr addObject:model];
            }else if ([status isEqualToString:@"1"]) {
                [self.hadUseArr addObject:model];
            }else {
                [self.loseUseArr addObject:model];
            }
        }

    }
    
    [self refreshTableView];
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
