//
//  PiaoLiangViewController.m
//  enuoS
//
//  Created by apple on 16/8/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "PiaoLiangViewController.h"
#import "PLSearchViewController.h"
#import "Macros.h"
#import <AFNetworking.h>
#import <Masonry.h>
#import "DeskCollectionCell.h"
#import "PiaoDetailViewController.h"
#import "DeskModel.h"
#import "DeskTwoModel.h"

#import "PLDetailViewController.h"

#import <SVProgressHUD.h>
#import <UIImageView+WebCache.h>
#import "SearchViewController.h"
#import "PiaoLiangCollectionViewCell.h"
@interface PiaoLiangViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic ,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation PiaoLiangViewController
//
//- (UICollectionView *)collectionView{
//    if (!_collectionView) {
//        self.collectionView = [[UICollectionView alloc]init];
//    }return _collectionView;
//}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }return _dataArray;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication]setStatusBarStyle: UIStatusBarStyleDefault];
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"绿色返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleWithBack:)];
                self.navigationItem.leftBarButtonItem = leftItem;
        //

    }return self;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:255/255.0 green:192/255.0 blue:202/255.0 alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [SVProgressHUD show];
    [self requestData];
    [self creatCollectionView];
    
    [self creatNationControllerView];
}

- (void)handleWithBack:(UIBarButtonItem *)sender{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}




- (void)creatNationControllerView{
    
    UIImageView *imageSearch = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-200, 26)];
  
    imageSearch.image = [UIImage imageNamed:@"整容搜索"];
    
    self.navigationItem.titleView = imageSearch;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleWithTapSearch:)];
    
    imageSearch.userInteractionEnabled = YES;
    
       tapGesture.numberOfTapsRequired = 1;//单击
        //  2）设置触摸手指的个数
        tapGesture.numberOfTouchesRequired = 1;//触摸手指的个数
    
    
    [imageSearch addGestureRecognizer:tapGesture];
    
    
    
    
    
    
    
}

- (void)handleWithTapSearch:(UITapGestureRecognizer *)sender{
//    PLSearchViewController *plVC = [[PLSearchViewController alloc]init];
//    
//    UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:plVC];
//      naNC.modalTransitionStyle =    UIModalTransitionStyleCrossDissolve;
//    [self.navigationController presentViewController:naNC animated:YES completion:^{
//        
//    }];
    SearchViewController *searchvc =[[SearchViewController alloc]init];
    UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:searchvc];
     naNC.modalTransitionStyle =    UIModalTransitionStyleCrossDissolve;
    [self presentViewController:naNC animated:YES completion:^{
        
    }];
}



- (void)creatCollectionView{
    
    UICollectionViewFlowLayout *_layout  = [[UICollectionViewFlowLayout alloc]init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth , kScreenHeigth- 10) collectionViewLayout:_layout];
    
    self.view = self.collectionView;
    //设置item属性
    _layout.itemSize = CGSizeMake(kScreenWidth/4, kScreenWidth/4);

  _layout.minimumLineSpacing = 10;
    _layout.minimumInteritemSpacing = 10;
    self.collectionView.dataSource = self;
    self.collectionView.delegate =self;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"PiaoLiangCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    
    
    
    //[self.view addSubview:self.collectionView];
    
    
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//

//返回不同分区对应的item的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;//每个分区返回23个item
}

//配置不同分区的item内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

  PiaoLiangCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
   
    DeskTwoModel *model = self.dataArray[indexPath.row];
    cell.labelText.text = model.sDepName;
    NSString *str = [NSString stringWithFormat:urlPicture,model.photo];
    [cell.imageDes sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:nil] ;
    
    
    

    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    PiaoDetailViewController *piaoVC = [[PiaoDetailViewController alloc]init];
//    UINavigationController *naVC = [[UINavigationController alloc]initWithRootViewController:piaoVC];
//    
//    [self.navigationController  presentViewController:naVC animated:YES completion:^{
//        
//    }];
     DeskTwoModel *model = self.dataArray[indexPath.row];
    PLDetailViewController *olVC = [[PLDetailViewController alloc]init];
    UINavigationController *naNc = [[UINavigationController alloc]initWithRootViewController:olVC];
    
    olVC.receiver = model.cid;
    [self  presentViewController:naNc animated:YES completion:^{
        
    }];

}



- (void)requestData{
    NSString *url = @"http://www.enuo120.com/index.php/App/index/get_sdep_list";
    NSDictionary *dic = @{@"dep_id":@"11"};
    
    BaseRequest *request =[[BaseRequest alloc]init];
    [request POST:url params:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        [self handleWithdic:responseObject];
        NSLog(@"re = %@",responseObject);
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}



- (void)handleWithdic:(NSDictionary *)dic{
   NSArray *arr  =  dic[@"data"];
    for (NSDictionary *temp in arr) {
       DeskTwoModel    *model = [DeskTwoModel deskTwoModelWithDic:temp];
        [self.dataArray addObject:model];
    }[self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
