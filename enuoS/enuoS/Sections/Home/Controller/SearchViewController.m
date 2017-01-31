//
//  SearchViewController.m
//  enuoS
//
//  Created by apple on 16/8/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SearchViewController.h"
#import "ZZSearchView.h"
#import "Macros.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <UIImageView+WebCache.h>
#import "ZZCoredata.h"
#import "PellTableViewSelect.h"
#import "SarchDetailViewController.h"
#define DefineWeakSelf __weak __typeof(self) weakSelf = self


@interface SearchViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>

{
    ZZSearchView* searchView;
}
@property(nonatomic,strong)UITableView *hisTableView;
@property(nonatomic,strong) NSMutableArray *historyArr;
@property(nonatomic,strong) NSMutableArray *hotArr;
@property(nonatomic,strong) NSMutableArray *hisTArr;
@property (nonatomic,strong)NSMutableArray *dataArr;

@property (nonatomic,strong)NSMutableArray *keyDic;

@property (nonatomic,copy)NSString *sumMark;
@property (nonatomic,assign)BOOL yee;
@end

@implementation SearchViewController


- (NSMutableArray *)keyDic{
    if (!_keyDic) {
        self.keyDic = [NSMutableArray array];
    }return _keyDic;
}

- (UITableView *)hisTableView{
    if (!_hisTableView ) {
        self.hisTableView = [[UITableView alloc]init];
    }return _hisTableView;
}

- (NSMutableArray *)historyArr{
    if (!_historyArr) {
        self.historyArr = [NSMutableArray array];
    }return _historyArr;
   
    
}
- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        self.dataArr = [NSMutableArray array];
    }return _dataArr;
}



//- (UITableView *)tableView{
//    if (!_tableView) {
//        self.tableView = [[UITableView alloc]init];
//    }return _tableView;
//}
//+(YYSearchViewController *)SearchViewController
//{
//    YYSearchViewController * search = [[YYSearchViewController alloc]initWithNibName:@"YYSearchViewController" bundle:nil];
//    return search;
//}

//+ (SearchViewController *)searchViewController{
//    SearchViewController *search = [SearchViewController alloc]initWithNibName:@"" bundle:<#(nullable NSBundle *)#>
//}

//- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"绿色返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleWithBack:)];
//        self.navigationItem.leftBarButtonItem = leftItem;
//    }return self;
//}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tableView.hidden = YES;
    

}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.yee = YES;
    self.sumMark = @"0";
     [self.view addSubview:self.tableView];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
//        [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
        [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
       self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    //[self creatTabeleView];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];
    [self setupSearchView];
    self.tableView = [[UITableView alloc]init];
    [self.tableView  registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeigth);
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:self.tableView];
    

  
}



