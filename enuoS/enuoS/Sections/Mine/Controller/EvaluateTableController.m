//
//  EvaluateTableController.m
//  enuo4
//
//  Created by apple on 16/4/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "EvaluateTableController.h"
#import "Macros.h"
#import <AFNetworking.h>
#import "RootTabBarViewController.h"



@interface EvaluateTableController ()<UIAlertViewDelegate,UITextViewDelegate>
@property (nonatomic,strong)UITextField *textField;
@property (nonatomic,strong)UITextView *aview;
@property (nonatomic,strong)UIAlertView *altert;
@property (nonatomic,strong)UIAlertController *alertView;
@property (nonatomic,copy)NSString *oneBtnStr;
@property (nonatomic,copy)NSString *twoBtnStr;
@property (nonatomic,copy)NSString *threeBtnStr;
@property (nonatomic,copy)NSString *fourBtnStr;
@property (nonatomic,copy)NSString *fiveBtnStr;
@property (nonatomic,copy)NSString *sixBtnStr;

@property (nonatomic,copy)NSString *zh;
@property (nonatomic,copy)NSString *dnumber;
@property (nonatomic,copy)NSString *content;
@property (nonatomic,copy)NSString *level;
@property (nonatomic,copy)NSString *huanj;
@property (nonatomic,copy)NSString *service;
@property (nonatomic,copy)NSString *wz;




@end

@implementation EvaluateTableController
//- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    
//    if (self) {
//        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"fanhui"] style:UIBarButtonItemStyleDone target:self action:@selector(handleBackBarItem)];
//        self.navigationItem.leftBarButtonItem = leftItem;
//        
//        
//    }return self;
//}


- (instancetype)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if (self) {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"登录返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleBackBarItem)];
        self.navigationItem.leftBarButtonItem = leftItem;

    }return self;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航条底图"] forBarMetrics:0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    //1.轻拍收拾
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGesture)];
   // 1）设置轻拍次数  单击  双击  三连击。。。。。
    tapGesture.numberOfTapsRequired = 1;//单击
    [self.tableView addGestureRecognizer:tapGesture];
    self. tableView.separatorColor = [UIColor whiteColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.zh = @"0";
    self.service = @"0";
    self.wz = @"0";
    self.level = @"0";
    self.huanj = @"0";
    self.tableView.rowHeight = 44;
    self.dnumber = self.reseiver;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (void)handleBackBarItem{
    [self popoverPresentationController];
}
- (void)handleTapGesture{
    [_aview resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        if ([self.zh isEqualToString:@"1"]) {
            return 1;
        }else{
            return 0;
        }
    }else if(section == 1){
        if ([self.service isEqualToString:@"1"]) {
            return 1;
        }else{
            return 0;
        }
    }else if (section == 2){
        if ([self.level isEqualToString:@"1"]) {
            return 1;
        }else{
            return 0;
        }
    }else if (section == 3){
        if ([self.huanj isEqualToString:@"1"]) {
            return 1;
        }else{
            return 0;
        }
    }else{
        return 0;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 5) {
        return 70;
    }else{
        return 50;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    UILabel *alabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth -85, 0, kScreenWidth -85, 40)];
    alabel.numberOfLines = 0;
    alabel.text =@"默认最满意";
    [cell.contentView addSubview:alabel];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
       UIView *aview= [self ceatOneView];
        return aview;
    }else if(section == 1){
        UIView *aview= [self ceatTwoView];
        return aview;
    }else if (section ==2){
        UIView *aview= [self ceatThreeView];
        return aview;
    }else if (section == 3){
        UIView *aview= [self ceatFourView];
        return aview;
    }else if (section == 4){
        UIView *aview= [self ceatFiveView];
        return aview;
    }else if(section == 5){
        UIView *aview= [self ceatSixView];
        return aview;
 
    }else{
        UIView *aview= [self ceatSevenView];
        return aview;
    }
}


