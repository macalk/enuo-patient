//
//  HosViewController.m
//  enuoS
//
//  Created by apple on 16/7/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "HosViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "Macros.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import "DeskModel.h"
#import "HosModel.h"
#import "HosDocViewController.h"
#import "HosDocEvaViewController.h"
@interface HosViewController ()<UITableViewDataSource,UITableViewDelegate>



@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)UITableView *tabelView;
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *deskArray;
//header部控件

@property (nonatomic,strong)UILabel *nameLabel;

@property (nonatomic,strong)UILabel *leveLabel;
@property (nonatomic,strong)UILabel *phoneLabel;
@property (nonatomic,strong)UILabel *ybLabel;
@property (nonatomic,strong)UILabel *netLabel;
@property (nonatomic,strong)UILabel *addressLabel;
@property (nonatomic,strong)UILabel *xukeLabel;

@property (nonatomic,strong)UIImageView *hosImage;




//收起设置

@property (nonatomic,copy)NSString *oneStr;
@property (nonatomic,copy)NSString *twoStr;
@property (nonatomic,copy)NSString *threeStr;
@property (nonatomic,copy)NSString *fourStr;
@property (nonatomic,copy)NSString *fiveStr;

@property (nonatomic,assign)BOOL oneS;
@property (nonatomic,assign)BOOL fourS;
@property (nonatomic,assign)BOOL twoS;
@property (nonatomic,assign)BOOL threeS;
@property (nonatomic,assign)BOOL fiveS;

@property (nonatomic,assign)NSInteger numS;
@property (nonatomic,assign)NSInteger numA;
@property (nonatomic,strong)UIView *deskView;
@property (nonatomic,assign)BOOL gunanzhu;

@end

UIButton *phoneBtn;
UIButton *netBtn;

UIButton *markBtn;
@implementation HosViewController

- (NSMutableArray *)deskArray{
    if (!_deskArray) {
        self.deskArray = [NSMutableArray array];
    }return _deskArray;
}
- (UIView *)deskView{
    if (!_deskView) {
        self.deskView = [[UIView alloc]init];
    }return _deskView;
}



- (UITableView *)tabelView{
    if (!_tabelView) {
        self.tabelView = [[UITableView alloc]init];
    }return _tabelView;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        self.collectionView = [[UICollectionView alloc]init];
    }return _collectionView;
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
    [self creatTableView];
    [SVProgressHUD show];
   self.navigationController.toolbarHidden=NO;
    self.fiveStr = @"1";
    self.oneS = YES;
    self.fiveS  = YES;
    self.twoS = YES;
    self.threeS = YES;
    self.fourS = YES;
    self.oneStr =@"1";
    self.twoStr = @"1";
    self.threeStr = @"1";
    self.fourStr = @"1";
    self.tabelView.backgroundColor = [UIColor whiteColor];
    
    self.view = self.tabelView;
    self.tabelView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 365)];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航条底图"] forBarMetrics:0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    NSLog(@"self.receiver = %@",self.receiver);
    [self requestData];
    //[self requestkeShiData];
    [self creatHeaderView];
    [self creatToolView];
    
}
- (void)handleWithBack:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)creatToolView{
    
    UIView *toolView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    
    UIButton *boyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *girlButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *changeButton =[UIButton buttonWithType:UIButtonTypeCustom];
    
    boyButton.frame = CGRectMake(0, 0, kScreenWidth/3, 44);
    girlButton.frame = CGRectMake(kScreenWidth/3, 0, kScreenWidth/3, 44);
    changeButton.frame = CGRectMake(kScreenWidth*2/3, 0, kScreenWidth/3, 44);
    [toolView addSubview:boyButton];
  
    [boyButton setTitle:@"评论" forState:UIControlStateNormal];
    [boyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    boyButton.titleLabel.font = [UIFont systemFontOfSize:16];
    
   
 
    toolView.backgroundColor =  [UIColor colorWithRed:0/255.0 green:179/255.0 blue:163/255.0 alpha:1];
    [self.navigationController.toolbar addSubview:toolView];
    [boyButton addTarget:self action:@selector(handleWithboyBtn:) forControlEvents:UIControlEventTouchUpInside];


    
}


- (void)handleWithboyBtn:(UIButton *)sender{
    HosModel *model = self.dataArray[0];
    HosDocEvaViewController *hVC = [[HosDocEvaViewController alloc]init];
    UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:hVC];
    hVC.markStr = @"1";
    hVC.receiver = model.cid;
    [self presentViewController:naNC animated:YES completion:^{
        
    }];
    
    
    
}


