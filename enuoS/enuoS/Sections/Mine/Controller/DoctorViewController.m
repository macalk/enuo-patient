//
//  DoctorViewController.m
//  enuoS
//
//  Created by apple on 16/7/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "DoctorViewController.h"

#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "DocOrderViewController.h"
#import <UIImageView+WebCache.h>
#import "Macros.h"
#import "UIImageView+UIImageView_FaceAwareFill.h"
#import "DocModel.h"
#import <Masonry.h>
#import "HosDocEvaViewController.h"
#import "UIColor+Extend.h"
#import "BaseRequest.h"

#import <NIMKit.h>
@interface DoctorViewController ()<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate,UIScrollViewDelegate>

@property (nonatomic,copy)NSString *docToken;
@property (nonatomic,copy)NSString *docUsename;
@property (nonatomic,copy)NSString *lock;
@property (nonatomic,copy)NSString *levePj;
@property (nonatomic,copy)NSString *servierPj;
@property (nonatomic,strong)NSArray *contentarr;
@property (nonatomic,copy)NSString *plNum;
@property (nonatomic,copy)NSString *hosId;
@property (nonatomic,copy)NSString *docId;

@property (nonatomic,strong)UIPageControl *pageControl;

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArray;


@property (nonatomic,strong)UIView *headerView;
@property (nonatomic,strong)UIImageView *headerImage;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *leveLabel;
@property (nonatomic,strong)UILabel *deskLabel;
@property (nonatomic,strong)UILabel *addressLabel;
@property (nonatomic,strong)UILabel *nuoLabel;
@property (nonatomic,strong)UILabel *commentLable;
@property (nonatomic,strong)UIImageView *attentionImage;

@property (nonatomic,strong)NSArray *markArray;
@property (nonatomic,strong)NSMutableArray *markOneArray;
@property (nonatomic,strong)NSMutableArray *markTwoArray;
@property (nonatomic,strong)UILabel *oneLabel;
@property (nonatomic,strong)UILabel *twoLabel;


@property (nonatomic,strong)NSMutableArray *weekListArray;
@property (nonatomic,strong)NSMutableArray *dayListArray;

@property (nonatomic,copy)NSString *oneStr;
@property (nonatomic,copy)NSString *twoStr;
@property (nonatomic,copy)NSString *threeStr;


@property (nonatomic,assign)BOOL oneS;

@property (nonatomic,assign)BOOL twoS;
@property (nonatomic,assign)BOOL threeS;




@end



UIButton *attentionBtn;

@implementation DoctorViewController

- (NSMutableArray *)weekListArray {
    if (!_weekListArray) {
        _weekListArray = [NSMutableArray array];
    }return _weekListArray;
}

- (NSMutableArray *)dayListArray {
    if (!_dayListArray) {
        _dayListArray = [NSMutableArray array];
    }return _dayListArray;
}


- (NSArray *)contentarr{
    if (!_contentarr) {
        _contentarr = [NSArray array];
    }return _contentarr;
}


- (NSMutableArray *)markOneArray{
    if (!_markOneArray) {
        _markOneArray  = [NSMutableArray array];
    }return _markOneArray;
}
- (NSMutableArray *)markTwoArray{
    if (!_markTwoArray) {
        _markTwoArray = [NSMutableArray array];
    }return _markTwoArray;
}
- (UILabel *)oneLabel{
    if (!_oneLabel) {
        _oneLabel = [[UILabel alloc]init];
    }return _oneLabel;
}

- (UILabel *)twoLabel{
    if (!_twoLabel) {
        _twoLabel = [[UILabel alloc]init];
    }return _twoLabel;
}

- (NSArray *)markArray{
    if (!_markArray) {
        _markArray = [NSArray array];
    }return _markArray;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        
    }return _dataArray;
}