- (UIView *)ceatOneView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    UIButton *oneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UILabel *oneLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 2, 75, 40)];
    UILabel *twoLabel = [[UILabel alloc]initWithFrame:CGRectMake(115, 2, kScreenWidth-100, 40)];
    oneButton.frame = CGRectMake(85, 12, 15, 15);
    if ([self.zh isEqualToString:@"1"]) {
          [oneButton setImage:[UIImage imageNamed:@"orangenuo"] forState:UIControlStateNormal];
        oneButton.selected = YES;
    }else {
          [oneButton setImage:[UIImage imageNamed:@"greynuo"] forState:UIControlStateNormal];
        oneButton.selected = NO;
    }
  
    oneLabel.text = @"综合评价:";
    oneLabel.font = [UIFont systemFontOfSize:16];
    twoLabel.font = [UIFont systemFontOfSize:16];
    twoLabel.text = @"(满意请点诺)";
    [oneButton addTarget:self action:@selector(handleOneButton:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:oneButton];
    [view addSubview:oneLabel];
    [view addSubview:twoLabel];
    return view;
}
- (UIView *)ceatTwoView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    UIButton *oneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UILabel *oneLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 2, 75, 40)];
    UILabel *twoLabel = [[UILabel alloc]initWithFrame:CGRectMake(115, 2, kScreenWidth-100, 40)];
    oneButton.frame = CGRectMake(85, 12, 15, 15);
    if ([self.service isEqualToString:@"1"]) {
        [oneButton setImage:[UIImage imageNamed:@"orangeservice"] forState:UIControlStateNormal];
        oneButton.selected = YES;
    }else {
        [oneButton setImage:[UIImage imageNamed:@"greyservice"] forState:UIControlStateNormal];
        oneButton.selected = NO;
    }
    oneLabel.text = @"服务评价:";
    oneLabel.font = [UIFont systemFontOfSize:16];
    twoLabel.font = [UIFont systemFontOfSize:16];
    twoLabel.text = @"(满意请点赞)";
    [oneButton addTarget:self action:@selector(handleTwoButton:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:oneButton];
    [view addSubview:oneLabel];
    [view addSubview:twoLabel];
    return view;
}
- (UIView *)ceatThreeView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    UIButton *oneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UILabel *oneLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 2, 75, 40)];
    UILabel *twoLabel = [[UILabel alloc]initWithFrame:CGRectMake(115, 2, kScreenWidth-100, 40)];
    oneButton.frame = CGRectMake(85, 12, 15, 15);
    if ([self.level isEqualToString:@"1"]) {
        [oneButton setImage:[UIImage imageNamed:@"orangetec"] forState:UIControlStateNormal];
        oneButton.selected = YES;
    }else {
        [oneButton setImage:[UIImage imageNamed:@"greytec"] forState:UIControlStateNormal];
        oneButton.selected =NO;
    }
    oneLabel.text = @"技能评价:";
    oneLabel.font = [UIFont systemFontOfSize:16];
    twoLabel.font = [UIFont systemFontOfSize:16];
    twoLabel.text = @"(满意请点赞)";
    [oneButton addTarget:self action:@selector(handleThreeButton:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:oneButton];
    [view addSubview:oneLabel];
    [view addSubview:twoLabel];
    return view;
}
- (UIView *)ceatFourView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    UIButton *oneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UILabel *oneLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 2, 75, 40)];
    UILabel *twoLabel = [[UILabel alloc]initWithFrame:CGRectMake(115, 2, kScreenWidth-100, 40)];
    oneButton.frame = CGRectMake(85, 12, 15, 15);
    if ([self.huanj isEqualToString:@"1"]) {
        [oneButton setImage:[UIImage imageNamed:@"orangetree"] forState:UIControlStateNormal];
       oneButton.selected = YES;
    }else {
        [oneButton setImage:[UIImage imageNamed:@"greytree"] forState:UIControlStateNormal];
        oneButton.selected = NO;
    }
    oneLabel.text = @"环境评价:";
    oneLabel.font = [UIFont systemFontOfSize:16];
    twoLabel.font = [UIFont systemFontOfSize:16];
    twoLabel.text = @"(满意请点赞)";
    [oneButton addTarget:self action:@selector(handleFourButton:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:oneButton];
    [view addSubview:oneLabel];
    [view addSubview:twoLabel];
    return view;
}
- (UIView *)ceatFiveView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    UIButton *oneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UILabel *oneLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 2, 75, 40)];
    UILabel *twoLabel = [[UILabel alloc]initWithFrame:CGRectMake(115, 2, kScreenWidth-100, 40)];
    oneButton.frame = CGRectMake(85, 12, 15, 15);
    [oneButton setImage:[UIImage imageNamed:@"orangenuo"] forState:UIControlStateNormal];
    oneLabel.text = @"是否误诊:";
    
    oneLabel.font = [UIFont systemFontOfSize:16];
    twoLabel.font = [UIFont systemFontOfSize:16];
    twoLabel.text = @"(满意请点诺)";
    UISegmentedControl *segmented = [[UISegmentedControl alloc]initWithItems:@[@"否",@"是"]];
    if ([self.wz isEqualToString:@"0"]) {
         segmented.selectedSegmentIndex = 0;
    }else{
         segmented.selectedSegmentIndex = 1;
    }

    segmented.frame = CGRectMake(90, 9, 60, 25);
      segmented.tintColor = [UIColor orangeColor];
    [oneButton addTarget:self action:@selector(handleFiveButton:) forControlEvents:UIControlEventTouchUpInside];
   // [view addSubview:oneButton];
    [segmented addTarget:self action:@selector(handleSegmented:) forControlEvents:UIControlEventValueChanged];
    [view addSubview:segmented];
    [view addSubview:oneLabel];
    //[view addSubview:twoLabel];
    return view;
}
- (UIView *)ceatSixView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 70)];
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    _textField.placeholder = @"评价内容";
    self.aview = [[UITextView alloc]initWithFrame:CGRectMake(5, 20, kScreenWidth - 10, 40)];

    _aview.backgroundColor = [UIColor orangeColor];
    _aview.layer.borderWidth =1.0;//该属性显示外边框
    _aview.layer.cornerRadius = 6.0;//通过该值来设置textView边角的弧度
    _aview.layer.masksToBounds = YES;
      _aview.delegate = self;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(4, 0, 100, 20)];
   // label.backgroundColor = [UIColor blueColor];
    label.text = @"评价内容:";
    label.font = [UIFont systemFontOfSize:13];
    //aview.editable = NO;
   // [aview addSubview:label];
    [view addSubview:label];
    [view addSubview:_aview];
    return view;
}

