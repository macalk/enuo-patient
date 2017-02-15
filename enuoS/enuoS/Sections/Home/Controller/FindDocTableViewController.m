//
//  FindDocTableViewController.m
//  enuoNew
//
//  Created by apple on 16/7/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "FindDocTableViewController.h"
#import <MJRefresh.h>
#import "PromiseDocViewCell.h"
#import <AFNetworking.h>
#import "FindDocModel.h"
#import "Macros.h"
#import <UIImageView+WebCache.h>
#import "DoctorViewController.h"
#import "SarchDetailViewController.h"
#import "UIColor+Extend.h"
#import "SZKAlterView.h"

@interface FindDocTableViewController ()<UISearchBarDelegate>
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (assign, nonatomic) NSInteger num;

@end

@implementation FindDocTableViewController



- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }return _dataArray;
}



- (void)customNavView {
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"白色返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleWithBack:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    [titleLable setTextAlignment:NSTextAlignmentCenter];
    [titleLable setTextColor:[UIColor whiteColor]];
    [titleLable setText:@"找医生"];
    titleLable.font = [UIFont boldSystemFontOfSize:18];
    self.navigationItem.titleView = titleLable;
    
    self.navigationController.navigationBar.barTintColor = [UIColor stringTOColor:@"#22ccc6"];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customNavView];
    self.navigationController.navigationBar.translucent = NO;
    self.num = 1;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PromiseDocViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [self requestDocDetailData];

}


- (void)refresh{
    //NSLog(@"你是个大逗逼");
    [self.dataArray removeAllObjects];
    _num = 1;
    [self requestDocDetailData];
}

- (void)loadMore{
   // NSLog(@"都比都比");
    _num ++;
    [self requestDocDetailData];
}

- (void)handleWithBack:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
    UIView *searckView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
        
    searckView.backgroundColor = [UIColor whiteColor];
        
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(20, 6, kScreenWidth-40, 30)];
        searchBar.layer.borderWidth = 1;
        searchBar.layer.cornerRadius = 5;
        searchBar.clipsToBounds = YES;
        searchBar.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    searchBar.placeholder = @"搜索医生";
       searchBar.delegate = self;
    
    //移除searchbar的灰色背景  只留下textfield样式（需要iOS8.0以上版本 以下需要判断）
    for(int i =  0 ;i < searchBar.subviews.count;i++){
        
        UIView * backView = searchBar.subviews[i];
        
        if ([backView isKindOfClass:NSClassFromString(@"UISearchBarBackground")] == YES) {
            
            [backView removeFromSuperview];
            [searchBar setBackgroundColor:[UIColor clearColor]];
            break;
            
        }else{
            
            NSArray * arr = searchBar.subviews[i].subviews;
            
            for(int j = 0;j<arr.count;j++   ){
                
                UIView * barView = arr[i];
                
                if ([barView isKindOfClass:NSClassFromString(@"UISearchBarBackground")] == YES) {
                    
                    [barView removeFromSuperview];
                    [searchBar setBackgroundColor:[UIColor clearColor]];
                    break;
                    
                }
                
            }
            
        }
        
    }
    
    searchBar.keyboardType = UIKeyboardTypeDefault;
 
    [searckView addSubview:searchBar];
        
        return searckView;
        
    }else {
        UIView *searckView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 70)];
        
        searckView.backgroundColor = [UIColor stringTOColor:@"#f3f3f6"];
        
        UIButton *changeGroupBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        changeGroupBtn.backgroundColor = [UIColor stringTOColor:@"#00b09f"];
        changeGroupBtn.center = CGPointMake(searckView.center.x, searckView.center.y-10);
        changeGroupBtn.bounds = CGRectMake(0, 0, 100, 30);
        [changeGroupBtn setTitle:@"换一组" forState:normal];
        [changeGroupBtn setTitleColor:[UIColor whiteColor] forState:normal];
        changeGroupBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [changeGroupBtn addTarget:self action:@selector(changegroup:) forControlEvents:UIControlEventTouchUpInside];
        changeGroupBtn.layer.cornerRadius = 10;
        changeGroupBtn.clipsToBounds = YES;
        [searckView addSubview:changeGroupBtn];
        return searckView;

    }
    
}

- (void)changegroup:(UIButton *)sender {
    [self.dataArray removeAllObjects];
    _num = 1;
    [self requestDocDetailData];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    SarchDetailViewController *saVC = [[SarchDetailViewController alloc]init];
    UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:saVC];
    
    saVC.receiveMark = @"2";
    saVC.resualt = searchBar.text;
    [self presentViewController:naNC animated:YES completion:^{
        
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 44;

    }else {
        return 70;
    }
}


- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    return YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return self.dataArray.count;
    }else {
        return 0;
    }
    
    
}

//页面数据
- (void)requestDocDetailData{
    NSString *str = @"http://www.enuo120.com/index.php/app/index/find_doctor";
    NSString *username = [[NSUserDefaults standardUserDefaults]objectForKey:@"name"];
    if (username == nil) {
        username = @"";
    }
    NSDictionary *heardBody = @{@"ver":@"1.0",@"username":username};

    BaseRequest *request = [[BaseRequest alloc]init];
    [request POST:str params:heardBody success:^(NSURLSessionDataTask *task, id responseObject) {
        [self handleWithData:responseObject];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];

}

- (void)handleWithData:(NSDictionary *)data{
    if ([data[@"data"]isKindOfClass:[NSNull class]]) {
        NSLog(@"无数据");
//             [self endRefresh];
    }else{
        
        NSArray *arr= data[@"data"];
        
        [self.dataArray removeAllObjects];
        
        for (NSDictionary *temp in arr) {
            FindDocModel *model = [FindDocModel findDocModelInitWithDic:temp];
            NSLog(@"%ld",(long)model.guanzhu);
            [self.dataArray addObject:model];
        }
        [self.tableView reloadData];
        self.tableView.contentOffset = CGPointMake(0, 0);
    }
}

//医生关注按钮
- (void)requestAttentionDocWithID:(NSString *)cid andType:(NSInteger )type {
    NSLog(@"%@~~%ld",cid,(long)type);
    NSString *str = @"http://www.enuo120.com/index.php/app/patient/guanzhu";
    NSString * username = [[NSUserDefaults standardUserDefaults]objectForKey:@"name"];
    if (username == nil) {
        username = @"";
    }
    NSDictionary *heardBody = @{@"did":cid,@"username":username,@"type":[NSString stringWithFormat:@"%ld",(long)type],@"ver":@"1.0"};

    BaseRequest *request = [[BaseRequest alloc]init];
    [request POST:str params:heardBody success:^(NSURLSessionDataTask *task, id responseObject) {
        [self handleWithAttentionData:responseObject];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (void)handleWithAttentionData:(NSDictionary *)dic {
    
    NSString *str = dic[@"data"][@"errcode"];
    
    if ([str isEqualToString:@"0"]) {//关注成功
        
        NSLog(@"关注成功");
        [self requestDocDetailData];
        
    }else{
        
        NSLog(@"关注失败");
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PromiseDocViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    FindDocModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    cell.cid = model.cid;
    cell.nameLabel.text = model.name;
    cell.nuoNumber.text = model.nuo;
    cell.commentLabel.text = [NSString stringWithFormat:@"%ld",(long)model.comment_num];
    NSString *str0ne = [NSString stringWithFormat:urlPicture,model.photo];
    cell.illLabel.text = model.treatment;
    [cell.photoImage sd_setImageWithURL:[NSURL URLWithString:str0ne] placeholderImage:nil];
    cell.proLabel.text = model.professional;
    cell.deskLabel.text = model.dep_name;
    cell.pepLaebl.text = [NSString stringWithFormat:@"%@ 人",model.zhen];
    cell.hosLabel.text = model.hos_name;
    if (model.guanzhu  == 1) {//关注
        [cell.likeBtn setImage:[UIImage imageNamed:@"关注-s"] forState:normal];
    }else {
        [cell.likeBtn setImage:[UIImage imageNamed:@"关注"] forState:normal];
    }
    [cell.likeBtn addTarget:self action:@selector(likeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
   
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
    return cell;
}

//医生关注按钮
- (void)likeBtnClick:(UIButton *)sender {
    
    for (UIView *next = [sender superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[PromiseDocViewCell class]]) {
            PromiseDocViewCell *cell = (PromiseDocViewCell *)nextResponder;
            
            NSInteger type = cell.model.guanzhu;
            
            if (type  == 0) {//未关注
                [sender setImage:[UIImage imageNamed:@"关注-s"] forState:normal];
                type = 1;
            }else {
                [sender setImage:[UIImage imageNamed:@"关注"] forState:normal];
                type = 0;
            }
            [self requestAttentionDocWithID:cell.cid andType:type];
        }
    }
   
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 165;
}
-(void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DoctorViewController *docVC = [[DoctorViewController alloc]init];
    
    
    UINavigationController *navNC = [[UINavigationController alloc]initWithRootViewController:docVC];
    FindDocModel *monder = self.dataArray[indexPath.row];
    docVC.receiver = monder.cid;
    docVC.like = monder.guanzhu;
    [self presentViewController:navNC animated:YES completion:^{
        
    }];

   // [self.navigationController pushViewController:docVC animated:YES];
}


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
