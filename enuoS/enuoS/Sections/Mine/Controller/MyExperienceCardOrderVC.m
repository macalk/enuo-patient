//
//  MyExperienceCardOrderVC.m
//  enuoS
//
//  Created by apple on 16/12/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MyExperienceCardOrderVC.h"
#import "TitleButtomView.h"
#import "Macros.h"
#import "MyExperienceCardOrderView.h"
#import <AFNetworking.h>
#import "SZKAlterView.h"
#import "UIColor+Extend.h"

@interface MyExperienceCardOrderVC ()<titleButtonDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)TitleButtomView *titleButtonView;
@property (nonatomic,strong)UIScrollView *scrollView;

@property (nonatomic,strong)NSMutableArray *allDataArr;//全部
@property (nonatomic,strong)NSMutableArray *usingArr;//预约中
@property (nonatomic,strong)NSMutableArray *hadUseArr;//已预约
@property (nonatomic,strong)NSMutableArray *hadDoneArr;//已完成

@property (nonatomic,strong)UIButton *selectBtn;//选中的评价
@property (nonatomic,copy)NSString *selectCardno;//选中的卡号


@end

@implementation MyExperienceCardOrderVC
- (NSMutableArray *)allDataArr {
    if (!_allDataArr) {
        _allDataArr = [NSMutableArray array];
    }return _allDataArr;
}
- (NSMutableArray *)usingArr {
    if (!_usingArr) {
        _usingArr = [NSMutableArray array];
    }return _usingArr;
}
- (NSMutableArray *)hadUseArr {
    if (!_hadUseArr) {
        _hadUseArr = [NSMutableArray array];
    }return _hadUseArr;
}
- (NSMutableArray *)hadDoneArr {
    if (!_hadDoneArr) {
        _hadDoneArr = [NSMutableArray array];
    }return _hadDoneArr;
}

- (void)customNavView {
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.center = self.navigationItem.titleView.center;
    titleLabel.bounds = CGRectMake(0, 0, 100, 20);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"我的特价体验劵订单";
    self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"白色返回"] style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonClick:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
}

- (void)leftBarButtonClick:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self customNavView];
    [self customTitleView];
    [self createScrollView];
    
    [self requestData];

}

- (void)requestData {
    // 天杀的后台大兄弟 -_-
    [self requestOrderWithStatue:@"0"];
    [self requestOrderWithStatue:@"1"];
    [self requestOrderWithStatue:@"2"];
    [self requestOrderWithStatue:@"3"];
}

//刷新tableView
- (void)refreshTableViewWithStatue:(NSString *)statue {
    
        UITableView *tableView = [self.view viewWithTag:50+[statue integerValue]];
    NSLog(@"%ld",(long)tableView.tag);

        [tableView reloadData];
    
}

- (void)customTitleView {
    NSArray *titleArray = @[@"全部",@"预约中",@"已预约",@"已完成"];
    TitleButtomView *titleButtonView = [[TitleButtomView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 37)];
    titleButtonView.delegate = self;
    self.titleButtonView = titleButtonView;
    [titleButtonView createTitleBtnWithBtnArray:titleArray];
    [self.view addSubview:titleButtonView];
    
}
#pragma mark ----TitleButtomView 代理方法
- (void)titleButtonClickDelegate:(NSInteger)btnTag {
    NSLog(@"%ld",(long)btnTag);
    self.scrollView.contentOffset = CGPointMake(btnTag*kScreenWidth, 0);
}
#pragma mark----ScrollView
- (void)createScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 37, kScreenWidth, kScreenHeigth-37-64)];
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(kScreenWidth*4, 0);
    scrollView.pagingEnabled = YES;
    self.scrollView = scrollView;
    [self.view addSubview:scrollView];
    
    for (int i =0; i<4; i++) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(kScreenWidth*i, 0, kScreenWidth, scrollView.bounds.size.height) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tag = 50+i;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [scrollView addSubview:tableView];
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

