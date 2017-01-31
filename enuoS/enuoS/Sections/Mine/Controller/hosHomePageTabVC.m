//
//  hosHomePageTabVC.m
//  enuoS
//
//  Created by apple on 16/11/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "hosHomePageTabVC.h"
#import "HosHomePageView.h"
#import <AFNetworking.h>
#import "HosModel.h"
#import "Macros.h"
#import "UIColor+Extend.h"
#import <Masonry.h>
#import <SDWebImage/UIButton+WebCache.h>

@interface hosHomePageTabVC ()
@property (nonatomic,strong)HosHomePageView *headView;
@property (nonatomic,strong)HosModel *hoseDataModel;
@property (nonatomic,strong)HosModel *deskDataModel;

@property (nonatomic,strong)NSMutableArray *hoseDataArr;
@property (nonatomic,strong)NSMutableArray *deskListArr;
@property (nonatomic,strong)NSMutableArray *docListArr;


@end

@implementation hosHomePageTabVC

- (NSMutableArray *)hoseDataArr {
    if (!_hoseDataArr) {
        _hoseDataArr = [NSMutableArray array];
    }return _hoseDataArr;
}

- (NSMutableArray *)deskListArr {
    if (!_deskListArr) {
        _deskListArr = [NSMutableArray array];
    }return _deskListArr;
}
- (NSMutableArray *)docListArr {
    if (!_docListArr) {
        _docListArr = [NSMutableArray array];
    }return _docListArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestData];
    
}


//医院详情请求
- (void)requestData{
    
    NSString *str = @"http://www.enuo120.com/index.php/app/hospital/home";
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *username = [userDefault objectForKey:@"name"];
    if (username ==NULL) {
        username = @"";
    }
    NSLog(@"name = %@",username);
    NSDictionary *heardBody = @{@"username":username,@"hid":self.receiver,@"ver":@"1.0"};
    
    AFHTTPSessionManager *manegr = [AFHTTPSessionManager manager];
    
    [manegr POST:str parameters:heardBody progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject = %@",responseObject);
        
        [self handleWithHosData:responseObject];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
}
//医院详情页面数据处理
- (void)handleWithHosData:(NSDictionary *)dic{
    
    HosModel *model = [HosModel hosModelWithData:dic[@"data"]];
    self.hoseDataModel = model;
    
    NSArray *docListArr = dic[@"data"][@"doc_list"];
    for (int i = 0; i<docListArr.count; i++) {
        HosModel *docModel = [HosModel hosModelWithData:docListArr[i]];
        [self.docListArr addObject:docModel];
    }
    
    //请求科室
    [self deskRequestData];
    
}
//请求科室
- (void)deskRequestData {
    NSString *str = @"http://www.enuo120.com/index.php/app/hospital/home_keshi";
    
    NSDictionary *heardBody = @{@"hid":self.receiver,@"ver":@"1.0"};
    
    AFHTTPSessionManager *manegr = [AFHTTPSessionManager manager];
    
    [manegr POST:str parameters:heardBody progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject = %@",responseObject);
        
        [self handleWithDeskData:responseObject];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}


//科室数据处理
- (void)handleWithDeskData:(NSDictionary *)dic {
    
    NSArray *deskArr = dic[@"data"];
    for (int i = 0; i<deskArr.count; i++) {
        NSDictionary *dic = deskArr[i];
        HosModel *model = [HosModel hosModelWithData:dic];
        [self.deskListArr addObject:model];
    }
    
    [self createHeadView];
}

//创建头视图
- (void)createHeadView {
    self.headView = [[HosHomePageView alloc]init];
    self.headView.userInteractionEnabled = YES;
    self.headView.backgroundColor = [UIColor redColor];
    self.headView.frame = CGRectMake(0, 0, kScreenWidth, 100);
    [self.tableView.tableHeaderView addSubview:self.headView];
    self.headView.model = self.hoseDataModel;
    [self.headView createHeadViewWithType:nil];
    self.headView.frame = CGRectMake(0, 0, kScreenWidth, self.headView.viewHeight);
    
    //创建scrollview
    [self createSrcollView];
}

//创建scrollview
- (void)createSrcollView {
    
    NSArray *titleArr = @[@"科室",@"医院自荐专家"];
    for (int i = 0; i<2; i++) {
        
        UIScrollView *scrollView = [[UIScrollView alloc]init];
        scrollView.frame = CGRectMake(0, self.headView.viewHeight+133*i, kScreenWidth, 132);
        scrollView.backgroundColor = [UIColor redColor];
        [self.view addSubview:scrollView];
        
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.text = titleArr[i];
        [self.view addSubview:titleLabel];
        titleLabel.font = [UIFont systemFontOfSize:13];
        titleLabel.textColor = [UIColor stringTOColor:@"#00faf1"];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).with.offset(20);
            make.top.equalTo(scrollView).with.offset(10);
        }];
        
        CGFloat space = (kScreenWidth - 48*4)/5;//间距
        
        if (i == 0) {//科室scro
            scrollView.contentSize = CGSizeMake(kScreenWidth*(self.deskListArr.count/4), 0);
            
            for (int j = 0; j<self.deskListArr.count; j++) {
                
               HosModel *model= self.deskListArr[j];
                
                UIButton *deskBtn = [[UIButton alloc]init];
                deskBtn.frame = CGRectMake(kScreenWidth*(j/4)+space*(j%4+1)+48*j, 33, 48, 48);
                deskBtn.layer.cornerRadius = 24;
                deskBtn.clipsToBounds = YES;
                deskBtn.backgroundColor = [UIColor greenColor];
                [deskBtn sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:urlPicture,model.photo]] forState:normal];
                [scrollView addSubview:deskBtn];
            
                UILabel *deskTitLabel = [[UILabel alloc]init];
                deskTitLabel.text = model.department;
                deskTitLabel.font = [UIFont systemFontOfSize:10];
                [scrollView addSubview:deskTitLabel];
                [deskTitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(deskBtn.mas_centerX);
                    make.top.equalTo(deskBtn.mas_bottom).with.offset(10);
                    make.height.mas_offset(@10);
                }];
            }
            
        }else {//专家scro
            for (int j = 0; j<self.docListArr.count; j++) {
                
                scrollView.contentSize = CGSizeMake(kScreenWidth*(self.docListArr.count/4), 0);
                
                HosModel *model= self.docListArr[j];
                
                UIButton *docNameBtn = [[UIButton alloc]init];
                docNameBtn.frame = CGRectMake(kScreenWidth*(j/4)+space*(j%4+1)+48*j, 33, 48, 48);
                docNameBtn.layer.cornerRadius = 24;
                docNameBtn.clipsToBounds = YES;
                docNameBtn.backgroundColor = [UIColor greenColor];
                [docNameBtn sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:urlPicture,model.photo]] forState:normal];
                [scrollView addSubview:docNameBtn];
                
                UILabel *nameLabel = [[UILabel alloc]init];
                nameLabel.text = model.name;
                nameLabel.font = [UIFont systemFontOfSize:10];
                [scrollView addSubview:nameLabel];
                [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(docNameBtn.mas_centerX);
                    make.top.equalTo(docNameBtn.mas_bottom).with.offset(10);
                    make.height.mas_offset(@10);
                }];
            }

        }
        
        
    }
    
    [self.tableView.tableHeaderView addSubview: self.view];

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return self.view.frame.size.height;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if ( cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = @"11111";
    
    
    return cell;
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
