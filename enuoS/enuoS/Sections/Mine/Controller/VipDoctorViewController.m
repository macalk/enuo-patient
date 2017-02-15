//
//  VipDoctorViewController.m
//  enuo4
//
//  Created by apple on 16/5/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "VipDoctorViewController.h"
#import <AFNetworking.h>
#import "Macros.h"
#import <UIImageView+WebCache.h>
#import"VipDoctorModel.h"
#import "HosViewController.h"
#import "DoctorTableViewCell.h"
#import "DoctorViewController.h"
@interface VipDoctorViewController ()
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation VipDoctorViewController
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
//  
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithTitle:@"医院入口" style:UIBarButtonItemStyleDone target: self action:@selector(handleHospitalMent)];
//    
//    self.navigationItem.rightBarButtonItem = leftItem;
//
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航条底图"] forBarMetrics:0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];

    self.navigationItem.title = @"在职医生";
    [self requsetData];
    [self.tableView registerNib:[UINib nibWithNibName:@"DoctorTableViewCell"  bundle:nil] forCellReuseIdentifier:@"cell"];
    self.navigationController.navigationBar.translucent = NO;
    
}
- (void)handleHospitalMent{
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DoctorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    VipDoctorModel *model = self.dataArray[indexPath.row];
    cell.nameLabel.text = model.name;
    cell.hospitalLabel.text = model.hospital_name;
    cell.nuoLabel.text = model.nuo;
    cell.zhenLabel.text = model.zhen;
    cell.illLabel.text = model.introduce;
    cell.treatmentLabel.text  = model.treatment;
    cell.professionalLabel.text = model.professional;
     NSString *urlphoto = [NSString stringWithFormat:urlPicture,model.doctor_photo];
    cell.treatmentLabel.numberOfLines = 0;
    cell.illLabel.numberOfLines = 0;
    [cell.DoctorPhoto sd_setImageWithURL:[NSURL URLWithString:urlphoto]placeholderImage:[UIImage imageNamed:@"index1_02"]];
     cell.picLabel.image = [UIImage imageNamed:@"orangenuo"];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGesture:)];
    tapGesture.numberOfTapsRequired = 1;
    cell.hospitalLabel.textColor = [UIColor blueColor];
    cell.hospitalLabel.userInteractionEnabled = YES;
    cell.hospitalLabel.font = [UIFont systemFontOfSize:15];
    [cell.hospitalLabel addGestureRecognizer:tapGesture];
    return cell;
}

- (void)handleTapGesture:(UITapGestureRecognizer *)tap{
    HosViewController *hosVC = [[HosViewController alloc]init];
    
    UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:hosVC];
    hosVC.receiver = self.hreceiver;
   [self presentViewController:naNC animated:YES completion:^{
     
   }];
 //   endVC.receiver = self.hreceiver;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   VipDoctorModel *model = self.dataArray[indexPath.row];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13.0f], NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGRect rectOne = [model.introduce boundingRectWithSize:CGSizeMake(kScreenWidth - 75, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    CGRect rectTwo = [model.treatment boundingRectWithSize:CGSizeMake(kScreenWidth - 75, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    
    
    return 180 + rectOne.size.height + rectTwo.size.height;
}


- (void)requsetData{
    NSString *str = @"http://www.enuo120.com/index.php/phone/json/illc2?cid=%@&hid=%@";
    
    NSString *url  = [NSString stringWithFormat:str,self.creceiver,self.hreceiver];
    NSLog(@"URL = %@",url);
    
    BaseRequest *request = [[BaseRequest alloc]init];
    [request POST:url params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [self handleModelWithDic:responseObject];

    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

        CGFloat cellHeight = [self.tableView rectForRowAtIndexPath:indexPath].size.height;
        NSLog(@"cellHeight = %lf",cellHeight);
        
       VipDoctorModel *model = self.dataArray[indexPath.row];
    
    DoctorViewController *docVC = [[DoctorViewController alloc]init];
     UINavigationController *naNC = [[UINavigationController alloc]initWithRootViewController:docVC];
    
       docVC.receiver = model.cid;
 
    [self presentViewController:naNC animated:YES completion:^{
        
    }];

 
        
        
    }


- (void)handleModelWithDic:(NSDictionary *)dic{
   NSArray *arr = dic[@"data"];
    for (NSDictionary *temp in arr) {
        
        VipDoctorModel *model = [VipDoctorModel vipModelInitWithDic:temp];
        [self.dataArray addObject:model];
    }[self.tableView reloadData];
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
