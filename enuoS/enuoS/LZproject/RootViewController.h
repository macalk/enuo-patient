//
//  RootViewController.h
//  enuoDoctor
//
//  Created by apple on 16/12/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController

//提示框
- (void)createAlterViewWithMessage:(NSString *)message withSureBtn:(BOOL)sureYON withCancelBtn:(BOOL)cancelYON withDeleteBtn:(BOOL)deleteYON;

//自定义Nav
- (void)createCustomNavViewWithTitle:(NSString *)titleStr andLeftImage:(NSString *)leftImageStr withLeftTitle:(NSString *)leftTitleStr andRightImage:(NSString *)rightImageStr withRightTitle:(NSString *)rightTitleStr;

- (void)leftItemBack;
- (void)rightItemClick;
@property (nonatomic,copy) NSString *publicKey;
@end
