//
//  MyOrderInforViewController.m
//  enuoS
//
//  Created by apple on 16/11/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MyOrderInforViewController.h"
#import "TitleButtomView.h"
#import "BaseRequest.h"
#import "MyOrderInfoModel.h"
#import "UIColor+Extend.h"
#import "OrderView.h"
#import "Macros.h"

#import "ChoosePayWayViewController.h"
#import "MakePayMiMaViewController.h"

//优惠券的下拉功能
#import "MLMOptionSelectView.h"
#import "UIView+Category.h"
#import "CustomCell.h"

#import "SZKAlterView.h"

#import "SubmiteValuateVC.h"

#import "WXApi.h"
#import "RSAEncryptor.h"
#import "SureWeiXinModel.h"

#define WIDTH  [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface MyOrderInforViewController ()<titleButtonDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

//下拉劵
@property (nonatomic, strong) MLMOptionSelectView *cellView;

@property (nonatomic,strong) TitleButtomView *titleButtonView;
@property (nonatomic,strong) NSArray *titleArray;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) BaseRequest *request;

@property (nonatomic,strong) MyOrderInfoModel *myOrderModel;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) OrderView *orderView;


@property (nonatomic,strong) NSMutableArray *modelArr;//全部
@property (nonatomic,strong) NSMutableArray *waitDiagnoseModelArr;//等待就诊
@property (nonatomic,strong) NSMutableArray *waitPayModelArr;//待支付
@property (nonatomic,strong) NSMutableArray *WaitSureModelArr;//待确认
@property (nonatomic,strong) NSMutableArray *waitEvaluateModelArr;//待评价
@property (nonatomic,strong) NSMutableArray *juanArr;//劵价格数组
@property (nonatomic,copy) NSString *selectJuan;//当前选择的劵
@property (nonatomic,copy) NSString *selectJuanID;//当前选择劵的ID
@property (nonatomic,assign) NSInteger selectJuaNum;//当前劵所在数组位置
@property (nonatomic,assign) NSInteger selectCell;//当前所选择的cell

@property (nonatomic,copy) NSString *payMMStr;//支付密码
@property (nonatomic,copy) NSString *nowDnumber;//当前订单号

@property (nonatomic,strong) UIView *payView;

@property (nonatomic,strong) NSMutableArray *tableViewArr;

@property (nonatomic,strong) NSMutableArray *rewardArr;//打赏价格数组
@property (nonatomic,copy) NSString *selectMoney;//选中打赏金额
@property (nonatomic,copy) NSString *publicKey;



@end

@implementation MyOrderInforViewController

- (NSMutableArray *)rewardArr {
    if (!_rewardArr) {
        _rewardArr = [NSMutableArray array];
    }return _rewardArr;
}
- (NSMutableArray *)juanArr {
    if (!_juanArr) {
        _juanArr = [NSMutableArray array];
    }return _juanArr;
}
- (NSMutableArray *)WaitSureModelArr {
    if (!_WaitSureModelArr) {
        _WaitSureModelArr = [NSMutableArray array];
    }return _WaitSureModelArr;
}
- (NSMutableArray *)waitEvaluateModelArr {
    if (!_waitEvaluateModelArr) {
        _waitEvaluateModelArr = [NSMutableArray array];
    }return _waitEvaluateModelArr;
}
- (NSMutableArray *)waitPayModelArr {
    if (!_waitPayModelArr) {
        _waitPayModelArr = [NSMutableArray array];
    }return _waitPayModelArr;
}

- (NSMutableArray *)waitDiagnoseModelArr {
    if (!_waitDiagnoseModelArr) {
        _waitDiagnoseModelArr = [NSMutableArray array];
    }return _waitDiagnoseModelArr;
}
- (NSMutableArray *)tableViewArr {
    if (!_tableViewArr) {
        _tableViewArr = [NSMutableArray array];
    }return _tableViewArr;
}

- (MyOrderInfoModel *)myOrderModel {
    if (!_myOrderModel) {
        _myOrderModel = [[MyOrderInfoModel alloc]init];
    }return _myOrderModel;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
    }return _tableView;
}
- (NSMutableArray *)modelArr {
    if (!_modelArr) {
        _modelArr = [NSMutableArray array];
    }return _modelArr;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"绿色返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleWithBack:)];
        
        self.navigationItem.leftBarButtonItem = leftItem;
        
        
    }return self;
}
- (void)handleWithBack:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestMyOrderList];

}