- (UIView *)ceatSevenView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    UIButton *oneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UILabel *oneLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 2, 75, 40)];
    UILabel *twoLabel = [[UILabel alloc]initWithFrame:CGRectMake(105, 2, kScreenWidth-100, 40)];
    oneButton.frame = CGRectMake(0 , 2 , kScreenWidth, 40);
   // [oneButton setImage:[UIImage imageNamed:@"orangenuo"] forState:UIControlStateNormal];
    [oneButton setTitle:@"提  交  评  价" forState:UIControlStateNormal];
    oneButton.backgroundColor =  [UIColor colorWithRed:0/255.0 green:179/255.0 blue:163/255.0 alpha:1];
    
    
    oneLabel.text = @"综合评价:";
    oneLabel.font = [UIFont systemFontOfSize:16];
    twoLabel.font = [UIFont systemFontOfSize:16];
    twoLabel.text = @"(满意请点诺)";
    [oneButton addTarget:self action:@selector(handleSevenButton:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:oneButton];
   
    return view;
}

//第一行的按钮的响应方法
- (void)handleOneButton:(UIButton *)sender{
    NSLog(@"汤一夜");
    if(sender.isSelected == NO){
        self.zh = @"1";
       // [sender setImage:[UIImage imageNamed:@"orangenuo"] forState:UIControlStateNormal];
        //记得昨晚操作之后，改变按钮的点击状态
          [self.tableView reloadData];
        sender.selected = YES;
    }else{
        self.zh =@"0";
      //[sender setImage:[UIImage imageNamed:@"greynuo"] forState:UIControlStateNormal];
          [self.tableView reloadData];
        sender.selected = NO;
    }
    
}
//第2行的按钮的响应方法
- (void)handleTwoButton:(UIButton *)sender{
    if(sender.isSelected == NO){
        self.service =@"1";
        //[sender setImage:[UIImage imageNamed:@"orangeservice"] forState:UIControlStateNormal];
          [self.tableView reloadData];
        //记得昨晚操作之后，改变按钮的点击状态
        sender.selected = YES;
    }else{
        self.service =@"0";
        //[sender setImage:[UIImage imageNamed:@"greyservice"] forState:UIControlStateNormal];
          [self.tableView reloadData];
        sender.selected = NO;
    }
    
    
    NSLog(@"汤2夜");
}
//第3行的按钮的响应方法
- (void)handleThreeButton:(UIButton *)sender{
      NSLog(@"汤3夜");
    if(sender.isSelected == NO){
        self.level = @"1";
        
        //[sender setImage:[UIImage imageNamed:@"orangetec"] forState:UIControlStateNormal];
         [self.tableView reloadData];
        //记得昨晚操作之后，改变按钮的点击状态
        sender.selected = YES;
  
    }else{
        NSLog(@"dadaddad");
        self.level = @"0";
                   //[self.tableView reloadData];
        //[sender setImage:[UIImage imageNamed:@"greytec"] forState:UIControlStateNormal];
         [self.tableView reloadData];
        sender.selected = NO;
     
    }
}
//第4行的按钮的响应方法
- (void)handleFourButton:(UIButton *)sender{
      NSLog(@"汤4夜");
            //[_aview resignFirstResponder];
    if(sender.isSelected == NO){
        self.huanj = @"1";
        //[sender setImage:[UIImage imageNamed:@"orangetree"] forState:UIControlStateNormal];
        //记得昨晚操作之后，改变按钮的点击状态
          [self.tableView reloadData];
        sender.selected = YES;
    }else{
        self.huanj = @"0";
        //[sender setImage:[UIImage imageNamed:@"greytree"] forState:UIControlStateNormal];
          [self.tableView reloadData];
        sender.selected = NO;
    }
}
//第5行的按钮的响应方法
- (void)handleFiveButton:(UIButton *)sender{
      NSLog(@"汤5夜");
}