- (void)creatHeaderView{
    UIView *aView = [[UIView alloc]initWithFrame:CGRectMake(5, 5, kScreenWidth-10, 360)];


    self.hosImage = [[UIImageView alloc]init];
    //hosLabel = [[UILabel alloc]init];
    
    
    
    
    
    self.nameLabel = [[UILabel alloc]init];
    self.leveLabel  = [[UILabel alloc]init];
    self.phoneLabel = [[UILabel alloc]init];
    self.ybLabel = [[UILabel alloc]init];
    self.netLabel = [[UILabel alloc]init];
    self.addressLabel = [[UILabel alloc]init];
    self.xukeLabel = [[UILabel alloc]init];
   
    markBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    netBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    phoneBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    
    netBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    
    
    
    [markBtn addTarget:self action:@selector(handleThreeTapButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [phoneBtn addTarget:self action:@selector(handleOneTapButton:) forControlEvents:UIControlEventTouchUpInside];
    [netBtn addTarget:self action:@selector(handleTwoTapButton:) forControlEvents:UIControlEventTouchUpInside];
    [netBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [phoneBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    self.nameLabel.textColor =  [UIColor colorWithRed:0/255.0 green:179/255.0 blue:163/255.0 alpha:1];
    self.leveLabel.font = [UIFont systemFontOfSize:14];
    self.phoneLabel.font = [UIFont systemFontOfSize:13];
    self.ybLabel.font = [UIFont systemFontOfSize:13];
    self.netLabel.font = [UIFont systemFontOfSize:13];
    self.addressLabel.font = [UIFont systemFontOfSize:13];
    self.xukeLabel.font = [UIFont systemFontOfSize:13];
    
    
    
    UIImageView *markImage = [[UIImageView alloc]init];
    self.hosImage.userInteractionEnabled = YES;
    
    UILabel *phoneLB = [[UILabel alloc]init];
    phoneLB.font = [UIFont systemFontOfSize:13];
    phoneLB.text =@"电话:";
    UILabel *ybLB = [[UILabel alloc]init];
    ybLB.font = [UIFont systemFontOfSize:13];
    ybLB.text  = @"医保:";
    UILabel *netLB = [[UILabel alloc]init];
    netLB.font = [UIFont systemFontOfSize:13];
    netLB.text = @"官网:";
    UILabel *addressLB = [[UILabel alloc]init];
    self.addressLabel.numberOfLines = 0;
    addressLB.font = [UIFont systemFontOfSize:13];
    addressLB.text = @"地址:";
    UILabel *xukeLB = [[UILabel alloc]init];
    xukeLB.text = @"医疗许可证:";
    xukeLB.font = [UIFont systemFontOfSize:13];
    
    
//    UITapGestureRecognizer *tapOneGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleOneTapGesture:)];
//    
//    
//    UITapGestureRecognizer *tapTwoGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTwoTapGesture:)];
//    
//    
//    tapOneGesture.numberOfTapsRequired = 1;//单击
//    //  2）设置触摸手指的个数
//    tapOneGesture.numberOfTouchesRequired = 1;//触摸手指的个数
//    tapTwoGesture.numberOfTapsRequired = 1;//单击
//    //  2）设置触摸手指的个数
//    tapTwoGesture.numberOfTouchesRequired = 1;//触摸手指的个数
//    
//    
//    [self.phoneLabel addGestureRecognizer:tapOneGesture];
//    [self.netLabel addGestureRecognizer:tapTwoGesture];
//    self.phoneLabel.textColor = [UIColor blueColor];
//    self.netLabel.textColor = [UIColor blueColor];
//    
    [self.tabelView.tableHeaderView addSubview:aView];
    //self.tabelView.tableHeaderView = aView;
    [aView addSubview:self.hosImage];
    [aView addSubview:self.nameLabel];
    [aView addSubview:self.leveLabel];
    //[aView addSubview:self.phoneLabel];
    [aView addSubview:self.ybLabel];
    //[aView addSubview:self.netLabel];
    [aView addSubview:self.addressLabel];
    [aView addSubview:self.xukeLabel];
    [aView addSubview:phoneLB];
    [aView addSubview:ybLB];
    [aView addSubview:netLB];
    [aView addSubview:addressLB];
    [aView addSubview:xukeLB];
    
    [aView addSubview:markBtn];
    [aView addSubview:phoneBtn];
    [aView addSubview:netBtn];
   // [self.hosImage addSubview:markImage];
    //self.hosImage.backgroundColor = [UIColor redColor];
    //markImage.backgroundColor = [UIColor greenColor];
    __weak typeof(self)  weakSelf = self;
    
   
    [weakSelf.hosImage mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(aView.mas_left);
        make.right.equalTo (aView.mas_right);
        make.top.equalTo(aView.mas_top);
        
        make.height.mas_equalTo(kScreenWidth*70/113);
    }];
    
    [weakSelf.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(aView.mas_left);
        make.top.equalTo(weakSelf.hosImage.mas_bottom).with.offset(5);
        make.height.mas_equalTo(@20);
        
        
    }];
    [weakSelf.leveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.nameLabel.mas_right).with.offset(10);
        make.top.equalTo(weakSelf.hosImage.mas_bottom).with.offset(5);
        make.height.mas_equalTo(@20);
    }];
    [phoneLB mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(aView.mas_left);
        make.top.equalTo(weakSelf.nameLabel.mas_bottom).with.offset(5);
        make.height.mas_equalTo(@15);
        make.width.mas_equalTo(@30);
    }];
    [ybLB mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(aView.mas_left);
        make.top.equalTo(phoneLB.mas_bottom).with.offset(5);
        make.height.mas_equalTo(@15);
        make.width.mas_equalTo(@30);
        
        
        
        
    }];
    
    [netLB mas_makeConstraints:^(MASConstraintMaker *make) {
       
        
        make.left.equalTo(aView.mas_left);
        make.top.equalTo(ybLB.mas_bottom).with.offset(5);
        make.height.mas_equalTo(@15);
        make.width.mas_equalTo(@30);
        
        
        
    }];
    

    [addressLB mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(aView.mas_left);
        make.top.equalTo(netLB.mas_bottom).with.offset(5);
        make.height.mas_equalTo(@15);
        make.width.mas_equalTo(@30);
        
    }];
    
     [xukeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        
         make.left.equalTo(aView.mas_left);
         //make.top.equalTo(addressLB.mas_bottom).with.offset(5);
         make.height.mas_equalTo(@15);
         make.width.mas_equalTo(@75);
         
     }];
    [phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(phoneLB.mas_right).with.offset(10);
        make.centerY.equalTo(phoneLB);
        make.height.mas_equalTo(@15);
        
        
    }];
    
    [weakSelf.ybLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(ybLB.mas_right).with.offset(10);
        make.centerY.equalTo(ybLB);
        make.height.mas_equalTo(@15);
        
        
    }];
    [netBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(netLB.mas_right).with.offset(10);
        make.centerY.equalTo(netLB);
        make.height.mas_equalTo(@15);
    }];
    
    [weakSelf.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addressLB.mas_right).with.offset(10);
       // make.centerY.equalTo(addressLB);
        //make.height.mas_equalTo(@15);
        make.right.equalTo(aView.mas_right).with.offset(5);
        make.top.equalTo(netBtn.mas_bottom).with.offset(5);
    
    }];
    
    [weakSelf.xukeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(xukeLB.mas_right).with.offset(10);
        make.centerY.equalTo(xukeLB);
        make.height.mas_equalTo(@15);
        make.top.equalTo(weakSelf.addressLabel.mas_bottom).with.offset(5);
    }];
    
    [markBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(weakSelf.hosImage.mas_right).with.offset(-5);
        make.bottom.equalTo(weakSelf.hosImage.mas_bottom).with.offset(-10);
        make.width.mas_equalTo(@40);
        
        
    }];
    
    
    
    
    
    
}
//关注

