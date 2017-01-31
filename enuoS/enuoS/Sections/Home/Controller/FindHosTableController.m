//
//  FindHosTableController.m
//  enuoS
//
//  Created by apple on 16/7/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "FindHosTableController.h"
#import "PromiseHosViewCell.h"
#import "Macros.h"
#import <Masonry.h>
#import "UIColor+Extend.h"

#import <AFNetworking.h>
#import <MJRefresh.h>
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
//#import "HosViewController.h"
//#import "hosHomePageTabVC.h"
#import "hosHomePageVC.h"
#import "FindHosModel.h"
#import "hosFiltrateView.h"
#import "hosFiltrateTabVC.h"
#import "SarchDetailViewController.h"


@interface FindHosTableController ()<UISearchBarDelegate>
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)NSMutableArray *areaArray;
@property (nonatomic,strong)NSMutableArray *sortArray;

@property (nonatomic,strong)hosFiltrateTabVC *hosFilTabVC;


@property (assign, nonatomic) NSInteger num;


@end

@implementation FindHosTableController

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }return _dataArray;
}
- (NSMutableArray *)areaArray{
    if (!_areaArray) {
        _areaArray = [NSMutableArray array];
    }return _areaArray;
}- (NSMutableArray *)sortArray{
    if (!_sortArray) {
        _sortArray = [NSMutableArray array];
    }return _sortArray;
}

- (instancetype)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if (self) {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"绿色返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleWithBack:)];
        self.navigationItem.leftBarButtonItem = leftItem;
    }return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"PromiseHosViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航条底图"] forBarMetrics:0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    self.navigationController.navigationBar.translucent = NO;
    self.num = 1;
    
    [self requestData];
    
    //筛选请求
    [self requestFiltrateData];
    
    
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
//    //默认【上拉加载】
//    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    
}


//- (void)refresh{
//    //NSLog(@"你是个大逗逼");
//    [self.dataArray removeAllObjects];
//    _num = 1;
//    [self requestData];
//}
//
//- (void)loadMore{
//    // NSLog(@"都比都比");
//    _num ++;
//    [self requestData];
//}






- (void)handleWithBack:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return self.dataArray.count;
    }else {
        return 0;
    }
}


- (void)requestData{
    NSString *str = @"http://www.enuo120.com/index.php/app/index/find_hospital";
    NSString * page = [NSString stringWithFormat:@"%ld",(long)self.num];
      NSDictionary *heardBody = @{@"page":page,@"ver":@"1.0"};
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger POST:str parameters:heardBody progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleWithDic:responseObject];
//        [selendRefreshf endRefresh];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
}
//请求筛选数据
- (void)requestFiltrateData {
    //地区
    NSString *str = @"http://www.enuo120.com/index.php/app/Index/get_area_list";
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger POST:str parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *name = @"area";
        [self FiltrateData:responseObject withWho:name];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    //地区下的科室
    NSString *docStr = @"http://www.enuo120.com/index.php/app/Index/get_sort_list";
    [manger POST:docStr parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *name = @"sort";
        [self FiltrateData:responseObject withWho:name];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}
//筛选数据
- (void)FiltrateData:(NSDictionary *)dic withWho:(NSString *)who {
    if ([dic[@"data"]isKindOfClass:[NSNull class]]) {
        
    }else{
        NSArray *arr = dic[@"data"];
        
        if ([who isEqualToString:@"area"]) {//地区请求
            [self.areaArray removeAllObjects];
            for (NSDictionary *temp in arr) {
                FindHosModel *model = [FindHosModel findHosModelInithWithDic:temp];
                [self.areaArray addObject:model];
            }
        }else {//地区科室请求
            [self.sortArray removeAllObjects];
            for (NSDictionary *temp in arr) {
                FindHosModel *model = [FindHosModel findHosModelInithWithDic:temp];
                [self.sortArray addObject:model];
            }
        }
        
    }
    
}

- (void)handleWithDic:(NSDictionary *)dic{
    if ([dic[@"data"]isKindOfClass:[NSNull class]]) {
        
    }else{
        NSArray *arr = dic[@"data"];
        [self.dataArray removeAllObjects];
        for (NSDictionary *temp in arr) {
            FindHosModel *model = [FindHosModel findHosModelInithWithDic:temp];
            [self.dataArray addObject:model];
        }
        [self.tableView reloadData];
        self.tableView.contentOffset = CGPointMake(0, 0);
     
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        UIView *baseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 77)];
        
        UIView *searckView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
        [baseView addSubview:searckView];
        
        searckView.backgroundColor = [UIColor stringTOColor:@"#00b09f"];
        
        UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(20, 6, kScreenWidth-40, 30)];
        searchBar.placeholder = @"搜索医院";
        searchBar.delegate = self;
        
        //移除searchbar的灰色背景  只留下textfield样式（需要iOS8.0以上版本 以下需要判断）
        for(int i =  0 ;i < searchBar.subviews.count;i++){
            
            UIView * backView = searchBar.subviews[i];
            
            if ([backView isKindOfClass:NSClassFromString(@"UISearchBarBackground")] == YES) {
                
                [backView removeFromSuperview];
                [searchBar setBackgroundColor:[UIColor clearColor]];
                break;
                
            }else{
                
                NSArray * arr = searchBar.subviews[i].subviews;
                
                for(int j = 0;j<arr.count;j++   ){
                    
                    UIView * barView = arr[i];
                    
                    if ([barView isKindOfClass:NSClassFromString(@"UISearchBarBackground")] == YES) {
                        
                        [barView removeFromSuperview];
                        [searchBar setBackgroundColor:[UIColor clearColor]];
                        break;
                        
                    }
                    
                }
                
            }
            
        }
        
        searchBar.keyboardType = UIKeyboardTypeDefault;
        
        [searckView addSubview:searchBar];
        
        
        //筛选
        UIView *filtrateView = [[UIView alloc]init];
        filtrateView.backgroundColor = [UIColor whiteColor];
        filtrateView.frame = CGRectMake(0, 44, kScreenWidth, 33);
        [baseView addSubview:filtrateView];
        
        UILabel *filtrateLabel = [[UILabel alloc]init];
        filtrateLabel.text = @"筛选";
        filtrateLabel.textColor = [UIColor blackColor];
        [filtrateView addSubview:filtrateLabel];
        UIImageView *triangleImageView = [[UIImageView alloc]init];
        triangleImageView.image = [UIImage imageNamed:@"筛选展开"];
        [filtrateView addSubview:triangleImageView];
        
        [filtrateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(filtrateView.mas_left).with.offset(kScreenWidth/2);
            make.centerY.equalTo(filtrateView.mas_centerY);
        }];
        [triangleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(filtrateView.mas_left).with.offset(kScreenWidth/2);
            make.centerY.equalTo(filtrateView.mas_centerY);
            make.size.mas_offset(CGSizeMake(14, 8));
        }];
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]init];
        [gesture addTarget:self action:@selector(filtrateClick:)];
        [filtrateView addGestureRecognizer:gesture];
        
        return baseView;
        
    }else {
        UIView *searckView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 70)];
        
        searckView.backgroundColor = [UIColor stringTOColor:@"#f3f3f6"];
        
        UIButton *changeGroupBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        changeGroupBtn.backgroundColor = [UIColor stringTOColor:@"#00b09f"];
        changeGroupBtn.center = CGPointMake(searckView.center.x, searckView.center.y);
        changeGroupBtn.bounds = CGRectMake(0, 0, 100, 30);
        [changeGroupBtn setTitle:@"换一组" forState:normal];
        [changeGroupBtn setTitleColor:[UIColor whiteColor] forState:normal];
        changeGroupBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [changeGroupBtn addTarget:self action:@selector(changegroup:) forControlEvents:UIControlEventTouchUpInside];
        changeGroupBtn.layer.cornerRadius = 10;
        changeGroupBtn.clipsToBounds = YES;
        [searckView addSubview:changeGroupBtn];
        return searckView;
        
    }

}

