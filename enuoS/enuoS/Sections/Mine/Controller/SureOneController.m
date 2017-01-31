//
//  SureOneController.m
//  enuo4
//
//  Created by apple on 16/4/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SureOneController.h"
#import "Macros.h"
#import <AFNetworking.h>
#import <Masonry.h>
#import "SureOneModel.h"
#import <SVProgressHUD.h>




@interface SureOneController ()
@property (nonatomic,strong)NSMutableArray *dataArr;

@end

@implementation SureOneController
- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        self.dataArr = [NSMutableArray array];

    }return _dataArr;
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
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
  [self requsetData];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航条底图"] forBarMetrics:0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    NSLog(@"asdasd");
}


- (void)handleWithBack:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}





- (void)creatTableView{
    NSLog(@"self.datarr = %@",self.dataArr);
    SureOneModel *model = self.dataArr[0];
        UILabel *oneLabel = [[UILabel alloc]init];
        oneLabel.text = @"诊断:";
        oneLabel.font = [UIFont systemFontOfSize:14];
    oneLabel.textAlignment = NSTextAlignmentRight;
    
        UILabel *twoLabel  = [[UILabel alloc]init];
        twoLabel.text = @"主诉:";
        twoLabel.font = [UIFont systemFontOfSize:14];
    twoLabel.textAlignment = NSTextAlignmentRight;
    
        UILabel *threeLabel = [[UILabel alloc]init];
        threeLabel.text = @"现病史:";
        threeLabel.font = [UIFont systemFontOfSize:14];
    threeLabel.textAlignment = NSTextAlignmentRight;
    
        UILabel *frouLabel  = [[UILabel alloc]init];
        frouLabel.text = @"体格检查:";
        frouLabel.font = [UIFont systemFontOfSize:14];
    frouLabel.textAlignment = NSTextAlignmentRight;
    
    NSLog(@"ashjdkasdjkkjalsjdlajsdlkj");
        UILabel *fiveLabel = [[UILabel alloc]init];
        fiveLabel.text = @"实验室检查:";
        fiveLabel.font = [UIFont systemFontOfSize:14];
    fiveLabel.textAlignment = NSTextAlignmentRight;
    
        
        
        UILabel *sixLabel = [[UILabel alloc]init];
        sixLabel.text = @"辅助检查:";
        sixLabel.font = [UIFont systemFontOfSize:14];
    sixLabel.textAlignment = NSTextAlignmentRight;
    
        UILabel *oneTextLabel = [[UILabel alloc]init];
        oneTextLabel.font = [UIFont systemFontOfSize:14];
        oneTextLabel.textColor = [UIColor darkGrayColor];
    oneTextLabel.numberOfLines = 0;
    oneTextLabel.text = model.zhenduan;
        
        UILabel *twoTextLabel = [[UILabel alloc]init];
        twoTextLabel.font = [UIFont systemFontOfSize:14];
        twoTextLabel.textColor = [UIColor darkGrayColor];
    twoTextLabel.numberOfLines = 0;
    twoTextLabel.text = model.main_say;
    
    
    
        UILabel *threeTextLabel = [[UILabel alloc]init];
        threeTextLabel.font = [UIFont systemFontOfSize:14];
        threeTextLabel.textColor = [UIColor darkGrayColor];
        threeTextLabel.numberOfLines = 0;
    threeTextLabel.text = model.now_disease;
    
    
    
    
    
    
        UILabel *frouTextLabel = [[UILabel alloc]init];
        frouTextLabel.numberOfLines = 0;
        frouTextLabel.textColor = [UIColor darkGrayColor];
        frouTextLabel.font = [UIFont systemFontOfSize:14 ];
        frouTextLabel.text = model.dody_check;
    
        UILabel *fiveTextLabel = [[UILabel alloc]init];
        fiveTextLabel.font = [UIFont systemFontOfSize:14];
        fiveTextLabel.textColor = [UIColor darkGrayColor];
        fiveTextLabel.numberOfLines = 0;
    fiveTextLabel.text = model.lab_check;
    
        UILabel *sixTextLabel = [[UILabel alloc]init];
        sixTextLabel.font = [UIFont systemFontOfSize:14];
        sixTextLabel.textColor = [UIColor darkGrayColor];
        sixLabel.numberOfLines = 0;
    sixTextLabel.text = model.he_check;
        [self.view addSubview:oneTextLabel];
        [self.view addSubview:twoTextLabel];
        [self.view addSubview:threeTextLabel];
        [self.view addSubview:frouTextLabel];
        [self.view addSubview:fiveTextLabel];
        [self.view addSubview:sixTextLabel];
        [self.view addSubview:oneLabel];
        [self.view addSubview:twoLabel];
        [self.view addSubview:threeLabel];
        [self.view addSubview:frouLabel];
        [self.view addSubview:fiveLabel];
        [self.view addSubview:sixLabel];
        __weak typeof (self) weakSelf = self;
        [oneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.view.mas_left).with.offset(5);
            make.width.mas_equalTo(@75);
            make.top.equalTo(weakSelf.view.mas_top).with.offset(5);
            
            
        }];
        
        [twoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(oneLabel);
            make.width.mas_equalTo(@75);
          //  make.top.equalTo(oneLabel.mas_bottom).with.offset(5);
            
        }];
        [threeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(twoLabel);
            make.width.mas_equalTo(@75);
           // make.top.equalTo(twoLabel.mas_bottom).with.offset(5);
        }];
        [frouLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(threeLabel);
            make.width.mas_equalTo(@75);
          //  make.top.equalTo(threeLabel.mas_bottom).with.offset(5);
        }];
        [fiveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(frouLabel);
            make.width.mas_equalTo(@75);
           // make.top.equalTo(frouLabel.mas_bottom).with.offset(5);
        }];
        [sixLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(fiveLabel);
            make.width.mas_equalTo(@75);
           // make.top.equalTo(fiveLabel.mas_bottom).with.offset(5);
        }];
        
        [oneTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(oneLabel.mas_right).with.offset(5);
            make.top.equalTo(oneLabel);
            make.right.equalTo(weakSelf.view.mas_right);
            
        }];
        [twoTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(oneTextLabel.mas_bottom).with.offset(5);
            make.left.equalTo(twoLabel.mas_right).with.offset(5);
            make.top.equalTo(twoLabel);
            make.right.equalTo(weakSelf.view.mas_right);
            
        }];
        [threeTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(threeLabel.mas_right).with.offset(5);
            make.top.equalTo(threeLabel);
            make.right.equalTo(weakSelf.view.mas_right);
              make.top.equalTo(twoTextLabel.mas_bottom).with.offset(5);
            
        }];
        [frouTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(frouLabel.mas_right).with.offset(5);
            make.top.equalTo(frouLabel);
            make.right.equalTo(weakSelf.view.mas_right);
              make.top.equalTo(threeTextLabel.mas_bottom).with.offset(5);
        }];
        [fiveTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(fiveLabel.mas_right).with.offset(5);
             make.top.equalTo(fiveLabel);
            make.right.equalTo(weakSelf.view.mas_right);
              make.top.equalTo(frouTextLabel.mas_bottom).with.offset(5);
        }];
        [sixTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(sixLabel.mas_right).with.offset(5);
            make.top.equalTo(sixLabel);
            make.right.equalTo(weakSelf.view.mas_right);
              make.top.equalTo(fiveTextLabel.mas_bottom).with.offset(5);
        }];

//    }else{
//              __weak typeof (self) weakSelf = self;
//        UILabel *alabel = [[UILabel alloc]init];
//        alabel.text = @"暂无数据";
//        [self.view addSubview:alabel];
//        [alabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(weakSelf.view);
//            make.centerY.equalTo(weakSelf.view);
//            make.size.mas_equalTo(CGSizeMake(100, 44));
//        }];
    
        
        
   
    
    
    
    
    
}
- (void)requsetData{
    NSString *str = @"http://www.enuo120.com/index.php/phone/Json/zhen?pro=%@";
    NSLog(@"sef.receiver = %@",self.receiver);
    NSString *url = [NSString stringWithFormat:str,self.receiver];
    
    
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleDataWithDic:responseObject];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)handleDataWithDic:(NSDictionary *)dic{
    NSArray *arr = dic[@"data"];
    for (NSDictionary *temp  in arr) {
        SureOneModel *model = [SureOneModel sureOneModelInithWithDic:temp];
        [self.dataArr addObject:model];
    }
    [self creatTableView];

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