- (void)customNavView {
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"白色返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleWithBack:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    [titleLable setTextAlignment:NSTextAlignmentCenter];
    [titleLable setTextColor:[UIColor whiteColor]];
    [titleLable setText:@"医生主页"];
    titleLable.font = [UIFont boldSystemFontOfSize:18];
    self.navigationItem.titleView = titleLable;
    
    self.navigationController.navigationBar.barTintColor = [UIColor stringTOColor:@"#22ccc6"];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //判断是否已经完善信息
    [self getCenterRequest];
    
    [self customNavView];
    
    self.oneS = YES;
    self.twoS = YES;
    self.threeS = YES;
    self.oneStr =@"1";
    self.twoStr = @"1";
    self.threeStr = @"1";
    
    [SVProgressHUD show];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *name = [userDefaults objectForKey:@"name"];
    NSLog(@"name = %@",name);
    
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
    
    self.navigationController.toolbarHidden=NO;
    self.view.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0];
    [self creatHeadView];
    [self creattableView];
    [self creatToolBar];
    [self requestData];
    
    NSLog(@"self.receiver = %@",self.receiver);
}
- (void)handleWithBack:(UIBarButtonItem *)sender{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (void)creatWorkHeaderView{
    
    UIView *tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 170)];
    tableHeaderView.backgroundColor = [UIColor stringTOColor:@"#fff4de"];
    self.tableView.tableHeaderView = tableHeaderView;
    

    //创建pageControl
    self.pageControl = [[UIPageControl alloc]init];
    [tableHeaderView addSubview:self.pageControl];
    self.pageControl.numberOfPages = 3;
    self.pageControl.currentPage = 0;
    self.pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(tableHeaderView.mas_bottom);
        make.centerX.equalTo(tableHeaderView.mas_centerX);
    }];
    
    
    //创建scrollview
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 151)];
    scrollView.contentSize = CGSizeMake(kScreenWidth*3, 0);
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    [tableHeaderView addSubview:scrollView];
    
    
    UILabel *docMarkLabel = [[UILabel alloc]init];
    docMarkLabel.text = @"值 班 表";
    docMarkLabel.textAlignment = NSTextAlignmentCenter;
    [docMarkLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:13]];
    docMarkLabel.frame = CGRectMake(kScreenWidth/2-50, 5, 100, 20);
    [tableHeaderView addSubview:docMarkLabel];

        /*****创建3个时间表的bgview*****/
        //横间距
        float hDistance = (kScreenWidth-20)/8;
        
        for (int i = 0; i<3; i++) {
            NSArray *weekArray = self.weekListArray[i];
            NSArray *dayArray = self.dayListArray[i];
            
            UIView *weekView = [[UIView alloc]init];
            weekView.frame = CGRectMake(kScreenWidth*i, 30, kScreenWidth, 100);
            weekView.backgroundColor = [UIColor clearColor];
            [scrollView addSubview:weekView];
            
            for (int i = 0; i<9; i++) {
                //竖线
                UILabel *Vline = [[UILabel alloc]init];
                Vline.frame = CGRectMake(10+hDistance*i, 0, 1, 100);
                Vline.backgroundColor = [UIColor lightGrayColor];
                [weekView addSubview:Vline];
            }
            for (int i = 0; i<4; i++) {
                //横线
                UILabel *Hline = [[UILabel alloc]init];
                Hline.backgroundColor = [UIColor lightGrayColor];
                [weekView addSubview:Hline];
                if (i == 0) {
                    Hline.frame = CGRectMake(10, 0, kScreenWidth-20, 1);
                }else {
                    Hline.frame = CGRectMake(10, 40+(i-1)*30, kScreenWidth-20, 1);
                }
            }
            
            //排版 上午 下午
            NSArray *hintArr = @[@"排班",@"上午",@"下午"];
            for ( int i= 0; i<3; i++) {
                UILabel *label = [[UILabel alloc]init];
                label.text = hintArr[i];
                label.font = [UIFont systemFontOfSize:13];
                label.textAlignment = NSTextAlignmentCenter;
                [weekView addSubview:label];
                if (i == 0) {
                    label.frame = CGRectMake(10, 0, hDistance, 40);
                }else {
                    label.frame = CGRectMake(10, 40+30*(i-1), hDistance, 30);
                }
            }
            
            //周几 几号
            for (int j =0; j<7; j++) {
                UILabel *weekLabel = [[UILabel alloc]init];
                weekLabel.font = [UIFont systemFontOfSize:12];
                weekLabel.textAlignment = NSTextAlignmentCenter;
                weekLabel.text = weekArray[j];
                weekLabel.frame = CGRectMake(10+hDistance+hDistance*j, 0, hDistance, 20);
                [weekView addSubview:weekLabel];
                
                UILabel *dateLabel = [[UILabel alloc]init];
                dateLabel.font = [UIFont systemFontOfSize:11];
                dateLabel.textColor = [UIColor lightGrayColor];
                dateLabel.textAlignment = NSTextAlignmentCenter;
                dateLabel.text = dayArray[j];
                dateLabel.frame = CGRectMake(10+hDistance+hDistance*j, 20, hDistance, 20);
                [weekView addSubview:dateLabel];
            }
            
            //坐诊
            for (int j = 0; j<14; j++) {
                UIButton *button = [[UIButton alloc]init];
                [button setTitle:@"坐诊" forState:normal];
                button.titleLabel.font = [UIFont systemFontOfSize:13];
                [button setTitleColor:[UIColor blackColor] forState:normal];
                button.frame = CGRectMake(10+hDistance+hDistance*(j%7), 40+30*(j/7), hDistance, 30);
                button.tag = 100*i+j;
                [button addTarget:self action:@selector(diagnoseButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                [weekView addSubview:button];
            }
            
            
        }
        /***********/
    
}
//出诊btn点击事件
- (void)diagnoseButtonClick:(UIButton *)sender {
    
}

// scrollview的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (![scrollView isKindOfClass:[UITableView class]]) {
        self.pageControl.currentPage = scrollView.contentOffset.x/kScreenWidth;
    }
    
}

