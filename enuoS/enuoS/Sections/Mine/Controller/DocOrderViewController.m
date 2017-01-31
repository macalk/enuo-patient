//
//  DocOrderViewController.m
//  enuoS
//
//  Created by apple on 16/8/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "DocOrderViewController.h"
#import "Macros.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "illListModel.h"
#import "DocOrderModel.h"
#import "IllListDetailModel.h"
#import "LrdAlertTabeleView.h"
#import "UIColor+Extend.h"
#import "PerfectViewController.h"

#import "BaseRequest.h"

#import <Masonry.h>
#import "DocModel.h"

//使用第三方点击lable展开列表
#import "MLMOptionSelectView.h"
#import "UIView+Category.h"
#import "CustomCell.h"

#import "SZKAlterView.h"

typedef NS_ENUM(NSUInteger, TTGState) {
    TTGStateOK = 0,
    TTGStateError = 1,
    TTGStateUnknow = 2,
};

@interface DocOrderViewController ()<UIAlertViewDelegate,UITableViewDelegate,UITableViewDataSource,LrdAlertTableViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIScrollViewDelegate,UIPageViewControllerDelegate,UIPageViewControllerDataSource>

@property (nonatomic,strong)BaseRequest *request;
@property (nonatomic,strong)DocModel *model;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)NSMutableArray *illDataArray;
@property (nonatomic,strong)NSMutableArray *illDetailArray;
@property (nonatomic,strong)NSMutableArray *illIDArray;
@property (nonatomic,strong)NSMutableArray *categoryArray;

@property (nonatomic,strong)NSMutableArray *deskDataArray;
@property (nonatomic,strong)NSMutableArray *depIdDataArray;
@property (nonatomic,strong)NSMutableArray *sunDeskDataArray;
@property (nonatomic,strong)NSMutableArray *sunDeskIdArray;
@property (nonatomic,strong)NSMutableArray *treatArray;



@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,assign)NSInteger *rrr;

@property (nonatomic,strong)UILabel *hosTextlabel;
@property (nonatomic,strong)UILabel *nameTextlabel;
@property (nonatomic,strong)UILabel *deskTextLabel;
@property (nonatomic,strong)UILabel *deskSunTextLabel;
@property (nonatomic,strong)UILabel *illTextLabel;
@property (nonatomic,strong)UILabel *typeTextLabel;
@property (nonatomic,strong)UILabel *styleTextLabel;

@property (nonatomic,strong)UIButton *illBtn;
@property (nonatomic,strong)UILabel *priceTextLabel;


@property (nonatomic,strong)UILabel *cycleTextLabel;

@property (nonatomic,strong)UILabel *effectTextLabel;

@property (nonatomic,strong)UILabel *classifyTextLabel;//详细分类
@property (nonatomic,strong)UILabel *cureWayTextLabel;// 治疗方式

@property (nonatomic,strong)UILabel *priceLabel;
@property (nonatomic,strong)UILabel *cycleLabel;
@property (nonatomic,strong)UILabel *effectLabel;
@property (nonatomic,strong)UIView *topView;
@property (nonatomic,strong)UIView *bottomView;



@property (nonatomic,strong)NSDictionary *nsDic;

@property (nonatomic,assign)NSInteger sss;//判断哪周
@property (nonatomic,strong)UILabel *docMarkLabel;
@property (nonatomic,strong)UIView *bView;


@property (nonatomic,copy)NSString *timeStr;
@property (nonatomic,copy)NSString *currentDepId;
@property (nonatomic,copy)NSString *currentSelectDate;



@property (nonatomic,assign)NSInteger headerHeight;

@property (nonatomic,strong)UIButton *oneBtn;
@property (nonatomic,strong)UIButton *twoBtn;
@property (nonatomic,strong)UIButton *selectBtn;

@property (nonatomic,strong)UIPageControl *pageControl;

@property (nonatomic,strong)NSMutableArray *oneWeekSelectArr;
@property (nonatomic,strong)NSMutableArray *twoWeekSelectArr;
@property (nonatomic,strong)NSMutableArray *threeWeekSelectArr;


@property (nonatomic,strong)NSMutableArray *weekListArray;
@property (nonatomic,strong)NSMutableArray *dayListArray;

@property (nonatomic,strong)NSMutableArray *markOneArray;
@property (nonatomic,strong)NSMutableArray *markTwoArray;

@property (nonatomic,strong)UIView *tableHeadView;

@property (nonatomic,assign) BOOL showEffect;//判断是否出现了预约疾病


//使用第三方点击lable展开列表
@property (nonatomic, strong) MLMOptionSelectView *cellView;


@end

@implementation DocOrderViewController
- (UIView *)tableHeadView {
    if (!_tableHeadView) {
        _tableHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    }return _tableHeadView;
}
- (NSMutableArray *)illIDArray {
    if (!_illIDArray) {
        _illIDArray = [NSMutableArray array];
    }return _illIDArray;
}
- (UILabel *)classifyTextLabel {
    if (!_classifyTextLabel) {
        _classifyTextLabel = [[UILabel alloc]init];
    }return _classifyTextLabel;
}
- (UILabel *)cureWayTextLabel {
    if (!_cureWayTextLabel) {
        _cureWayTextLabel = [[UILabel alloc]init];
    }return _cureWayTextLabel;
}
- (NSMutableArray *)weekListArray {
    if (!_weekListArray) {
        _weekListArray = [NSMutableArray array];
    }return _weekListArray;
}
- (NSMutableArray *)dayListArray {
    if (!_dayListArray) {
        _dayListArray = [NSMutableArray array];
    }return _dayListArray;
}- (NSMutableArray *)markOneArray {
    if (!_markOneArray) {
        _markOneArray = [NSMutableArray array];
    }return _markOneArray;
}- (NSMutableArray *)markTwoArray {
    if (!_markTwoArray) {
        _markTwoArray = [NSMutableArray array];
    }return _markTwoArray;
}

- (NSMutableArray *)treatArray {
    if (!_treatArray) {
        _treatArray = [NSMutableArray array];
    }return _treatArray;
}

- (NSMutableArray *)categoryArray {
    if (!_categoryArray) {
        _categoryArray = [NSMutableArray array];
    }return _categoryArray;
}

- (NSMutableArray *)oneWeekSelectArr {
    if (!_oneWeekSelectArr) {
        _oneWeekSelectArr = [[NSMutableArray alloc]init];
    }return _oneWeekSelectArr;
}

- (NSMutableArray *)twoWeekSelectArr {
    if (!_twoWeekSelectArr) {
        _twoWeekSelectArr = [[NSMutableArray alloc]init];
    }return _twoWeekSelectArr;
}

- (NSMutableArray *)threeWeekSelectArr {
    if (!_threeWeekSelectArr) {
        _threeWeekSelectArr = [[NSMutableArray alloc]init];
    }return _threeWeekSelectArr;
}


- (NSMutableArray *)deskDataArray {
    if (!_deskDataArray) {
        _deskDataArray = [NSMutableArray array];
    }return _deskDataArray;
}

