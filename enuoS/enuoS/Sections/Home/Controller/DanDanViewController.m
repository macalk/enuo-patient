//
//  DanDanViewController.m
//  enuoS
//
//  Created by apple on 16/8/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "DanDanViewController.h"

#import <Masonry.h>
#import <AFNetworking.h>

#import "Macros.h"
#import "UIColor+Extend.h"

#import "DanDanOneController.h"
#import "DanDanTwoController.h"
#import "DanZlIntroViewController.h"
#import "DanZdModel.h"
#import "DanZlModel.h"
#import "DanDanViewCell.h"
@interface DanDanViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UIImageView *imageBg;
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)UICollectionViewFlowLayout *layout;

@property (nonatomic,strong)NSMutableArray *oneDataArray;//诊断数组

@property (nonatomic,strong)NSMutableArray *twoDataArray;//治疗数据组

@property (nonatomic,strong)UIButton *selectBtn;//选择 诊断还是治疗

@end

@implementation DanDanViewController


- (NSMutableArray *)oneDataArray{
    if (!_oneDataArray) {
        self.oneDataArray = [NSMutableArray array];
    }return _oneDataArray;
}

- (NSMutableArray *)twoDataArray{
    if (!_twoDataArray) {
        self.twoDataArray = [NSMutableArray array];
    }return _twoDataArray;
}


- (UICollectionViewFlowLayout *)layout{
    if (!_layout) {
        self.layout  = [[UICollectionViewFlowLayout alloc]init];
    }return _layout;
}

- (void)customNavView {
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"白色返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleWithBack:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
        UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
        [titleLable setTextAlignment:NSTextAlignmentCenter];
        [titleLable setTextColor:[UIColor whiteColor]];
        [titleLable setText:@"丹丹发布"];
        titleLable.font = [UIFont boldSystemFontOfSize:18];
        self.navigationItem.titleView = titleLable;
    
    self.navigationController.navigationBar.barTintColor = [UIColor stringTOColor:@"#22ccc6"];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    [self customNavView];
    [self creatDanDanView];
    
    //诊断发布
    [self requestTwoData];

}

- (void)handleWithBack:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

//丹丹界面布局设置
- (void)creatDanDanView{
    UILabel *danLabel = [[UILabel alloc]init];
    danLabel.text = @"想知道医院有没有过度检查、过度治疗，“丹丹发布”告诉你。";
    danLabel.numberOfLines = 0;
    danLabel.font = [UIFont systemFontOfSize:13];
    danLabel.textColor = [UIColor blackColor];
    
    //修改label行间距
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:danLabel.text];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:10];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [danLabel.text length])];
    [danLabel setAttributedText:attributedString1];
    [danLabel sizeToFit];
    
    UIButton *diagnoseBtn = [[UIButton alloc]init];//诊断
    self.selectBtn = diagnoseBtn;
    diagnoseBtn.layer.cornerRadius = 10;
    diagnoseBtn.clipsToBounds = YES;
    [diagnoseBtn setTitle:@"诊断发布" forState:normal];
    [diagnoseBtn setTitleColor:[UIColor whiteColor] forState:normal];
    [diagnoseBtn setBackgroundColor:[UIColor stringTOColor:@"#53ccc2"]];
    [diagnoseBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *treatBtn = [[UIButton alloc]init];//治疗
    treatBtn.layer.cornerRadius = 10;
    treatBtn.clipsToBounds = YES;
    [treatBtn setTitle:@"治疗发布" forState:normal];
    [treatBtn setTitleColor:[UIColor whiteColor] forState:normal];
    [treatBtn setBackgroundColor:[UIColor stringTOColor:@"#00b0a1"]];
    [treatBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];

    
    /***他之前的代码，我尽量没动，****/
    UIImageView *danImage = [[UIImageView alloc]init];
    
    _layout = [[UICollectionViewFlowLayout alloc]init];
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:_layout];
   
    //设置item属性
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"DanDanViewCell" bundle:nil ] forCellWithReuseIdentifier:@"cell"];
    self.collectionView.backgroundColor = [UIColor clearColor];

    _layout.itemSize = CGSizeMake((kScreenWidth - 66)/3-10, 35);
    //4.设置最小行间距
    _layout.minimumLineSpacing = 15;
    //5.设置最小item的间距
    _layout.minimumInteritemSpacing = 10;
    //_layout.minimumInteritemSpacing = 10;
   // _layout.sectionInset = UIEdgeInsetsMake(350, 20, 20, 20);
    
    [self.view addSubview:danLabel];
    [self.view addSubview:danImage];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:diagnoseBtn];
    [self.view addSubview:treatBtn];
    
   // self.collectionView.collectionViewLayout =
    __weak typeof(self) weakSelf = self;
    
    danImage.image = [UIImage  imageNamed:@"丹丹"];
    
    [danLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left).with.offset(20);
        make.top.equalTo(weakSelf.view.mas_top).with.offset(27);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(-100);
    }];
    [danImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.view.mas_right).with.offset(-20);
        make.centerY.equalTo(danLabel.mas_centerY);
        make.size.mas_offset(CGSizeMake(57, 57));
    }];
    
    [diagnoseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo (danImage.mas_bottom).with.offset(20);
        make.centerX.equalTo(weakSelf.view.mas_centerX).with.offset(-kScreenWidth/4);
        make.height.mas_equalTo(@33);
        make.width.mas_equalTo(110);
    }];
    
    [treatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo (danImage.mas_bottom).with.offset(20);
        make.centerX.equalTo(weakSelf.view.mas_centerX).with.offset(kScreenWidth/4);
        make.height.mas_equalTo(@33);
        make.width.mas_equalTo(110);
    }];
    
    [weakSelf.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(diagnoseBtn.mas_bottom).with.offset(15);
        make.left.equalTo(weakSelf.view.mas_left).with.offset(20);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(-20);
        make.bottom.equalTo(weakSelf.view.mas_bottom);
        
    }];
}

