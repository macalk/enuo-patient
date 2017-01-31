//
//  LrdAlertTabeleView.h
//  enuoS
//
//  Created by apple on 16/8/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LrdAlertTableView;
@protocol LrdAlertTableViewDelegate <NSObject>

- (void)sendeId:(NSInteger)row;

@end








@interface LrdAlertTableView : UIView
@property (nonatomic,weak)id<LrdAlertTableViewDelegate>mydelegate;
//从外面传进来的数据数组
@property (nonatomic, strong) NSArray *dataArray;

//弹出
- (void)pop;

//隐藏
- (void)dismiss;

@end
