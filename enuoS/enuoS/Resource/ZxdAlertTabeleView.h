//
//  ZxdAlertTabeleView.h
//  enuoS
//
//  Created by apple on 16/8/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ZxdAlertTabeleView;
@protocol ZxdAlertTabeleViewDelegate <NSObject>

- (void)sendeId:(NSInteger)row;

@end









@interface ZxdAlertTabeleView : UIView
@property (nonatomic,weak)id<ZxdAlertTabeleViewDelegate>mydelegate;

//从外面传进来的数据数组
@property (nonatomic, strong) NSArray *dataArray;

//弹出
- (void)pop;

//隐藏
- (void)dismiss;


@end
