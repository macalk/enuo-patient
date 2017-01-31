//
//  hosFiltrateView.h
//  enuoS
//
//  Created by apple on 16/11/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface hosFiltrateView : UIView

@property (nonatomic,strong)UIButton *selectAreaBtn;
@property (nonatomic,strong)UIButton *selectSortBtn;

@property (nonatomic,strong)NSArray *areaArr;
@property (nonatomic,strong)NSArray *sortArr;
@property (nonatomic,strong)NSArray *titleArr;



- (void)createBtnWithAreaArray:(NSArray *)areaArr andSortArr:(NSArray *)sortArr andTitleArr:(NSArray *)titleArr;
@end
