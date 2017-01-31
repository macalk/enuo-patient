//
//  SearchViewController.h
//  enuoS
//
//  Created by apple on 16/8/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
+ (SearchViewController *)searchViewController;

@end