- (NSMutableArray *)depIdDataArray {
    if (!_depIdDataArray) {
        _depIdDataArray = [NSMutableArray array];
    }return _depIdDataArray;
}

- (NSMutableArray *)sunDeskDataArray {
    if (!_sunDeskDataArray) {
        _sunDeskDataArray = [NSMutableArray array];
    }return _sunDeskDataArray;
}

- (NSMutableArray *)sunDeskIdArray {
    if (!_sunDeskIdArray) {
        _sunDeskIdArray = [NSMutableArray array];
    }return _sunDeskIdArray;
}

- (NSDictionary *)nsDic{
    if (!_nsDic) {
        self.nsDic = [NSDictionary dictionary];
    }return _nsDic;
}


- (UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc]init];
    }return _tableView;
}


- (UIView *)bView{
    if (!_bView) {
        self.bView = [[UIView alloc]init];
        
    }return _bView;
}


- (UILabel *)hosTextlabel{
    if (!_hosTextlabel) {
        self.hosTextlabel = [[UILabel alloc]init];
        
    }return _hosTextlabel;
}

- (UILabel *)nameTextlabel{
    if (!_nameTextlabel) {
        self.nameTextlabel = [[UILabel alloc]init];
        
    }return _nameTextlabel;
}

- (UILabel *)deskTextLabel {
    if (!_deskTextLabel) {
        _deskTextLabel = [[UILabel alloc]init];
    }return _deskTextLabel;
}

- (UILabel *)deskSunTextLabel {
    if (!_deskSunTextLabel) {
        _deskSunTextLabel = [[UILabel alloc]init];
    }return _deskSunTextLabel;
}

- (UILabel *)illTextLabel {
    if (!_illTextLabel) {
        _illTextLabel = [[UILabel alloc]init];
    }return _illTextLabel;
}

- (UILabel *)typeTextLabel {
    if (!_typeTextLabel) {
        _typeTextLabel = [[UILabel alloc]init];
    }return _typeTextLabel;
}

- (UILabel *)styleTextLabel {
    if (!_styleTextLabel) {
        _styleTextLabel = [[UILabel alloc]init];
    }return _styleTextLabel;
}

- (UILabel *)priceTextLabel{
    if (!_priceTextLabel) {
        self.priceTextLabel = [[UILabel alloc]init];
    }return _priceTextLabel;
}


- (UILabel *)cycleTextLabel{
    if (!_cycleTextLabel) {
        self.cycleTextLabel = [[UILabel alloc]init];
    }return _cycleTextLabel;
}

- (UILabel *)effectTextLabel{
    if (!_effectTextLabel) {
        self.effectTextLabel = [[UILabel alloc]init];
    }return _effectTextLabel;
}

- (UIButton *)illBtn{
    if (!_illBtn) {
        self.illBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }return _illBtn;
}
- (UIButton *)selectBtn {
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }return _selectBtn;
}
- (NSMutableArray *)illDetailArray{
    if (!_illDetailArray) {
        self.illDetailArray = [NSMutableArray array];
    }return _illDetailArray;
}

- (NSMutableArray *)illDataArray{
    if (!_illDataArray) {
        self.illDataArray = [NSMutableArray array];
    }return _illDataArray;
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
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _cellView = [[MLMOptionSelectView alloc] initOptionView];
    
    self.currentDepId = self.dep_id;
    
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleLable.text  = @"预约";
    [titleLable setTextColor:[UIColor stringTOColor:@"#00b09f"]];
    titleLable.font = [UIFont boldSystemFontOfSize:18];
    titleLable.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLable;
    
    self.request = [[BaseRequest alloc]init];
    [self requestData];//请求网页信息
    [self requestDeskData];//请求科室信息

    
    for (int i = 0; i<14; i++) {
        [self.oneWeekSelectArr addObject:@"NO"];
        [self.twoWeekSelectArr addObject:@"NO"];
        [self.threeWeekSelectArr addObject:@"NO"];
    }
    
    if ([self.VIP isEqualToString:@"VIP"]) {
        [self requestAppointWithIllID:self.illID];
    }
    
}

- (void)handleWithBack:(UIBarButtonItem *)dic{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)creatbleView{
    
    self.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeigth);
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView.backgroundColor = [UIColor redColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 700;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return [self creatTopView];
}