- (void)handleThreeTapButton:(UIButton *)sender{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *name = [userDefault objectForKey:@"name"];
    NSLog(@"name = %@",name);
    if (name) {
        
        if( self.gunanzhu ==NO){
            //记得昨晚操作之后，改变按钮的点击状态
      
            //self.registerButton.backgroundColor = [UIColor colorWithRed:0/255.0 green:179/255.0 blue:163/255.0 alpha:1];
            //  self.markStr = @"2";
            [self requestGuanZhu];
         self.gunanzhu = YES;
        }else{
            
//
            // self.imageAcc.image = [UIImage imageNamed:@"check"];
            //self.markStr = @"1";
            [self requestGuanZhu];
           self.gunanzhu = NO;
        }
        
        
    }else{
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请先登录账号" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [alert show];
        }else{
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"请先登录账号" preferredStyle:UIAlertControllerStyleAlert];
            [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:alertView animated:YES completion:^{
                
            }];
            
        }
        
    }

}

- (void)requestGuanZhu{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *name = [userDefault objectForKey:@"name"];
    NSString *url = @"http://www.enuo120.com/index.php/app/patient/guanzhuh";
    AFHTTPSessionManager *mager  = [AFHTTPSessionManager manager];
    NSString *a = [[NSString alloc]init];
    if (self.gunanzhu ==NO) {
        a = @"1";
    }else{
        a = @"0";
    }
    
    NSDictionary *heardBody = @{@"username":name,@"hid":self.receiver,@"type":a};
    NSLog(@"heradaBody = %@",heardBody);
    [mager POST:url parameters:heardBody progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"RESPONSEoBJECT = %@",responseObject);
        [self handelWithGuanZhuData:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
    
}


- (void)handelWithGuanZhuData:(NSDictionary *)dic{
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:dic[@"data"][@"message"] delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alert show];
    }else{
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:dic[@"data"][@"message"] preferredStyle:UIAlertControllerStyleAlert];
        [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alertView animated:YES completion:^{
            
        }];
        
    }
    
    if ([dic[@"data"][@"message"] isEqualToString:@"医院关注成功"]) {
              [markBtn setImage:[UIImage imageNamed:@"关注中"] forState:UIControlStateNormal];
    
        self.gunanzhu =YES;
    }else if([dic[@"data"][@"message"] isEqualToString:@"医院取消关注成功"]){
         [markBtn setImage:[UIImage imageNamed:@"+关注"] forState:UIControlStateNormal];
        self.gunanzhu = NO;
    }else{
        NSLog(@"lalalallalallallalal");
    }

}