- (void)handleSegmented:(UISegmentedControl *)sender{
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.wz = @"0";
            NSLog(@"按摩");
            break;
        case 1:
            self.wz = @"1";
            NSLog(@"捏脚");
            break;
        default:
            break;
    }
}
//第6行的按钮的响应方法
- (void)handleSixButton:(UIButton *)sender{
      NSLog(@"汤6夜");
}
//第7行的按钮的响应方法
- (void)handleSevenButton:(UIButton *)sender{
      NSLog(@"汤7夜");
    [self requestData];
}
//- (void)textViewDidBeginEditing:(UITextView *)textView{
//    
//}
// 配置键盘协议
//- (BOOL)textFieldShouldReturn:(UITextField *)textField{
//    [textField resignFirstResponder];
//    return YES;
//}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"汤五浪费！！！！！！");
    
    
    if (![_aview isExclusiveTouch]) {
        [_aview resignFirstResponder];
    }
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    NSLog(@"将要开始编辑？");
    NSTimeInterval animationDuration=0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    //上移30个单位，按实际情况设置
    CGRect rect=CGRectMake(0.0f,-110,width,height);
    self.view.frame=rect;
    [UIView commitAnimations];
 
    
    
    
    
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    NSLog(@"将要结束编辑");
    
    NSTimeInterval animationDuration=0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    //如果当前View是父视图，则Y为20个像素高度，如果当前View为其他View的子视图，则动态调节Y的高度
    //float Y = 30.0f;
    CGRect rect=CGRectMake(0.0f,0,width,height);
    self.view.frame=rect;
    [UIView commitAnimations];
    
    
    return YES;
}

- (void)requestData{
    NSString *str = @"http://www.enuo120.com/index.php/phone/Json/pj?username=%@&dnumber=%@&content=%@&zh=%@&service=%@&level=%@&huanj=%@&wz=%@";
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *name = [userDefaults objectForKey:@"name"];
        NSString * str1 = [self.aview.text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    self.dnumber = self.reseiver;
    self.content = str1;
    NSString *url = [NSString stringWithFormat:str,name,self.dnumber,self.content,self.zh,self.service,self.level,self.huanj,self.wz];
    NSLog(@"url =%@",url);
    BaseRequest *request = [[BaseRequest alloc]init];
    [request POST:url params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [self handleWithResponseObject:responseObject];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}
- (void)handleWithResponseObject:(NSDictionary *)responseObject{
    NSString *ste = responseObject[@"data"];
    RootTabBarViewController *rootvc = [[RootTabBarViewController alloc]init];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
        self.altert = [[UIAlertView alloc]initWithTitle:@"提示" message:ste delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
        self.altert.delegate =self;
        [self performSelector:@selector(popVC) withObject:nil afterDelay:0.5];
        
    }else{
        self.alertView = [UIAlertController alertControllerWithTitle:@"提示" message:ste preferredStyle:UIAlertControllerStyleAlert];
        [self.alertView addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            //NSLog(@"arr = %@",_arr);

            
            [self presentViewController:rootvc animated:YES completion:^{
                
            }];
        }]];
       
        [self performSelector:@selector(popVCcc) withObject:nil afterDelay:0.5];

    
    
    
}
}
- (void)popVC{
    [self.altert show];
}
    
- (void)popVCcc{
        [self presentViewController:self.alertView animated:YES completion:^{
            NSLog(@"汤五爷在此，尔等受死！！");
        }];
    }
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    RootTabBarViewController *rootvc = [[RootTabBarViewController alloc]init];
    switch (buttonIndex) {
        case 0:
            NSLog(@"跳转界面");
            
            [self presentViewController:rootvc animated:YES completion:^{
                
            }]; 
            break;
            
        default:
            break;
    }
}
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    
//}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
