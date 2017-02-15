//
//  PromisesViewController.m
//  enuoS
//
//  Created by apple on 16/7/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "PromisesViewController.h"
#import "WJDropdownMenu.h"
#import "Macros.h"
#import <AFNetworking.h>
#import "DeskModel.h"
#import "DeskTwoModel.h"

#import "PromiseHosViewCell.h"
#import "PromiseDocViewCell.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>

#import <MJRefresh.h>
#import "FindDocModel.h"
#import "DoctorViewController.h"

@interface PromisesViewController ()<UITableViewDelegate,UITableViewDataSource,WJMenuDelegate>

@property (strong,nonatomic)UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)UIView *sectionView;

@property (nonatomic,strong)NSMutableArray *firstDataArray;
@property (nonatomic,strong)NSMutableArray *firstImageArray;
@property (nonatomic,strong)NSMutableArray *firstIdArray;

@property (nonatomic,strong)NSMutableArray *data;

@property (nonatomic,weak)WJDropdownMenu *menu;

@property (nonatomic,strong)NSMutableArray *secondDataArray;
@property (nonatomic,strong)NSMutableArray *secondPIDArray;
@property (nonatomic,strong)NSMutableArray *secondIdArray;

@property (nonatomic,strong)NSArray *thrirdDataArray;

@property (nonatomic,strong)NSMutableArray *allDocDataArray;

@property (nonatomic,strong)UIView *aheaderView;


//医生信息
@property (nonatomic,assign)NSInteger num;
@property (nonatomic,copy)NSString *dep_id;
@property (nonatomic,copy)NSString *sdep_id;
@property (nonatomic,copy)NSString *sort_order;//类型排序
//

@property (nonatomic,strong)NSMutableDictionary *IdDic;
@property (nonatomic,strong)NSMutableDictionary *pIdDic;
@property (nonatomic,strong)NSMutableDictionary *dataDic;
@end

@implementation PromisesViewController

- (UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc]init];
    }return _tableView;
}



- (UIView *)headerView{
    if (!_aheaderView) {
        self.aheaderView = [[UIView alloc]init];
    }return _aheaderView;
}


- (NSMutableArray *)allDocDataArray{
    if (!_allDocDataArray) {
        self.allDocDataArray = [NSMutableArray array];
    }return _allDocDataArray;
}



- (NSMutableDictionary *)dataDic{
    if (!_dataDic) {
        self.dataDic = [NSMutableDictionary dictionary];
    }return _dataDic;
}
- (NSMutableDictionary *)IdDic{
    if (!_IdDic) {
        self.IdDic = [NSMutableDictionary dictionary];
    }return _IdDic;
}

- (NSMutableDictionary *)pIdDic{
    if (!_pIdDic) {
        self.pIdDic = [NSMutableDictionary dictionary];
    }return _pIdDic;
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

- (NSMutableArray *)firstDataArray{
    if (!_firstDataArray) {
        self.firstDataArray = [NSMutableArray array];
    }return _firstDataArray;
}



- (NSArray *)thrirdDataArray{
    if (!_thrirdDataArray) {
        self.thrirdDataArray = [NSArray array];
    }return _thrirdDataArray;
}



- (UIView *)sectionView{
    if (!_sectionView) {
        self.sectionView = [[UIView alloc]init];
        
    }
    return _sectionView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
      [SVProgressHUD show];
    self.sort_order = @"0";
    self.dep_id = @"";
    self.sdep_id = @"";
   // NSLog(@"self.stor+dep = %@",self.dep_id);
    //self.secondDataArray = [NSMutableArray arrayWithObject:@"全部"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航条底图"] forBarMetrics:0];
        [self.tableView registerNib:[UINib nibWithNibName:@"PromiseDocViewCell" bundle:nil] forCellReuseIdentifier:@"Doccell"];
    self.num = 1;
    [self requestDeskData];
    [self requestAllDocData];
    self.tableView.frame = CGRectMake(0, 40, kScreenWidth, kScreenHeigth-155);
    [self.view addSubview:self.tableView];
    //  如果是有导航栏请清除自动适应设置
    // self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    //NSArray *threeMenuTitleArray =  @[@"菜单A",@"菜单B"];
    
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
    NSArray *twoMenuTitleArray = @[@"排序",@"科室"];
    [menu netCreateMenuTitleArray:twoMenuTitleArray];
    
    
    //[self creatSegement];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    //默认【上拉加载】
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];

}