//第一个区头
- (UIView *)creatTopView{
    
    UIView *oneView = [[UIView alloc]init];
    
    oneView.frame = CGRectMake(0, 64, kScreenWidth,700);
    
    self.topView = oneView;
    oneView.userInteractionEnabled = YES;
    oneView.backgroundColor = [UIColor whiteColor];
    UILabel *hosLabel = [[UILabel alloc]init];//医院
    UILabel *docLabel = [[UILabel alloc]init];//医生
    UILabel *illLabel = [[UILabel alloc]init];//疾病
    UILabel *effectLabel = [[UILabel alloc]init];//约定效果
    UILabel *classifyLabel = [[UILabel alloc]init];//详细分类
    UILabel *cureWayLabel = [[UILabel alloc]init];//治疗方式
    UILabel *priceLabel = [[UILabel alloc]init];//约定价格
    UILabel *cycleLabel = [[UILabel alloc]init];//约定周期
    UILabel *deskLabel = [[UILabel alloc]init];//科室
    UILabel *deskSunLabel = [[UILabel alloc]init];//子科室
    
    
    hosLabel.font = [UIFont systemFontOfSize:14];
    hosLabel.text = @"预约医院:";
    docLabel.font = [UIFont systemFontOfSize:14];
    docLabel.text = @"预约医生:";
    illLabel.font = [UIFont systemFontOfSize:14];
    illLabel.text = @"疾       病:";
    effectLabel.font = [UIFont systemFontOfSize:14];
    effectLabel.text = @"约定疗效:";
    self.effectLabel = effectLabel;
    classifyLabel.font = [UIFont systemFontOfSize:14];
    classifyLabel.text = @"详细分类:";
    cureWayLabel.font = [UIFont systemFontOfSize:14];
    cureWayLabel.text = @"治疗方式:";
    priceLabel.font = [UIFont systemFontOfSize:14];
    priceLabel.text = @"约定价格:";
    self.priceLabel = priceLabel;
    cycleLabel.font = [UIFont systemFontOfSize:14];
    cycleLabel.text = @"约定周期:";
    self.cycleLabel = cycleLabel;
    deskLabel.font = [UIFont systemFontOfSize:14];
    deskLabel.text = @"预约科室:";
    deskSunLabel.font = [UIFont systemFontOfSize:14];
    deskSunLabel.text = @"子  科  室:";

    
    self.priceTextLabel.font = [UIFont systemFontOfSize:14];
    
    self.cycleTextLabel.font = [UIFont systemFontOfSize:14];
    
    self.classifyTextLabel.font = [UIFont systemFontOfSize:14];
    self.classifyTextLabel.text = self.classify;
    self.cureWayTextLabel.font = [UIFont systemFontOfSize:14];
    self.cureWayTextLabel.text = self.cureWay;
    self.effectTextLabel.font = [UIFont systemFontOfSize:14];
    
    self.hosTextlabel.font = [UIFont systemFontOfSize:14];
    self.hosTextlabel.text = self.hosName;
    self.nameTextlabel.font = [UIFont systemFontOfSize:14];
    self.nameTextlabel.text = self.docName;
    self.deskTextLabel.font = [UIFont systemFontOfSize:13];
    self.deskSunTextLabel.font = [UIFont systemFontOfSize:13];
    self.illTextLabel.font = [UIFont systemFontOfSize:13];
    

    if (_showEffect == NO) {
        self.deskTextLabel.text = @"科  室";
        self.deskSunTextLabel.text = @"子科室";
        self.illTextLabel.text = @"疾  病";
        self.priceTextLabel.text = [NSString stringWithFormat:@"不高于 ¥%@",self.price];
        self.cycleTextLabel.text = self.cycle;
        self.effectTextLabel.text = nil;
    }
    
    [oneView addSubview:hosLabel];
    [oneView addSubview:docLabel];
    [oneView addSubview:illLabel];
    [oneView addSubview:priceLabel];
    [oneView addSubview:cycleLabel];
    [oneView addSubview:effectLabel];
    [oneView addSubview:self.hosTextlabel];
    [oneView addSubview:self.nameTextlabel];
    [oneView addSubview:self.illTextLabel];
    [oneView addSubview:self.priceTextLabel];
    [oneView addSubview:self.cycleTextLabel];
    [oneView addSubview:self.effectTextLabel];
    
    
    if ([self.VIP isEqualToString:@"VIP"]) {
        
        self.illTextLabel.text = self.ill;
        
        
        [oneView addSubview:classifyLabel];
        [oneView addSubview:cureWayLabel];
        
        
        [oneView addSubview:self.classifyTextLabel];
        [oneView addSubview:self.cureWayTextLabel];
        
        
    }else {
        
        if (self.showEffect == NO) {
            
        priceLabel.hidden = YES;
        cycleLabel.hidden = YES;
        effectLabel.hidden = YES;
        self.priceTextLabel.hidden = YES;
        self.cycleTextLabel.hidden = YES;
        self.effectTextLabel.hidden = YES;
            
        }
        /***以上把价格、周期、疗效先隐藏****/
        
        [oneView addSubview:deskLabel];
        [oneView addSubview:deskSunLabel];
        
        [oneView addSubview:self.deskTextLabel];
        [oneView addSubview:self.deskSunTextLabel];
        
        NSArray *array = @[self.deskTextLabel,self.deskSunTextLabel,self.illTextLabel];
        for (int i = 0 ; i<array.count; i++) {
            UILabel *label = array[i];
            label.layer.borderWidth = 1;
            label.layer.borderColor = [[UIColor blackColor]CGColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.05];
            label.userInteractionEnabled = YES;
            
        }
    }
   
    __weak typeof(self) weakSelf = self;
    
    [hosLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(oneView.mas_left).with.offset(10);
        make.top.equalTo (oneView.mas_top).with.offset(10);
     }];
    [weakSelf.hosTextlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(hosLabel);
        make.left.equalTo(hosLabel.mas_right).with.offset(10);
        
    }];

    
    
    [docLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(oneView.mas_left).with.offset(10);
        make.top.equalTo (hosLabel.mas_bottom).with.offset(10);
    }];
    [weakSelf.nameTextlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(docLabel);
        make.left.equalTo(docLabel.mas_right).with.offset(10);
    }];
    
    
    if ([self.VIP isEqualToString:@"VIP"]) {
        
        [illLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(docLabel.mas_right);
            make.top.equalTo(docLabel.mas_bottom).with.offset(10);
        }];
        [self.illTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(illLabel.mas_centerY);
            make.left.equalTo(illLabel.mas_right).with.offset(10);
        }];
        
        [classifyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(illLabel.mas_right);
            make.top.equalTo(illLabel.mas_bottom).with.offset(10);
        }];
        [self.classifyTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(classifyLabel.mas_centerY);
            make.left.equalTo(classifyLabel.mas_right).with.offset(10);
        }];
        
        [cureWayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(classifyLabel.mas_right);
            make.top.equalTo(classifyLabel.mas_bottom).with.offset(10);
        }];
        [self.cureWayTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cureWayLabel.mas_centerY);
            make.left.equalTo(cureWayLabel.mas_right).with.offset(10);
        }];
        
        
        [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(cureWayLabel.mas_right);
            make.top.equalTo(cureWayLabel.mas_bottom).with.offset(10);
        }];
        [self.priceTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(priceLabel.mas_centerY);
            make.left.equalTo(priceLabel.mas_right).with.offset(10);
        }];
        
        
        [cycleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(priceLabel.mas_right);
            make.top.equalTo(priceLabel.mas_bottom).with.offset(10);
        }];
        [self.cycleTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cycleLabel.mas_centerY);
            make.left.equalTo(cycleLabel.mas_right).with.offset(10);
        }];
        
        [effectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(cycleLabel.mas_right);
            make.top.equalTo(cycleLabel.mas_bottom).with.offset(10);
        }];
        [self.effectTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(effectLabel);
            make.left.equalTo(effectLabel.mas_right).with.offset(10);
        }];

        
    }else {
        [deskLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(docLabel.mas_right);
            make.top.equalTo(docLabel.mas_bottom).with.offset(10);
        }];
        [self.deskTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(deskLabel.mas_centerY);
            make.left.equalTo(deskLabel.mas_right).with.offset(10);
            make.width.equalTo(@200);
        }];
        
        [deskSunLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(deskLabel.mas_right);
            make.top.equalTo(deskLabel.mas_bottom).with.offset(10);
        }];
        [self.deskSunTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(deskSunLabel.mas_centerY);
            make.left.equalTo(deskSunLabel.mas_right).with.offset(10);
            make.width.equalTo(@200);
            
        }];
        
        
        
        [illLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(deskSunLabel.mas_right);
            make.top.equalTo (deskSunLabel.mas_bottom).with.offset(10);
        }];
        [self.illTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(illLabel.mas_centerY);
            make.left.equalTo(self.deskSunTextLabel.mas_left);
            make.width.equalTo(@200);
            
        }];
        
        [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(illLabel.mas_right);
            make.top.equalTo(illLabel.mas_bottom).with.offset(10);
        }];
        [self.priceTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(priceLabel.mas_centerY);
            make.left.equalTo(priceLabel.mas_right).with.offset(10);
        }];
        
        
        [cycleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(priceLabel.mas_right);
            make.top.equalTo(priceLabel.mas_bottom).with.offset(10);
        }];
        [self.cycleTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cycleLabel.mas_centerY);
            make.left.equalTo(cycleLabel.mas_right).with.offset(10);
        }];
        [effectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(cycleLabel.mas_right);
            make.top.equalTo(cycleLabel.mas_bottom).with.offset(10);
        }];
        [self.effectTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(effectLabel);
            make.left.equalTo(effectLabel.mas_right).with.offset(10);
        }];

        

    }
    
    /*********以下加载bottomView*********/
    UIView *bottomView = [[UIView alloc]init];
    self.bottomView = bottomView;
    bottomView.userInteractionEnabled = YES;
    bottomView.backgroundColor = [UIColor stringTOColor:@"#fff4de"];
    [oneView addSubview:bottomView];
    
    if (effectLabel.hidden == NO) {
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.effectTextLabel.mas_bottom).with.offset(20);
            make.size.mas_offset(CGSizeMake(kScreenWidth, 200));
        }];
    }else {
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(illLabel.mas_bottom).with.offset(20);
            make.size.mas_offset(CGSizeMake(kScreenWidth, 200));
        }];
    }
    
    
    //创建scrollview
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 151)];
    scrollView.contentSize = CGSizeMake(kScreenWidth*3, 0);
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    [bottomView addSubview:scrollView];
    
    //创建pageControl
    self.pageControl = [[UIPageControl alloc]init];
    [bottomView addSubview:self.pageControl];
    self.pageControl.numberOfPages = 3;
    self.pageControl.currentPage = 0;
    self.pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scrollView.mas_bottom);
        make.centerX.equalTo(bottomView.mas_centerX);
    }];
    
    
    //确认提交按钮
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    sureBtn.layer.cornerRadius = 5;
    sureBtn.clipsToBounds = YES;
    sureBtn.backgroundColor = [UIColor stringTOColor:@"#00afa1"];
    [sureBtn setTitle:@"确认提交" forState:normal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:normal];
    [sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [oneView addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView.mas_bottom).with.offset(10);
        make.centerX.equalTo(bottomView.mas_centerX);
        make.width.mas_offset(@200);
    }];
    
    
    
    
    self.docMarkLabel = [[UILabel alloc]init];
    self.docMarkLabel.text = @"本周";
    self.docMarkLabel.font = [UIFont systemFontOfSize:13];
    [bottomView addSubview:self.docMarkLabel];
    [self.docMarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bottomView.mas_centerX);
        make.top.equalTo(bottomView.mas_top).with.offset(15);
    }];
    
    
    /*****创建3个时间表的bgview*****/
    //横间距
    float hDistance = (kScreenWidth-20)/8;
    
    for (int i = 0; i<3; i++) {
        NSArray *weekArray = self.weekListArray[i];
        NSArray *dayArray = self.dayListArray[i];
        
        UIView *weekView = [[UIView alloc]init];
        weekView.frame = CGRectMake(kScreenWidth*i, 50, kScreenWidth, 100);
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
            [button addTarget:self action:@selector(chuzhenBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [weekView addSubview:button];
        }
        
        
    }
    /***********/
    
    return oneView;
}