- (void)creatTabeleView{
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.hisTableView.delegate = self;
    self.hisTableView.dataSource =self;
    
 
    [self.hisTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell2"];
    
   
}

-(void)setupSearchView
{
    searchView = [ZZSearchView creatView];
    searchView.frame = CGRectMake(0, 0, kScreenWidth, 30);
    
    searchView.ZZSearch.delegate = self;
    //searchView.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchView.cancelBtn addTarget:self action:@selector(handleWithBack:) forControlEvents:UIControlEventTouchUpInside];
    [searchView.changeBtn addTarget:self action:@selector(handleSelectWithButton:) forControlEvents:UIControlEventTouchUpInside];
    DefineWeakSelf;
    [searchView.ZZSearch addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [searchView setZZGetCancel:^{
        
    }];
    [searchView setZZGetTitle:^(NSString * title)
     {
         [weakSelf searchKeyWords:title];
     }];
    self.navigationItem.titleView = searchView;
}
- (void)handleSelectWithButton:(UIButton *)sender{
    // 弹出QQ的自定义视图
    [PellTableViewSelect addPellTableViewSelectWithWindowFrame:CGRectMake(0, 64, 65, 200) selectData:@[@"疾病",@"医院",@"医生"] images:nil action:^(NSInteger index) {
        NSLog(@"选择%ld",(long)index);
              NSArray *arr = @[@"疾病",@"医院",@"医生"];
        self.sumMark =  [NSString stringWithFormat:@"%ld",index];
        [searchView.changeBtn setTitle:arr[index] forState:UIControlStateNormal];
//        self.indexStr = [arrOn[index] integerValue] ;
//        [sender setTitle:arr[index] forState:UIControlStateNormal];
//        self.passStr = [[NSString alloc]init];
//        self.passStr = [NSString stringWithFormat:str,self.indexStr];
//        NSLog(@"self.passStr = %@",self.passStr);
        
        
    } animated:YES];
}

- (void)handleWithBack:(UIButton*)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
//-(CGRect)placeholderRectForBounds:(CGRect)bounds
//{
//    
//    //return CGRectInset(bounds, 20, 0);
//    CGRect inset = CGRectMake(0, bounds.origin.y, bounds.size.width -10, bounds.size.height);//更好理解些
//    return inset;
//}
-(void)searchKeyWords:(NSString *)keyWords
{
    if ([keyWords isEqualToString:@""] || keyWords == nil)
    {
        return;
    }
    [self loadSearchDataWithKeyWord:keyWords];
}

- (void)loadSearchDataWithKeyWord:(NSString *)keyword
{
    for (int i = 0; i< self.historyArr.count; i++)
    {
        if ([[self.historyArr[i] valueForKey:@"title"] isEqual:keyword] == YES)
        {
            [self.historyArr removeObject:self.historyArr[i]];
        }
    }
    NSDictionary * dict2 = @{@"title":keyword};
    [self.historyArr addObject:dict2];
    //写入本地
    NSString *path = [[ZZCoredata shareCoreData] userResPath:@"searchFile.plist"];
    [self.historyArr writeToFile:path atomically:YES];
    
    self.hisTArr = [NSMutableArray array];
    self.historyArr = [NSMutableArray arrayWithContentsOfFile:[[ZZCoredata shareCoreData]userResPath:@"searchFile.plist"]];
    if (!self.historyArr)
    {
        self.historyArr = [NSMutableArray array];
    }
    
    [self.hisTableView reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSLog(@"SELF.KEYDIC.COUNT = %ld",self.keyDic.count);
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.keyDic.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (tableView == self.tableView&&self.keyDic.count !=0) {
         UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        NSLog(@"self.keydic = %@",self.keyDic);
        
        cell.textLabel.text = self.keyDic[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        return cell;
    }else{
        return nil;
    }
    
    
    
}


- (void)requestKeyData{
    NSString *str = @"http://www.enuo120.com/index.php/app/search/show_keyword";
    
    NSDictionary *headBody = @{@"type":self.sumMark,@"search_val":searchView.ZZSearch.text,@"ver":@"1.0"};
    
    NSLog(@"headBody = %@",headBody);
    AFHTTPSessionManager *mager = [AFHTTPSessionManager manager];
    [mager POST:str parameters:headBody progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        [self handleWithKeyData:responseObject];
        NSLog(@"RESPOSE = %@",responseObject);
        if (!_tableView ) {
            NSLog(@"111111111111111111111111111");
                  }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
    
}


- (void)handleWithKeyData:(NSDictionary *)data{
    if ([data[@"data"]isKindOfClass:[NSArray class]]) {
        self.keyDic = data[@"data"];
        [self.tableView reloadData];
       
         self.tableView.hidden = NO;

    }else{
        NSLog(@"数据错误");
    }
    
    
    
    
    //[self.tableView reloadData];
}

- (void) textFieldDidChange:(UITextField *) TextField{
   
    if ([TextField.text isEqualToString:@""]) {
        self.tableView.hidden = YES;
        
    }
         [self requestKeyData];
   
    
   
    
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
 
    
   
    
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
 
    
}




- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
   
    
    
    
    return YES;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSString *selectIll = self.keyDic[indexPath.row];
    
    NSLog(@"%@",selectIll);
    
    [searchView.ZZSearch resignFirstResponder];
    
    SarchDetailViewController *aeVC = [[SarchDetailViewController alloc]init];
    aeVC.receiveMark = self.sumMark;
    aeVC.resualt = selectIll;
    UINavigationController *naVC= [[UINavigationController alloc]initWithRootViewController:aeVC];
    [self presentViewController:naVC animated:YES completion:^{
        
    }];

    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [searchView.ZZSearch resignFirstResponder];
    
    SarchDetailViewController *aeVC = [[SarchDetailViewController alloc]init];
    
    aeVC.receiveMark = self.sumMark;
    aeVC.resualt = searchView.ZZSearch.text;
    UINavigationController *naVC= [[UINavigationController alloc]initWithRootViewController:aeVC];
    [self presentViewController:naVC animated:YES completion:^{
        
    }];
    
    
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
