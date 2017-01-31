//
//  ExaminaViewController.m
//  enuoS
//
//  Created by apple on 16/7/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ExaminaViewController.h"
#import <OBShapedButton.h>
#import <Masonry.h>
#import "Macros.h"
#import <AFNetworking.h>
#import "BodyModel.h"

#import "ExaminavDetailController.h"



#define kWidth [UIScreen mainScreen].bounds.size.width*3/4

#define kHeight [UIScreen mainScreen].bounds.size.height*3/4 *636/841


@interface ExaminaViewController ()

@property (strong,nonatomic)UIImageView *peopImage;

@property (nonatomic,copy)NSString *markStr;

@property (nonatomic,strong)UIView *oneView;
@property (nonatomic,strong)UIView *twoView;
@property (nonatomic,strong)UIView *threeView;

@property (nonatomic,strong)UIView *fourView;

@property (nonatomic,strong)NSMutableArray *bodyArray;

@property (nonatomic,strong)NSMutableArray *idDataArray;
@property (nonatomic,strong)NSMutableArray *sortArray;
@property (nonatomic,strong)NSMutableArray *bodyNameArray;


@property (nonatomic,strong)UIButton *changeBtn;

@end

@implementation ExaminaViewController
- (UIButton *)changeBtn{
    if (!_changeBtn) {
        self.changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }return _changeBtn;
}

- (NSMutableArray *)idDataArray{
    if (!_idDataArray) {
        self.idDataArray = [NSMutableArray array];
    }return _idDataArray;
}

- (NSMutableArray *)sortArray{
    if (!_sortArray) {
        self.sortArray = [NSMutableArray array];
    }return _sortArray;
}

- (NSMutableArray *)bodyNameArray{
    if (!_bodyNameArray) {
        self.bodyNameArray = [NSMutableArray array];
    }return _bodyNameArray;
}


- (NSMutableArray *)bodyArray{
    if (!_bodyArray) {
        self.bodyArray = [NSMutableArray array];
    }return _bodyArray;
}

- (UIView *)oneView{
    if (!_oneView) {
        self.oneView = [[UIView alloc]init];
        self.oneView.backgroundColor = [UIColor whiteColor];
    }return _oneView;
}

- (UIView *)twoView{
    if (!_twoView) {
        self.twoView = [[UIView alloc]init];
    
        self.twoView.backgroundColor = [UIColor whiteColor];
    
    }return _twoView;
}
- (UIView *)threeView{
    if (!_threeView) {
        self.threeView = [[UIView alloc]init];
        
        self.threeView.backgroundColor = [UIColor whiteColor];
    }return _threeView;
}

- (UIView *)fourView{
    if (!_fourView) {
        self.fourView = [[UIView alloc]init];
        self.fourView.backgroundColor = [UIColor whiteColor];
    }return _fourView;
}

- (UIImageView *)peopImage{
    if (!_peopImage) {
        self.peopImage = [[UIImageView alloc]init];
    }return _peopImage;
}



- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"绿色返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleWithBack:)];
        self.navigationItem.leftBarButtonItem = leftItem;
        
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"全身" style:UIBarButtonItemStyleDone target:self action:@selector(handleWithQuanShen:)];
        self.navigationItem.rightBarButtonItem = rightItem;
        
        
        
    }return self;
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航条底图"] forBarMetrics:0];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0/255.0 green:179/255.0 blue:163/255.0 alpha:1];

    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationItem.title = @"你那里不舒服";
//    self.navigationController.navigationBar.barTintColor =  [UIColor colorWithRed:0/255.0 green:179/255.0 blue:163/255.0 alpha:1];
   // self.navigationController.navigationBar.translucent = NO;
    
    [self creatButtonInView];
    [self creatOneButtonInView];
    [self creatTwoButtonInView];
    [self creatThreeButtonInView];
    self.markStr = @"0";
     self.navigationController.toolbarHidden=NO;

    self.view = self.threeView;
    [self creatToolView];
//
    NSArray *arr =@[@"1",@"98",@"98",@"100",@"100",@"100",@"100"];
    
    
}


- (void)handleWithQuanShen:(UIBarButtonItem *)sender{
    if (self.view == self.threeView ||self.view == self.fourView) {
        ExaminavDetailController *examVC = [[ExaminavDetailController alloc]init];
        examVC.receiver = @"男";
        examVC.pbody =@"全身";
        UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:examVC];
        naNC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:naNC animated:YES completion:^{
            
        }];
    }else{
        ExaminavDetailController *examVC = [[ExaminavDetailController alloc]init];
        examVC.receiver = @"女";
        examVC.pbody =@"全身";
        UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:examVC];
        naNC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:naNC animated:YES completion:^{
            
        }];
    }
   
    
}
- (void)handleWithBack:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (void)creatButtonInView{

    
    NSArray *arrOne = @[@"女背头",@"女背手臂",@"女背肩",@"女背背",@"女背屁股",@"女背腿"];
    

    UIImageView *aImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeigth)];
    aImage.image = [UIImage imageNamed:@"女背面"];
   // aImage.backgroundColor = [UIColor redColor];
   [self.oneView addSubview:aImage];
    
    for (int i = 0; i < arrOne.count; i ++) {
        OBShapedButton *aOnebutton = [OBShapedButton buttonWithType:UIButtonTypeCustom];
       // aOnebutton.backgroundColor = [UIColor blueColor];
        [aOnebutton setBackgroundImage:[UIImage imageNamed:arrOne[i]] forState:UIControlStateNormal];
        aOnebutton.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeigth);
        [self.oneView addSubview:aOnebutton];
        [aOnebutton addTarget:self action:@selector(handleBeiNvButton:) forControlEvents:UIControlEventTouchUpInside];
        aOnebutton.tag = 400 +i;
        
    }
    
    
 

    
    

}

