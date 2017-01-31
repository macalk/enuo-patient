//
//  CFFlowButtonView.h
//  CFFlowButtonView
//
//  Created by 周凌宇 on 15/10/27.
//  Copyright © 2015年 周凌宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CFFlowButtonView : UIView

/**
 *  存放需要显示的button
 */
@property (nonatomic, strong) NSMutableArray *buttonList;
@property (nonatomic, strong) NSMutableArray *oneButtonList;
@property (nonatomic, strong) NSMutableArray *twoButtonList;
@property (nonatomic, strong) NSMutableArray *threeBtonList;
@property (nonatomic, strong) NSArray *currenArr;
@property (nonatomic, strong) NSArray *titleList;

@property (nonatomic, strong) UILabel *cateLabel;
@property (nonatomic, strong) UILabel *treatLabel;
@property (nonatomic, strong) UILabel *hoseLabel;


@property (nonatomic, strong) UIButton *lastBtn;
@property (nonatomic, strong) UIButton *sureBtn;



/**
 *  通过传入一组按钮初始化CFFlowButtonView
 *
 *  @param buttonList 按钮数组
 *
 *  @return CFFlowButtonView对象
 */
- (instancetype)initWithButtonList:(NSMutableArray *)buttonList WithTitleList:(NSMutableArray *)titleList;
@end