//筛选按钮点击事件
- (void)filtrateClick:(UITapGestureRecognizer *)sender {

    
//    CFFViewController *cffVC = [[CFFViewController alloc]initWithTitleList:titleArr withBtnList:self.buttonList];
//    self.cffVC = cffVC;
//    [self.cffVC.flowButtonView.sureBtn addTarget:self action:@selector(screenOutSureClick:) forControlEvents:UIControlEventTouchUpInside];
//    
//    self.cffVC.view.frame = CGRectMake(0, 33, WIDHT, HEIGHT-33-64);
//    self.cffVC.view.tag = 100;
//    [self.view addSubview:self.cffVC.view];

    
//    hosFiltrateTabVC *filtrateView = [[hosFiltrateTabVC alloc]initWithAreaArray:self.areaArray andSortArr:self.sortArray];
//    
//    self.hosFilTabVC = filtrateView;
//        
//    self.hosFilTabVC.view.frame = CGRectMake(0, 77, kScreenWidth, kScreenHeigth-77);
//    [self.view addSubview:self.hosFilTabVC.view];
    
    
    UIView *view = [[UIView alloc]initWithFrame:self.view.frame];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    
}

//换一组
- (void)changegroup:(UIButton *)sender {
    [self requestData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 77;

    }else {
        return 70;
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    SarchDetailViewController *saVC = [[SarchDetailViewController alloc]init];
    UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:saVC];
    
    saVC.receiveMark = @"1";
    saVC.resualt = searchBar.text;
    [self presentViewController:naNC animated:YES completion:^{
        
    }];
    
    
    
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    return YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 137;
}






- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PromiseHosViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
  
    FindHosModel *model = self.dataArray[indexPath.row];
    
    
    cell.hosNameLabel.text = model.name;
    cell.zhenLabel.text = model.zhen;
    cell.rankLabel.text = model.rank;
    cell.ybLabel.text = model.yb;
    cell.phoneLabel.text = model.phone;
    cell.introduceLabel.text = model.introduce;
    cell.commentLabel.text = [NSString stringWithFormat:@"%ld",model.comment_num];
    cell.dunLabel.text = model.dun;
    
    NSString *str = [NSString stringWithFormat:urlPicture,model.photo];
    [cell.photoImage sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:nil];
    
    cell.contentView.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:247/255.0 alpha:1];
    
    
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    cell.bgView.layer.cornerRadius = 4.0;
    cell.bgView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    
    cell.bgView.layer.shadowColor = [UIColor lightGrayColor].CGColor;//shadowColor阴影颜色
    cell.bgView.layer.shadowOffset = CGSizeMake(0,2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    cell.bgView.layer.shadowOpacity = 0.5;//阴影透明度，默认0
    cell.bgView.layer.shadowRadius = 4;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    hosHomePageVC *hosVC = [[hosHomePageVC alloc]init];
    
    UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:hosVC];
    
    FindHosModel *model =self.dataArray[indexPath.row];

    hosVC.receiver = model.cid;
    
    [self presentViewController:naNC animated:YES completion:^{
        
    }];



}




//-(void)endRefresh{
//    [self.tableView.mj_header endRefreshing];
//    [self.tableView.mj_footer endRefreshing];
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
