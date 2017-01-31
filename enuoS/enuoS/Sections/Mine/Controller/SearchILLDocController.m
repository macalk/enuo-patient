//
//  SearchILLDocController.m
//  enuoS
//
//  Created by apple on 16/8/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SearchILLDocController.h"
#import <AFNetworking.h>
#import <Masonry.h>
#import <SVProgressHUD.h>
#import <UIImageView+WebCache.h>
#import "Macros.h"
#import "SearchillDocModel.h"
#import "UIImageView+UIImageView_FaceAwareFill.h"
#import "SearchILLDocCell.h"
#import "DoctorViewController.h"
#import "DocOrderViewController.h"
#import "UIColor+Extend.h"
@interface SearchILLDocController ()<UITableViewDataSource,UITableViewDelegate>



@property (nonatomic,strong)NSMutableArray *mbDataArr;
@property (nonatomic,strong)NSMutableArray *docListArr;


@property (nonatomic,strong)UITableView *tableView;

@end

@implementation SearchILLDocController
- (NSMutableArray *)docListArr {
    if (!_docListArr) {
        _docListArr = [NSMutableArray array];
    }return _docListArr;
    
}
- (NSMutableArray *)mbDataArr {
    if (!_mbDataArr) {
        _mbDataArr = [NSMutableArray array];
    }return _mbDataArr;
}
- (UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeigth) style:UITableViewStyleGrouped];
    }return _tableView;
}



- (void)customNavView {
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"白色返回"] style:UIBarButtonItemStyleDone target:self action:@selector(handleWithBack:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
//    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
//    [titleLable setTextAlignment:NSTextAlignmentCenter];
//    [titleLable setTextColor:[UIColor whiteColor]];
//    [titleLable setText:[NSString stringWithFormat:@"%@:%@",self.illReceiver,self.treat]];
//    titleLable.font = [UIFont boldSystemFontOfSize:18];
//    self.navigationItem.titleView = titleLable;
    
    self.navigationController.navigationBar.barTintColor = [UIColor stringTOColor:@"#22ccc6"];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self customNavView];
    
    [SVProgressHUD show];
    [self requestData];
    [self creatTableView];
   
}
- (void)handleWithBack:(UIBarButtonItem *)sender{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)creatTableView{
    self.tableView.dataSource = self;
    self.tableView.delegate =self;
    [self.view addSubview:self.tableView];
     self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView .backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
}