- (void)setLableBtn:(UILabel *)label withDataArray:(NSArray *)dataArray {
    WEAK(weakTopB, label);
    WEAK(weaklistArray, dataArray);
    [label tapHandle:^{
        CGRect label3Rect = [MLMOptionSelectView targetView:label];
        NSLog(@"~~~~%ld",(unsigned long)dataArray.count);
        [self defaultCellWithDataArray:dataArray];
        _cellView.arrow_offset = .5;
        _cellView.vhShow = YES;
        _cellView.optionType = MLMOptionSelectViewTypeCustom;
        _cellView.selectedOption = ^(NSIndexPath *indexPath) {//cell 的点击方法
            weakTopB.text = weaklistArray[indexPath.row];
            
            if (label == self.deskTextLabel) {
                [self requestDeskSunDataWithId:self.depIdDataArray[indexPath.row]];
                self.currentDepId = self.depIdDataArray[indexPath.row];
                
                

            }else if (label == self.deskSunTextLabel) {
                [self requestIllDataWithDipId:self.currentDepId withSdepId:self.sunDeskIdArray[indexPath.row]];
                    self.currentSunDeskID = self.sunDeskIdArray[indexPath.row];
                

            }else if (label == self.illTextLabel) {
                    self.illID = self.illIDArray[indexPath.row];
                    [self requestAppointWithIllID:self.illID];
                
                
            }
        };
        
        [_cellView showViewFromPoint:CGPointMake(label3Rect.origin.x, label3Rect.origin.y+label3Rect.size.height) viewWidth:label.bounds.size.width targetView:label direction:MLMOptionSelectViewBottom];
    }];

}
#pragma mark - 设置——cell
- (void)defaultCellWithDataArray:(NSArray *)dataArray {
    WEAK(weaklistArray, dataArray);
    WEAK(weakSelf, self);
    _cellView.canEdit = NO;
    [_cellView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"DefaultCell"];
    _cellView.cell = ^(NSIndexPath *indexPath){
        UITableViewCell *cell = [weakSelf.cellView dequeueReusableCellWithIdentifier:@"DefaultCell"];
        
        if (![weaklistArray[indexPath.row] isEqual:[NSNull null]]) {
            cell.textLabel.text = [NSString stringWithFormat:@"%@",weaklistArray[indexPath.row]];
        }
        
        return cell;
    };
    _cellView.optionCellHeight = ^{
        return 40.f;
    };
    _cellView.rowNumber = ^(){
        NSLog(@"行数：%ld",(unsigned long)weaklistArray.count);
        return (NSInteger)weaklistArray.count;
    };
    
}


//确认提交
- (void)sureBtnClick:(UIButton *)sender {
    [self submitData];
}

