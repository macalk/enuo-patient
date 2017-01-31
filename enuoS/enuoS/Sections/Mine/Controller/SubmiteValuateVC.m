//
//  SubmiteValuateVC.m
//  enuoS
//
//  Created by apple on 16/12/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SubmiteValuateVC.h"
#import "Macros.h"
#import "BaseRequest.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SZKAlterView.h"

#import "MyPJViewController.h"

//发表评价
@interface SubmiteValuateVC ()<UITextViewDelegate>

@property (nonatomic,strong) BaseRequest *request;

@property (nonatomic,strong) NSMutableArray *hosAttitudeArr;//医院态度
@property (nonatomic,strong) NSMutableArray *hosEnvironmentArr;//医院环境
@property (nonatomic,strong) NSMutableArray *docAttitudeArr;//医生态度
@property (nonatomic,strong) NSMutableArray *docSkillArr;//医生技能
@property (nonatomic,strong) UITextView *selectTextView;//当前选中的textView

@property (nonatomic,assign) CGFloat keyboardHeight;

//黄色星星的数量
@property (nonatomic,assign) NSInteger hosAttitudeNum;
@property (nonatomic,assign) NSInteger hosEnvironmentNum;
@property (nonatomic,assign) NSInteger docAttitudeNum;
@property (nonatomic,assign) NSInteger docSkillNum;


@end

@implementation SubmiteValuateVC

