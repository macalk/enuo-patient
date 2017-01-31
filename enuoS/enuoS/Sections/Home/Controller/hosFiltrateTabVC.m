//
//  hosFiltrateTabVC.m
//  enuoS
//
//  Created by apple on 16/11/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "hosFiltrateTabVC.h"
#import "Macros.h"

@interface hosFiltrateTabVC ()

@end

@implementation hosFiltrateTabVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    
}

- (instancetype)initWithAreaArray:(NSArray *)areaArr andSortArr:(NSArray *)sortArr andTitleArr:(NSArray *)titleArr
{
    self = [super init];
    if (self) {
        self.tableView.separatorStyle = UITableViewCellAccessoryNone;
        [self createBtnWithAreaArray:areaArr andSortArr:sortArr andTitleArr:titleArr];
    }
    return self;
}

- (void)createBtnWithAreaArray:(NSArray *)areaArr andSortArr:(NSArray *)sortArr andTitleArr:(NSArray *)titleArr {
    hosFiltrateView *view = [[hosFiltrateView alloc]init];
    NSArray *array = [NSArray array];
    if (areaArr.count>sortArr.count) {
        array = areaArr;
    }else {
        array = sortArr;
    }
    NSLog(@"%ld",array.count);
    view.frame = CGRectMake(0, 0,kScreenWidth,(array.count+1)*44);
    self.filtView = view;
    [self.filtView createBtnWithAreaArray:areaArr andSortArr:sortArr andTitleArr:titleArr];
    self.tableView.tableHeaderView = self.filtView;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
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