- (void)creatOneButtonInView{
    
    
    NSArray *arrOne = @[@"女正头",@"女正手臂",@"女正脖子",@"女正胸部",@"女正腹部",@"女正生殖",@"女正腿"];
    NSArray *arrTwo = @[@"头部",@"上肢",@"脖子",@"胸部",@"腹部",@"生殖",@"下肢"];
    
    UIImageView *aImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeigth)];
    aImage.image = [UIImage imageNamed:@"女正面"];
    // aImage.backgroundColor = [UIColor redColor];
   
    [self.twoView addSubview:aImage];
    
    for (int i = 0; i < arrOne.count; i ++) {
        OBShapedButton *aOnebutton = [OBShapedButton buttonWithType:UIButtonTypeCustom];
        // aOnebutton.backgroundColor = [UIColor blueColor];
        [aOnebutton setBackgroundImage:[UIImage imageNamed:arrOne[i]] forState:UIControlStateNormal];
        aOnebutton.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeigth);
        [self.twoView addSubview:aOnebutton];
        [aOnebutton addTarget:self action:@selector(handleZhengNvButton:) forControlEvents:UIControlEventTouchUpInside];
        aOnebutton.tag = 200 +i;
        
    }
    
    
    
    
    
    
    
}
- (void)creatTwoButtonInView{
    
    
    NSArray *arrOne = @[@"男正头",@"男正手臂",@"男正脖子",@"男正胸",@"男正腹",@"男正生殖",@"男正腿"];
       NSArray *arrTwo = @[@"头部",@"上肢",@"脖子",@"胸部",@"腹部",@"生殖",@"下肢"];
    
    UIImageView *aImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeigth)];
    aImage.image = [UIImage imageNamed:@"男正面"];
    // aImage.backgroundColor = [UIColor redColor];
    
    [self.threeView addSubview:aImage];
    
    for (int i = 0; i < arrOne.count; i ++) {
        OBShapedButton *aOnebutton = [OBShapedButton buttonWithType:UIButtonTypeCustom];
        // aOnebutton.backgroundColor = [UIColor blueColor];
        [aOnebutton setBackgroundImage:[UIImage imageNamed:arrOne[i]] forState:UIControlStateNormal];
        aOnebutton.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeigth);
        [self.threeView addSubview:aOnebutton];
        [aOnebutton addTarget:self action:@selector(handleZhengNanButton:) forControlEvents:UIControlEventTouchUpInside];
        aOnebutton.tag = 300 +i;
        
    }
    
    
    
    
    
    
    
}
- (void)creatThreeButtonInView{
    
    
    NSArray *arrOne = @[@"男背头",@"男背手臂",@"男背肩",@"男背背",@"男背屁股",@"男背腿"];
    
  
    UIImageView *aImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeigth)];
    aImage.image = [UIImage imageNamed:@"男背面"];
    //aImage.backgroundColor = [UIColor redColor];
    
    [self.fourView addSubview:aImage];
    
    for (int i = 0; i < arrOne.count; i ++) {
        OBShapedButton *aOnebutton = [OBShapedButton buttonWithType:UIButtonTypeCustom];
        // aOnebutton.backgroundColor = [UIColor blueColor];
        [aOnebutton setBackgroundImage:[UIImage imageNamed:arrOne[i]] forState:UIControlStateNormal];
        aOnebutton.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeigth);
        [self.fourView addSubview:aOnebutton];
        [aOnebutton addTarget:self action:@selector(handleBeiNanButton:) forControlEvents:UIControlEventTouchUpInside];
        aOnebutton.tag = 100 +i;
        
    }
    
    
}
- (void)handleBeiNvButton:(OBShapedButton *)sender{
    //NSLog(@"sender.tag = %d",sender.tag);
    ExaminavDetailController *examVC = [[ExaminavDetailController alloc]init];
      NSArray *arrTwo = @[@"头部",@"上肢",@"肩部",@"背部",@"臀部",@"下肢"];
    UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:examVC];
    naNC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    examVC.pbody = arrTwo[sender.tag - 400];
    examVC.receiver = @"女";
    
    [self presentViewController:naNC animated:YES completion:^{
        
    }];
    
    
}