#pragma mark----刷新tableView
- (void)refreshTableView {
    for (int i = 0; i<5; i++) {
        UITableView *tableView = self.tableViewArr[i];
        [tableView reloadData];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的订单";
    
    NSArray *titleArray = @[@"全部",@"待就诊",@"待支付",@"待确认",@"待评价"];
    self.titleArray = titleArray;
    self.titleButtonView = [[TitleButtomView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 37)];
    self.titleButtonView.delegate = self;
    [self.titleButtonView createTitleBtnWithBtnArray:titleArray];
    [self.view addSubview:self.titleButtonView];
    
    self.request = [[BaseRequest alloc]init];
    [self requestMyOrderList];
    [self createScrollView];
    [self createTableView];
    
    //下拉劵中的cell
    _cellView = [[MLMOptionSelectView alloc] initOptionView];

}

- (void)createScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 37, WIDTH, HEIGHT-37)];
    self.scrollView = scrollView;
    
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.scrollEnabled = YES;
    scrollView.contentOffset = CGPointMake(0, 0);
    scrollView.contentSize = CGSizeMake(WIDTH*self.titleArray.count, 0);
    
    [self.view addSubview:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (![scrollView isKindOfClass:[UITableView class]]) {
        NSInteger index = scrollView.contentOffset.x/WIDTH;
        [self.titleButtonView changeButtonState:index];
    }
}

- (void)titleButtonClickDelegate:(NSInteger)btnTag {
    
    self.scrollView.contentOffset = CGPointMake(btnTag*WIDTH, 0);
    
}

