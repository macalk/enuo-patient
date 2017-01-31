//
//  MyPJOneController.m
//  enuoS
//
//  Created by apple on 16/8/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MyPJOneController.h"
#import "Macros.h"
#import <UIImageView+WebCache.h>
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "PJDocTableViewCell.h"
#import "PjDocModel.h"
#import <Masonry.h>
#import "UIColor+Extend.h"
#import "BaseRequest.h"
#import "SubzhuiViewController.h"
#import "AddCommentVC.h"

#import "WXApi.h"
#import "SureWeiXinModel.h"
#import "SZKAlterView.h"

#define IOS8 [[[UIDevice currentDevice]systemVersion] floatValue] >= 8.0


@interface MyPJOneController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)BaseRequest *request;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,copy)NSString *pjcid;

@property (nonatomic,copy)NSString *nowDnumber;

@property (nonatomic,copy)NSString *selectMoney;//选中打赏金额
@property (nonatomic,strong) NSMutableArray *rewardArr;//打赏金额数组


@end


@implementation MyPJOneController

- (NSMutableArray *)rewardArr {
    if (!_rewardArr) {
        _rewardArr = [NSMutableArray array];
    }return _rewardArr;
}
- (BaseRequest *)request {
    if (!_request) {
        _request = [[BaseRequest alloc]init];
    }return _request;
}

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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD show];
    [self creatTableView];
    [self requestData];
}

- (void)creatTableView{
    self.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeigth-64);
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PJDocTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PjDocModel *model = self.dataArray[indexPath.row];
    
    CGRect rect = [model.content boundingRectWithSize:CGSizeMake(kScreenWidth-40, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
    
    return 137+rect.size.height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    PJDocTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    PjDocModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    NSString *url = [NSString stringWithFormat:urlPicture,model.photo];
    [cell.docImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
    cell.docNameLabel.text = model.doc_name;
    cell.deskLabel.text = model.dep_name;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell.payBtn setTitle:[NSString stringWithFormat:@" %@",model.type_name] forState:normal];
    cell.addBtn.layer.cornerRadius = 5;
    cell.addBtn.clipsToBounds = YES;
    
    if ([model.type_name isEqualToString:@"可打赏"]) {
        [cell.payBtn setTitleColor:[UIColor orangeColor] forState:normal];
        [cell.payBtn setImage:[UIImage imageNamed:@"未打赏"] forState:normal];
        
        [cell.payBtn addTarget:self action:@selector(payBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }else {
        [cell.payBtn setTitleColor:[UIColor lightGrayColor] forState:normal];
        [cell.payBtn setImage:[UIImage imageNamed:@"已打赏"] forState:normal];
    }
    
    if ([model.zhui isEqualToString:@""] || [model.zhui isEqual:[NSNull null]]) {
        [cell.addBtn setTitle:@"追加" forState:normal];
        [cell.addBtn setTitleColor:[UIColor whiteColor] forState:normal];
        [cell.addBtn setBackgroundColor:[UIColor stringTOColor:@"#00afa1"]];
        [cell.addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }else {
        [cell.addBtn setTitleColor:[UIColor lightGrayColor] forState:normal];
        cell.addBtn.backgroundColor = [UIColor clearColor];
        [cell.addBtn setTitle:@"已追加" forState:normal];
    }
    cell.dnumber = model.dnumber;
    cell.userNameLabel.text = model.username;
    [cell.userImageView sd_setImageWithURL:nil placeholderImage:nil];
    cell.commentLabel.text = model.content;
    
    /*****星星为设置*****/
    if (![model.service isEqualToString:@""]) {
        for (int i = 0; i<[model.service integerValue]; i++) {
            UIImageView *imageView = cell.arrOne[i];
            imageView.image = [UIImage imageNamed:@"黄星星"];
        }
    }
    
    if (![model.level isEqualToString:@""]) {
        for (int i = 0; i<[model.level integerValue]; i++) {
            UIImageView *imageView = cell.arrTwo[i];
            imageView.image = [UIImage imageNamed:@"黄星星"];
        }
    }
    
    [cell.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell.contentView).with.offset(50);
        make.bottom.equalTo(cell.contentView).with.offset(-10);
    }];
        
    return cell;
}

//打赏按钮
- (void)payBtnClick:(UIButton *)sender {
    for (UIView *next = [sender superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[PJDocTableViewCell class]]) {
            PJDocTableViewCell *cell = (PJDocTableViewCell *)nextResponder;
            self.nowDnumber = cell.dnumber;
            
            [self rewardViewRequest];
        }
    }
}
//追加功能
- (void)addBtnClick:(UIButton *)sender {
    for (UIView *next = [sender superview]; next; next = [next superview]) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[PJDocTableViewCell class]]) {
            PJDocTableViewCell *cell = (PJDocTableViewCell *)nextResponder;
            
            AddCommentVC *addVC = [[AddCommentVC alloc]init];
            addVC.type = @"doctor";
            addVC.model = cell.model;
            [self.navigationController pushViewController:addVC animated:YES];
        }
    }
    
}

                           /*******打赏功能********/

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