#pragma mark----tableView 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyExperienceCardOrderModel *model;
    
    
    if (tableView.tag == 50) {
        model = self.allDataArr[indexPath.row];
    }else if (tableView.tag == 51) {
        model = self.usingArr[indexPath.row];
    }else if (tableView.tag == 52) {
        model = self.hadUseArr[indexPath.row];
    }else if (tableView.tag == 53) {
        model = self.hadDoneArr[indexPath.row];
    }
    
    return model.bgViewHeight+120;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (tableView.tag) {
            
        case 50:
        {
            return self.allDataArr.count;
        }
            break;
        case 51:
        {
            return self.usingArr.count;
        }
            break;
        case 52:
        {
            return self.hadUseArr.count;

        }
            break;
        case 53:
        {
            return self.hadDoneArr.count;
        }
            break;

            
        default:return 0;
            break;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //清空
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    
    //(1)
    MyExperienceCardOrderModel *model;
    
    if (tableView.tag == 50) {
        model = self.allDataArr[indexPath.row];
    }else if (tableView.tag == 51) {
        model = self.usingArr[indexPath.row];
    }else if (tableView.tag == 52) {
        model = self.hadUseArr[indexPath.row];
    }else if (tableView.tag == 53) {
        model = self.hadDoneArr[indexPath.row];
    }
    
    
    //(2)
    MyExperienceCardOrderView *orderView = [[MyExperienceCardOrderView alloc]init];
    orderView.frame = CGRectMake(0, 0, kScreenWidth, 300);
    
    [orderView.button addTarget:self action:@selector(cellButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    orderView.button.tag = indexPath.row+100;
    
    [cell.contentView addSubview:orderView];

    
    [orderView createViewWithModel:model];

    
    return cell;
    
}

//cell 上 button点击事件
- (void)cellButtonClick:(UIButton *)sender {

    NSLog(@"%@",sender.currentTitle);
    
    for (UIView *next = [sender superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UITableView class]]) {
            UITableView *tableView = (UITableView *)nextResponder;
            
            MyExperienceCardOrderModel *model;
            if (tableView.tag == 50) {
                model = self.allDataArr[sender.tag-100];
            }else if (tableView.tag == 51) {
                model = self.usingArr[sender.tag-100];
            }else if (tableView.tag == 52) {
                model = self.hadUseArr[sender.tag-100];
            }else if (tableView.tag == 53) {
                model = self.hadDoneArr[sender.tag-100];
            }
            
            self.selectCardno = model.cardno;
            
            if ([sender.currentTitle isEqualToString:@"取消订单"]) {
                [self cancelOrderRequestWithCarno:model.cardno];
            }else if ([sender.currentTitle isEqualToString:@"评价"]) {
                [self createEvaluateView];
            }
            
        }
    }
    
    
}

