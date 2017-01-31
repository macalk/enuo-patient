//
//  TitleButtomView.h
//  ShiGuangJi
//
//  Created by luzhen on 16/8/18.
//  Copyright © 2016年 杭州笑嘻嘻网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

//代理
@protocol titleButtonDelegate <NSObject>

- (void)titleButtonClickDelegate:(NSInteger)btnTag;

@end



@interface TitleButtomView : UIView

@property (nonatomic,weak) id <titleButtonDelegate> delegate;

- (void)createTitleBtnWithBtnArray:(NSArray *)titleBtnArray;

//被动改变button的状态
- (void)changeButtonState:(NSInteger)buttonTag;

@end