- (BaseRequest *)request {
    if (!_request) {
        _request = [[BaseRequest alloc]init];
    }return _request;
}
- (NSMutableArray *)hosAttitudeArr {
    if (!_hosAttitudeArr) {
        _hosAttitudeArr = [NSMutableArray array];
        for (int i = 0; i<5; i++) {
            UIButton *button = [self.view viewWithTag:(10+i)];
            [_hosAttitudeArr addObject:button];
        }
    }return _hosAttitudeArr;
}
- (NSMutableArray *)hosEnvironmentArr {
    if (!_hosEnvironmentArr) {
        _hosEnvironmentArr = [NSMutableArray array];
        for (int i = 0; i<5; i++) {
            UIButton *button = [self.view viewWithTag:(15+i)];
            [_hosEnvironmentArr addObject:button];
        }
    }return _hosEnvironmentArr;
}
- (NSMutableArray *)docAttitudeArr {
    if (!_docAttitudeArr) {
        _docAttitudeArr = [NSMutableArray array];
        for (int i = 0; i<5; i++) {
            UIButton *button = [self.view viewWithTag:(20+i)];
            [_docAttitudeArr addObject:button];
        }
    }return _docAttitudeArr;
}
- (NSMutableArray *)docSkillArr {
    if (!_docSkillArr) {
        _docSkillArr = [NSMutableArray array];
        for (int i = 0; i<5; i++) {
            UIButton *button = [self.view viewWithTag:(25+i)];
            [_docSkillArr addObject:button];
        }
    }return _docSkillArr;
}


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"绿色返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleWithBack:)];
        
        self.navigationItem.title = @"发表评价";
        self.navigationItem.leftBarButtonItem = leftItem;
        
        
    }return self;
}
- (void)handleWithBack:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.hos_imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:urlPicture,self.model.photo]] placeholderImage:nil];
    self.hos_nameLabel.text = self.model.hos_name;
    self.deskLabel.text = self.model.rank;
    
    [self.doc_imageView sd_setImageWithURL:nil placeholderImage:nil];
    self.doc_nameLabel.text = self.model.doc_name;
    self.docDeskLabel.text = nil;
    
    self.sendCommentBtn.layer.cornerRadius = 3;
    self.sendCommentBtn.clipsToBounds = YES;
    
    self.hosTextView.delegate = self;
    self.docTextView.delegate = self;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)keyboardChange:(NSNotification *)noti {
    //获取键盘的高度
    NSDictionary *userInfo = [noti userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    self.keyboardHeight = keyboardRect.size.height;
    
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    textView.text = nil;
    self.selectTextView = textView;
    if (textView.tag == 31) {//为下面的textView
        self.view.frame = CGRectMake(0, self.view.frame.origin.y-self.keyboardHeight, kScreenWidth, kScreenHeigth);
    }
    
    return YES;
}

//发表评论
- (IBAction)sendCommentBtnClick:(UIButton *)sender {
    [self.view endEditing:YES];
    [self SendCommentRequest];
}

//匿名按钮
- (IBAction)anonymityBtnClick:(UIButton *)sender {
}

//医院态度按钮
- (IBAction)hosAttitudeBtnClick:(UIButton *)sender {
    self.hosAttitudeNum = sender.tag-10+1;
    [self changeYellowStarNumWithBtn:sender andArray:self.hosAttitudeArr andTag:10];
}

//医院环境按钮
- (IBAction)hosEnvironmentBtnClick:(UIButton *)sender {
    self.hosEnvironmentNum = sender.tag-15+1;

    [self changeYellowStarNumWithBtn:sender andArray:self.hosEnvironmentArr andTag:15];
}

//医生态度按钮
- (IBAction)docAttitudeBtnClick:(UIButton *)sender {
    self.docAttitudeNum = sender.tag-20+1;

    [self changeYellowStarNumWithBtn:sender andArray:self.docAttitudeArr andTag:20];
}

//医生技能按钮
- (IBAction)docSkillBtnClick:(UIButton *)sender {
    self.docSkillNum = sender.tag-25+1;

    [self changeYellowStarNumWithBtn:sender andArray:self.docSkillArr andTag:25];
}

//修改星星的颜色
- (void)changeYellowStarNumWithBtn:(UIButton *)sender andArray:(NSArray *)arr andTag:(NSInteger)tag {
    
    for (int i =0; i<=sender.tag-tag; i++) {
        UIButton *button = arr[i];
        [button setBackgroundImage:[UIImage imageNamed:@"黄星星"] forState:normal];
    }
    
    for (int i = 4; sender.tag-tag<i; i--) {
        UIButton *button = arr[i];
        [button setBackgroundImage:[UIImage imageNamed:@"灰星星"] forState:normal];
    }
}


- (void)SendCommentRequest {
        
    NSDictionary *dic = @{@"dnumber":self.model.dnumber,@"doc_content":self.docTextView.text,@"hos_content":self.hosTextView.text,@"huanjing":@(self.hosEnvironmentNum),@"doc_service":@(self.docAttitudeNum),@"hos_service":@(self.hosAttitudeNum),@"level":@(self.docSkillNum)};
    
    [self.request POST:@"http://www.enuo120.com/index.php/app/patient/submit_pj" params:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        
        
        NSString *status = responseObject[@"data"][@"errcode"]
        ;
        if ( [status integerValue] == 0) {//评论成功
            
            UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeigth)];
            bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
            SZKAlterView *alertView = [SZKAlterView alterViewWithTitle:@"提示" content:responseObject[@"data"][@"message"] cancel:@"取消" sure:@"确定" cancelBtClcik:^{
                [bgView removeFromSuperview];
                [self.navigationController popViewControllerAnimated:YES];
            } sureBtClcik:^{
                [bgView removeFromSuperview];
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [bgView addSubview:alertView];
            [self.view addSubview:bgView];
            
        }else {
            UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeigth)];
            bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
            SZKAlterView *alertView = [SZKAlterView alterViewWithTitle:@"提示" content:responseObject[@"data"][@"message"] cancel:@"取消" sure:@"确定" cancelBtClcik:^{
                [bgView removeFromSuperview];
                
            } sureBtClcik:^{
                [bgView removeFromSuperview];
            }];
            [bgView addSubview:alertView];
            [self.view addSubview:bgView];
        }
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"失败");
    }];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    
    if (self.view.frame.origin.y<0) {
        self.view.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeigth-64);
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
