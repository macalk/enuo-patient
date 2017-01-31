//
//  FiltrateVC.m
//  Filtrate
//
//  Created by apple on 16/11/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH [UIScreen mainScreen].bounds.size.width

#import "FiltrateVC.h"

@interface FiltrateVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)NSMutableArray *sortArr;
@property (nonatomic,strong)NSMutableArray *areaArr;
@property (nonatomic,strong)NSMutableArray *titleArr;


@end

@implementation FiltrateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (instancetype)initWithAreaArray:(NSMutableArray *)areaArr andSortArr:(NSMutableArray *)sortArr
{
    self = [super init];
    if (self) {
        
        self.sortArr = sortArr;
        self.areaArr = areaArr;
        
        [self createTableView];
    }
    return self;
}

- (void)createTableView {
    
    
    for (int i = 0; i<2; i++) {
        
        UITableView *tableView = [[UITableView alloc]init];
        tableView.frame = CGRectMake(WIDTH/2*i, 64, WIDTH/2, HEIGHT-64);
        
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tag = 10+i;
        
        [self.view addSubview:tableView];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (tableView.tag) {
        case 10:
        {
            return self.areaArr.count;
            
        }
            break;
        case 11:
        {
            return self.sortArr.count;
            
        }
            break;
            
        default:
            break;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    UIButton *button = [[UIButton alloc]init];
    button.backgroundColor = [UIColor redColor];
    button.frame = CGRectMake(0, 0, WIDTH/2, 44);
    [cell.contentView addSubview:button];
    if (tableView.tag == 10) {
        [button setTitle:[NSString stringWithFormat:@"%@",self.areaArr[indexPath.row]] forState:normal];
    }else {
        [button setTitle:[NSString stringWithFormat:@"%@",self.sortArr[indexPath.row]] forState:normal];
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView.tag == 10) {
        
    }else {
        
        
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