//打赏视图
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

                    /*******以上为打赏*********/


- (void)handelwithZPBtn: (id)sender event:(id)event{
    NSSet *touches =[event allTouches];
    UITouch *touch =[touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    NSIndexPath *indexPath= [self.tableView indexPathForRowAtPoint:currentTouchPosition];
    if (indexPath != nil) {
        
        PjDocModel *model = self.dataArray[indexPath.row];
        self.pjcid = model.cid;
        
        if([model.zhui isEqualToString:@""]){
        if(IOS8){
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            
            // Create the actions.
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                
            }];
            
            UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:@"发布追评" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                SubzhuiViewController *subVC = [[SubzhuiViewController alloc]init];
                
                
                UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:subVC];
                subVC.receiver = @"0";
                subVC.cidReceiver = model.cid;
                [self presentViewController:naNC animated:YES completion:^{
                    
                }];
            }];
            
            // Add the actions.
            [alertController addAction:cancelAction];
            [alertController addAction:destructiveAction];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
        }else{
            UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@""delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"发布追评" otherButtonTitles:nil, nil];
            
            actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
            [actionSheet showInView:self.view];
        }
        
        }else{
            if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"该评论已追评" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
                [alert show];
            }else{
                UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"该评论已追评" preferredStyle:UIAlertControllerStyleAlert];
                [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];
                [self presentViewController:alertView animated:YES completion:^{
                    
                }];
            }

        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"lalal");
    
    
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    SubzhuiViewController *subVC = [[SubzhuiViewController alloc]init];
    
    
    UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:subVC];
    
    if (buttonIndex == 0) {
        subVC.receiver = @"0";
        subVC.cidReceiver  = self.pjcid;
        [self presentViewController:naNC animated:YES completion:^{
            
        }];
    }else {
        NSLog(@"取消");
    }
    
}


- (void)requestData{
    NSString *url = @"http://www.enuo120.com/index.php/app/Patient/comment";
    NSUserDefaults *userStand = [NSUserDefaults standardUserDefaults];
    
    NSString *name  = [userStand objectForKey:@"name"];
    
    NSDictionary *hearbody = @{@"username":name,@"ver":@"1.0"};
    
    
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    
    [manger POST:url parameters:hearbody progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleWithData:responseObject];
        NSLog(@"reeee  =%@",responseObject);
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

- (void)handleWithData:(NSDictionary *)dic{
    
    
    if ([dic[@"data"] isKindOfClass:[NSNull class]]) {
        [self creatnullView];
    }else{
        
        if (!(dic[@"data"][@"doc_list"] == nil)) {
            
            NSArray *arr = dic[@"data"][@"doc_list"];
            
            [self.dataArray removeAllObjects];
            
            if (![arr isEqual:[NSNull null]]) {
                
                for (NSDictionary *temp in arr) {
                    PjDocModel *model  = [PjDocModel pjDocModelWithDic:temp];
                    [self.dataArray addObject:model];
                }
                [self.tableView reloadData];
                if (self.dataArray.count ==0) {
                    [self creatnullView];
                }else{
                    [self.view addSubview:self.tableView];
                }
            }else {
                NSLog(@"数组 为空");
            }
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