- (void)createTableView {
    
    for (int i = 0; i<5; i++) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(WIDTH*i, 0, WIDTH, HEIGHT-37-64) style:UITableViewStylePlain];
        tableView.tag = 10+i;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [self.tableViewArr addObject:tableView];
        [self.scrollView addSubview:tableView];
        
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (tableView.tag) {
        case 10:
        {
            return self.modelArr.count;
 
        }
            break;
        case 11:
        {
            return self.waitDiagnoseModelArr.count;

        }
            break;
        case 12:
        {
            return self.waitPayModelArr.count;

        }
            break;
        case 13:
        {
            return  self.WaitSureModelArr.count;

        }
            break;
        case 14:
        {
            return  self.waitEvaluateModelArr.count;

        }
            break;
            
        default:
            break;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (tableView.tag) {
        case 10:
        {
            MyOrderInfoModel *model = self.modelArr[indexPath.row];
            self.orderView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, model.baseViewHeight+10);
            return model.baseViewHeight+10;
            
        }
            break;
        case 11:
        {
            
            MyOrderInfoModel *model = self.waitDiagnoseModelArr[indexPath.row];
            self.orderView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, model.baseViewHeight+10);
            return model.baseViewHeight+10;
            
        }
            break;
        case 12:
        {
            MyOrderInfoModel *model = self.waitPayModelArr[indexPath.row];
            self.orderView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, model.baseViewHeight+10);
            return model.baseViewHeight+10;
            
        }
            break;
        case 13:
        {
            MyOrderInfoModel *model = self.WaitSureModelArr[indexPath.row];
            self.orderView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, model.baseViewHeight+10);
            return model.baseViewHeight+10;
        }
            break;
        case 14:
        {
            MyOrderInfoModel *model = self.waitEvaluateModelArr[indexPath.row];
            self.orderView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, model.baseViewHeight+10);
            return model.baseViewHeight+10;
        }
            break;
            
        default:
            break;
    }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.selectionStyle = UITableViewCellAccessoryNone;
    
    NSLog(@"tag===%ld",(long)tableView.tag);
    
    //清空
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    
    OrderView *orderView = [[OrderView alloc]initWithFrame:CGRectMake(0, 10, [UIScreen mainScreen].bounds.size.width, 100)];
    self.orderView = orderView;
    [cell.contentView addSubview:orderView];
    
    if (tableView.tag == 10) {//全部
        [orderView createViewWithModel:self.modelArr[indexPath.row]];
        
        /********对劵进行判断和操作********/
        
        MyOrderInfoModel *model = self.modelArr[indexPath.row];
        NSMutableArray *array = [NSMutableArray array];
        NSMutableArray *juanIDArray = [NSMutableArray array];
        [array addObject:@"请选择"];
        for (int i = 0; i<model.prefer.count; i++) {
            [array addObject: model.prefer[i].name];//存储劵的名字
            [self.juanArr addObject:model.prefer[i].money];//存储劵的价格
            [juanIDArray addObject:model.prefer[i].ID];//存储劵的ID
        }
        
        if (array.count == 1) {
            self.orderView.juanTextLabel.text = @"没有可以使用的券";
        }
        
        [self setLableBtn:self.orderView.juanTextLabel withDataArray:array withRow:indexPath.row WithJuanIDArr:juanIDArray];
        
        if (!(self.selectJuan == nil)) {
            
            if (self.selectCell == indexPath.row) {
                
                self.orderView.juanTextLabel.text = self.selectJuan;
                if (![self.orderView.juanTextLabel.text isEqualToString:@"请选择"]) {
                    // 约定金额-劵金额
                    NSInteger price = [self.orderView.priceTextLabel.text integerValue]- [self.juanArr[self.selectJuaNum] integerValue];
                    if (price>0) {
                        self.orderView.prepaidTextLabel.text = [NSString stringWithFormat:@"%ld",(NSInteger)price];
                    }else {
                        self.orderView.prepaidTextLabel.text = @"0";
                    }
                }else {
                    self.orderView.prepaidTextLabel.text = self.orderView.priceTextLabel.text;
                }
            }
            
        }
        /********对劵进行判断和操作********/
        
    }else if (tableView.tag ==11) {//等待就诊
        [orderView createViewWithModel:self.waitDiagnoseModelArr[indexPath.row]];
    }else if (tableView.tag == 12) {//等待支付
        [orderView createViewWithModel:self.waitPayModelArr[indexPath.row]];
        
        /********对劵进行判断和操作********/
        
            MyOrderInfoModel *model = self.waitPayModelArr[indexPath.row];
            NSMutableArray *array = [NSMutableArray array];
        NSMutableArray *juanIDArray = [NSMutableArray array];
            [array addObject:@"请选择"];
            for (int i = 0; i<model.prefer.count; i++) {
                [array addObject: model.prefer[i].name];//存储劵的名字
                [self.juanArr addObject:model.prefer[i].money];//存储劵的价格
                [juanIDArray addObject:model.prefer[i].ID];//存储劵的ID
            }
        
        if (array.count == 1) {
            self.orderView.juanTextLabel.text = @"没有可以使用的券";
        }
        
            [self setLableBtn:self.orderView.juanTextLabel withDataArray:array withRow:indexPath.row WithJuanIDArr:juanIDArray];
            
            if (!(self.selectJuan == nil)) {
                
                if (self.selectCell == indexPath.row) {
                
                self.orderView.juanTextLabel.text = self.selectJuan;
                if (![self.orderView.juanTextLabel.text isEqualToString:@"请选择"]) {
                    // 约定金额-劵金额
                    NSInteger price = [self.orderView.priceTextLabel.text integerValue]- [self.juanArr[self.selectJuaNum] integerValue];
                    if (price>0) {
                        self.orderView.prepaidTextLabel.text = [NSString stringWithFormat:@"%ld",price];
                    }else {
                        self.orderView.prepaidTextLabel.text = @"0";
                    }
                }else {
                    self.orderView.prepaidTextLabel.text = self.orderView.priceTextLabel.text;
                }
                }
                
            }
        /********对劵进行判断和操作********/
        
    }else if (tableView.tag == 13) {//等待确认
        [orderView createViewWithModel:self.WaitSureModelArr[indexPath.row]];
    }else if (tableView.tag == 14) {//等待评价
        [orderView createViewWithModel:self.waitEvaluateModelArr[indexPath.row]];
    }
    
    self.tableView = tableView;
        
    [self.orderView.cancelBtn addTarget:self action:@selector(getTableWithBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.orderView.sureBtn addTarget:self action:@selector(getTableWithBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    

    
    return cell;
}

- (void)getTableWithBtn:(UIButton *)sender {
    for(UIView* next = [sender superview]; next; next = next.superview)
    {
        UIResponder *nextResponder = [next nextResponder];
        
        if ([nextResponder isKindOfClass:[self.orderView class]])
        {
            //获取当前cell里orderView(以及model)
            self.orderView = (OrderView *)nextResponder;
            MyOrderInfoModel *model = self.orderView.model;
            self.nowDnumber = model.dnumber;
            
            if ([sender.currentTitle isEqualToString:@"确认治疗"] || [sender.currentTitle isEqualToString:@"确认检查"]) {
        
                NSLog(@"%@",self.orderView.prepaidTextLabel.text);
                NSLog(@"11111");
                
                if ([self.orderView.prepaidTextLabel.text isEqualToString:@"0"]) {//支付为0元
                    
                    [self payMoneyIsZreoWithDnumner:model.dnumber andStep:[NSString stringWithFormat:@"%ld",model.step] andPrefer:self.selectJuanID];
                    
                }else {//支付不为0的情况

                ChoosePayWayViewController *payWayVC = [[ChoosePayWayViewController alloc]init];
                
                    if ([sender.currentTitle isEqualToString:@"确认治疗"]) {
                        //治疗待支付
                        payWayVC.infoDic = @{@"dnumber":model.dnumber,@"body":model.ill,@"fee":self.orderView.prepaidTextLabel.text,@"prefer":@"0",@"step":[NSString stringWithFormat:@"%ld",model.step],@"is_check":@"0",@"type":@"app"};
                        payWayVC.status = @"确认治疗";
                    }else {
                        
                        //检查待支付
                        payWayVC.infoDic = @{@"dnumber":model.dnumber,@"body":model.ill,@"fee":self.orderView.prepaidTextLabel.text,@"prefer":@"0",@"step":[NSString stringWithFormat:@"%ld",model.step],@"is_check":@"1",@"type":@"app"};
                        payWayVC.status = @"确认检查";
                        
                    }
                    

                    
                [self.navigationController pushViewController:payWayVC animated:YES];
                NSLog(@"%@",model.dnumber);//订单号
                    
                }
                
            } else if ([sender.currentTitle isEqualToString:@"取消治疗"]) {
                
                [self cancelAndEndTreatWithUrl:@"http://www.enuo120.com/index.php/app/patient/cancel_treat" andDnumber:model.dnumber];
                
            } else if ([sender.currentTitle isEqualToString:@"结束治疗"]) {
                
                    [self cancelAndEndTreatWithUrl:@"http://www.enuo120.com/index.php/app/patient/end_treat" andDnumber:model.dnumber];
                
                
            } else if ([sender.currentTitle isEqualToString:@"取消检查"]) {
                
                [self cancelAndEndTreatWithUrl:@"http://www.enuo120.com/index.php/app/patient/cancel_check" andDnumber:model.dnumber];
                
                
            } else if ([sender.currentTitle isEqualToString:@"确认"]) {
                    if (model.pay_jump == 1) {//有支付密码就不用跳转（如果没有则跳转到设置支付密码界面）
                        [self createPayMMView];
                    }else {
                        MakePayMiMaViewController *payMMVC = [[MakePayMiMaViewController alloc]init];
                        [self.navigationController pushViewController:payMMVC animated:YES];
                    }
                
            } else if ([sender.currentTitle isEqualToString:@"申诉"]) {
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://95105120"]];
                
            } else if ([sender.currentTitle isEqualToString:@"去评价"]) {
                SubmiteValuateVC *subVC = [[SubmiteValuateVC alloc]init];
                subVC.model = model;
                [self.navigationController pushViewController:subVC animated:YES];
                
            } else if ([sender.currentTitle isEqualToString:@"去打赏"]) {
//                [self rewardViewRequest];
            }
            
            
        }
    }

}


//打赏
- (void)rewardViewWithMoneyArr:(NSArray *)moneyArr {
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeigth)];
    bgView.tag = 900;
    bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self.view addSubview:bgView];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/2-100, 50, 200, 270)];
    view.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:view];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, view.bounds.size.width, 50)];
    titleLabel.text = @"请选择打赏金额";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor stringTOColor:@"#00afa1"];
    [view addSubview:titleLabel];
    
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, view.bounds.size.width, 1)];
    lineLabel.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:lineLabel];
    
    for (int i =0; i<3; i++) {
        UIImageView *imageBtn = [[UIImageView alloc]init];
        imageBtn.frame = CGRectMake(view.frame.size.width/2-50, 60+37*i, 17, 17);
        imageBtn.image = [UIImage imageNamed:@"支付_未选中"];
        imageBtn.tag = 500+i;
        [view addSubview:imageBtn];
        
        UIButton *moneyBtn = [[UIButton alloc]initWithFrame:CGRectMake(view.frame.size.width/2-27, 60+37*i, 60, 17)];
        [moneyBtn setTitle:[NSString stringWithFormat:@"¥%@",moneyArr[i]] forState:normal];
        moneyBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [moneyBtn setTitleColor:[UIColor blackColor] forState:normal];
        moneyBtn.tag = 600+i;
        [moneyBtn addTarget:self action:@selector(selectMoneyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:moneyBtn];
        
    }
    
    NSArray *titleArr = @[@"打赏",@"取消"];
    for (int i = 0; i<2; i++) {
    
    UIButton *sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(view.frame.size.width/2-55+60*i, 170, 50, 30)];
    [sureBtn setTitle:[NSString stringWithFormat:@"%@",titleArr[i]] forState:normal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:normal];
    [sureBtn setBackgroundColor:[UIColor stringTOColor:@"#00afa1"]];
    [sureBtn addTarget:self action:@selector(sureRewardBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    sureBtn.layer.cornerRadius = 5;
    sureBtn.clipsToBounds = YES;
    [view addSubview:sureBtn];
        
    }
}
//获得打赏金额
- (void)rewardViewRequest {
    [self.request POST:@"http://www.enuo120.com/index.php/app/Patient/doc_money" params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        
        [self.rewardArr removeAllObjects];
        
        NSMutableArray *moneyArr = [NSMutableArray array];
        NSArray *array = responseObject[@"data"];
        for (NSDictionary *dic in array) {
            NSString *money = dic[@"money"];
            [moneyArr addObject:money];
        }
        
        self.rewardArr = moneyArr;
        [self rewardViewWithMoneyArr:moneyArr];
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

//选择打赏金额
- (void)selectMoneyBtnClick:(UIButton *)sender {
    for (int i = 0; i<3; i++) {
        UIImageView *imageView = [self.view viewWithTag:500+i];
        imageView.image = [UIImage imageNamed:@"支付_未选中"];
        if (imageView.tag == sender.tag-100) {
            imageView.image = [UIImage imageNamed:@"支付_选中"];
        }
    }
    
    self.selectMoney = self.rewardArr[sender.tag-600];
}
//确认打赏
- (void)sureRewardBtnClick:(UIButton *)sender {
    
    UIView *view = [self.view viewWithTag:900];
    [view removeFromSuperview];
    
    if ([sender.currentTitle isEqualToString:@"打赏"]) {
        
        
        if ([WXApi isWXAppInstalled]&&[WXApi isWXAppSupportApi]) {
            
            
            [self sureReward];
            
        }else if(![WXApi isWXAppSupportApi]&&[WXApi isWXAppInstalled]){
            
            UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeigth)];
            bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
            [self.view addSubview:bgView];
            
            SZKAlterView *alterView = [SZKAlterView alterViewWithTitle:@"提示" content:@"微信版本不支持" cancel:@"取消" sure:@"确定" cancelBtClcik:^{
                [bgView removeFromSuperview];
            } sureBtClcik:^{
                [bgView removeFromSuperview];
            }];
            [bgView addSubview:alterView];
            
        }else {
            
            UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeigth)];
            bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
            [self.view addSubview:bgView];
            
            SZKAlterView *alterView = [SZKAlterView alterViewWithTitle:@"提示" content:@"没有装微信" cancel:@"取消" sure:@"确定" cancelBtClcik:^{
                [bgView removeFromSuperview];
            } sureBtClcik:^{
                [bgView removeFromSuperview];
            }];
            [bgView addSubview:alterView];
            
        }
    }

}

