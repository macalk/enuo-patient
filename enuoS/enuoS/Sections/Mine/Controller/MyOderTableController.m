//
//  MyOderTableController.m
//  enuoS
//
//  Created by apple on 16/7/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MyOderTableController.h"
#import "WaitDocTableViewCell.h"
#import "TreatOrSunrCell.h"
#import "CheckPayCell.h"
#import "TreatPayCell.h"
#import "RefundTableViewCell.h"
@interface MyOderTableController ()



@property (nonatomic,strong)NSMutableArray *dataArray;


@end

@implementation MyOderTableController




- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
        
    }return _dataArray;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"WaitDocTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellOne"];
    [self.tableView registerNib:[UINib nibWithNibName:@"TreatOrSunrCell" bundle:nil] forCellReuseIdentifier:@"cellTwo"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CheckPayCell" bundle:nil] forCellReuseIdentifier:@"cellThree"];
    [self.tableView registerNib:[UINib nibWithNibName:@"RefundTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellFour"];
    [self.tableView registerNib:[UINib nibWithNibName:@"TreatPayCell" bundle:nil] forCellReuseIdentifier:@"cellFive"];
}
-(void)ceshi
{
    NSLog(@"开始刷新");
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

    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSLog(@"nsnnsnsnsnsn=======%@",self.receiver);
    cell.textLabel.text = self.title;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat coffset = fabs(scrollView.contentOffset.y/50);
    
    if (coffset == 1) {
        UIEdgeInsets set = UIEdgeInsetsMake(50, 0, 0, 0);
        
        self.tableView.contentInset = set;
    }
    
    
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
 
    
    
}


-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified it*/

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