- (void)chuzhenBtnClick:(UIButton *)sender {
    
    //0:本周  1：下周  2：下下周
    NSInteger weekNum = sender.tag/100;
    
    
    //单选
    if ([sender.currentTitle isEqualToString:@"坐诊"]) {
        self.selectBtn.backgroundColor = [UIColor clearColor];
        sender.backgroundColor = [UIColor greenColor];
        self.selectBtn = sender;
        
        NSArray *weekAMArray = self.markOneArray[weekNum];//获取周
        if ((sender.tag - 100*weekNum)<7) {//上午
            self.currentSelectDate = [weekAMArray[sender.tag - 100*weekNum] objectForKey:@"date"];
        }else {//下午
            NSArray *weekPMArray = self.markTwoArray[weekNum];
            self.currentSelectDate = [weekPMArray[sender.tag - 100*weekNum-7] objectForKey:@"date"];
        }
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (![scrollView isKindOfClass:[UITableView class]]) {
    NSInteger index = scrollView.contentOffset.x/kScreenWidth;
    self.pageControl.currentPage = index;
    switch (index) {
        case 0:
            self.docMarkLabel.text = @"本周";
            break;
        case 1:
            self.docMarkLabel.text = @"下周";
            break;
        case 2:
            self.docMarkLabel.text = @"下下周";
            break;
            
        default:
            break;
    }
    }
    
}

- (void)handleWithillButton:(UIButton *)sender{
    if (self.dataArray.count == 1) {
        DocOrderModel *model = self.dataArray[0];
       // NSString *str = model.disease;
       // NSLog(@"str = %@",str);
//        self.dataTwoArr = [NSArray array];
//        self.dataTwoArr = [str componentsSeparatedByString:@","];
//        self.dataThreeArr = [model.ill componentsSeparatedByString:@","];
        
        LrdAlertTableView *view = [[LrdAlertTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeigth)];
        //传入数据
        //NSString *ill = @"%@";
        // LrdDateModel *model = [[LrdDateModel alloc]initWithIll:ill];
        view.dataArray = model.ill_list;
        view.mydelegate = self;
        [view pop];
    }
}



//代理返回值

- (void)sendeId:(NSInteger)row{
    //[self reloadCell:2 section:0];
    if (self.dataArray.count != 0) {
       DocOrderModel *model = self.dataArray[0];
//        NSString *str = model.disease;
//        NSLog(@"str = %@",str);
//        self.dataTwoArr = [NSArray array];
//        self.dataTwoArr = [str componentsSeparatedByString:@","];
        
//self.rrr   = row;
        
        // self.threeTextLabel.titleLabel.text = self.dataTwoArr[_rrr];
        [self.illBtn setTitle:model.ill_list[row][@"ill"] forState:UIControlStateNormal];

        [self.illDetailArray removeAllObjects];
        [self requestIllListView:model.ill_list[row][@"cid"]];
        [self.tableView reloadData];

    }
}

//请求data
- (void)requestData{
    NSString *str = @"http://www.enuo120.com/index.php/app/doctor/home";
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *username = [userDefault objectForKey:@"name"];
    if (username ==NULL) {
        username = @"";
    }
    NSLog(@"receivre = %@",self.docId);
    NSDictionary *heardBody = @{@"username":username,@"did":self.docId,@"ver":@"1.0"};
    
    AFHTTPSessionManager *manegr = [AFHTTPSessionManager manager];
    
    [manegr POST:str parameters:heardBody progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject = %@",responseObject);
        [SVProgressHUD dismiss];
        [self handleWithData:responseObject];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
    
}
- (void)handleWithData:(NSDictionary *)dic{
    
    self.model = [DocModel docModelInitWithData:dic[@"data"]];
    
//    self.docName = self.model.professional;//主治医师
//    self.hosName = self.model.hos_name;//医院名字
//    self.hosId = self.model.hos_id;
//    self.docId = self.model.cid;
    
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
    
    
    //创建头部视图
    [self creatbleView];
//    [self.tableView reloadData];
//    [self creatTopView];
    //创建日期
//    [self createBottomView];
}

//科室
- (void)requestDeskData {
    NSLog(@"hid == %@",self.hosId);
    NSDictionary *dic = @{@"did":self.docId,@"ver":@"1.0"};
    [self.request POST:@"http://www.enuo120.com/index.php/app/doctor/keshi" params:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *dataArr = responseObject[@"data"];
        
        if (!(dataArr.count == 0)) {
            [self.depIdDataArray removeAllObjects];
            [self.deskDataArray removeAllObjects];
            for (NSDictionary *dic in dataArr) {
                NSString *deskName = dic[@"name"];//科室名字
                NSString *depId = dic[@"id"];//depId
                [self.deskDataArray addObject:deskName];
                [self.depIdDataArray addObject:depId];
                [self setLableBtn:self.deskTextLabel withDataArray:self.deskDataArray];

            }
        }else {
            NSLog(@"数组为空，没有科室");
        }
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

//子科室
- (void)requestDeskSunDataWithId:(NSString *)depId {
    NSLog(@"hosid == %@~~depid == %@",self.hosId,depId);
            NSDictionary *dic = @{@"hid":self.hosId,@"dep_id":depId,@"ver":@"1.0"};
            [self.request POST:@"http://www.enuo120.com/index.php/app/index/get_yue_sdep_list" params:dic success:^(NSURLSessionDataTask *task, id responseObject) {
                
                if (![responseObject[@"data"] isEqual:[NSNull null]]) {
                    
                    NSArray *dataArr = responseObject[@"data"];
                    
                    if (!(dataArr.count == 0)) {
                        [self.sunDeskDataArray removeAllObjects];
                        [self.sunDeskIdArray removeAllObjects];
                        
                        for (NSDictionary *dic in dataArr) {
                            NSString *deskName = dic[@"name"];//科室名字
                            NSString *sdepId = dic[@"sdep_id"];//depId
                            
                            [self.sunDeskDataArray addObject:deskName];
                            [self.sunDeskIdArray addObject:sdepId];
                            
                            [self setLableBtn:self.deskSunTextLabel withDataArray:self.sunDeskDataArray];
                            
                        }
                    }else {
                        NSLog(@"数组为空，没有科室");
                    }
                }
            } fail:^(NSURLSessionDataTask *task, NSError *error) {
                
            }];
        }

//疾病
- (void)requestIllDataWithDipId:(NSString *)depId withSdepId:(NSString *)sdepId {
    
            NSLog(@"depid =  %@,sdepId = %@~~~%@",depId,sdepId,self.hosId);
    
            NSDictionary *dic = @{@"dep_id":depId,@"sdep_id":sdepId,@"ver":@"1.0",@"did":self.docId};
            [self.request POST:@"http://www.enuo120.com/index.php/App/doctor/get_yue_doc_mb_list" params:dic success:^(NSURLSessionDataTask *task, id responseObject) {
                
                if (![responseObject[@"data"] isEqual:[NSNull null]]) {

                NSArray *dataArr = responseObject[@"data"];
                
                if (!(dataArr.count == 0)) {
                    
                    [self.illDataArray removeAllObjects];

                    for (NSDictionary *dic in dataArr) {
                        [self.illIDArray addObject:dic[@"id"]];
                        NSString *ill = dic[@"ill"];//疾病名字
                        NSString *category = dic[@"category"];
                        NSString *treat = dic[@"treat"];
                        if ([dic[@"category"] isEqual:[NSNull null]]) {
                            category = nil;
                        }
                        if ([dic[@"treat"] isEqual:[NSNull null]]) {
                            treat = nil;
                        }
                        NSString *illStr = [NSString stringWithFormat:@"%@ %@ %@",ill,category,treat];
                        [self.illDataArray addObject:illStr];
                        
                        [self setLableBtn:self.illTextLabel withDataArray:self.illDataArray];

                    }
                }}else {
                    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeigth)];
                    bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
                    SZKAlterView *alterView = [SZKAlterView alterViewWithTitle:@"提示" content:@"该子科室没有可选择疾病" cancel:nil sure:@"确定" cancelBtClcik:^{
                        
                    } sureBtClcik:^{
                        [bgView removeFromSuperview];
                    }];
                    [bgView addSubview:alterView];
                    [self.view addSubview:bgView];
                }
            } fail:^(NSURLSessionDataTask *task, NSError *error) {
                
            }];
}

//约定疗效
- (void)requestAppointWithIllID:(NSString *)illID {
    
    NSDictionary *dic = @{@"mb_id":illID};
    NSLog(@"%@",illID);
    NSString *url = @"http://www.enuo120.com/index.php/App/index/get_yue_mb_info";
    
    [self.request POST:url params:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        [self dataWithAppointRequest:responseObject];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (void)dataWithAppointRequest:(NSDictionary *)dic {
    
    self.priceLabel.hidden = NO;
    self.priceTextLabel.hidden = NO;
    self.cycleLabel.hidden = NO;
    self.cycleTextLabel.hidden = NO;
    self.effectLabel.hidden = NO;
    self.effectTextLabel.hidden = NO;
    
    NSString *price = dic[@"data"][@"heightprice"];
    NSString *cycle = dic[@"data"][@"cycle"];
    
    self.priceTextLabel.text = [NSString stringWithFormat:@"不高于 ¥%@",price];
    self.cycleTextLabel.text = cycle;
    
    NSArray *effectArr = dic[@"data"][@"effect_list"];
    self.effectTextLabel.numberOfLines = 0;
    for (int i=0; i<effectArr.count; i++) {
        if (i == 0) {
            self.effectTextLabel.text = [NSString stringWithFormat:@"1、%@",effectArr[i]];
        }else {
            self.effectTextLabel.text = [NSString stringWithFormat:@"%@\n%d、%@",self.effectTextLabel.text,i+1,effectArr[i]];
        }
        
    }
    
    self.showEffect = YES;
    [self.tableView reloadData];
    
}

//提交
- (void)submitData {
    NSString *userName = [[NSUserDefaults standardUserDefaults]objectForKey:@"name"];
    
    
    NSString *illID = (self.illID == nil)?@"疾病":self.illID;
    NSString *PID = (self.currentSunDeskID == nil)?@"0":self.currentSunDeskID;
    
    if (userName != nil && self.currentDepId != nil && self.currentSelectDate != nil) {
        
        NSDictionary *dic = @{@"username":userName,@"hos_id":self.hosId,@"dep_id":self.currentDepId,@"doc_id":self.docId,@"date":self.currentSelectDate,@"ver":@"1.0",@"mb_id":illID,@"PID":PID};
                
        [self.request POST:@"http://www.enuo120.com/index.php/app/doctor/confirm_yue" params:dic success:^(NSURLSessionDataTask *task, id responseObject) {
            
            [self handelWithSureData:responseObject];
            
        } fail:^(NSURLSessionDataTask *task, NSError *error) {
            
            
            
        }];
    }else {
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请补全信息" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [alert show];
        }else{
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"请补全信息"preferredStyle:UIAlertControllerStyleAlert];
            [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:alertView animated:YES completion:^{
                
            }];
        }
        
    }
    
}

- (void)handelWithSureData:(NSDictionary *)dic{
    
    if ([dic[@"data"][@"errcode"] integerValue] == 0) {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:dic[@"data"][@"message"] delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [alert show];
        }else{
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:dic[@"data"][@"message"]preferredStyle:UIAlertControllerStyleAlert];
            [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                
            }]];
            [self presentViewController:alertView animated:YES completion:^{
                
            }];
        }
        
    }else{
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:dic[@"data"][@"message"] delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [alert show];
        }else{
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:dic[@"data"][@"message"]preferredStyle:UIAlertControllerStyleAlert];
            [alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                PerfectViewController *peVC = [[PerfectViewController alloc]init];
                UINavigationController *naVC = [[UINavigationController alloc]initWithRootViewController:peVC];
                [self presentViewController:naVC animated:YES completion:^{
                    
                }];
                
            }]];
            
            [self presentViewController:alertView animated:YES completion:^{

            }];
        }
    }
    
    
}


