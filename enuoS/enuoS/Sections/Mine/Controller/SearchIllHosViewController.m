//
//  SearchIllHosViewController.m
//  enuoS
//
//  Created by apple on 16/8/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SearchIllHosViewController.h"
#import <AFNetworking.h>
#import "Macros.h"
#import <Masonry.h>
#import <SVProgressHUD.h>
#import "SearchillHosModel.h"
#import "SarchIllHosTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "UIImageView+UIImageView_FaceAwareFill.h"

#import "SearchILLDocController.h"
#import "CFFlowButtonView.h"
#import "UIView+Extension.h"
#import "CFFViewController.h"

#import "UIColor+Extend.h"

#define WIDHT [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface SearchIllHosViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *categoryListArray;
@property (nonatomic,strong)NSMutableArray *treatListArray;
@property (nonatomic,strong)NSMutableArray *mbListArray;
@property (nonatomic,strong)NSMutableArray *hosListArray;

@property (nonatomic, weak)CFFViewController *cffVC;
@property (nonatomic, strong) NSMutableArray *buttonList;

@property (nonatomic,strong)NSArray *hosArr;

@property (nonatomic,strong)UIButton *selectCateBtn;
@property (nonatomic,strong)UIButton *selectTreatBtn;
@property (nonatomic,strong)UIButton *selectHosBtn;

@property (nonatomic,copy)NSString *selectHosId;

@property (nonatomic,assign)BOOL open;


@end

@implementation SearchIllHosViewController

- (UIButton *)selectTreatBtn {
    if (!_selectTreatBtn) {
        _selectTreatBtn = [[UIButton alloc]init];
    }return _selectTreatBtn;
}
- (UIButton *)selectCateBtn {
    if (!_selectCateBtn) {
        _selectCateBtn = [[UIButton alloc]init];
    }return _selectCateBtn;
}
- (UIButton *)selectHosBtn {
    if (!_selectHosBtn) {
        _selectHosBtn = [[UIButton alloc]init];
    }return _selectHosBtn;
}

- (NSArray *)hosArr{
    if (!_hosArr) {
        self.hosArr = [NSArray array];
    }return _hosArr;
}

- (UITableView *)tableView{
    if (!_tableView) {
        self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0,WIDHT, HEIGHT-33) style:UITableViewStyleGrouped];
    }return _tableView;
}


- (NSMutableArray *)categoryListArray{
    if (!_categoryListArray) {
        _categoryListArray = [NSMutableArray array];
    }return _categoryListArray;
}
- (NSMutableArray *)treatListArray{
    if (!_treatListArray) {
        _treatListArray = [NSMutableArray array];
    }return _treatListArray;
}
- (NSMutableArray *)mbListArray{
    if (!_mbListArray) {
        _mbListArray = [NSMutableArray array];
    }return _mbListArray;
}
- (NSMutableArray *)hosListArray{
    if (!_hosListArray) {
        _hosListArray = [NSMutableArray array];
    }return _hosListArray;
}

- (void)customNavView {
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"白色返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleWithBack:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    [titleLable setTextAlignment:NSTextAlignmentCenter];
    [titleLable setTextColor:[UIColor whiteColor]];
    [titleLable setText:self.receiver];
    titleLable.font = [UIFont boldSystemFontOfSize:18];
    self.navigationItem.titleView = titleLable;
    
    self.navigationController.navigationBar.barTintColor = [UIColor stringTOColor:@"#22ccc6"];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)handleWithBack:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self customNavView];
    [SVProgressHUD show];
    [self creatTableView];
    [self requestData];
}

- (void)creatTableView{
    self.tableView.delegate = self;
    self.tableView .dataSource =self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SarchIllHosTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
}

