//
//  DSViewController.m
//  enuoS
//
//  Created by apple on 16/8/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "DSViewController.h"
#import "Macros.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "DSTableViewCell.h"
#import "DSModel.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import "UIImageView+UIImageView_FaceAwareFill.h"
#import "PayViewController.h"
#import "SureTwoModel.h"
#import "SureWeiXinModel.h"
#import "WXApi.h"
#import "DSMoneyModel.h"
#define IOS8 [[[UIDevice currentDevice]systemVersion] floatValue] >= 8.0


@interface DSViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)NSMutableArray *dataWXArr;
@property (nonatomic,copy)NSString *dnumbbb;

@property (nonatomic,strong)NSMutableArray *moneyArr;

@end

@implementation DSViewController


- (NSMutableArray *)moneyArr{
    if (!_moneyArr) {
        self.moneyArr = [NSMutableArray array];
    }return _moneyArr;
}

- (NSMutableArray *)dataWXArr{
    if (!_dataWXArr) {
        self.dataWXArr = [NSMutableArray array];
    }return _dataWXArr;
}
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
        
    }return _dataArray;
}

- (UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc]init];
    }return _tableView;
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"绿色返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleBackBarItem)];
        
        self.navigationItem.leftBarButtonItem =leftItem;
        

    }return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD show];
    [self creatTableView];
    [self requestData];
    [self requestDataMoney];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航条底图"] forBarMetrics:0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)handleBackBarItem{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)creatTableView{
    self.tableView.dataSource= self;
    self.tableView.delegate = self;
    self.tableView .backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    [self.tableView registerNib:[UINib nibWithNibName:@"DSTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
}

//金钱取得
- (void)requestDataMoney{
    NSString *url = @"http://www.enuo120.com/index.php/app/patient/doc_money";
    AFHTTPSessionManager *mager = [AFHTTPSessionManager manager];
    [mager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleWithMoneyWith:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)handleWithMoneyWith:(NSDictionary *)dic{
    NSArray *arr = dic[@"data"];
    for (NSDictionary *temp in arr) {
        DSMoneyModel *mondel = [DSMoneyModel dsModelInitWithDic: temp];
        
        [self.moneyArr addObject:mondel];
        
    }
    
}

- (void)requestData{
    NSString *url = @"http://www.enuo120.com/index.php/app/patient/doc_history";
    
    NSUserDefaults *statStand = [NSUserDefaults standardUserDefaults];
    NSString *name = [statStand objectForKey:@"name"];
    NSDictionary *heardBody = @{@"username":name};
    AFHTTPSessionManager *mager = [AFHTTPSessionManager manager];
    [mager POST:url parameters:heardBody progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleWithDic:responseObject];
        NSLog(@"responseObject = %@",responseObject);
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

- (void)handleWithDic:(NSDictionary *)dic{
    
    if ([dic[@"data"]isKindOfClass:[NSNull class]]) {
        [self creatnullView];
    }else{

        NSArray *arr = dic[@"data"];
        
        for (NSDictionary *temp in arr) {
            DSModel *model  = [DSModel dsModelInitWithDic:temp];
            [self.dataArray addObject:model];
        }[self.tableView reloadData];
      
        if (self.dataArray.count ==0) {
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    DSModel *model = self.dataArray[indexPath.row];
    NSString *url = [NSString stringWithFormat:urlPicture,model.photo];
    [cell.doc_Image sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];

    [cell.doc_Image faceAwareFill];
    cell.name_label.text = model.name;
    cell.hos_label.text = model.hos_name;
    cell.deskLabel.text = model.dep_name;
    cell.proLael.text = model.professional;
    cell.doc_Image.layer.borderWidth = 0.5;
    cell.doc_Image.layer.cornerRadius = 35.0;
    cell.doc_Image.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cell.doc_Image.clipsToBounds = YES;
    if (model.statue == 0) {
        [cell.sureBtn setImage:[UIImage imageNamed:@"灰色赏"] forState:UIControlStateNormal];
    }else{
         [cell.sureBtn setImage:[UIImage imageNamed:@"黄色赏"] forState:UIControlStateNormal];
    }
    [cell.sureBtn addTarget:self action:@selector(handelwithGZBtn: event:) forControlEvents:UIControlEventTouchUpInside];
    cell.nuoNumber.text = model.nuo;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
     [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    cell.contentView.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:247/255.0 alpha:1];
    cell.bgView.layer.cornerRadius = 4.0;
    cell.bgView.layer.borderColor = [UIColor clearColor].CGColor;
    cell.bgView.layer.borderWidth = 1.0;
    
    cell.bgView.layer.shadowColor = [UIColor lightGrayColor].CGColor;//shadowColor阴影颜色
    cell.bgView.layer.shadowOffset = CGSizeMake(0,2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    cell.bgView.layer.shadowOpacity = 0.5;//阴影透明度，默认0
    cell.bgView.layer.shadowRadius = 4;
     tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return cell;
}
- (void)handelwithGZBtn:(id *)sender event:(id)event{
    
    NSSet *touches =[event allTouches];
    UITouch *touch =[touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    NSIndexPath *indexPath= [self.tableView indexPathForRowAtPoint:currentTouchPosition];
    if (indexPath!= nil){
        DSModel *model = self.dataArray[indexPath.row];
        self.dnumbbb= model.dnumber;
        if (self.moneyArr.count != 0) {
            if(IOS8){
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
                
                // Create the actions.
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                    NSLog(@"0");
                }];
                for (int i = 0; i<self.moneyArr.count; i ++) {
                    DSMoneyModel *model = self.moneyArr[i];
                    UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:model.money style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                        NSLog(@"1");
                        
                        if ([WXApi isWXAppInstalled]&&[WXApi isWXAppSupportApi]) {
                            [self requsetTwoData:model.money];
                            
                            
                            if (self.dataWXArr.count !=0) {
                            }else{
                                NSLog(@"没有事，没有值");
                            }
                            
                        }else if(![WXApi isWXAppSupportApi]&&[WXApi isWXAppInstalled]){
                            NSLog(@"微信版本不支持");
                        }else {
                            NSLog(@"没有装微信");
                        }
                        
                        
                        
                    }];
                    [alertController addAction:destructiveAction];
                    
                }
                // Add the actions.
                [alertController addAction:cancelAction];
                
                
                
                [self presentViewController:alertController animated:YES completion:nil];
                
            }else{
                
                UIActionSheet *actionSheet = [[UIActionSheet alloc]init];
                [actionSheet addButtonWithTitle:@"取消"];
            
                for (int i = 0; i<self.moneyArr.count; i ++) {
                    DSMoneyModel *model = self.moneyArr[i];
                    [actionSheet addButtonWithTitle:model.money];
                }
                
                actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
                [actionSheet showInView:self.view];
            }

        }else{
            NSLog(@"数据丢失");
        }
      
    }
    
    
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([actionSheet.title isEqualToString:@"取消"]) {
        NSLog(@"五爷五爷五爷！！！！");
    }else{
        if ([WXApi isWXAppInstalled]&&[WXApi isWXAppSupportApi]) {
            [self requsetTwoData:actionSheet.title];
            
            
            if (self.dataWXArr.count !=0) {
            }else{
                NSLog(@"没有事，没有值");
            }
            
        }else if(![WXApi isWXAppSupportApi]&&[WXApi isWXAppInstalled]){
            NSLog(@"微信版本不支持");
        }else {
            NSLog(@"没有装微信");
        }
        

    }
   
}

- (void)requsetTwoData:(NSString *)sender{
   
    NSString *str = @"http://www.enuo120.com/index.php/app/patient/wx_doc_pay";
        AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    
    
    NSDictionary *heardBody = @{@"dnumber":self.dnumbbb,@"type":@"apk",@"pay_total":sender};
    NSLog(@"heardBody = %@",heardBody);
    [ manger POST:str parameters:heardBody progress:^(NSProgress * _Nonnull uploadProgress) {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         [self handleWXWithData:responseObject];
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         
     }];
    }
- (void)handleWXWithData:(NSDictionary *)data{
        NSArray *arr=  data[@"data"];
        for (NSDictionary *temp in arr) {
            SureWeiXinModel *model = [SureWeiXinModel sureWXWithDic:temp];
            [self.dataWXArr addObject:model];
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
    




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
}



@end