- (void)requestIllListView:(NSString *)cid{
    NSString *url = @"http://www.enuo120.com/index.php/app/doctor/get_ill_info";
    
    AFHTTPSessionManager *mager = [AFHTTPSessionManager manager];
     NSDictionary *heardBody = @{@"cid":cid};
    
    
    [mager POST:url parameters:heardBody  progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"ressss = %@",responseObject);
        [self handleWithillData:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
    
    
}

- (void)handleWithillData:(NSDictionary *)dic{
    IllListDetailModel *model = [IllListDetailModel IllListDocModelWith:dic[@"data"]];
    self.priceTextLabel.text =[NSString stringWithFormat:@"不高于%@元",model.heightprice] ;
    self.cycleTextLabel.text = model.cycle;
     NSString *str =  [model.effect stringByReplacingOccurrencesOfString:@"</p>" withString:@"\n"];
    self.effectTextLabel.text = [str stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
    
    [self.illDetailArray addObject:model];
    
    [self.tableView reloadData];
}


#pragma mark---------------------------------时间--------------------------------------------------------
- (UIView*)creatTimeView{
    // NSLog(@"model.scher = %@",model.schedule);
    if (self.dataArray.count !=0) {
         DocOrderModel  *model = self.dataArray[0];
        UIView *aView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 250)];
        NSMutableArray *arrMut = [NSMutableArray array];
        UIView *aller = [[UIView alloc]initWithFrame:CGRectMake(0,  40, kScreenWidth,42)];
        for (int i = 0; i<7; i ++) {
            
            NSTimeInterval secondsPerDay =  (i+_sss) * 24*60*60;
            NSDate *curDate = [NSDate dateWithTimeIntervalSinceNow:secondsPerDay];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"MM.dd"];
            NSString *dateStr = [dateFormatter stringFromDate:curDate];//几月几号
            NSDateFormatter *weekFormatter = [[NSDateFormatter alloc] init];
            [weekFormatter setDateFormat:@"EEEE"];//星期几 @"HH:mm 'on' EEEE MMMM d"];
            NSString *weekStr = [weekFormatter stringFromDate:curDate];
            
            
            UILabel *alabel = [[UILabel alloc]initWithFrame:CGRectMake(25+(kScreenWidth - 25)/7 *i,0, (kScreenWidth - 20)/7, 20)];
            UILabel *tlabel = [[UILabel alloc]initWithFrame:CGRectMake(25+(kScreenWidth - 25)/7 *i,20, (kScreenWidth - 20)/7, 20)];
            alabel.text = dateStr;
            tlabel.text = weekStr;
            NSString *chinaStr = [self cTransformFromE:weekStr];
            [arrMut addObject:chinaStr];
            alabel.adjustsFontSizeToFitWidth = YES;
            tlabel.adjustsFontSizeToFitWidth = YES;
            alabel.font = [UIFont systemFontOfSize:13];
            tlabel.font = [UIFont systemFontOfSize:13];
            [aller addSubview:alabel];
            [aller addSubview:tlabel];
        }
        aller.backgroundColor = [UIColor colorWithRed:0/255.0 green:179/255.0 blue:163/255.0 alpha:1];
        //[self.view addSubview:aller];
        //NSLog( @"Model.scj.count =%d",model.schedule_list.count);
        //NSLog(@"model.schedule[1] = %@",model.schedule[1]);
        self.bView = [[UIView alloc]initWithFrame:CGRectMake(0, 90, kScreenWidth, (kScreenWidth - 25)/7/0.9+4)];
        //_bView.backgroundColor = [UIColor blueColor];
        NSArray *arr = model.schedule_list;
        NSMutableArray *oneArr = [NSMutableArray array];//上午
        NSMutableArray *twoArr = [NSMutableArray array];//下午
        for (int i = 0; i<14; i ++) {
            
            if (i<7) {
                [oneArr addObject:arr[i]];
            }else{
                [twoArr addObject:arr[i]];
            }
        }
        
        for (int i = 0; i<7; i++) {
            if ([oneArr[i] integerValue] == 1) {
                for (int j = 0; j<7; j++) {
                    if (i == [arrMut[j] integerValue]) {
                        UIButton *abutton = [UIButton buttonWithType:UIButtonTypeCustom];
                        abutton.frame = CGRectMake(25+(kScreenWidth - 25)/7 *j,2, (kScreenWidth - 25)/7, (kScreenWidth - 25)/7/1.8);
                        [abutton addTarget:self action:@selector(handleAbutton:) forControlEvents:UIControlEventTouchUpInside];
                        abutton.tag = j+130;
                        //abutton.backgroundColor = [UIColor yellowColor];
                        //                        [abutton setTitle:@"预约" forState:UIControlStateNormal];
                        //                           abutton.titleLabel.font = [UIFont systemFontOfSize:14];
                        //                               [abutton setTitleColor: [UIColor colorWithRed:0/255.0 green:179/255.0 blue:163/255.0 alpha:1]forState:UIControlStateNormal];
                        //                        abutton.titleLabel.adjustsFontSizeToFitWidth = YES;
                        // abutton.imageView.image = [UIImage imageNamed:@"g_uncheck"];
                        
                        abutton.userInteractionEnabled = YES;
                        
                        [abutton setBackgroundImage:[UIImage imageNamed:@"g_uncheck"] forState:UIControlStateNormal];
                        [_bView addSubview:abutton];
                    }
                }
            }
        }
        
        
        for (int i = 0; i<7; i++) {
            if ([twoArr[i] integerValue] == 1) {
                for (int j = 0; j<7; j++) {
                    if (i == [arrMut[j] integerValue]) {
                        UIButton *abutton = [UIButton buttonWithType:UIButtonTypeCustom];
                        [abutton addTarget:self action:@selector(handleBbutton:) forControlEvents:UIControlEventTouchUpInside];
                        abutton.tag = j+100;
                        // abutton.backgroundColor = [UIColor yellowColor];
                        abutton.frame = CGRectMake(25+(kScreenWidth - 25)/7 *j,32, (kScreenWidth - 25)/7, (kScreenWidth - 25)/7/1.8);
                        abutton.userInteractionEnabled = YES;
                        
                        [abutton setBackgroundImage:[UIImage imageNamed:@"g_uncheck"] forState:UIControlStateNormal];
                        [_bView addSubview:abutton];
                    }
                }
            }
        }
        
        
        // [self.view addSubview:_bView];
        UILabel *shangLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 2, 15, 30)];
        shangLabel.numberOfLines = 0;
        shangLabel.text = @"上午";
        shangLabel.font = [UIFont systemFontOfSize:11];
        
        UILabel *xiaLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 32, 15, 30)];
        xiaLabel.numberOfLines = 0;
        xiaLabel.text = @"下午";
        xiaLabel.font = [UIFont systemFontOfSize:11];
        [_bView addSubview:shangLabel];
        [_bView addSubview:xiaLabel];
        
        //   NSLog(@"arr.count = %ld",arr.count);
        
        //    for (int i=0; i<7; i ++) {
        //        if (i<7  &&  [arr [[arrMut[i] integerValue]]isEqualToString:@"1"]) {
        //            UIButton *abutton = [UIButton buttonWithType:UIButtonTypeCustom];
        //            abutton.frame = CGRectMake(10+(kScreenWidth - 20)/7 *i,0, (kScreenWidth - 20)/7, 20);
        //            [abutton setTitle:@"1" forState:UIControlStateNormal];
        //            [bView addSubview:abutton];
        //        }else if (i>6 && [arr[[arrMut[i] integerValue]+6]isEqualToString:@"1"]){
        //            UIButton *bbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        //            bbutton.frame = CGRectMake(10+(kScreenWidth - 20)/7 *(i- 7),20, (kScreenWidth - 20)/7, 20);
        //
        //            [bbutton setTitle:@"2" forState:UIControlStateNormal];
        //
        //            [bView addSubview:bbutton];
        //        }else{
        //            NSLog(@"adasdasd");
        //        }
        //    }
        //
        UIButton *abutton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton *bbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        abutton.frame = CGRectMake(40, 160, 80, 20);
        bbutton.frame = CGRectMake(kScreenWidth - 140, 160, 80, 20);
        abutton.backgroundColor = [UIColor colorWithRed:0/255.0 green:179/255.0 blue:163/255.0 alpha:1];
        bbutton.backgroundColor = [UIColor colorWithRed:0/255.0 green:179/255.0 blue:163/255.0 alpha:1];
        [abutton setTitle:@"返回上周" forState:UIControlStateNormal];
        [bbutton setTitle:@"预约下周" forState:UIControlStateNormal];
        [abutton addTarget:self action:@selector(addtabebutton:) forControlEvents:UIControlEventTouchUpInside];
        [bbutton addTarget:self action:@selector(nexttabebutton:) forControlEvents:UIControlEventTouchUpInside];
        //[self.view addSubview:abutton];
        //[self.view addSubview:bbutton];
        
        [aView addSubview:aller];
        [aView addSubview:_bView];
        [aView addSubview:abutton];
        [aView addSubview:bbutton];
        

        
        return aView;
        
    }else{
        return nil;
    }
}