- (void)creatCollectionView{

    
//5.设置最小item的间距
    
    
//_layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
  
}

#pragma mark _数据请求————————————————————————————

//治疗发布数据请求
- (void)requestOneData{
   NSString *url = @"http://www.enuo120.com/index.php/app/publish/zl";
    
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handelWithZlData:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}
- (void)handelWithZlData:(NSDictionary *)dic{
    NSArray *arr = dic[@"data"];
    
    for (NSDictionary *temp  in arr) {
        DanZlModel *model = [DanZlModel danZlModel:temp];
        [self.twoDataArray addObject:model];
    }[self.collectionView reloadData];
}



//诊断发布数据请求
- (void)requestTwoData{
    NSString *url = @"http://www.enuo120.com/index.php/app/publish/zd";
    
    AFHTTPSessionManager *mager = [AFHTTPSessionManager manager];
    
    [mager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handelWithZdData:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
}


- (void)handelWithZdData:(NSDictionary *)dic{
    NSArray *arr = dic[@"data"];
    for (NSDictionary *temp in arr) {
        DanZdModel *model = [DanZdModel DanZdModelInitWithData:temp];
        
        [self.oneDataArray addObject:model];
        
    }[self.collectionView reloadData];
}


#pragma mark _集合视图delegate
//
//返回集合视图的分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;//返回20个分区
}
//返回不同分区对应的item的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if ([self.selectBtn.currentTitle isEqualToString:@"诊断发布"]) {
        return self.oneDataArray.count ;
    }else{
        return  self.twoDataArray.count;
    }
   
}

//配置不同分区的item内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    DanDanViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if ([self.selectBtn.currentTitle isEqualToString:@"诊断发布"]) {
        DanZdModel *model = self.oneDataArray[indexPath.row];
        cell.titleLabel.text= model.zz;

    }else{
        DanZlModel *model = self.twoDataArray[indexPath.row];
        cell.titleLabel.text= model.ill;
    }
    
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.contentView.layer.cornerRadius = 10.0;
    cell.contentView.layer.borderColor = [UIColor stringTOColor:@"#00afa1"].CGColor;
    cell.contentView.layer.borderWidth = 1.0;
    cell.contentView.layer.masksToBounds = YES;
    
    return cell;

    
   }
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.selectBtn.currentTitle isEqualToString:@"诊断发布"]) {
        DanZdModel *model = self.oneDataArray[indexPath.row];
        DanDanOneController *danVC = [[DanDanOneController alloc]init];
        [self.navigationController pushViewController:danVC animated:YES];
        DanDanViewCell *cell = (DanDanViewCell *)[self collectionView:collectionView cellForItemAtIndexPath:indexPath];
 
        danVC.receiver = cell.titleLabel.text;
        danVC.cidReceiver = model.cid;
    }else{
        
        DanZlModel *model = self.twoDataArray[indexPath.row];
        DanZlIntroViewController *danVC = [[DanZlIntroViewController alloc]init];
        danVC.receiver = model.ill;
        danVC.cidReceiver = model.cid;
        
        [self.navigationController pushViewController:danVC animated:YES];
    }
}


- (void)buttonClick:(UIButton *)sender {
    
    [self.selectBtn setBackgroundColor:[UIColor stringTOColor:@"#00b0a1"]];
    
    [sender setBackgroundColor:[UIColor stringTOColor:@"#53ccc2"]];
    
    self.selectBtn = sender;
    
    if ([sender.currentTitle isEqualToString:@"诊断发布"]) {
        _layout.itemSize = CGSizeMake((kScreenWidth - 66)/3-10, 35);
        //4.设置最小行间距
        _layout.minimumLineSpacing = 15;
        //5.设置最小item的间距
        _layout.minimumInteritemSpacing = 10;
        
        self.collectionView.collectionViewLayout = _layout;
        //[self.collectionView reloadData];
        [self.oneDataArray removeAllObjects];
        [self requestTwoData];
        
    }else {
        
        _layout.itemSize = CGSizeMake((kScreenWidth - 66)/2-10, 35);
        //4.设置最小行间距
        _layout.minimumLineSpacing = 15;
        //5.设置最小item的间距
        _layout.minimumInteritemSpacing = 10;
        
        self.collectionView.collectionViewLayout = _layout;
        [self.twoDataArray removeAllObjects];
        [self requestOneData];
        

    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.selectBtn.currentTitle isEqualToString:@"诊断发布"]) {
        return CGSizeMake((kScreenWidth - 66)/2-10, 35);
    }else{
        return CGSizeMake((kScreenWidth - 66)/2-10, 35);
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
