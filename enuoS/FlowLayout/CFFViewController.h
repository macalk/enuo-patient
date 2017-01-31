//
//  CFFViewController.h
//  enuoS
//
//  Created by apple on 16/11/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CFFlowButtonView.h"

@interface CFFViewController : UITableViewController

@property (nonatomic,strong) CFFlowButtonView *flowButtonView;

- (instancetype)initWithTitleList:(NSMutableArray *)titleList withBtnList:(NSMutableArray *)btnListArr;

@end