#pragma mark---评价视图
- (void)createEvaluateView {
    UIView *bgView = [[UIView alloc]init];
    bgView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeigth);
    bgView.tag = 70;
    bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self.view addSubview:bgView];
    
    UIView *evaluaView = [[UIView alloc]init];
    evaluaView.frame = CGRectMake(0, 37, kScreenWidth, 260);
    evaluaView.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:evaluaView];
    
    NSArray *titleArr = @[@"非常满意",@"满意",@"一般",@"不满意",@"非常不满意"];
    for (int i = 0; i<5; i++) {

        UIButton *selectBtn = [[UIButton alloc]init];
        selectBtn.center = CGPointMake(self.view.center.x+20, 20+40*i);
        selectBtn.bounds = CGRectMake(0, 0, 150, 20);
        selectBtn.tag = 34-i;
        selectBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        selectBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        
        [selectBtn setTitleColor:[UIColor blackColor] forState:normal];
        [selectBtn setImage:[UIImage imageNamed:@"支付_未选中"] forState:normal];
        [selectBtn setImage:[UIImage imageNamed:@"支付_选中"] forState:UIControlStateSelected];
        [selectBtn setTitle:[NSString stringWithFormat:@"%@",titleArr[i]] forState:normal];
        [selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [evaluaView addSubview:selectBtn];
        
        UILabel *lineLabel = [[UILabel alloc]init];
        lineLabel.backgroundColor = [UIColor lightGrayColor];
        lineLabel.frame = CGRectMake(0, 40+40*i, kScreenWidth, 1);
        [evaluaView addSubview:lineLabel];
    }
    
    NSArray *btnTitleArr = @[@"确认",@"取消"];
    for (int i = 0; i<2; i++) {
    UIButton *sureBtn = [[UIButton alloc]init];
    sureBtn.center = CGPointMake(self.view.center.x-50+100*i, 230);
    sureBtn.bounds = CGRectMake(0, 0, 80, 30);
    sureBtn.layer.cornerRadius = 5;
    sureBtn.clipsToBounds = YES;
    [sureBtn setTitleColor:[UIColor whiteColor] forState:normal];
    [sureBtn setBackgroundColor:[UIColor stringTOColor:@"#00afa1"]];
    [sureBtn setTitle:[NSString stringWithFormat:@"%@",btnTitleArr[i]] forState:normal];
    [sureBtn addTarget:self action:@selector(satisfactionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [evaluaView addSubview:sureBtn];
    
    }
}
- (void)selectBtnClick:(UIButton *)sender {
    self.selectBtn.selected = NO;
    sender.selected = YES;
    self.selectBtn = sender;
}

//评价确认按钮
- (void)satisfactionBtnClick:(UIButton *)sender {
    if ([sender.currentTitle isEqualToString:@"取消"]) {
        UIView *view = [self.view viewWithTag:70];
        [view removeFromSuperview];
        self.selectBtn = nil;
        NSLog(@"><><><><%ld",(long)self.selectBtn.tag);
        
    }else {
        if (self.selectBtn == nil) {
            UIView *bgView = [[UIView alloc]init];
            bgView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeigth);
            bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
            [self.view addSubview:bgView];
            
            SZKAlterView *alterView = [SZKAlterView alterViewWithTitle:@"提示" content:@"请选择满意度" cancel:@"取消" sure:@"确定" cancelBtClcik:^{
                [bgView removeFromSuperview];
            } sureBtClcik:^{
                [bgView removeFromSuperview];
            }];
            [bgView addSubview:alterView];
            
        }else {
            NSLog(@"%ld",(long)self.selectBtn.tag);
            [self evaluateRequestWithCardno:self.selectCardno];
            UIView *view = [self.view viewWithTag:70];
            [view removeFromSuperview];
            
        }
    }
    
}

#pragma mark----request
- (void)requestOrderWithStatue:(NSString *)statue {
    
    NSString *username = [[NSUserDefaults standardUserDefaults]objectForKey:@"name"];
    NSDictionary *dic = @{@"username":username,@"statue":statue};
    
    NSString *url = @"http://www.enuo120.com/index.php/app/Patient/experience_order";
    
    BaseRequest *request = [[BaseRequest alloc]init];
    [request POST:url params:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        [self requestOrderData:responseObject withStatue:statue];

    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
- (void)requestOrderData:(NSDictionary *)dic withStatue:(NSString *)statue {
    
    if ([statue isEqualToString:@"0"]) {
        [self.allDataArr removeAllObjects];
    }else if ([statue isEqualToString:@"1"]) {
        [self.usingArr removeAllObjects];
    }else if ([statue isEqualToString:@"2"]) {
        [self.hadUseArr removeAllObjects];
    }else if ([statue isEqualToString:@"3"]) {
        [self.hadDoneArr removeAllObjects];
    }
    
    if (![dic[@"data"] isKindOfClass:[NSNull class]]) {
        
        NSArray *dataArr = dic[@"data"];
        
        for (int i = 0; i<dataArr.count; i++) {
            NSDictionary *modelDic = dataArr[i];
            
            MyExperienceCardOrderModel *model = [MyExperienceCardOrderModel MyExperienceCardOrderModelInitWithDic:modelDic];
            
            if ([statue isEqualToString:@"0"]) {
                [self.allDataArr addObject:model];
            }else if ([statue isEqualToString:@"1"]) {
                [self.usingArr addObject:model];
            }else if ([statue isEqualToString:@"2"]) {
                [self.hadUseArr addObject:model];
            }else if ([statue isEqualToString:@"3"]) {
                [self.hadDoneArr addObject:model];
            }
        }
    }
    
    [self refreshTableViewWithStatue:statue];


}

//取消订单
- (void)cancelOrderRequestWithCarno:(NSString *)cardno {
    NSString *url = @"http://www.enuo120.com/index.php/app/Patient/cancel_experience";
    NSDictionary *dic = @{@"cardno":cardno};
    
    BaseRequest *request = [[BaseRequest alloc]init];
    [request POST:url params:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        [self cancelOrderRequestData:responseObject];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (void)cancelOrderRequestData:(NSDictionary *)dic {
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeigth)];
    bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self.view addSubview:bgView];
    
    SZKAlterView *alterView = [SZKAlterView alterViewWithTitle:@"提示" content:dic[@"data"][@"message"] cancel:@"取消" sure:@"确定" cancelBtClcik:^{
        [self requestData];

        [bgView removeFromSuperview];
    } sureBtClcik:^{
        [self requestData];

        [bgView removeFromSuperview];
    }];
    
    [bgView addSubview:alterView];
    
}
//评价
- (void)evaluateRequestWithCardno:(NSString *)cardno {
    
    NSString *pjNumber = [NSString stringWithFormat:@"%ld",self.selectBtn.tag-30];
    
    NSString *url = @"http://www.enuo120.com/index.php/app/Patient/experience_evaluate";
    NSDictionary *dic = @{@"cardno":cardno,@"pj":pjNumber};
    
    BaseRequest *request = [[BaseRequest alloc]init];
    [request POST:url params:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        [self evaluateRequestData:responseObject];

    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}
- (void)evaluateRequestData:(NSDictionary *)dic {
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    bgView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeigth);
    [self.view addSubview:bgView];
    
    SZKAlterView *alterView = [SZKAlterView alterViewWithTitle:@"提示" content:dic[@"data"][@"message"] cancel:@"取消" sure:@"确认" cancelBtClcik:^{
        [bgView removeFromSuperview];
    } sureBtClcik:^{
        [bgView removeFromSuperview];
    }];
    [bgView addSubview:alterView];
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