- (void)handleZhengNvButton:(OBShapedButton *)sender{
    //NSLog(@"sender.tag = %d",sender.tag);
           NSArray *arrTwo = @[@"头部",@"上肢",@"脖子",@"胸部",@"腹部",@"生殖",@"下肢"];
    ExaminavDetailController *examVC = [[ExaminavDetailController alloc]init];
       examVC.receiver = @"女";
    examVC.pbody = arrTwo[sender.tag - 200];
    UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:examVC];
      naNC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:naNC animated:YES completion:^{
        
    }];
    
    
    
}

- (void)handleBeiNanButton:(OBShapedButton *)sender{
   // NSLog(@"sender.tag = %d",sender.tag);
      NSArray *arrTwo = @[@"头部",@"上肢",@"肩部",@"背部",@"臀部",@"下肢"];
    ExaminavDetailController *examVC = [[ExaminavDetailController alloc]init];
       examVC.receiver = @"男";
    examVC.pbody = arrTwo[sender.tag -100];
    UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:examVC];
      naNC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:naNC animated:YES completion:^{
        
    }];
    
    
    
}


- (void)handleZhengNanButton:(OBShapedButton *)sender{
   // NSLog(@"sender.tag = %d",sender.tag);
          NSArray *arrTwo = @[@"头部",@"上肢",@"脖子",@"胸部",@"腹部",@"生殖",@"下肢"];
    ExaminavDetailController *examVC = [[ExaminavDetailController alloc]init];
    examVC.receiver = @"男";
    examVC.pbody = arrTwo[sender.tag - 300];
    
    
    UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:examVC];
      naNC.modalTransitionStyle =  UIModalTransitionStyleCrossDissolve;
    [self presentViewController:naNC animated:YES completion:^{
        
    }];
    
    
}


- (void)creatToolView{
    UIView *toolView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    
    UIButton *boyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *girlButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //UIButton *changeButton =[UIButton buttonWithType:UIButtonTypeCustom];
    
    boyButton.frame = CGRectMake(0, 0, kScreenWidth/3, 44);
    girlButton.frame = CGRectMake(kScreenWidth/3, 0, kScreenWidth/3, 44);
    self.changeBtn.frame = CGRectMake(kScreenWidth*2/3, 0, kScreenWidth/3, 44);
    [toolView addSubview:boyButton];
    [toolView addSubview:girlButton];
    [toolView addSubview:self.changeBtn];

    [boyButton setImage:[UIImage imageNamed:@"男生"] forState:UIControlStateNormal];
    [girlButton setImage:[UIImage imageNamed:@"女生"] forState:UIControlStateNormal];
    [self.changeBtn setImage:[UIImage imageNamed:@"切换"] forState:UIControlStateNormal];
    
     [self.navigationController.toolbar addSubview:toolView];
    [boyButton addTarget:self action:@selector(handleWithboyBtn:) forControlEvents:UIControlEventTouchUpInside];
    [girlButton addTarget:self action:@selector(handleWithgirlBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.changeBtn addTarget:self action:@selector(handleWithChangeBtn:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)handleWithboyBtn:(UIButton *)sender{
   [self.changeBtn setImage:[UIImage imageNamed:@"切换"] forState:UIControlStateNormal];
      self.view = self.threeView;
}

- (void)handleWithgirlBtn:(UIButton *)sender{
 [self.changeBtn setImage:[UIImage imageNamed:@"切换"] forState:UIControlStateNormal];
     self.view = self.twoView;
}
- (void)handleWithChangeBtn:(UIButton *)sender{
    
    if (self.view == self.twoView) {
        [self.changeBtn setImage:[UIImage imageNamed:@"切换2"] forState:UIControlStateNormal];
        self.view = self.oneView;
    }else if (self.view == self.oneView){
        [self.changeBtn setImage:[UIImage imageNamed:@"切换"] forState:UIControlStateNormal];
        self.view = self.twoView;
    }else if (self.view == self.threeView){
        [self.changeBtn setImage:[UIImage imageNamed:@"切换2"] forState:UIControlStateNormal];
        self.view = self.fourView;
    }else{
        [self.changeBtn setImage:[UIImage imageNamed:@"切换"] forState:UIControlStateNormal];
        self.view = self.threeView;
    }
    
    
}

#pragma mark - 数据处理————————————————————————————————————————————————————————————————————————————————







- (void)requestBodyData{
    NSString *url = @"http://www.enuo120.com/index.php/app/index/zcbody";
    
    AFHTTPSessionManager *mangr = [AFHTTPSessionManager manager];
    [mangr POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleWithBodyData:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
    
}

- (void)handleWithBodyData:(NSDictionary *)dic{
    NSArray *arr = dic[@"data"];
    for (NSDictionary *temp in arr) {
        
        BodyModel *model = [BodyModel bodyModelInitWithDic:temp];
        [self.bodyArray addObject:model];
    }
    
    
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    
    
    
}



@end