- (void)refresh{
    //NSLog(@"你是个大逗逼");
    [self.allDocDataArray removeAllObjects];
    _num = 1;
    [self requestAllDocData];
}

- (void)loadMore{
    // NSLog(@"都比都比");
    _num ++;
    [self requestAllDocData];
}


- (void)hideMenu{
    //  点击收缩menu
    [self.menu drawBackMenu];
}





#pragma mark -- 代理方法1 返回点击时对应的index


- (void)menuCellDiDSelected:(NSInteger)MenuTitleIndex firstIndex:(NSInteger)firstIndex{
    
    
    
    
    NSLog(@"firstttttttttttttttttt = %ld",(long)firstIndex);
    //[self requestDeskDetailDataWith:self.firstIdArray[firstIndex]];
    
}

- (void)menuCellDidSelected:(NSInteger)MenuTitleIndex firstIndex:(NSInteger)firstIndex secondIndex:(NSInteger)secondIndex thirdIndex:(NSInteger)thirdIndex{
    
    
    if (secondIndex==-1) {
        self.sort_order = [NSString stringWithFormat:@"%ld",(long)MenuTitleIndex];
//        NSLog(@"22222222222222222222222");
    }else{
        

       self.dep_id  = [NSString stringWithFormat:@"%@",self.secondPIDArray[(long)MenuTitleIndex]];
       self.sdep_id  = [NSString stringWithFormat:@"%@",self.secondIdArray[(long)secondIndex]];
//        NSLog(@"self.ssssdep_id = %@",self.sdep_id);
//        NSLog(@"self.ddddddep_id = %@",self.dep_id);
        
    }
    [self.allDocDataArray removeAllObjects];
    [self requestAllDocData];

 
};



#pragma mark -- 代理方法2 返回点击时对应的内容
- (void)menuCellDidSelected:(NSString *)MenuTitle firstContent:(NSString *)firstContent secondContent:(NSString *)secondContent thirdContent:(NSString *)thirdContent{
    //
//    NSLog(@"菜单title:%@       一级菜单:%@         二级子菜单:%@    三级子菜单:%@",MenuTitle,firstContent,secondContent,thirdContent);
    // NSLog(@"222222222222222");
    
    self.data = [NSMutableArray array];
    [self.data addObject:[NSString stringWithFormat:@"%@ 的 detail data 1",secondContent]];
    [self.data addObject:[NSString stringWithFormat:@"%@ 的 detail data 2",secondContent]];
    [self.data addObject:[NSString stringWithFormat:@"%@ 的 detail data 3",secondContent]];
    [self.tableView reloadData];
    
};

#pragma mark -- 代理方法3 返回点击时对应的内容和index(合并了方法1和方法2)
- (void)menuCellDidSelected:(NSString *)MenuTitle menuIndex:(NSInteger)menuIndex firstContent:(NSString *)firstContent firstIndex:(NSInteger)firstIndex secondContent:(NSString *)secondContent secondIndex:(NSInteger)secondIndex thirdContent:(NSString *)thirdContent thirdIndex:(NSInteger)thirdIndex{
    
    
    NSLog(@"菜单title:%@  titleIndex:%ld,一级菜单:%@    一级菜单Index:%ld,     二级子菜单:%@   二级子菜单Index:%ld   三级子菜单:%@  三级子菜单Index:%ld",MenuTitle,(long)menuIndex,firstContent,(long)firstIndex,secondContent,(long)secondIndex,thirdContent,thirdIndex);
    
    
}

// ------------------------------------------  以下是网络点击联动的代理方法可在此一级一级的导入数据，测试方法请打开 if 0 -------------------


