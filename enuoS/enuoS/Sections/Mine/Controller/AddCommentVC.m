//
//  AddCommentVC.m
//  enuoS
//
//  Created by apple on 16/12/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AddCommentVC.h"
#import "AddCommentView.h"
#import "Macros.h"
#import <AFNetworking.h>
#import "SZKAlterView.h"
#import "UIColor+Extend.h"

@interface AddCommentVC ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UITextView *textView;

@end

@implementation AddCommentVC

- (void)customNavView {    
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"白色返回"] style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonClick:)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.center = self.navigationItem.titleView.center;
    titleLabel.bounds = CGRectMake(0, 0, 100, 20);
    titleLabel.text = @"追加评论";
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    
}
- (void)leftBarButtonClick:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self customNavView];
    
    [self createTableView];
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGRClick:)];
    [self.view addGestureRecognizer:tapGR];
    
    
    //监控键盘
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
- (void)keyBoardChange:(NSNotification *)noti {
    //获取键盘高度
    NSDictionary *dic = [noti userInfo];
    CGRect rect = [[dic objectForKey:@"UIKeyboardBoundsUserInfoKey"] CGRectValue];
    
    if (self.tableView.bounds.size.height == kScreenHeigth) {
        self.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeigth-rect.size.height-64);
    }else {
        self.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeigth);
    }
}

- (void)createTableView {
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeigth) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
    self.tableView.tableHeaderView = [self customTableHeadView];
    [self.view addSubview:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    return cell;
}

- (UIView *)customTableHeadView {
    AddCommentView *view = [[AddCommentView alloc]init];
    view.model = self.model;
    view.type = self.type;
    
    CGRect rect = [self.model.content boundingRectWithSize:CGSizeMake(kScreenWidth-40, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
    
    if (465+rect.size.height<kScreenHeigth) {
        view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeigth);
    }else {
        view.frame = CGRectMake(0, 0, kScreenWidth, 465+rect.size.height);
    }
    

    
    UIButton *sendTextBtn = [[UIButton alloc]init];
    sendTextBtn.layer.cornerRadius = 5;
    sendTextBtn.clipsToBounds = YES;
    [sendTextBtn addTarget:self action:@selector(sendCommentText:) forControlEvents:UIControlEventTouchUpInside];
    
    UITextView *textView = [[UITextView alloc]init];
    self.textView = textView;
    textView.delegate = self;
    
    [view createViewWithTextField:textView withSendTextBtn:sendTextBtn];
    
    
    return view;
}

//发表评价
- (void)sendCommentText:(UIButton *)sender {
    [self.view endEditing:YES];
    [self sendCommentRequest];
}

- (void)sendCommentRequest {
    
    NSString *type;
    if ([self.type isEqualToString:@"doctor"]) {
        type = @"doc";
    }else {
        type = @"hos";
    }
    
    NSLog(@"%@~~~",self.model.dnumber);
    
    NSString *url = @"http://www.enuo120.com/index.php/app/Patient/submit_zhui";
    NSDictionary *dic = @{@"ver":@"1.0",@"type":type,@"zhui":self.textView.text,@"dnumber":self.model.dnumber};
    
    BaseRequest *request = [[BaseRequest alloc]init];
    [request POST:url params:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@~~~~",responseObject);
        [self sendCommentRequestData:responseObject];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (void)sendCommentRequestData:(NSDictionary *)dic {
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeigth)];
    bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self.view addSubview:bgView];
    
    SZKAlterView *alterView = [SZKAlterView alterViewWithTitle:@"提示" content:dic[@"data"][@"message"] cancel:@"取消" sure:@"确定" cancelBtClcik:^{
        [bgView removeFromSuperview];
        [self.navigationController popViewControllerAnimated:YES];
    } sureBtClcik:^{
        [bgView removeFromSuperview];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [bgView addSubview:alterView];
    
    
}

#pragma mark --- textView的delegate方法
- (void)textViewDidBeginEditing:(UITextView *)textView {
    textView.text = @"";
}

//手势解决键盘取消问题
- (void)tapGRClick:(UITapGestureRecognizer *)tap {
    [self.view endEditing:YES];
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
