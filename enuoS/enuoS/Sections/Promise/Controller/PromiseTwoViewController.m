//
//  PromiseTwoViewController.m
//  enuoS
//
//  Created by apple on 16/7/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "PromiseTwoViewController.h"
#import "WJDropdownMenu.h"
#import "FindHosModel.h"
#import "PromiseHosViewCell.h"
#import "Macros.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
#import "DeskModel.h"
#import <MJRefresh.h>
#import "DeskTwoModel.h"
#import "HosViewController.h"


@interface PromiseTwoViewController ()<UITableViewDelegate,UITableViewDataSource,WJMenuDelegate>

@property (nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *allHosDataArray;

@property (nonatomic,weak)WJDropdownMenu *menu;//下拉列表


//医生信息
@property (nonatomic,assign)NSInteger num;
@property (nonatomic,copy)NSString *dep_id;
@property (nonatomic,copy)NSString *sdep_id;
@property (nonatomic,copy)NSString *sort_order;//类型排序
//
@property (nonatomic,strong)NSMutableArray *secondDataArray;
@property (nonatomic,strong)NSMutableArray *secondPIDArray;
@property (nonatomic,strong)NSMutableArray *secondIdArray;


//
@property (nonatomic,strong)NSMutableArray *firstDataArray;
@property (nonatomic,strong)NSMutableArray *firstImageArray;
@property (nonatomic,strong)NSMutableArray *firstIdArray;



@end

@implementation PromiseTwoViewController

- (NSMutableArray *)allHosDataArray{
    if (!_allHosDataArray) {
        self.allHosDataArray = [NSMutableArray array];
    }return _allHosDataArray;
}

- (NSMutableArray *)firstDataArray{
    if (!_firstDataArray) {
        self.firstDataArray = [NSMutableArray array];
    }return _firstDataArray;
}

- (NSMutableArray *)firstIdArray{
    if (!_firstIdArray) {
        self.firstIdArray = [NSMutableArray array];
    }return _firstIdArray;
}

- (NSMutableArray *)firstImageArray{
    if (!_firstImageArray) {
        self.firstImageArray = [NSMutableArray array];
        
    }return _firstImageArray;
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

- (NSMutableArray *)secondDataArray{
    if (!_secondDataArray) {
        self.secondDataArray = [NSMutableArray array];
    }return _secondDataArray;
}

- (NSMutableArray *)secondIdArray{
    if (!_secondIdArray) {
        self.secondIdArray = [NSMutableArray array];
    }return _secondIdArray;
}

- (NSMutableArray *)secondPIDArray{
    if (!_secondPIDArray) {
        self.secondPIDArray = [NSMutableArray array];
    }return _secondPIDArray;
}







- (void)viewDidLoad {
    [super viewDidLoad];
      [SVProgressHUD show];
    self.num = 1;
    self.sdep_id = @"";
    self.dep_id = @"";
      [self requestDeskData];
        [self requestAllHosData];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PromiseHosViewCell" bundle:nil] forCellReuseIdentifier:@"Hoscell"];
    self.tableView.frame = CGRectMake(0, 40, kScreenWidth, kScreenHeigth-155);
    [self.view addSubview:self.tableView];
    self.navigationController.navigationBar.translucent = NO;
    // 创建menu
    WJDropdownMenu *menu = [[WJDropdownMenu alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    menu.delegate = self;
    
    //  设置代理
    [self.view addSubview:menu];
    self.menu = menu;
    // 设置属性(可不设置)
    menu.caverAnimationTime = 0.2;             //  增加了展开动画时间设置   不设置默认是  0.15
    menu.hideAnimationTime = 0.2;              //  增加了缩进动画时间设置   不设置默认是  0.15
    menu.menuTitleFont = 12;                   //  设置menuTitle字体大小    不设置默认是  11
    menu.tableTitleFont = 11;                  //  设置tableTitle字体大小   不设置默认是  10
    menu.cellHeight = 38;                      //  设置tableViewcell高度   不设置默认是  40
    menu.menuArrowStyle = menuArrowStyleSolid; //  旋转箭头的样式(空心箭头 or 实心箭头)
    menu.tableViewMaxHeight = 200;             //  tableView的最大高度(超过此高度就可以滑动显示)
    menu.menuButtonTag = 100;                  //  menu定义了一个tag值如果与本页面的其他button的值有冲突重合可以自定义设置
    menu.CarverViewColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];//设置遮罩层颜色
    menu.selectedColor = [UIColor redColor];   //  选中的字体颜色
    menu.unSelectedColor = [UIColor grayColor];//  未选中的字体颜色
    // 第二中方法net网络请求一级一级导入数据，先在此导入菜单数据，然后分别再后面的net开头的代理方法中导入一级一级子菜单的数据
    NSArray *twoMenuTitleArray =@[ @"科室"];
    [menu netCreateMenuTitleArray:twoMenuTitleArray];
    
    
    //[self creatSegement];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    //默认【上拉加载】
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];


}
- (void)refresh{
    //NSLog(@"你是个大逗逼");
    [self.allHosDataArray removeAllObjects];
    _num = 1;
    [self requestAllHosData];
}

- (void)loadMore{
    // NSLog(@"都比都比");
    _num ++;
    [self requestAllHosData];
}




#pragma mark ---------menu 代理的方法 返回点击时对应得index

- (void)menuCellDidSelected:(NSInteger)MenuTitleIndex firstIndex:(NSInteger)firstIndex secondIndex:(NSInteger)secondIndex thirdIndex:(NSInteger)thirdIndex{
    

        
        
        self.dep_id  = [NSString stringWithFormat:@"%@",self.secondPIDArray[(long)MenuTitleIndex]];
        self.sdep_id  = [NSString stringWithFormat:@"%@",self.secondIdArray[(long)secondIndex]];
        
        

    [self.allHosDataArray removeAllObjects];
    [self requestAllHosData];
    
    
};
#pragma mark -- 代理方法2 返回点击时对应的内容
- (void)menuCellDidSelected:(NSString *)MenuTitle firstContent:(NSString *)firstContent secondContent:(NSString *)secondContent thirdContent:(NSString *)thirdContent{
    //
    //    NSLog(@"菜单title:%@       一级菜单:%@         二级子菜单:%@    三级子菜单:%@",MenuTitle,firstContent,secondContent,thirdContent);
    // NSLog(@"222222222222222");
    
//    self.data = [NSMutableArray array];
//    [self.data addObject:[NSString stringWithFormat:@"%@ 的 detail data 1",secondContent]];
//    [self.data addObject:[NSString stringWithFormat:@"%@ 的 detail data 2",secondContent]];
//    [self.data addObject:[NSString stringWithFormat:@"%@ 的 detail data 3",secondContent]];
    [self.tableView reloadData];
    
};

#pragma mark -- net网络获取数据代理方法返回点击时菜单对应的index(导入子菜单数据)
- (void)netMenuClickMenuIndex:(NSInteger)menuIndex menuTitle:(NSString *)menuTitle{
    
    // 模拟网络加载数据延时0.5秒，相当于传一个menuIndex的参数返回数据之后 调用netLoadFirstArray方法，将网络请求返回数据导入一级数据到菜单
    
   
   

        
        [self.menu netLoadFirstArray:self.firstDataArray FirstImageArray:self.firstImageArray];

    
    
}

#pragma mark -- net网络获取数据代理方法返回点击时菜单和一级子菜单分别对应的index(导入子菜单数据)
- (void)netMenuClickMenuIndex:(NSInteger)menuIndex menuTitle:(NSString *)menuTitle FirstIndex:(NSInteger)FirstIndex firstContent:(NSString *)firstContent{
    
    // 模拟网络加载数据延时0.5秒，相当于传menuIndex、FirstIndex的两个参数返回数据之后，调用 netLoadSecondArray 方法，将网络请求返回数据导入二级数据到菜单
    
    
    NSLog(@"firstIndex = %ld",(long)FirstIndex);
    [self.secondDataArray removeAllObjects];
    [self.secondIdArray removeAllObjects];
    [self.secondPIDArray removeAllObjects];
    // self.secondDataArray = [NSMutableArray arrayWithObject:@"全部"];
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        
        
        [self requestDeskDetailDataWith:self.firstIdArray[FirstIndex]];
        NSLog(@"self.secondArray = %@",self.secondDataArray);
        //NSArray  *secondArrTwo = @[@"a二级菜单21",@"a二级菜单22"];
        
        
        
        
   
    // });
}



- (void)requestDeskData{
    NSString *str = @"http://www.enuo120.com/index.php/app/index/find_keshi";
    
    BaseRequest *request = [[BaseRequest alloc]init];
    [request POST:str params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [self handleWithDeskWithData:responseObject];

    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}






- (void)handleWithDeskWithData:(NSDictionary *)data{
    
    
    NSArray *arr = data[@"data"];
    for (NSDictionary *temp in arr) {
        DeskModel *model = [DeskModel deskModelInitWithDic:temp];
        
        [self.firstImageArray addObject:model.photo];
        [self.firstIdArray addObject:model.cid];
        [self.firstDataArray addObject:model.department];
    }
    if (self.firstIdArray.count != 0) {
        
        
    }
    
    
    // NSLog(@"self.firstDataArray = %@",self.firstDataArray);
}

//科室分类

- (void)requestDeskDetailDataWith:(NSString *)Cid{
    NSString *str = @"http://www.enuo120.com/index.php/App/index/get_sdep_list";
    
    NSString *strHeader =  [NSString stringWithFormat:@"dep_id=%@",Cid];
    NSDictionary *heardBody = @{@"dep_id":Cid};
    NSLog(@"strHeader = %@",strHeader);
    
    
    BaseRequest *request = [[BaseRequest alloc]init];
    [request POST:str params:heardBody success:^(NSURLSessionDataTask *task, id responseObject) {
        [self handleDataWithDeskDetailWith:responseObject];
        [self.menu netLoadSecondArray:self.secondDataArray];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}


- (void)handleDataWithDeskDetailWith:(NSDictionary *)data{
    
    if ([data[@"data"]isKindOfClass:[NSNull class]]
        ) {
        NSLog(@"无数据");
    }else{
        NSArray *arr = data[@"data"];
        
        
        
        for (NSDictionary *temp in arr) {
            DeskTwoModel *model = [DeskTwoModel deskTwoModelWithDic:temp];
            [self.secondDataArray addObject:model.sDepName];
            [self.secondIdArray addObject:model.cid];
            [self.secondPIDArray addObject:model.PID];
        }
        
    }//[self.tableView reloadData];
    
    
    
}
//请求所有医院的数据
- (void)requestAllHosData{
    NSString *url = @"http://www.enuo120.com/index.php/app/index/find_keshi_hos";
    
    //    NSString *sort = @"sort_order";
    //    NSString *sdep = @"sdep_id";
    //    NSString *dep = @"dep_id";
    NSString * page = [NSString stringWithFormat:@"%ld",(long)self.num];
    NSDictionary *heardBody = @{@"page":page, @"dep_id":self.dep_id,@"sdep_id":self.sdep_id};
    
    BaseRequest *request = [[BaseRequest alloc]init];
    [request POST:url params:heardBody success:^(NSURLSessionDataTask *task, id responseObject) {
        [self handleWithDataWithDoc: responseObject];
        NSLog(@"resp[nde = %@",responseObject);
        [SVProgressHUD dismiss];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
        
}

- (void)handleWithDataWithDoc:(NSDictionary *)data{
    if ([data[@"data"]isKindOfClass:[NSNull class]]
        ) {
        NSLog(@"无数据");
        [self endRefresh];
    }else{
        NSArray *arr = data[@"data"];
        
        
        
        for (NSDictionary *temp in arr) {
            FindHosModel *model = [FindHosModel findHosModelInithWithDic:temp];
            
            [self.allHosDataArray addObject:model];
        }
    }[self.tableView reloadData];
    [self endRefresh];
    
}

- (void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}


#pragma mark -----dataSource ------delegate---------------------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.allHosDataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 210;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PromiseHosViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Hoscell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:247/255.0 alpha:1];
    cell.bgView.layer.cornerRadius = 4.0;
    cell.bgView.layer.borderColor = [UIColor clearColor].CGColor;
    cell.bgView.layer.borderWidth = 1.0;
    
    cell.bgView.layer.shadowColor = [UIColor lightGrayColor].CGColor;//shadowColor阴影颜色
    cell.bgView.layer.shadowOffset = CGSizeMake(0,2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    cell.bgView.layer.shadowOpacity = 0.5;//阴影透明度，默认0
    cell.bgView.layer.shadowRadius = 4;
    FindHosModel *model = self.allHosDataArray[indexPath.row];
       tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    cell.hosNameLabel.text = model.name;
    cell.zhenLabel.text = model.zhen;
    cell.rankLabel.text = model.rank;
    cell.ybLabel.text = model.yb;
    cell.addressLabel.text = model.address;
    cell.illLabel.text = model.ill;
    
    NSString *str = [NSString stringWithFormat:urlPicture,model.photo];
    [cell.photoImage sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:nil];
    

    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HosViewController *hosVC = [[HosViewController alloc]init];
    
    UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:hosVC];
    
    FindHosModel *model =self.allHosDataArray[indexPath.row];
    
    hosVC.receiver = model.cid;
    
    [self presentViewController:naNC animated:YES completion:^{
        
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