#pragma mark -- net网络获取数据代理方法返回点击时菜单对应的index(导入子菜单数据)
- (void)netMenuClickMenuIndex:(NSInteger)menuIndex menuTitle:(NSString *)menuTitle{
    
    // 模拟网络加载数据延时0.5秒，相当于传一个menuIndex的参数返回数据之后 调用netLoadFirstArray方法，将网络请求返回数据导入一级数据到菜单
    
    if (menuIndex == 0) {
        
        NSArray *firstArrTwo = [NSArray arrayWithObjects:@"诺",@"服务",@"技术",@"价格", nil];
          NSArray *firstImageArrTwo = [NSArray arrayWithObjects:@"点诺",@"服务",@"技术",@"价格", nil];
        [self.menu netLoadFirstArray:firstArrTwo FirstImageArray:firstImageArrTwo];
        
        
    }
    if (menuIndex == 1) {
        
        [self.menu netLoadFirstArray:self.firstDataArray FirstImageArray:self.firstImageArray];
    }
    
    
}


#pragma mark -- net网络获取数据代理方法返回点击时菜单和一级子菜单分别对应的index(导入子菜单数据)
- (void)netMenuClickMenuIndex:(NSInteger)menuIndex menuTitle:(NSString *)menuTitle FirstIndex:(NSInteger)FirstIndex firstContent:(NSString *)firstContent{
    
    // 模拟网络加载数据延时0.5秒，相当于传menuIndex、FirstIndex的两个参数返回数据之后，调用 netLoadSecondArray 方法，将网络请求返回数据导入二级数据到菜单
    
    
   // NSLog(@"firstIndex = %ld",FirstIndex);
    [self.secondDataArray removeAllObjects];
    [self.secondIdArray removeAllObjects];
    [self.secondPIDArray removeAllObjects];
    // self.secondDataArray = [NSMutableArray arrayWithObject:@"全部"];
  //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    if (menuIndex == 1) {
        
        
        [self requestDeskDetailDataWith:self.firstIdArray[FirstIndex]];
       // NSLog(@"self.secondArray = %@",self.secondDataArray);
        //NSArray  *secondArrTwo = @[@"a二级菜单21",@"a二级菜单22"];
        
        
        
        
    }else{
        [self.menu netLoadSecondArray:nil];
    }
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
   // NSLog(@"strHeader = %@",strHeader);
    
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
//请求所有医生的数据
- (void)requestAllDocData{
    NSString *url = @"http://www.enuo120.com/index.php/app/index/find_keshi_doc";
    
//    NSString *sort = @"sort_order";
//    NSString *sdep = @"sdep_id";
//    NSString *dep = @"dep_id";
    NSString * page = [NSString stringWithFormat:@"%ld",(long)self.num];
    NSDictionary *heardBody = @{@"page":page,@"sort_order":self.sort_order, @"dep_id":self.dep_id,@"sdep_id":self.sdep_id};
    
    BaseRequest *request = [[BaseRequest alloc]init];
    [request POST:url params:heardBody success:^(NSURLSessionDataTask *task, id responseObject) {
        [self handleWithDataWithDoc: responseObject];
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
           FindDocModel *model = [FindDocModel findDocModelInitWithDic:temp];
            
            [self.allDocDataArray addObject:model];
          
         
        }
    }[self.tableView reloadData];
    [self endRefresh];

}