//电话
- (void)handleOneTapButton:(UIButton*)sender{
  
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:  [ NSString stringWithFormat:@"tel://%@",self.phoneLabel.text]]];
}
//网页
- (void)handleTwoTapButton:(UIButton *)sender{
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[ NSString stringWithFormat:@"%@",self.netLabel.text]]];
}


//医院详情请求
- (void)requestData{
    
    NSString *str = @"http://www.enuo120.com/index.php/app/hospital/home";
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *username = [userDefault objectForKey:@"name"];
    if (username ==NULL) {
        username = @"";
    }
    NSLog(@"name = %@",username);
    NSDictionary *heardBody = @{@"username":username,@"hid":self.receiver};
    
    AFHTTPSessionManager *manegr = [AFHTTPSessionManager manager];
    
    [manegr POST:str parameters:heardBody progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      NSLog(@"responseObject = %@",responseObject);
        [SVProgressHUD dismiss];
        [self handleWithHosData:responseObject];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    

    
    
    
}
//医院详情页面数据处理
- (void)handleWithHosData:(NSDictionary *)dic{
    
    HosModel *model = [HosModel hosModelWithData:dic[@"data"]];
    
    
    NSString * url = [NSString stringWithFormat:urlPicture,model.photo];
    NSLog(@"url = %@",url);
    [self.hosImage sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
    self.nameLabel.text = model.hos_name;
    self.leveLabel.text = model.rank;
    self.phoneLabel.text = model.phone;
    self.ybLabel.text = model.yb;
    self.netLabel.text = model.website;
    self.xukeLabel.text = model.yljg;
    self.addressLabel.text = model.address;
   // model.guanzhu == 0
    
    if (model.guanzhu == 0) {
        self.gunanzhu = NO;
        [markBtn setImage:[UIImage imageNamed:@"+关注"] forState:UIControlStateNormal];
    }else{
        self.gunanzhu = YES;
        [markBtn setImage:[UIImage imageNamed:@"关注中"] forState:UIControlStateNormal];
    }
    
    [phoneBtn setTitle:model.phone forState:UIControlStateNormal];
    [netBtn setTitle:model.website forState:UIControlStateNormal];
    
    [self.dataArray addObject:model];
    
    [self requestkeShiData];
     //[self.tabelView reloadData];
}









//医院科室详情数据请求
- (void)requestkeShiData{
    NSString *str = @"http://www.enuo120.com/index.php/app/hospital/home_keshi";
    NSDictionary *heardBody = @{@"hid":self.receiver};
    
    AFHTTPSessionManager *manegr = [AFHTTPSessionManager manager];
    
    
    
    [manegr POST:str parameters:heardBody progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject = %@",responseObject);
        [SVProgressHUD dismiss];
        // [self handleWithData:responseObject];
        [self handleKeShiWithData:responseObject];
        
        if (self.dataArray.count != 0 &&self.deskArray.count !=0 ) {
            int width = 0;
            int height = 0;
            int number = 0;
            int han = 0;
            
            
            //创建button
            for (int i = 0; i < self.deskArray.count; i++) {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.tag = 300 + i;
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                DeskModel *modell = self.deskArray[i];
                
                button.layer.masksToBounds = YES;
                button.layer.cornerRadius = 10;
                [self setOneBtn:button title:modell.department image:modell.photo];
                CGSize titleSize = CGSizeMake(kScreenWidth/4-10, 70);
                han = han +titleSize.width;
                if (han > [[UIScreen mainScreen]bounds].size.width) {
                    han = 0;
                    han = han + titleSize.width;
                    height++;
                    width = 0;
                    width = width+titleSize.width;
                    number = 0;
                    button.frame = CGRectMake(0, 0 +70*height, titleSize.width, 70);
                }else{
                    button.frame = CGRectMake(width,  70*height, titleSize.width, 70);
                    width = width+titleSize.width;
                }
                number++;
              
                [self.deskView addSubview:button];
            }
            [self.tabelView reloadData];
        }
        

        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];


}

//科室
- (void)handleKeShiWithData:(NSDictionary *)dic{
    NSArray *arr = dic[@"data"];
    if ([dic[@"data"]isKindOfClass:[NSNull class]]) {
        //无数据
    }else{
        for (NSDictionary *temp in arr) {
            DeskModel *model = [DeskModel deskModelInitWithDic:temp];
            [self.deskArray addObject:model];
          
        
        
        }
        

        if(self.deskArray.count/4 > 1){
            self.deskView.frame = CGRectMake(0, 0, kScreenWidth, (self.deskArray.count/4 +1)*70);
            
            
            //[self.tabelView reloadData];
            
        }else{
            self.deskView.frame = CGRectMake(0, 0, kScreenWidth, 70);
        }
      
        

  }
    
            [self.tabelView reloadData];
    
}

//button的设定！
- (void)setOneBtn:(UIButton *)sender title:(NSString *)title image:(NSString *)image{
     NSString * url = [NSString stringWithFormat:urlPicture,image];
    NSLog(@"URL == = = = %@",url);
    
    UIImageView *aimage = [[UIImageView alloc]init];
 
    
    [aimage sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
    //[sender.imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
    
//    [sender setTitle:title forState:UIControlStateNormal];
//   // sender.hidden = NO;
//    [sender setImage:aimage.image forState:UIControlStateNormal];
//    sender.backgroundColor = [UIColor greenColor];
//    sender.titleLabel.backgroundColor = [UIColor redColor];
//    sender.imageView.backgroundColor = [UIColor blueColor];
//    sender.imageEdgeInsets = UIEdgeInsetsMake(5,10,20,5);//上  左 下 右
//    sender.titleEdgeInsets = UIEdgeInsetsMake(64-20, 25-kScreenWidth/4, 0, 0);
//    sender.titleLabel.font = [UIFont systemFontOfSize:12];
//    sender.titleLabel.textAlignment  = NSTextAlignmentCenter;
    [sender addTarget:self action:@selector(handleWithDanDan:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [sender setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    UILabel *alabel = [[UILabel alloc]init];

    [sender addSubview:aimage];
    [sender addSubview:alabel];
    
    [aimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo (sender.mas_left).with.offset(10);
        make.top.equalTo (sender.mas_top).with.offset(5);
        make.bottom.equalTo(alabel.mas_top);
        make.right.equalTo (sender.mas_right).with.offset(-10);
        
    }];
    
    [alabel mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.equalTo (sender.mas_left);
          make.right.equalTo (sender.mas_right);
            make.bottom.equalTo(sender.mas_bottom);
        make.height.mas_equalTo(@20);
    }];
    alabel.text = title;
    alabel.font = [UIFont systemFontOfSize:12];
    alabel.textColor = [UIColor grayColor];
    alabel.textAlignment = NSTextAlignmentCenter;

}

//button

- (void)handleWithDanDan:(UIButton *)sender{
    if (sender.tag >=300) {
          DeskModel *modell = self.deskArray[sender.tag - 300];
          HosModel *model = self.dataArray[0];
        HosDocViewController *hosVc = [[HosDocViewController alloc]init];
        UINavigationController *naNC  = [[UINavigationController alloc]initWithRootViewController:hosVc];
        hosVc.dep_id = modell.cid;
        hosVc.hid = model.cid;
        [self presentViewController:naNC animated:YES completion:^{
            
        }];
        
        
    }
}

//tableView的创建
- (void)creatTableView{
    self.tabelView.delegate = self;
    self.tabelView.dataSource = self;

    [self.tabelView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.dataArray.count !=0 &&self.deskArray.count != 0) {
        HosModel *model = self.dataArray[0];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14], NSParagraphStyleAttributeName:paragraphStyle.copy};
        
        CGRect rectOne = [model.hos_information boundingRectWithSize:CGSizeMake(kScreenWidth, 20000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        CGRect rectTwo = [model.ill boundingRectWithSize:CGSizeMake(kScreenWidth, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        CGRect rectThree = [model.bus boundingRectWithSize:CGSizeMake(kScreenWidth, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        
        if (indexPath.section == 0) {
            return rectOne.size.height;
        }else if(indexPath.section == 1){
            return  rectTwo.size.height;
        }else if (indexPath.section == 2){
            return rectThree.size.height;
        }else {
            return self.deskView.frame.size.height;
       
        }
    }else{
        return 0;
    }

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"self.onestr = %@",self.oneStr);
    if (section == 0){
        //self.oneS = NO;
        if ([self.oneStr isEqualToString:@"1"]) {
            return 1;
        }else{
            return 0;
        }
    }else if (section == 1){
        // self.twoS = NO;
        if ([self.twoStr isEqualToString:@"1"]) {
            return 1;
        }else{
            return 0;
        }
    }else if (section == 2){
        //self.twoS = NO;
        if ([self.threeStr isEqualToString:@"1"]) {
        
            return 1;
        }else{
            return 0;
        }
    }else  if (section == 3){
        if ([self.fourStr isEqualToString:@"1"]) {
            return 1;
        }else{
            return 0;
        }
    }else{
        if ([self.fiveStr isEqualToString:@"1"]) {
            return 1;
        }else{
            return 0;
        }
    }

}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return [self creatHosWith:nil title:@"医院简介"];
    }else if (section == 1){
        return [self creatIllWith:nil title:@"约定疾病"];
    }else if (section == 2){
        return  [self creatBusWith:nil title:@"公交"];
    }else{
       return [self creatKeShiWith:nil title:@"科室"];
   
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}






- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    

    cell.textLabel.font = [UIFont systemFontOfSize:13.0];
    cell.textLabel.numberOfLines = 0;
   if (self.dataArray.count != 0 &&self.deskArray.count !=0 ) {
//        if (self.deskArray.count/4 ==0) {
//            self.numS = self.deskArray.count/4;
//            self.numA = self.deskArray.count;
//        }else{
//            self.numS = self.deskArray.count/4 +1;
//            self.numA = 4;
//        }
//        
//        if (self.deskArray.count/4 ==0 ) {
//            for (int i = 0; i<self.deskArray.count; i ++) {
//
//                UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
//                [self setOneBtn:aButton title:modell.department image:modell.photo];
//          
//                aButton.tag = 200+i;
//                aButton.frame = CGRectMake(i*kScreenWidth/4, 0, kScreenWidth/4, 70);
//                [self.deskView addSubview:aButton];
//                
//            }
//        }else{
//            for (int i= 0; i <self.numS; i ++) {
//                for (int j = 0; j < self.numA; j ++) {
//                    DeskModel *modell = self.deskArray[4*i+j];
//                    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
//                  
//                    [self setOneBtn:aButton title:modell.department image:modell.photo];
//                    aButton.tag = 100+4*i+j;
//                    aButton.frame = CGRectMake(j*kScreenWidth/4, 70*i, kScreenWidth/4, 70);
//                    
//                    NSLog(@"asdasdsad");
//                    [self.deskView addSubview:aButton];
//                    
//                }
//                
//                
//            }
   
       
        
        
        
        
        
        
       

        HosModel *model = self.dataArray[0];
        if (indexPath.section == 0) {
            
            cell.textLabel.text = model.hos_information;
        }else if (indexPath.section == 1){
            cell.textLabel.text = model.ill;
        }else if (indexPath.section == 2){
            cell.textLabel.text = model.bus;
        }else if (indexPath.section == 3){
            NSLog(@"sadsdadad= %ld",(unsigned long)self.deskArray.count);
            
            
            [cell.contentView addSubview: self.deskView];
        }else{
            cell.textLabel.text = @"暂无评论";
        }

    
   }
    
    
    
    return cell;
    
}





//医院简介
- (UIView*)creatHosWith:(NSString *)image
                    title:(NSString *)title{
    
    UIView *aview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    aview.layer.borderWidth=1;
    aview.layer.borderColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0].CGColor;
    UIImageView *amage = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-30, 10, 25, 25)];
    amage.image = [UIImage imageNamed:image];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 0, kScreenWidth-30, 30);
    [button addTarget:self action:@selector(handleHosSecrion:) forControlEvents:UIControlEventTouchUpInside];
    aview.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0];
    // button.backgroundColor = [UIColor yellowColor];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [aview addSubview:amage];
    [aview addSubview:button];
    UIImageView *bottomImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 28, kScreenWidth, 2)];
    bottomImage.image = [UIImage imageNamed:@"绿色底线"];
    
    [aview addSubview:bottomImage];
    return aview;
    
    
    
    
    
}
- (void)handleHosSecrion:(UIButton *)sender{
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:0];
    
    
    if(self.oneS == YES){
        //记得昨晚操作之后，改变按钮的点击状态
        self.oneStr = @"2";
        
        [self.tabelView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
        //self.registerButton.backgroundColor = [UIColor colorWithRed:0/255.0 green:179/255.0 blue:163/255.0 alpha:1];
        //  self.markStr = @"2";
        self.oneS =NO;
    }else{
        self.oneStr = @"1";
        [self.tabelView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
        
        // self.imageAcc.image = [UIImage imageNamed:@"check"];
        //self.markStr = @"1";
        
        self.oneS = YES;
    }

}




//约定疾病
- (UIView*)creatIllWith:(NSString *)image
                    title:(NSString *)title{
    
    UIView *aview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    aview.layer.borderWidth=1;
    aview.layer.borderColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0].CGColor;
    UIImageView *amage = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-30, 10, 25, 25)];
    amage.image = [UIImage imageNamed:image];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 0, kScreenWidth-30, 30);
    [button addTarget:self action:@selector(handleillSecrion:) forControlEvents:UIControlEventTouchUpInside];
    aview.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0];
    // button.backgroundColor = [UIColor yellowColor];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [aview addSubview:amage];
    [aview addSubview:button];
    UIImageView *bottomImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 28, kScreenWidth, 2)];
    bottomImage.image = [UIImage imageNamed:@"绿色底线"];
    
    [aview addSubview:bottomImage];
    return aview;
    
    
    
    
    
}


