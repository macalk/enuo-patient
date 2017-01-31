//
//  hosFiltrateTabVC.h
//  enuoS
//
//  Created by apple on 16/11/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "hosFiltrateView.h"

@interface hosFiltrateTabVC : UITableViewController

@property (nonatomic,strong)hosFiltrateView *filtView;

- (instancetype)initWithAreaArray:(NSArray *)areaArr andSortArr:(NSArray *)sortArr andTitleArr:(NSArray *)titleArr;

@end
