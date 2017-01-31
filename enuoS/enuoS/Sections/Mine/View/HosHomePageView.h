//
//  HosHomePageView.h
//  enuoS
//
//  Created by apple on 16/11/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HosModel;

@interface HosHomePageView : UIView

@property (nonatomic,strong)HosModel *model;
@property (nonatomic,assign)CGFloat viewHeight;
@property (nonatomic,strong)UIButton *moreBtn;
@property (nonatomic,strong)UIButton *likeBtn;

- (void)createHeadViewWithType:(NSString *)type;

@end