- (void)sureReward {
    NSDictionary *dic = @{@"type":@"app",@"pay_total":self.selectMoney,@"dnumber":self.nowDnumber};
    [self.request POST:@"http://www.enuo120.com/index.php/app/Patient/wx_doc_pay" params:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [self handleWXWithData:responseObject];
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

//微信支付数据
- (void)handleWXWithData:(NSDictionary *)data{
    NSArray *arr=  data[@"data"];
    for (NSDictionary *temp in arr) {
        SureWeiXinModel *model = [SureWeiXinModel sureWXWithDic:temp];
//        [self.dataWXArr addObject:model];
        PayReq *request = [[PayReq alloc] init];
        
        /** 商家向财付通申请的商家id */
        request.partnerId = model.partnerid;
        /** 预支付订单 */
        request.prepayId = model.prepayid;
        //  request.prepayId= @"82010380001603250865be9c4c063c30";
        /** 商家根据财付通文档填写的数据和签名 */
        request.package = model.package;
        /** 随机串，防重发 */
        request.nonceStr= model.noncestr;
        /** 时间戳，防重发 */
        request.timeStamp= [model.timestamp intValue] ;
        /** 商家根据微信开放平台文档对数据做的签名 */
        request.sign= model.sign;
        /*! @brief 发送请求到微信，等待微信返回onResp
         *
         * 函数调用后，会切换到微信的界面。第三方应用程序等待微信返回onResp。微信在异步处理完成后一定会调用onResp。支持以下类型
         * SendAuthReq、SendMessageToWXReq、PayReq等。
         * @param req 具体的发送请求，在调用函数后，请自己释放。
         * @return 成功返回YES，失败返回NO。
         */
        [WXApi sendReq: request];
        
    }
    
}


//支付为0元处理事件
- (void)payMoneyIsZreoWithDnumner:(NSString *)dnumber andStep:(NSString *)step andPrefer:(NSString *)prefer {
    
    NSDictionary *dic = @{@"dnumber":dnumber,@"step":step,@"prefer":prefer,@"pay_money":@"0"};
    [self.request POST:@"http://www.enuo120.com/index.php/app/Patient/to_succed" params:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (responseObject[@"data"]) {
            UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeigth)];
            bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
            SZKAlterView *alterView = [SZKAlterView alterViewWithTitle:@"提示" content:@"支付成功" cancel:@"取消" sure:@"确定" cancelBtClcik:^{
                [bgView removeFromSuperview];
                [self requestMyOrderList];
            } sureBtClcik:^{
                [bgView removeFromSuperview];
                [self requestMyOrderList];
            }];
            
            [bgView addSubview:alterView];
            [self.view addSubview:bgView];
        }
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeigth)];
        bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        SZKAlterView *alterView = [SZKAlterView alterViewWithTitle:@"提示" content:@"确认失败" cancel:@"取消" sure:@"确定" cancelBtClcik:^{
            [bgView removeFromSuperview];
        } sureBtClcik:^{
            [bgView removeFromSuperview];
        }];
        
        [bgView addSubview:alterView];
        [self.view addSubview:bgView];
    }];
}