- (NSString *)cTransformFromE:(NSString *)theWeek{
    NSString *chinaStr;
    if(theWeek){
        if([theWeek isEqualToString:@"星期一"]){
            chinaStr = @"0";
        }else if([theWeek isEqualToString:@"星期二"]){
            chinaStr = @"1";
        }else if([theWeek isEqualToString:@"星期三"]){
            chinaStr = @"2";
        }else if([theWeek isEqualToString:@"星期四"]){
            chinaStr = @"3";
        }else if([theWeek isEqualToString:@"星期五"]){
            chinaStr = @"4";
        }else if([theWeek isEqualToString:@"星期六"]){
            chinaStr = @"5";
        }else if([theWeek isEqualToString:@"星期日"]){
            chinaStr = @"6";
        }
    }
    return chinaStr;
}



- (void)addtabebutton:(UIButton *)sender{
    //self.sss = 0;
    if (self.sss >0) {
        self.sss = self.sss -7;
    }
    
    [self reloadSection:1];
    
}

- (void)nexttabebutton:(UIButton *)sender{
    if (self.sss <14) {
        self.sss = _sss+7;
    } [self reloadSection:1];
    
    // [self creatTableView];
}

- (void)handleAbutton:(UIButton *)sender{
    //
    //    if (sender.selected == YES) {
    //          [sender setBackgroundImage:[UIImage imageNamed:@"g_uncheck"] forState:UIControlStateNormal];
    //    }else{
    //        [sender setBackgroundImage:[UIImage imageNamed:@"g_check"] forState:UIControlStateNormal];
    //    }
    
    
    
    if (self.sss == 0) {

        float a = (sender.frame.origin.x-10)/((kScreenWidth - 20)/7);
   
        NSTimeInterval secondsPerDay =  a * 24*60*60;
        NSDate *curDate = [NSDate dateWithTimeIntervalSinceNow:secondsPerDay];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateStr = [dateFormatter stringFromDate:curDate];//几月几号
        NSString *str1 = @"am";
        self.timeStr = [NSString stringWithFormat:@"%@ %@",dateStr,str1];
        NSLog(@"dateStrAAAAAA = %@",dateStr);
        
        
        UIButton *button = (UIButton *)[self.view viewWithTag:[sender tag]];
        
        for (int i = 100; i<150; i++) {
            UIButton *abutton = (UIButton *)[self.view viewWithTag:i];
            if (abutton.tag == button.tag) {
                [abutton setBackgroundImage:[UIImage imageNamed:@"g_check"] forState:UIControlStateNormal];
            }else{
                [abutton setBackgroundImage:[UIImage imageNamed:@"g_uncheck"] forState:UIControlStateNormal];
            }
            
            
        }
   
        
    }else if (self.sss == 7){
        float a = (sender.frame.origin.x-10)/((kScreenWidth - 20)/7) + 7;
        NSTimeInterval secondsPerDay =  a * 24*60*60;
        NSDate *curDate = [NSDate dateWithTimeIntervalSinceNow:secondsPerDay];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateStr = [dateFormatter stringFromDate:curDate];//几月几号
        NSLog(@"dateStrAAAAAA = %@",dateStr);
        NSString *str1 = @"am";
          self.timeStr = [NSString stringWithFormat:@"%@ %@",dateStr,str1];
        UIButton *button = (UIButton *)[self.view viewWithTag:[sender tag]];
        
        for (int i = 100; i<150; i++) {
            UIButton *abutton = (UIButton *)[self.view viewWithTag:i];
            if (abutton.tag == button.tag) {
                [abutton setBackgroundImage:[UIImage imageNamed:@"g_check"] forState:UIControlStateNormal];
            }else{
                [abutton setBackgroundImage:[UIImage imageNamed:@"g_uncheck"] forState:UIControlStateNormal];
            }
        }
        
    }else{
        float a = (sender.frame.origin.x-10)/((kScreenWidth - 20)/7) + 14;
        NSTimeInterval secondsPerDay =  a * 24*60*60;
        NSDate *curDate = [NSDate dateWithTimeIntervalSinceNow:secondsPerDay];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateStr = [dateFormatter stringFromDate:curDate];//几月几号
        NSLog(@"dateStrAAAAAA = %@",dateStr);
        NSString *str1 = @"am";
         self.timeStr = [NSString stringWithFormat:@"%@ %@",dateStr,str1];
        UIButton *button = (UIButton *)[self.view viewWithTag:[sender tag]];
        
        for (int i = 100; i<150; i++) {
            UIButton *abutton = (UIButton *)[self.view viewWithTag:i];
            if (abutton.tag == button.tag) {
                [abutton setBackgroundImage:[UIImage imageNamed:@"g_check"] forState:UIControlStateNormal];
            }else{
                [abutton setBackgroundImage:[UIImage imageNamed:@"g_uncheck"] forState:UIControlStateNormal];
            }
        }
    }
    
}