- (void)handleillSecrion:(UIButton *)sender{
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:1];
    
    
    if(self.twoS ==YES){
        //记得昨晚操作之后，改变按钮的点击状态
        self.twoStr = @"2";
        
        [self.tabelView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
        //self.registerButton.backgroundColor = [UIColor colorWithRed:0/255.0 green:179/255.0 blue:163/255.0 alpha:1];
        //  self.markStr = @"2";
        self.twoS = NO;
    }else{
        self.twoStr = @"1";
        [self.tabelView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
        
        // self.imageAcc.image = [UIImage imageNamed:@"check"];
        //self.markStr = @"1";
        
        self.twoS = YES;
    }

}





//公交
- (UIView*)creatBusWith:(NSString *)image
                    title:(NSString *)title{
    
    UIView *aview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    aview.layer.borderWidth=1;
    aview.layer.borderColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0].CGColor;
    UIImageView *amage = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-30, 10, 25, 25)];
    amage.image = [UIImage imageNamed:image];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 0, kScreenWidth-30, 30);
    [button addTarget:self action:@selector(handleBusSecrion:) forControlEvents:UIControlEventTouchUpInside];
    aview.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0];
    // button.backgroundColor = [UIColor yellowColor];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [aview addSubview:amage];
    [aview addSubview:button];
    UIImageView *bottomImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 28, kScreenWidth, 2)];
    bottomImage.image = [UIImage imageNamed:@"绿色底线"];
    
    [aview addSubview:bottomImage];
    return aview;
    
    
    
    
    
}