//  时间表
- (void)handleWithTapG:(UITapGestureRecognizer *)sender{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *name = [userDefault objectForKey:@"name"];
    if (name !=nil) {
        DocModel *model = self.dataArray[0];
        
        DocOrderViewController *docVC = [[DocOrderViewController alloc]init];
        
        UINavigationController *naNC  = [[UINavigationController alloc]initWithRootViewController:docVC];
//        docVC.didReceiver = model.cid;
        [self presentViewController:naNC animated:YES completion:^{
            
        }];
    }else{
        
        
//        //[self.dataArray addObject:model];
//        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请先登录账号" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
//            [alert show];
//        }else{
//            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"请先登录账号" preferredStyle:UIAlertControllerStyleAlert];
//            [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                
//            }]];
//            [self presentViewController:alertView animated:YES completion:^{
//                
//            }];
//            
//        }
        NSLog(@"qunimade ");
        
        
    }

}


//头部
- (void)creatHeadView{
    
    UIView *headerView = [[UIView alloc]init];
    headerView.frame = CGRectMake(0, 65, kScreenWidth, 73);
    [self.view addSubview:headerView];
    
    self.headerImage = [[UIImageView alloc]init];
    self.nameLabel = [[UILabel alloc]init];
    self.leveLabel = [[UILabel alloc]init];
    self.deskLabel = [[UILabel alloc]init];
    self.nuoLabel = [[UILabel alloc]init];
    self.addressLabel = [[UILabel alloc]init];
    self.commentLable = [[UILabel alloc]init];
    
    UIImageView *nuoImage = [[UIImageView alloc]init];//诺
    UIImageView *commentImage = [[UIImageView alloc]init];//评论
    UIImageView *attentionImage = [[UIImageView alloc]init];//关注
    self.attentionImage = attentionImage;
    _headerImage.layer.borderColor = [UIColor grayColor].CGColor;
    headerView.backgroundColor = [UIColor whiteColor];
    _headerImage.layer.borderWidth = 0.5;
    _headerImage.layer.cornerRadius = 26.0;
    
    _headerImage.clipsToBounds = YES;

    [headerView addSubview:nuoImage];
    [headerView addSubview:commentImage];
    [headerView addSubview:attentionImage];
    [headerView addSubview:self.headerImage];//头像
    [headerView addSubview:self.nameLabel];//名字
    [headerView addSubview:self.leveLabel];//主任医师
    [headerView addSubview:self.deskLabel];//科室
    [headerView addSubview:self.nuoLabel];//诺
    [headerView addSubview:self.addressLabel];//地址
    [headerView addSubview:self.commentLable];//评论
    self.nameLabel.font = [UIFont systemFontOfSize:13];
    self.leveLabel.font =[UIFont systemFontOfSize:10];
    self.deskLabel.font = [UIFont systemFontOfSize:10];
    self.nuoLabel.font = [UIFont systemFontOfSize:9];
    self.addressLabel.font = [UIFont systemFontOfSize:10];
    self.commentLable.font = [UIFont systemFontOfSize:9];
    self.leveLabel.textColor = [UIColor stringTOColor:@"#666666"];
    self.deskLabel.textColor = [UIColor stringTOColor:@"#666666"];
    self.addressLabel.textColor = [UIColor stringTOColor:@"#666666"];


    nuoImage.image = [UIImage imageNamed:@"点诺"];
    commentImage.image = [UIImage imageNamed:@"形状-1-拷贝"];
    if (self.like == 1) {
        attentionImage.image = [UIImage imageNamed:@"关注-s"];

    }else {
        attentionImage.image = [UIImage imageNamed:@"关注"];

    }

    headerView.layer.borderWidth = 1.0;
    headerView.layer.borderColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0].CGColor;
    __weak typeof(self)  weakSelf = self;
    
    
    [weakSelf.headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_top).with.offset(10);
        make.left.equalTo (headerView.mas_left).with.offset(20);
        make.bottom.equalTo(headerView.mas_bottom).with.offset(-10);
        make.width.mas_equalTo(@53);
        
    }];
    
    [weakSelf.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.headerImage.mas_right).with.offset(10);
        make.top.equalTo(headerView.mas_top).with.offset(10);
        
    }];
    
    [weakSelf.leveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.nameLabel.mas_right).with.offset(10);
        make.bottom.equalTo(weakSelf.nameLabel.mas_bottom).with.offset(0);
        
    }];
    
    
    [weakSelf.deskLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.headerImage.mas_right).with.offset(10);
        make.top.equalTo(weakSelf.nameLabel.mas_bottom).with.offset(7);
        
    }];
    
    [weakSelf.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.deskLabel.mas_left);
        make.top.equalTo(weakSelf.deskLabel.mas_bottom).with.offset(7);
        
    }];
    
    
    [attentionImage mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(headerView.mas_top).with.offset(12);
        make.right.equalTo(headerView.mas_right).with.offset(-19);
        make.size.mas_equalTo(CGSizeMake(20, 16));
        
    }];
    
    
    [commentImage mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(attentionImage.mas_centerY);
        make.right.equalTo(attentionImage.mas_left).with.offset(-15);
        make.size.mas_equalTo(CGSizeMake(19, 17));
        
    }];
    
    [_commentLable mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(commentImage.mas_left).with.offset(13);
        make.top.equalTo(commentImage.mas_top).with.offset(-2);
        make.size.mas_equalTo(CGSizeMake(20, 10));
        
    }];
    
    
    
    
    [nuoImage mas_makeConstraints:^(MASConstraintMaker *make) {
    
//        make.left.equalTo(weakSelf.leveLabel.mas_right).with.offset(5);
        make.centerY.equalTo(commentImage.mas_centerY);
        make.right.equalTo(commentImage.mas_left).with.offset(-20);
        make.size.mas_equalTo(CGSizeMake(18, 18));
        
        
    }];
    [weakSelf.nuoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(nuoImage.mas_right).with.offset(2);
        make.top.equalTo(nuoImage.mas_top);
        make.width.mas_equalTo(@20);
        make.height.mas_equalTo(@10);
      
    }];
    
}