- (void)handleBbutton:(UIButton *)sender{
    if (self.sss == 0) {
        float a = (sender.frame.origin.x-10)/((kScreenWidth - 20)/7);
        
        NSTimeInterval secondsPerDay =  a * 24*60*60;
        NSDate *curDate = [NSDate dateWithTimeIntervalSinceNow:secondsPerDay];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateStr = [dateFormatter stringFromDate:curDate];//几月几号
        NSLog(@"dateStrBBBBB = %@",dateStr);
        NSString *str1 = @"pm";
        self.timeStr = [NSString stringWithFormat:@"%@ %@",dateStr,str1];
        UIButton *button = (UIButton *)[self.view viewWithTag:[sender tag]];
        
        for (int i = 100; i<150; i++) {
            UIButton *abutton = (UIButton *)[self.view viewWithTag:i];
            if (abutton.tag == button.tag) {
                [abutton setBackgroundImage:[UIImage imageNamed:@"g_check"] forState:UIControlStateNormal];
            }else{
                [abutton setBackgroundImage:[UIImage imageNamed:@"g_uncheck"] forState:UIControlStateNormal];
            }
        }
        
        
        
    }else if (self.sss == 7){
        float a = (sender.frame.origin.x-10)/((kScreenWidth - 20)/7) + 7;
        NSTimeInterval secondsPerDay =  a * 24*60*60;
        NSDate *curDate = [NSDate dateWithTimeIntervalSinceNow:secondsPerDay];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateStr = [dateFormatter stringFromDate:curDate];//几月几号
        NSLog(@"dateStrBBBBB = %@",dateStr);
        NSString *str1 = @"pm";
        self.timeStr = [NSString stringWithFormat:@"%@ %@",dateStr,str1];
        UIButton *button = (UIButton *)[self.view viewWithTag:[sender tag]];
        
        for (int i = 100; i<150; i++) {
            UIButton *abutton = (UIButton *)[self.view viewWithTag:i];
            if (abutton.tag == button.tag) {
                [abutton setBackgroundImage:[UIImage imageNamed:@"g_check"] forState:UIControlStateNormal];
            }else{
                [abutton setBackgroundImage:[UIImage imageNamed:@"g_uncheck"] forState:UIControlStateNormal];
            }
        }
        
    }else{
        float a = (sender.frame.origin.x-10)/((kScreenWidth - 20)/7) + 14;
        NSTimeInterval secondsPerDay =  a * 24*60*60;
        NSDate *curDate = [NSDate dateWithTimeIntervalSinceNow:secondsPerDay];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateStr = [dateFormatter stringFromDate:curDate];//几月几号
        NSLog(@"dateStrBBBBB = %@",dateStr);
        NSString *str1 = @"pm";
        self.timeStr = [NSString stringWithFormat:@"%@ %@",dateStr,str1];
        UIButton *button = (UIButton *)[self.view viewWithTag:[sender tag]];
        
        for (int i = 100; i<150; i++) {
            UIButton *abutton = (UIButton *)[self.view viewWithTag:i];
            if (abutton.tag == button.tag) {
                [abutton setBackgroundImage:[UIImage imageNamed:@"g_check"] forState:UIControlStateNormal];
            }else{
                [abutton setBackgroundImage:[UIImage imageNamed:@"g_uncheck"] forState:UIControlStateNormal];
            }
        }
    }
}

//刷新cell
- (void)reloadCell:(NSInteger)row section:(NSInteger)section{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
}

//刷新分区
- (void)reloadSection:(NSInteger)section{
    NSIndexSet *indexSets = [[NSIndexSet alloc]initWithIndex:section];
    [self.tableView reloadSections:indexSets withRowAnimation:UITableViewRowAnimationAutomatic];
    
}









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