- (void)handleBusSecrion:(UIButton *)sender{
     NSIndexSet *set = [NSIndexSet indexSetWithIndex:2];
    if(self.threeS == YES){
        //记得昨晚操作之后，改变按钮的点击状态
        self.threeStr = @"2";
        
        [self.tabelView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
        //self.registerButton.backgroundColor = [UIColor colorWithRed:0/255.0 green:179/255.0 blue:163/255.0 alpha:1];
        //  self.markStr = @"2";
        self.threeS = NO;
    }else{
        self.threeStr = @"1";
        [self.tabelView reloadSections:set withRowAnimation:UITableViewRowAnimationFade
         ];
        
        // self.imageAcc.image = [UIImage imageNamed:@"check"];
        //self.markStr = @"1";
        self.threeS = YES;
    }
    
    
}








//科室
- (UIView*)creatKeShiWith:(NSString *)image
                    title:(NSString *)title{
    
    UIView *aview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    aview.layer.borderWidth=1;
    aview.layer.borderColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0].CGColor;
    UIImageView *amage = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-30, 10, 25, 25)];
    amage.image = [UIImage imageNamed:image];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 0, kScreenWidth-30, 30);
    [button addTarget:self action:@selector(handleKeshiSecrion:) forControlEvents:UIControlEventTouchUpInside];
    aview.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0];
    // button.backgroundColor = [UIColor yellowColor];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [aview addSubview:amage];
    [aview addSubview:button];
    UIImageView *bottomImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 28, kScreenWidth, 2)];
    bottomImage.image = [UIImage imageNamed:@"绿色底线"];
    
    [aview addSubview:bottomImage];
    return aview;
    
    
    
    
    
}