- (void)requestData{
        
    NSString *url = @"http://www.enuo120.com/index.php/app/search/many_doctor";
    NSDictionary *headBody =@{@"category":self.category,@"treat":self.treat,@"ill":self.illReceiver,@"hid":self.hid,@"ver":@"1.0"};
    AFHTTPSessionManager *mager = [AFHTTPSessionManager manager];
    [mager POST:url parameters:headBody progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"RESSS = %@",responseObject);
        [self handleWithData:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

- (void)handleWithData:(NSDictionary *)dic{
    if ([dic[@"data"]isKindOfClass:[NSNull class]]) {
        NSLog(@"无数据");
    }else{
        if (![dic[@"data"][@"mb_list"] isEqual:[NSNull null]]) {
        NSDictionary *mbDic = dic[@"data"][@"mb_list"][0];
        NSLog(@"%@",mbDic);
        SearchillDocModel *model  = [SearchillDocModel SearchillDocModelInitWithDic:mbDic];
        [self.mbDataArr addObject:model];
        
        NSArray *docListArr = dic[@"data"][@"doc_list"];
        if (![docListArr isEqual:[NSNull null]]) {
            for (int i = 0; i<docListArr.count; i++) {
                
                NSDictionary *dic = docListArr[i];
                SearchillDocModel *model  = [SearchillDocModel SearchillDocModelInitWithDic:dic];
                [self.docListArr addObject:model];
            }
        }
        
        [self.tableView reloadData];
        }else {
            NSLog(@"mb_list 内容为空！！！！！");
        }
    }
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
    
    return self.docListArr.count;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 290;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 105;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.mbDataArr.count != 0) {
        
       SearchillDocModel *model = self.mbDataArr[0];
        
        //bgView
        UIView *aView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 70)];
        
        //topView
        UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
        [aView addSubview:topView];
        
        //topView上的topLable
        topView.backgroundColor = [UIColor whiteColor];
        UILabel *topLabel = [[UILabel alloc]init];
        
        if ([model.treat isEqual:[NSNull null]] || model.treat == nil) {
            model.treat = @"";
        }
        topLabel.font = [UIFont systemFontOfSize:15];
        topLabel.text = [NSString stringWithFormat:@"%@:%@",model.ill,model.treat];
        [topView addSubview:topLabel];
        
        //图片
        UIImageView *imager= [[UIImageView alloc]init];
        NSString *str = [NSString stringWithFormat:urlPicture,model.photo];
        [imager sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:nil];
        [aView addSubview:imager];

        
        UILabel *priceLabel = [[UILabel alloc]init];
        priceLabel.text = @"约定价格：";
        priceLabel.font = [UIFont systemFontOfSize:11];
        priceLabel.textColor = [UIColor stringTOColor:@"#666666"];
        [aView addSubview:priceLabel];
        UILabel *priceTextLabel = [[UILabel alloc]init];
        priceTextLabel.font = [UIFont systemFontOfSize:11];
        priceTextLabel.textColor = [UIColor stringTOColor:@"#666666"];
        if ([self.VIP isEqualToString:@"VIP"]) {
            priceTextLabel.text = model.heightprice;

        }else {
            priceTextLabel.text = [NSString stringWithFormat:@"¥%@-%@",model.lowprice,model.heightprice];

        }
        [aView addSubview:priceTextLabel];
        
        UILabel *dateLabel = [[UILabel alloc]init];
        dateLabel.font = [UIFont systemFontOfSize:11];
        dateLabel.textColor = [UIColor stringTOColor:@"#666666"];
        dateLabel.text = @"约定周期：";
        [aView addSubview:dateLabel];
        UILabel *dateTextLabel = [[UILabel alloc]init];
        dateTextLabel.font = [UIFont systemFontOfSize:11];
        dateTextLabel.textColor = [UIColor stringTOColor:@"#666666"];
        dateTextLabel.text = model.cycle;
        [aView addSubview:dateTextLabel];
        
        UILabel *hosLabel = [[UILabel alloc]init];
        hosLabel.font = [UIFont systemFontOfSize:11];
        hosLabel.textColor = [UIColor stringTOColor:@"#666666"];
        hosLabel.text = @"所在医院：";
        [aView addSubview:hosLabel];
        UILabel *hosTextLabel = [[UILabel alloc]init];
        hosTextLabel.font = [UIFont systemFontOfSize:11];
        hosTextLabel.textColor = [UIColor stringTOColor:@"#666666"];
        hosTextLabel.text = model.hos_name;
        [aView addSubview:hosTextLabel];
        
        [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(topView.mas_centerX);
            make.centerY.equalTo(topView.mas_centerY);
        }];
        
        [imager mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topView.mas_bottom);
            make.height.mas_equalTo(imager.mas_width).multipliedBy(0.6);
            make.width.mas_offset(kScreenWidth);
        }];
        
        [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(aView).with.offset(20);
            make.top.equalTo(imager.mas_bottom).with.offset(10);
        }];
        [priceTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(priceLabel);
            make.left.equalTo(priceLabel.mas_right);
            
        }];
        
        
        [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(priceLabel.mas_bottom).with.offset(5);
            make.left.equalTo(priceLabel);
        }];
        [dateTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(dateLabel);
            make.left.equalTo(dateLabel.mas_right);
        }];
        
        [hosLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(aView).with.offset(20);
            make.top.equalTo(dateLabel.mas_bottom).with.offset(5);

        }];
        [hosTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(hosLabel);
            make.left.equalTo(hosLabel.mas_right);
        }];
        
        return aView;
        
    }else{
        return nil;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SearchILLDocCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchILLDocCell"];
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"SearchILLDocCell" owner:self options:nil];
        for (id tempCell in array) {
            if ([tempCell isKindOfClass:[SearchILLDocCell class]]) {
                cell = tempCell;
            }
        }
    }
    
    SearchillDocModel *model = self.docListArr[indexPath.row];
    cell.model = model;
    
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DocOrderViewController *docOrderVC = [[DocOrderViewController alloc]init];
    SearchillDocModel *CellModel = self.docListArr[indexPath.row];
    docOrderVC.hosId = self.hid;
    docOrderVC.dep_id = self.dep_id;
    docOrderVC.illID = self.mb_id;
    docOrderVC.currentSunDeskID = self.PID;
    docOrderVC.docId = CellModel.ID;
    docOrderVC.docName = CellModel.name;
    docOrderVC.VIP = @"VIP";
    
    SearchillDocModel *model = self.mbDataArr[0];
    docOrderVC.hosName = model.hos_name;
    docOrderVC.ill = model.ill;//疾病
    docOrderVC.cureWay = model.treat;//治疗方式
    docOrderVC.price = [NSString stringWithFormat:@"%@-%@",model.lowprice,model.heightprice];//约定价格
    docOrderVC.classify = self.category;//
    docOrderVC.cycle = model.cycle;////约定周期
    
    UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:docOrderVC];
    [self presentViewController:naNC animated:YES completion:^{
        
    }];
    
    /***
    doVC.receiver =self.docArr[indexPath.row][@"id"];
    
     
    ***/
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