#pragma mark---创建确认支付视图
- (void)createPayMMView {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth , kScreenHeigth)];
    view.tag = 70;
    view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self.view addSubview:view];
    
    //创建支付密码视图
    UIView *payView = [[UIView alloc]init];
    payView.center = CGPointMake(self.view.center.x, self.view.center.y-150);
    self.payView = payView;
    payView.bounds = CGRectMake(0, 0, 200, 200);
    payView.backgroundColor = [UIColor whiteColor];
    [view addSubview:payView];
    
    UILabel *titiLabel = [[UILabel alloc]init];
    titiLabel.text = @"请输入支付密码";
    titiLabel.textColor = [UIColor blackColor];
    titiLabel.textAlignment = NSTextAlignmentCenter;
    titiLabel.font = [UIFont systemFontOfSize:15];
    titiLabel.frame = CGRectMake(20, 40, 160, 20);
    [payView addSubview:titiLabel];

    for (int i = 0; i<2; i++) {
        UILabel *levelLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 90+30*i, 180, 1)];
        levelLabel.backgroundColor = [UIColor lightGrayColor];
        [payView addSubview:levelLabel];
    }
    for (int i = 0; i<7; i++) {
        UILabel *verticalLabel = [[UILabel alloc]initWithFrame:CGRectMake(10+30*i, 90, 1, 30)];
        verticalLabel.backgroundColor = [UIColor lightGrayColor];
        [payView addSubview:verticalLabel];

        if (i<6) {
            
            UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(10+30*i, 90, 30, 30)];
            textLabel.textAlignment = NSTextAlignmentCenter;
            textLabel.font = [UIFont systemFontOfSize:15];
            textLabel.tag = 50+i;
            [payView addSubview:textLabel];
        }
    }
    
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    textField.keyboardType = UIKeyboardTypeNumberPad;
    if (![textField becomeFirstResponder]) {
        [textField becomeFirstResponder];
    }
    [textField addTarget:self action:@selector(textValueChanged:) forControlEvents:UIControlEventEditingChanged];
    [payView addSubview:textField];

    NSArray *titileArr = @[@"确认",@"取消"];
    for (int i = 0; i<2; i++) {
        UIButton *payBtn = [[UIButton alloc]initWithFrame:CGRectMake(20+100*i, 140, 60, 30)];
        payBtn.backgroundColor = [UIColor stringTOColor:@"#00afa1"];
        [payBtn setTitle:titileArr[i] forState:normal];
        payBtn.layer.cornerRadius = 5;
        payBtn.clipsToBounds = YES;
        payBtn.tag = 80+i;
        [payBtn addTarget:self action:@selector(payBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [payView addSubview:payBtn];
    }
}

- (void)textValueChanged:(UITextField *)textField {
    
    if (textField.text.length >0 && textField.text.length<7) {
        //获取textfield中的最后一个字 然后赋值给label
//        NSString *str = [textField.text substringFromIndex:textField.text.length-1];
        
        UILabel *textLabel = [self.view viewWithTag:textField.text.length+50-1];
        
        //textLabel.text = str;//显示密码
        textLabel.text = @"*";//不显示密码
        
        //取消键盘
        if (textField.text.length == 6) {
            self.payMMStr = textField.text;
            [textField resignFirstResponder];
        }
        
    }
    
    //删除密码
    UILabel *otherTextLabel = [self.view viewWithTag:textField.text.length+50];
    otherTextLabel.text = nil;


}

- (void)payBtnClick:(UIButton *)sender {
    if (sender.tag == 80) {//确定按钮
        if (self.payMMStr.length == 6) {
            
            NSString *name = [[NSUserDefaults standardUserDefaults]objectForKey:@"name"];
            
            [self paySureUrl:@"http://www.enuo120.com/index.php/app/Patient/confirm_pay" andDnumber:self.nowDnumber andUsername:name andPassword:self.payMMStr];
            
            [self.payView removeFromSuperview];
            
        }
    }else {//取消按钮
        UIView *view = [self.view viewWithTag:70];
        [view removeFromSuperview];
        
    }
    
}
//全部订单
- (void)requestMyOrderList {
    NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
    
    NSLog(@"%@----",name);
    
    NSString *url = @"http://www.enuo120.com/index.php/app/patient/order";
    NSDictionary *dic = @{@"username":name,@"statue":@"0"};
    [self.request POST:url params:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (![responseObject[@"data"] isEqual:[NSNull null]]) {
            [self dataOfResponseObject:responseObject];
        }else {
            NSLog(@"没有订单");
        }
        
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

//  取消治疗||结束治疗
- (void)cancelAndEndTreatWithUrl:(NSString *)url andDnumber:(NSString *)dnumber {
    NSDictionary *dic = @{@"dnumber":dnumber};
    [self.request POST:url params:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        [self requestMyOrderList];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];

}
//确认支付
- (void)paySureUrl:(NSString *)url andDnumber:(NSString *)dnumber andUsername:(NSString *)username andPassword:(NSString *)password {
    
    NSLog(@"%@~~~",dnumber);
    NSDictionary *dic = @{@"dnumber":dnumber,@"username":username,@"paypassword":password};
    [self.request POST:url params:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"%@",responseObject);
        
        NSDictionary *dataDic = responseObject[@"data"];
        NSString *result = dataDic[@"message"];
        NSString *status = dataDic[@"errcode"];
        
        if ([status floatValue] == 0) {//确认成功
            SZKAlterView *alterView = [SZKAlterView alterViewWithTitle:@"提示" content:result cancel:@"取消" sure:@"确定" cancelBtClcik:^{
                
                UIView *view = [self.view viewWithTag:70];
                [view removeFromSuperview];
                [alterView removeFromSuperview];
                [self refreshTableView];

                
            } sureBtClcik:^{
                
                SubmiteValuateVC *submitVC = [[SubmiteValuateVC alloc]init];
                submitVC.model = self.orderView.model;
                [self.navigationController pushViewController:submitVC animated:YES];
                
                UIView *view = [self.view viewWithTag:70];
                [view removeFromSuperview];
                [alterView removeFromSuperview];
                
            }];
            
            [self.view addSubview:alterView];

            
        }else {
            SZKAlterView *alterView = [SZKAlterView alterViewWithTitle:@"提示" content:result cancel:@"取消" sure:@"确定" cancelBtClcik:^{
                UIView *view = [self.view viewWithTag:70];
                [view removeFromSuperview];
                [alterView removeFromSuperview];
                                
            } sureBtClcik:^{
                UIView *view = [self.view viewWithTag:70];
                [view removeFromSuperview];
                [alterView removeFromSuperview];
            }];
            
            [self.view addSubview:alterView];
        }
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

- (void)dataOfResponseObject:(id)data {
    NSArray *dataArr = data[@"data"];
    
    [self.modelArr removeAllObjects];
    [self.waitDiagnoseModelArr removeAllObjects];
    [self.waitPayModelArr removeAllObjects];
    [self.WaitSureModelArr removeAllObjects];
    [self.waitEvaluateModelArr removeAllObjects];

    
    for (int i = 0; i<dataArr.count; i++) {
        MyOrderInfoModel *model = [MyOrderInfoModel myOrderModelInitWithDic:dataArr[i]];
        
        
        [self.modelArr addObject:model];                       //全部
        
        if (model.type_id == 1 || model.type_id == 1.2) {      //等待就诊
            [self.waitDiagnoseModelArr addObject:model];
        }else if (model.type_id == 3 || model.type_id == 1.1) {//待支付
            [self.waitPayModelArr addObject:model];
        }else if (model.type_id == 4 || model.type_id == 1.3) {//待确认
            [self.WaitSureModelArr addObject:model];
        }else if (model.type_id == 5 || model.type_id == 5.1) {//待评价
            [self.waitEvaluateModelArr addObject:model];
        }
        
        
        for (int i = 0; i<5; i++) {
            UITableView *tableView = self.tableViewArr[i];
            [tableView reloadData];
        }
        
        
    }

}


//优惠券的下拉功能
- (void)setLableBtn:(UILabel *)label withDataArray:(NSArray *)dataArray withRow:(NSInteger)indexPathRow WithJuanIDArr:(NSArray *)IDArr {
    
    self.selectCell = indexPathRow;
    
    WEAK(weakTopB, label);
    WEAK(weaklistArray, dataArray);
    [label tapHandle:^{
        CGRect label3Rect = [MLMOptionSelectView targetView:label];
        
        [self defaultCellWithDataArray:dataArray];
        _cellView.arrow_offset = .5;
        _cellView.vhShow = YES;
        _cellView.optionType = MLMOptionSelectViewTypeCustom;
        _cellView.selectedOption = ^(NSIndexPath *indexPath) {//cell 的点击方法
            
            weakTopB.text = weaklistArray[indexPath.row];
            self.selectJuan = weakTopB.text;
            self.selectJuanID = nil;
            
            NSLog(@"%ld",indexPath.row);
            NSLog(@"%@",weakTopB.text);
            //0 我放置了请选择
            if (indexPath.row >0) {
                self.selectJuaNum = indexPath.row-1;
                self.selectJuanID = IDArr[indexPath.row-1];
            }
            UITableView *tableView = [self.view viewWithTag:12];
            [tableView reloadData];
            
        };
        
        [_cellView showViewFromPoint:CGPointMake(label3Rect.origin.x, label3Rect.origin.y+label3Rect.size.height) viewWidth:label.bounds.size.width targetView:label direction:MLMOptionSelectViewBottom];
    }];
    
}
#pragma mark - 设置——cell
- (void)defaultCellWithDataArray:(NSArray *)dataArray {
    WEAK(weaklistArray, dataArray);
    WEAK(weakSelf, self);
    _cellView.canEdit = NO;
    [_cellView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"DefaultCell"];
    _cellView.cell = ^(NSIndexPath *indexPath){
        UITableViewCell *cell = [weakSelf.cellView dequeueReusableCellWithIdentifier:@"DefaultCell"];
        
        if (![weaklistArray[indexPath.row] isEqual:[NSNull null]]) {
            cell.textLabel.text = [NSString stringWithFormat:@"%@",weaklistArray[indexPath.row]];
        }
        
        return cell;
    };
    _cellView.optionCellHeight = ^{
        return 40.f;
    };
    _cellView.rowNumber = ^(){
        NSLog(@"行数：%ld",weaklistArray.count);
        return (NSInteger)weaklistArray.count;
    };
    
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