- (void)handleKeshiSecrion:(UIButton *)sender{
//    NSIndexSet *set = [NSIndexSet indexSetWithIndex:3];
//    if(self.fourS == YES){
//        //记得昨晚操作之后，改变按钮的点击状态
//        self.fourStr = @"2";
//        
//        [self.tabelView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
//        //self.registerButton.backgroundColor = [UIColor colorWithRed:0/255.0 green:179/255.0 blue:163/255.0 alpha:1];
//        //  self.markStr = @"2";
//        self.fourS = NO;
//    }else{
//        self.fourStr = @"1";
//        [self.tabelView reloadSections:set withRowAnimation:UITableViewRowAnimationFade
//         ];
//        
//        //self.imageAcc.image = [UIImage imageNamed:@"check"];
//        //self.markStr = @"1";
//        self.fourS = YES;
//    }

    
    NSLog(@"科室");
}



//评论
- (UIView*)creatPLWith:(NSString *)image
                    title:(NSString *)title{
    
    UIView *aview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    aview.layer.borderWidth=1;
    aview.layer.borderColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0].CGColor;
    UIImageView *amage = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-30, 10, 25, 25)];
    amage.image = [UIImage imageNamed:image];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 0, kScreenWidth-30, 30);
    [button addTarget:self action:@selector(handlePLSecrion:) forControlEvents:UIControlEventTouchUpInside];
    aview.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0];
    // button.backgroundColor = [UIColor yellowColor];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [aview addSubview:amage];
    [aview addSubview:button];
    UIImageView *bottomImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 28, kScreenWidth, 2)];
    bottomImage.image = [UIImage imageNamed:@"绿色底线"];
    
    [aview addSubview:bottomImage];
    return aview;
    
    
    
    
    
}
- (void)handlePLSecrion:(UIButton *)sender{
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:4];
    if(self.fiveS == YES){
        //记得昨晚操作之后，改变按钮的点击状态
        self.fiveStr = @"2";
        
        [self.tabelView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
        //self.registerButton.backgroundColor = [UIColor colorWithRed:0/255.0 green:179/255.0 blue:163/255.0 alpha:1];
        //  self.markStr = @"2";
        self.fiveS = NO;
    }else{
        self.fiveStr = @"1";
        [self.tabelView reloadSections:set withRowAnimation:UITableViewRowAnimationFade
         ];
        
        //self.imageAcc.image = [UIImage imageNamed:@"check"];
        //self.markStr = @"1";
        self.fiveS = YES;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