- (void)creattableView{
    self.tableView.frame = CGRectMake(0, 138, kScreenWidth, kScreenHeigth-44-138);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.tableView];
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
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
    }else{
         //self.twoS = NO;
        if ([self.threeStr isEqualToString:@"1"]) {
            return 1;
        }else{
            return 0;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor stringTOColor:@"#fff4de"];
    cell.textLabel.font = [UIFont systemFontOfSize:13.0];
    cell.textLabel.numberOfLines = 0;
    
    if (self.dataArray.count != 0) {
        DocModel *model = self.dataArray[0];
        
        
        if (indexPath.section == 0) {
            cell.textLabel.text = model.ill;
        }else if(indexPath.section==1){
            cell.textLabel.text = model.treatment;
        }else{
            cell.textLabel.text = model.introduce;
        }

    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.dataArray.count !=0) {
        DocModel *model = self.dataArray[0];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14], NSParagraphStyleAttributeName:paragraphStyle.copy};
        
        CGRect rectOne = [model.ill boundingRectWithSize:CGSizeMake(kScreenWidth, 20000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        CGRect rectTwo = [model.treatment boundingRectWithSize:CGSizeMake(kScreenWidth, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        CGRect rectThree = [model.introduce boundingRectWithSize:CGSizeMake(kScreenWidth, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        
        
        
        if (indexPath.section == 0) {
            return rectOne.size.height+20;
        }else if (indexPath.section == 1){
            return rectTwo.size.height+20;
            
        }else{
            return rectThree.size.height+20;
        }

    }else{
        return 0;
    }
  }


//   擅长领域/约定病种/医生简介
- (UIView*)creatadeptWith:(NSString *)image
                    title:(NSString *)title{
    
    UIView *aview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    aview.backgroundColor = [UIColor whiteColor];
    UIImageView *amage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 20, 20)];
    amage.image = [UIImage imageNamed:image];
    [aview addSubview:amage];
    
    
    UILabel *label = [[UILabel alloc]init];
    label.textColor = [UIColor stringTOColor:@"#00b09f"];
    label.font = [UIFont systemFontOfSize:15];
    label.text = title;
    [aview addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(amage.mas_centerY);
        make.left.equalTo(amage.mas_right).with.offset(5);
    }];
    
    return aview;
    
}

- (void)handleadeptSecrion:(UIButton *)sender{
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    self.tableView
        NSIndexSet *set = [NSIndexSet indexSetWithIndex:0];
    
    
    if(self.oneS == YES){
        //记得昨晚操作之后，改变按钮的点击状态
        self.oneStr = @"2";
 
        [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
        //self.registerButton.backgroundColor = [UIColor colorWithRed:0/255.0 green:179/255.0 blue:163/255.0 alpha:1];
        //  self.markStr = @"2";
        self.oneS =NO;
    }else{
        self.oneStr = @"1";
         [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
        
        // self.imageAcc.image = [UIImage imageNamed:@"check"];
        //self.markStr = @"1";
        
        self.oneS = YES;
    }

    
    
    
}




- (void)handleSynSecrion:(UIButton *)sender{
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:1];
    
    
    if(self.twoS ==YES){
        //记得昨晚操作之后，改变按钮的点击状态
        self.twoStr = @"2";
        
        [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
        //self.registerButton.backgroundColor = [UIColor colorWithRed:0/255.0 green:179/255.0 blue:163/255.0 alpha:1];
        //  self.markStr = @"2";
        self.twoS = NO;
    }else{
        self.twoStr = @"1";
        [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
        
        // self.imageAcc.image = [UIImage imageNamed:@"check"];
        //self.markStr = @"1";
        
        self.twoS = YES;
    }

}

- (void)handleillSecrion:(UIButton *)sender{
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:2];
    
    
    if(self.threeS == YES){
        //记得昨晚操作之后，改变按钮的点击状态
        self.threeStr = @"2";
        
        [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
        //self.registerButton.backgroundColor = [UIColor colorWithRed:0/255.0 green:179/255.0 blue:163/255.0 alpha:1];
        //  self.markStr = @"2";
        self.threeS = NO;
    }else{
        self.threeStr = @"1";
        [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade
         ];
        
        // self.imageAcc.image = [UIImage imageNamed:@"check"];
        //self.markStr = @"1";
        self.threeS = YES;
    }

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
       return  [self creatadeptWith:@"约定病种" title:@"约定病种"];
    }else if(section == 1){
        return [self creatadeptWith:@"擅长领域" title:@"擅长领域"];
    }else {
        return [self creatadeptWith:@"医生简介" title:@"医生简介"];
    }
    
    
}
- (void)requestData{
    NSString *str = @"http://www.enuo120.com/index.php/app/doctor/home";
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *username = [userDefault objectForKey:@"name"];
    if (username ==NULL) {
        username = @"";
    }
    NSLog(@"receivre = %@",self.receiver);
      NSDictionary *heardBody = @{@"username":username,@"did":self.receiver,@"ver":@"1.0"};
    
    NSLog(@"%@~~~%@",username,self.receiver);
    BaseRequest *request = [[BaseRequest alloc]init];
    [request POST:str params:heardBody success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"responseObject = %@",responseObject);
        [SVProgressHUD dismiss];
        [self handleWithData:responseObject];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
- (void)handleWithData:(NSDictionary *)dic{
 
    
    
    DocModel *model = [DocModel docModelInitWithData:dic[@"data"]];
    NSString * url = [NSString stringWithFormat:urlPicture,model.photo];
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
    [self.headerImage faceAwareFill];
    
    if (model.comment == 1) {
        self.attentionImage.image = [UIImage imageNamed:@"关注-s"];
    }
    
    self.nameLabel.text = model.name;
    self.leveLabel.text = model.professional;//主治医师
    self.deskLabel.text = model.dep_name;//科室
    self.addressLabel.text = model.hos_name;//医院名字
    self.nuoLabel.text =  model.nuo;
    
    self.hosId = model.hos_id;
    self.docId = model.cid;
    self.docUsename = model.username;
    self.docToken = model.chat_token;
    
    self.commentLable.text = [NSString stringWithFormat:@"%ld",model.comment];
    
    NSDictionary *dataDic = dic[@"data"];
    NSDictionary *listDic = dataDic[@"schedule_list"];
    
    
    NSDictionary *oneWeekListDic = listDic[@"now_list"];
    NSDictionary *twoWeekListDic = listDic[@"one_week_list"];
    NSDictionary *threeWeekListDic = listDic[@"two_week_list"];
    
    
    NSArray *oneAmArray = oneWeekListDic[@"am_list"];
    NSArray *onePmArray = oneWeekListDic[@"pm_list"];
    NSArray *oneWeekListArr  = oneWeekListDic[@"week_list"];
    NSArray *oneDayListArr  = oneWeekListDic[@"day_list"];

    
    NSArray *twoAmArray = twoWeekListDic[@"am_list"];
    NSArray *twoPmArray = twoWeekListDic[@"pm_list"];
    NSArray *twoWeekListArr  = twoWeekListDic[@"week_list"];
    NSArray *twoDayListArr  = twoWeekListDic[@"day_list"];

    NSArray *threeAmArray = threeWeekListDic[@"am_list"];
    NSArray *threePmArray = threeWeekListDic[@"pm_list"];
    NSArray *threeWeekListArr  = threeWeekListDic[@"week_list"];
    NSArray *threeDayListArr  = threeWeekListDic[@"day_list"];
    
    //把三周的坐诊状态和日期放到数组里（上午的放在markOneArray，下午的放在markTwoArray）
    [self.markOneArray addObject:oneAmArray];
    [self.markOneArray addObject:twoAmArray];
    [self.markOneArray addObject:threeAmArray];
    
    [self.markTwoArray addObject:onePmArray];
    [self.markTwoArray addObject:twoPmArray];
    [self.markTwoArray addObject:threePmArray];
    
    //三周的星期数放在数组里
    [self.weekListArray addObject:oneWeekListArr];
    [self.weekListArray addObject:twoWeekListArr];
    [self.weekListArray addObject:threeWeekListArr];
    
    //三周的日期放在数组里
    [self.dayListArray addObject:oneDayListArr];
    [self.dayListArray addObject:twoDayListArr];
    [self.dayListArray addObject:threeDayListArr];
    
    
    if (model.guanzhu == 0) {
        attentionBtn.selected = NO;
        [attentionBtn setImage:[UIImage imageNamed:@"关注-(1)"] forState:UIControlStateNormal];
    }else{
        attentionBtn.selected = YES;
        
        [attentionBtn setImage:[UIImage imageNamed:@"红色关注"] forState:UIControlStateNormal];
    }
    
    [self creatWorkHeaderView];
    
    [self.dataArray addObject:model];
    
    [self.tableView reloadData];
    
    
}


- (void)creatToolBar{
    UIView *toolView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    UIButton *commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    attentionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *consultBtn = [UIButton buttonWithType:UIButtonTypeCustom];//咨询
    UIButton *orderBtn = [UIButton buttonWithType:UIButtonTypeCustom];//预约
   
    consultBtn.backgroundColor = [UIColor colorWithRed:253/255.0 green:171/255.0 blue:0/255.0 alpha:1];
    orderBtn.backgroundColor = [UIColor colorWithRed:0/255.0 green:142/255.0 blue:0/255.0 alpha:1];
    commentBtn.frame = CGRectMake(0, 0, kScreenWidth/6, 64);
    attentionBtn.frame = CGRectMake(kScreenWidth/6, 0, kScreenWidth/6, 64);
    consultBtn.frame = CGRectMake(0, 0, kScreenWidth/2, 44);
    orderBtn.frame = CGRectMake(kScreenWidth/2, 0, kScreenWidth/2, 44);
    [self setOneBtn:commentBtn title:@"评论" image:@"评论"];
    [self setOneBtn:attentionBtn title:@"关注" image:@""];
    [self setTwoBtn:consultBtn title:@"咨询" image:@"qq"];
    [self setTwoBtn:orderBtn title:@"预约" image:@"预约"];

    [commentBtn addTarget:self action:@selector(handleWithComment:) forControlEvents:UIControlEventTouchUpInside];
    [attentionBtn addTarget:self action:@selector(handleWithAttention:) forControlEvents:UIControlEventTouchUpInside];
    [consultBtn addTarget:self action:@selector(handleWithConsultBtn:) forControlEvents:UIControlEventTouchUpInside];
    [orderBtn addTarget:self action:@selector(handleWithOrder:) forControlEvents:UIControlEventTouchUpInside];
    
    
//    [toolView addSubview:commentBtn];
//    [toolView addSubview:attentionBtn];
    [toolView addSubview:consultBtn];
    [toolView addSubview:orderBtn];
    
    [self.navigationController.toolbar addSubview:toolView];
    
}

- (void)setOneBtn:(UIButton *)sender title:(NSString *)title image:(NSString *)image{
    [sender setTitle:title forState:UIControlStateNormal];
    [sender setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
     sender.imageEdgeInsets = UIEdgeInsetsMake(5,20,40,0);//上  左 下 右
      sender.titleEdgeInsets = UIEdgeInsetsMake(-20, -10, -20, 0);
    sender.titleLabel.font = [UIFont systemFontOfSize:13];
    [sender setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
}

- (void)setTwoBtn:(UIButton *)sender title:(NSString *)title image:(NSString *)image{
    [sender setTitle:title forState:UIControlStateNormal];
    [sender setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    sender.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);//上  左 下 右
      sender.titleLabel.font = [UIFont systemFontOfSize:15];
}

//评论按钮
- (void)handleWithComment:(UIButton*)sender{
    HosDocEvaViewController *hosVC = [[HosDocEvaViewController alloc]init];
    UINavigationController *NaVC = [[UINavigationController alloc]initWithRootViewController:hosVC];
    hosVC.markStr = @"2";
    hosVC.pjArr = [NSArray array];
    hosVC.pjArr = self.contentarr;
    hosVC.leve = self.levePj;
    hosVC.service = self.servierPj;
    [self presentViewController:NaVC animated:YES completion:^{
        
    }];
}

//关注按钮
- (void)handleWithAttention:(UIButton *)sender{
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *name = [userDefault objectForKey:@"name"];
    if (name != nil) {
        
        if(sender.isSelected == NO){
            //记得昨晚操作之后，改变按钮的点击状态
            [self requestDataGz];
        }else{
            
     
            // self.imageAcc.image = [UIImage imageNamed:@"check"];
            //self.markStr = @"1";
            
            [self requestDataGz];
        }
        
        
    }else{
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请先登录账号" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
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


- (void)requestDataGz{
    NSString *url = @"http://www.enuo120.com/index.php/app/patient/guanzhu";
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *name = [userDefault objectForKey:@"name"];
   
    NSString *a = [[NSString alloc]init];
    if (attentionBtn.selected ==NO) {
        a = @"1";
    }else{
        a = @"0";
    }
    NSDictionary *heardBody = @{@"username":name,@"did":self.receiver,@"type":a};

    BaseRequest *request = [[BaseRequest alloc]init];
    [request POST:url params:heardBody success:^(NSURLSessionDataTask *task, id responseObject) {
        [self handelWithGuanZhuData:responseObject];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
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
    
    if ([dic[@"data"][@"message"] isEqualToString:@"医生关注成功"]) {
        [attentionBtn setImage:[UIImage imageNamed:@"红色关注"] forState:UIControlStateNormal];
        attentionBtn.selected =YES;
    }else if([dic[@"data"][@"message"] isEqualToString:@"医生取消关注成功"]){
        [attentionBtn setImage:[UIImage imageNamed:@"关注-(1)"] forState:UIControlStateNormal];
        attentionBtn.selected = NO;
    }else{
        NSLog(@"lalalallalallallalal");
    }
    
}

//咨询按钮
- (void)handleWithConsultBtn:(UIButton *)sender{
    //名字
    NSString *mz = [[NSUserDefaults standardUserDefaults]objectForKey:@"mz"];
    
    if ([self.lock integerValue] != 1) {
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        UIView *bigView = [[UIView alloc]initWithFrame:window.bounds];
        bigView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        [window addSubview:bigView];
        
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请先完善用户信息" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [bigView removeFromSuperview];
        }];
        
        [alertVC addAction:sureAction];
        [self presentViewController:alertVC animated:YES completion:nil];
        
        
    }else {
        NSString *token = [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
        
        if (token == nil) {
            [self registUserNameWithName:mz];
        }else {
            
            NSString *username = [[NSUserDefaults standardUserDefaults]objectForKey:@"name"];
            NSLog(@"%@<<<<",username);
            NSString *accid = [NSString stringWithFormat:@"%@-patient",username];
            //登录云信
            [[[NIMSDK sharedSDK] loginManager] login:accid
                                               token:token
                                          completion:^(NSError *error) {
                                              NSLog(@"error===%@",error);
                                              
                                              NSString *sessionID = [NSString stringWithFormat:@"%@-doctor",self.docUsename];
                                              
                                              if (error == nil) {
                                                  NIMSession *session = [NIMSession session:sessionID type:NIMSessionTypeP2P];
                                                  NIMSessionViewController *vc = [[NIMSessionViewController alloc] initWithSession:session];
                                                  
                                                  vc.hidesBottomBarWhenPushed = YES;
                                                  
                                                  [self.navigationController pushViewController:vc animated:YES];
                                              }else {
                                                  NSLog(@"客服~~~~~~~");
                                              }
                                              
                                          }];
            
        }
        
    }
    
}
//预约按钮
- (void)handleWithOrder:(UIButton *)sender{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *name = [userDefault objectForKey:@"name"];
    if (name !=nil) {
        
        NSLog(@"hos_id == %@",self.hosId);
        
        DocOrderViewController *docVC = [[DocOrderViewController alloc]init];
        docVC.hosId = self.hosId;
        docVC.hosName = self.addressLabel.text;
        docVC.docId = self.docId;
        docVC.docName = self.nameLabel.text;
        
        docVC.view.backgroundColor = [UIColor whiteColor];
        UINavigationController *naNC  = [[UINavigationController alloc]initWithRootViewController:docVC];

        [self presentViewController:naNC animated:YES completion:^{
            
        }];
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


//注册IM账号
- (void)registUserNameWithName:(NSString *)name {
    
    NSString *username = [[NSUserDefaults standardUserDefaults]objectForKey:@"name"];
    NSLog(@"%@<<<<",username);
    NSString *accid = [NSString stringWithFormat:@"%@-patient",username];
    
    NSLog(@"accid==%@",accid);
    
    NSString *url = @"http:www.enuo120.com/index.php/app/chat/create_user";
    
    NSDictionary *dic = @{@"accid":accid,@"name":name};
    
    BaseRequest *request = [[BaseRequest alloc]init];
    
    [request POST:url params:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        [self registUserNameIDDate:responseObject];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"失败0.0");
    }];
}
- (void)registUserNameIDDate:(NSDictionary *)dic {
    NSLog(@"dic == %@",dic);

    if ([dic[@"data"][@"code"] integerValue] == 414) {//已经注册
        NSLog(@"已经注册了~~~~~~~");
        [self changeToken];
    }else {
        NSDictionary *infoDic = dic[@"data"][@"info"];
        NSString *token = infoDic[@"token"];
        NSString *accid = infoDic[@"accid"];
        
        NSLog(@"token==%@",token);
        
        [[NSUserDefaults standardUserDefaults]setObject:token forKey:@"token"];
        
        //登录云信
        [[[NIMSDK sharedSDK] loginManager] login:accid
                                           token:token
                                      completion:^(NSError *error) {
                                          NSLog(@"error===%@",error);
                                          
                                          if (error == nil) {
                                              
                                              NSString *sessionID = [NSString stringWithFormat:@"%@-doctor",self.docUsename];
                                              
                                              NIMSession *session = [NIMSession session:sessionID type:NIMSessionTypeP2P];
                                              NIMSessionViewController *vc = [[NIMSessionViewController alloc] initWithSession:session];
                                              
                                              vc.hidesBottomBarWhenPushed = YES;
                                              
                                              [self.navigationController pushViewController:vc animated:YES];
                                          }else {
                                              NSLog(@"客服~~~~~~~");
                                          }

                                      }];
    }
    
}

//获得个人中心，判断是否信息完善
- (void)getCenterRequest {
    NSString *url = @"http://www.enuo120.com/index.php/app/Patient/center";
    
    
    NSUserDefaults *userStand = [NSUserDefaults standardUserDefaults];
    NSString *name = [userStand objectForKey:@"name"];
    BaseRequest *request = [[BaseRequest alloc]init];
    if (name) {
        NSDictionary *hearBody = @{@"username":name};
        [request POST:url params:hearBody success:^(NSURLSessionDataTask *task, id responseObject) {
            
            [self getCenterData:responseObject];
            
        } fail:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
        
    }else{
    }

}
- (void)getCenterData:(NSDictionary *)dic {
    NSLog(@"%@",dic);
    
    self.lock = dic[@"data"][@"lock"];
    
    NSLog(@"1111");
}


//更新token
- (void)changeToken {
    
    NSString *url = @"http://www.enuo120.com/index.php/app/chat/update_user_token";
    
    
    NSUserDefaults *userStand = [NSUserDefaults standardUserDefaults];
    NSString *name = [userStand objectForKey:@"name"];
    NSString *accid = [NSString stringWithFormat:@"%@-patient",name];
    
    BaseRequest *request = [[BaseRequest alloc]init];
    
    NSDictionary *hearBody = @{@"accid":accid};
    [request POST:url params:hearBody success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [self changeTokenData:responseObject];
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}
- (void)changeTokenData:(NSDictionary *)dic {
    NSDictionary *infoDic = dic[@"data"][@"info"];
    NSString *token = infoDic[@"token"];
    [[NSUserDefaults standardUserDefaults]setObject:token forKey:@"token"];
}


//判断医生是否已经注册
- (void)requestDoctorData {
    NSString *urlStr = @"http://www.enuo120.com/index.php/app/doctor/center";
    NSDictionary *dic = @{@"username":self.docUsename};
    BaseRequest *request = [[BaseRequest alloc]init];
    [request POST:urlStr params:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        [self dataOfRequeset:responseObject];
        
        if ([responseObject[@"data"][@"chat_token"] isKindOfClass:[NSNull class]]) {
        }
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (void)dataOfRequeset:(NSDictionary *)dic {
    
//    NSString *accid = [NSString stringWithFormat:@"%@-doctor",self.docUsename];
    
    NSLog(@"docDic === %@",dic);
    
    NSString *docToken = dic[@"data"][@"chat_token"];
    
    if ([docToken isKindOfClass:[NSNull class]]) {
        [self registDoctorUserNameWithName:self.nameLabel.text];
    }
    
}

//注册IM账号
- (void)registDoctorUserNameWithName:(NSString *)name {
    
    NSString *accid = [NSString stringWithFormat:@"%@-doctor",self.docUsename];
    
    NSString *url = @"http://www.enuo120.com/index.php/app/chat/create_user";
    
    NSDictionary *dic = @{@"accid":accid,@"name":name};
    
    BaseRequest *request = [[BaseRequest alloc]init];
    
    [request POST:url params:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        [self registDoctorUserNameIDDate:responseObject];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"失败0.0");
    }];
}
- (void)registDoctorUserNameIDDate:(NSDictionary *)dic {
    NSLog(@"docDic ---- %@",dic);
    
    NSDictionary *infoDic = dic[@"data"][@"info"];
    NSString *docToken = infoDic[@"token"];
    self.docToken = docToken;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