- (void)requestData{
    NSString *url = @"http://www.enuo120.com/index.php/app/search/many_doctor";
    NSDictionary *heardBody = @{@"ill":self.receiver,@"ver":@"1.0"};
    
    BaseRequest *request = [[BaseRequest alloc]init];
    [request POST:url params:heardBody success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        [self handleWithData:responseObject];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}
//筛选请求
- (void)screenOutRequest {
    NSString *url = @"http://www.enuo120.com/index.php/app/search/many_doctor";
    
    if ([self.selectHosBtn.currentTitle isEqualToString:@"全部医院"]) {
        self.selectHosId = @"0";
    }
    
    NSLog(@"%@~~%@~~~%@~~~%@",self.receiver,self.selectCateBtn.currentTitle,self.selectTreatBtn.currentTitle,self.selectHosId);
    
    NSDictionary *heardBody = @{@"ill":self.receiver,@"category":self.selectCateBtn.currentTitle,@"treat":self.selectTreatBtn.currentTitle,@"hid":self.selectHosId,@"ver":@"1.0"};
    
    BaseRequest *request = [[BaseRequest alloc]init];
    [request POST:url params:heardBody success:^(NSURLSessionDataTask *task, id responseObject) {
        [self handleWithData:responseObject];

    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}


- (void)handleWithData:(NSDictionary*)dic{
    if ([dic[@"data"] isKindOfClass:[NSNull class]]) {
        NSLog(@"无数据");
    }else{
    
        NSArray *hosArr = dic[@"data"][@"hos_list"];
        if (![hosArr isEqual:[NSNull null]]) {
            [self.hosListArray removeAllObjects];
            for (int i = 0; i<hosArr.count; i++) {
                SearchillHosModel *model = [SearchillHosModel searchillHosModelInitWithDic:hosArr[i]];
                [self.hosListArray addObject:model];
            }
        }
        
        NSArray *mbArray = dic[@"data"][@"mb_list"];
        
        [self.mbListArray removeAllObjects];

        if (![mbArray isEqual:[NSNull null]]) {
            
            for (int i = 0; i<mbArray.count; i++) {
                SearchillHosModel *model = [SearchillHosModel searchillHosModelInitWithDic:mbArray[i]];
                [self.mbListArray addObject:model];
            }
            NSLog(@"%ld",(long)self.mbListArray.count);
            
        }else {
            NSLog(@"该医院没有所选疾病");
        }
        
        NSArray *categoryArr = dic[@"data"][@"category_list"];
        if (![categoryArr isEqual:[NSNull null]]) {
            [self.categoryListArray removeAllObjects];
            for (NSDictionary *dic in categoryArr) {
                [self.categoryListArray addObject:dic[@"category"]];
            }
        }
        
        NSArray *treateArr = dic[@"data"][@"treat_list"];
        if (![treateArr isEqual:[NSNull null]]) {
            [self.treatListArray removeAllObjects];
            for (NSDictionary *dic in treateArr) {
                [self.treatListArray addObject:dic[@"treat"]];
            }
        }
        
        [self.tableView reloadData];

        
    }
    
    
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 33;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDHT, 33)];
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"筛选";
    label.textColor = [UIColor blackColor];
    [view addSubview:label];
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"筛选展开"];
    [view addSubview:imageView];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view.mas_centerY);
        make.right.equalTo(view.mas_centerX);
    }];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view.mas_centerY);
        make.left.equalTo(view.mas_centerX);
    }];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(screenOut)];
    [view addGestureRecognizer:gesture];
    
    return view;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SearchillHosModel *model = self.mbListArray[indexPath.row];
    SearchILLDocController *sVC = [[SearchILLDocController alloc]init];
    sVC.mb_id = model.ID;
    sVC.illReceiver = model.ill;
    sVC.hid = model.hos_id;
    sVC.category = model.category;
    sVC.treat = model.treat;
    UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:sVC];
    [self presentViewController:naNC animated:YES completion:^{
        
    }];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SarchIllHosTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"SarchIllHosTableViewCell" owner:nil options:nil];
    
    
    if (![array isKindOfClass:[NSNull class]]) {
        
    for (id tempCell in array) {
        if ([tempCell isKindOfClass:[SarchIllHosTableViewCell class]]) {
            cell = tempCell;
        }
    }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.bgView.layer.cornerRadius = 4.0;
    cell.bgView.layer.borderColor = [UIColor clearColor].CGColor;
    cell.bgView.layer.borderWidth = 1.0;
    
    cell.bgView.layer.shadowColor = [UIColor lightGrayColor].CGColor;//shadowColor阴影颜色
    cell.bgView.layer.shadowOffset = CGSizeMake(0,2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    cell.bgView.layer.shadowOpacity = 0.5;//阴影透明度，默认0
    cell.bgView.layer.shadowRadius = 4;
    
    SearchillHosModel *model = self.mbListArray[indexPath.row];
    
    NSString *str = [NSString stringWithFormat:urlPicture,model.photo];
    [cell.photoImageView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:nil];

    cell.illLabel.text = model.ill;
    //价格
    cell.priceLabel.text = [NSString stringWithFormat:@"¥%@-¥%@元",model.lowprice,model.heightprice];
    //
    cell.cycleLabel.text = model.cycle;
    
    cell.hosNameLabel.text = model.hos_name;
    cell.treatLabel.text = model.treat;
    
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 124;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return self.mbListArray.count;
}


//筛选展开
- (void)screenOut {
    
    _open = !_open;
    
    if (_open) {
        
    NSMutableArray *titleArr = [NSMutableArray arrayWithObjects:@"疾病种类:",@"治疗方式:",@"医院:", nil];
        
    CFFViewController *cffVC = [[CFFViewController alloc]initWithTitleList:titleArr withBtnList:self.buttonList];
    self.cffVC = cffVC;
    [self.cffVC.flowButtonView.sureBtn addTarget:self action:@selector(screenOutSureClick:) forControlEvents:UIControlEventTouchUpInside];

    self.cffVC.view.frame = CGRectMake(0, 33, WIDHT, HEIGHT-33-64);
    self.cffVC.view.tag = 100;
    [self.view addSubview:self.cffVC.view];
    }else {
        UIView *view = [self.view viewWithTag:100];
        [view removeFromSuperview];
    }
}
//筛选确认按钮点击事件
- (void)screenOutSureClick:(UIButton *)sender {
    
    UIView *view = [self.view viewWithTag:100];
    [view removeFromSuperview];
    
    [self screenOutRequest];
}
#pragma mark - =======================懒加载=======================
- (NSArray *)listArr {
    
    NSMutableArray *cateArr = [NSMutableArray arrayWithObject:@"详细分类"];
    NSMutableArray *treatArr = [NSMutableArray arrayWithObject:@"治疗方式"];
    NSMutableArray *hosArr = [NSMutableArray arrayWithObject:@"全部医院"];

    for (int i = 0; i<self.categoryListArray.count; i++) {
        [cateArr addObject:self.categoryListArray[i]];
    }
    for (int i = 0; i<self.treatListArray.count; i++) {
        [treatArr addObject:self.treatListArray[i]];
    }
    for (int i = 0; i<self.hosListArray.count; i++) {
        SearchillHosModel *model = self.hosListArray[i];
        [hosArr addObject:model.hos_name];
    }
    
    NSArray *array = @[cateArr,treatArr,hosArr];
    
    return array;
}
- (NSMutableArray *)buttonList {
    
    if (_buttonList == nil) {
        _buttonList = [NSMutableArray array];
        
        NSArray *listArr = [self listArr];
        
        for (int i = 0; i<listArr.count; i++) {
            
            NSArray *currenArr = listArr[i];
            
            NSMutableArray *array = [NSMutableArray array];
            
            for (int j = 0; j < currenArr.count; j++) {
                
                NSString *str = currenArr[j];
                
                CGRect rect = [str boundingRectWithSize:CGSizeMake(1000, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
                
                UIButton *button = [[[NSBundle mainBundle] loadNibNamed:@"MyButton" owner:self options:nil] lastObject];
                button.layer.borderWidth = 1;
                button.layer.borderColor = [[UIColor blackColor]CGColor];
                button.tag = 1000*i+j;
                button.titleLabel.font = [UIFont systemFontOfSize:13];
                [button setTitle:[NSString stringWithFormat:@"%@",currenArr[j]] forState:UIControlStateNormal];
                
                button.width = rect.size.width+5;
                
                [button addTarget:self action:@selector(smallBtnClick:) forControlEvents:UIControlEventTouchUpInside];

                if ( i == 0 && j == 0) {
                    self.selectCateBtn = button;
                    button.backgroundColor = [UIColor stringTOColor:@"#00afa1"];
                }else if (i == 1 && j == 0) {
                    self.selectTreatBtn = button;
                    button.backgroundColor = [UIColor stringTOColor:@"#00afa1"];
                }else if (i == 2 && j == 0){
                    self.selectHosBtn = button;
                    button.backgroundColor = [UIColor stringTOColor:@"#00afa1"];
                }
                
                [array addObject:button];
            }
            
            [_buttonList addObject:array];
        }
    }
    return _buttonList;
}
//筛选里的小Btn
- (void)smallBtnClick:(UIButton *)sender {
    
    
    if (sender.tag<1000) {//疾病种类
        self.selectCateBtn.backgroundColor = [UIColor whiteColor];
        self.selectCateBtn = sender;
    }else if (1000<=sender.tag && sender.tag<2000) {//治疗方式
        self.selectTreatBtn.backgroundColor = [UIColor whiteColor];
        self.selectTreatBtn = sender;
    }else if (sender.tag>=2000){//医院
        self.selectHosBtn.backgroundColor = [UIColor whiteColor];
        self.selectHosBtn = sender;
        
        if (sender.tag == 2000) {//全部医院
            self.selectHosId = @"0";
        }else {
            SearchillHosModel *model = self.hosListArray[sender.tag-2000-1];
            self.selectHosId = model.hos_id;
        }
        
    }
    
    sender.backgroundColor = [UIColor stringTOColor:@"#00afa1"];


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

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