- (void)creatSegement{
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:@[@"医生",@"医院"]];
    segment.frame = CGRectMake(0, 0, 120, 30);
    self.navigationItem.titleView = segment;
    segment.selectedSegmentIndex = 0;
    segment.tintColor =  [UIColor colorWithRed:0/255.0 green:179/255.0 blue:163/255.0 alpha:1];
    [segment addTarget:self action:@selector(handleChangeSegmentWithValue:) forControlEvents:UIControlEventValueChanged];
}
- (void)handleChangeSegmentWithValue:(UISegmentedControl *)sender{
    switch (sender.selectedSegmentIndex) {
        case 0:
            NSLog(@"汤五爷在此");
            break;
        case 1:
            NSLog(@"汤五爷走了");
            break;
        default:
            break;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSLog(@"self.allDocDataArray.count = %ld",(unsigned long)self.allDocDataArray.count);
    return self.allDocDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PromiseDocViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Doccell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:247/255.0 alpha:1];
    
 
   tableView.separatorStyle = UITableViewCellSelectionStyleNone;
 
   // [cell.contentView addSubview:imageD9];
    cell.bgView.layer.cornerRadius = 4.0;
    cell.bgView.layer.borderColor = [UIColor whiteColor].CGColor;
    //cell.bgView.layer.borderWidth = 1.0;
    
    
    cell.bgView.layer.shadowColor = [UIColor lightGrayColor].CGColor;//shadowColor阴影颜色
    cell.bgView.layer.shadowOffset = CGSizeMake(0,2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    cell.bgView.layer.shadowOpacity = 0.5;//阴影透明度，默认0
    cell.bgView.layer.shadowRadius = 4;
    FindDocModel *model = self.allDocDataArray[indexPath.row];
    cell.nameLabel.text = model.name;
    cell.nuoNumber.text = model.nuo;
    
    NSString *str0ne = [NSString stringWithFormat:urlPicture,model.photo];
    
    cell.illLabel.text = model.ill;
    
    [cell.photoImage sd_setImageWithURL:[NSURL URLWithString:str0ne] placeholderImage:nil];
    NSLog(@"model.professinaol = %@",model.professional);
    cell.proLabel.text = model.professional;
    cell.deskLabel.text = model.dep_name;
    cell.pepLaebl.text = model.zhen;
    cell.hosLabel.text = model.hos_name;
    
    return  cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DoctorViewController *docVC = [[DoctorViewController alloc]init];
    
    
    UINavigationController *navNC = [[UINavigationController alloc]initWithRootViewController:docVC];
    FindDocModel *monder = self.allDocDataArray[indexPath.row];
    docVC.receiver = monder.cid;
    
    [self presentViewController:navNC animated:YES completion:^{
        
    }];

}
#pragma mark- cell 将要显示的时候调用这个方法，就在这个方法内进行圆角绘制
/**
 本质：就是修改cell的背景view，这个view的layer层自己分局cell的类型（顶，底和中间）来绘制*/
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([cell respondsToSelector:@selector(tintColor)])
//    {
//        CGFloat cornerRadius = 5.f;//圆角大小
//        cell.backgroundColor = [UIColor clearColor];
//        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
//        CGMutablePathRef pathRef = CGPathCreateMutable();
//        CGRect bounds = CGRectInset(cell.bounds, 10, 0);
//        BOOL addLine = NO;
//        
//        if (indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1)
//        {
//            CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
//            
//        }
//        else if (indexPath.row == 0)
//        {   //最顶端的Cell（两个向下圆弧和一条线）
//            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
//            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
//            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
//            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
//            addLine = YES;
//        }
//        else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1)
//        {   //最底端的Cell（两个向上的圆弧和一条线）
//            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
//            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
//            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
//            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
//        }
//        else
//        {   //中间的Cell
//            CGPathAddRect(pathRef, nil, bounds);
//            addLine = YES;
//        }
//        layer.path = pathRef;
//        CFRelease(pathRef);
//        layer.fillColor = [UIColor whiteColor].CGColor; //cell的填充颜色
//        layer.strokeColor = [UIColor lightGrayColor].CGColor; //cell 的边框颜色
//        
//        if (addLine == YES) {
//            CALayer *lineLayer = [[CALayer alloc] init];
//            CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
//            lineLayer.frame = CGRectMake(CGRectGetMinX(bounds), bounds.size.height-lineHeight, bounds.size.width, lineHeight);
//            lineLayer.backgroundColor = [UIColor lightGrayColor].CGColor;        //绘制中间间隔线
//            [layer addSublayer:lineLayer];
//        }
//        
//        UIView *bgView = [[UIView alloc] initWithFrame:bounds];
//        [bgView.layer insertSublayer:layer atIndex:0];
//        bgView.backgroundColor = UIColor.clearColor;
//        cell.backgroundView = bgView;
//    }
//}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  180;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

@end
