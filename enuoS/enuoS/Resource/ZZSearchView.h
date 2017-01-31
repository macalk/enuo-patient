//
//  ZZSearchView.h
//  enuoS
//
//  Created by apple on 16/8/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZSearchView : UIView
@property (strong,nonatomic)void (^ZZGetTitle)(NSString * Title);
@property (strong,nonatomic)void (^ZZGetCancel)(void);



@property (weak, nonatomic) IBOutlet UIButton *changeBtn;

@property (weak, nonatomic) IBOutlet UIView *ZZBgView;

@property (weak, nonatomic) IBOutlet UITextField *ZZSearch;


@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;



//创建视图

+ (instancetype)creatView;


@end
