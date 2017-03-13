//
//  HomeView.h
//  enuoS
//
//  Created by apple on 17/3/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeView : UIView


@property (nonatomic,assign) CGFloat viewHeight;
@property (nonatomic,strong) NSMutableArray *deskButtonArr;
@property (nonatomic,strong) NSMutableArray *deskButtonTitleArr;

@property (nonatomic,strong) UIButton *uncomfortableBtn;//哪里不舒服
@property (nonatomic,strong) UIButton *beautifulBtn;    //美啦
@property (nonatomic,strong) UIButton *conventionBtn;   //约定
@property (nonatomic,strong) UIButton *findDocBtn;      //找医生
@property (nonatomic,strong) UIButton *findHosBtn;      //找医院
@property (nonatomic,strong) UIButton *arroundHosBtn;   //周边医院
@property (nonatomic,strong) UIButton *deskMoreBtn;     //更多科室


- (void)createHomeView;

@end
