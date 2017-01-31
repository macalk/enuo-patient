//
//  CFFViewController.m
//  enuoS
//
//  Created by apple on 16/11/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CFFViewController.h"
#import "UIView+Extension.m"
#import "CFFlowButtonView.h"
#import <Masonry.h>
#import "UIColor+Extend.h"


@interface CFFViewController ()

@property (nonatomic,strong)NSMutableArray *categoryListArray;
@property (nonatomic,strong)NSMutableArray *treatListArray;
@property (nonatomic,strong)NSMutableArray *hosListArray;

@property (nonatomic, strong) NSMutableArray *buttonList;

@property (nonatomic,strong)NSArray *hosArr;

@end

@implementation CFFViewController

- (instancetype)initWithTitleList:(NSMutableArray *)titleList withBtnList:(NSMutableArray *)btnListArr
{
    self = [super init];
    if (self) {
        self.tableView.separatorStyle = UITableViewCellEditingStyleNone;
        
        [self screenOutWithTitleList:titleList withBtnList:btnListArr];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

//筛选展开
- (void)screenOutWithTitleList:(NSMutableArray *)titleList withBtnList:(NSMutableArray *)btnListArr {
        
    // 实例化一个CFFlowButtonView对象
    CFFlowButtonView *flowButtonView = [[CFFlowButtonView alloc] initWithButtonList:btnListArr WithTitleList:titleList];
    self.flowButtonView = flowButtonView;
    flowButtonView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 2000);
    self.tableView.tableHeaderView = flowButtonView;
    
    flowButtonView.backgroundColor = [UIColor whiteColor];
    
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
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
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
