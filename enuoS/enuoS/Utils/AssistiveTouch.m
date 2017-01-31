//
//  AssistiveTouch.m
//  navTest
//
//  Created by Lrs on 13-10-16.
//  Copyright (c) 2013年 Lrs. All rights reserved.
//

#import "AssistiveTouch.h"
#define WIDTH self.frame.size.width
#define HEIGHT self.frame.size.height
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#import <UIImageView+WebCache.h>
#import "Macros.h"
@implementation AssistiveTouch

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
     }
    return self;
}
-(id)initWithFrame:(CGRect)frame imageName:(NSString *)name
{
    if(self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];
//        self.windowLevel = UIWindowLevelAlert;
//        [self makeKeyAndVisible];
//        UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
//        [keyWindow addSubview:self];
//        _activeLabel = [[UILabel alloc]initWithFrame:(CGRect){0, 0,frame.size.width,     frame.size.height}];
//        _activeLabel.font = [UIFont  systemFontOfSize:13.0];
//        _activeLabel.text = name;
//        _activeLabel.alpha = 0.3;
//        _activeLabel.backgroundColor = [UIColor orangeColor];
//        [self addSubview:_activeLabel];
        // CGFloat viewX = (self.frame.size.width-200)/2;
//        self.layer.borderColor = [UIColor whiteColor].CGColor;
//        self.layer.borderWidth = 1.0;
        self.layer.cornerRadius = 6.0;
         self.layer.masksToBounds = YES;
        UIView *viewAnima = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        viewAnima.backgroundColor = [UIColor  yellowColor];
        self.viewAnima = viewAnima;
        self.viewAnima.clipsToBounds = YES;
        
        //定义视图容器
        //     [self.view addSubview:viewAnima];
        //    self.navigationItem.titleView = self.viewAnima;
      //  [self addSubview:self.viewAnima];
        
        CGFloat customLabY = (self.viewAnima.frame.size.height - 30)/2;
        UILabel *customLab = [[UILabel alloc] init];
        customLab.frame = CGRectMake(self.viewAnima.frame.size.width, customLabY, 250, 30);
        [customLab setTextColor:[UIColor redColor]];
        [customLab setText:name];
        customLab.font = [UIFont boldSystemFontOfSize:17];
        self.customLab = customLab;
        UIImageView *oneImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        NSString *oneStr = [NSString stringWithFormat:urlPicture,name];
        [oneImage sd_setImageWithURL:[NSURL URLWithString:oneStr] placeholderImage:nil];
        
        oneImage.backgroundColor = [UIColor clearColor];
        oneImage.userInteractionEnabled = YES;
        //添加视图
        [self addSubview:oneImage];
        


        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(locationChange:)];
        pan.delaysTouchesBegan = YES;
        [self addGestureRecognizer:pan];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
        [self addGestureRecognizer:tap];
    }
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                  target:self selector:@selector(changePos)
                                                userInfo:nil repeats:YES];
    return self;
}
//改变位置
-(void)locationChange:(UIPanGestureRecognizer*)p
{
    //[[UIApplication sharedApplication] keyWindow]
    CGPoint panPoint = [p locationInView:[[UIApplication sharedApplication] keyWindow]];
    if(p.state == UIGestureRecognizerStateBegan)
    {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(changeColor) object:nil];
        _viewAnima.alpha = 0.8;
        
    }
    else if (p.state == UIGestureRecognizerStateEnded)
    {
        [self performSelector:@selector(changeColor) withObject:nil afterDelay:4.0];
    }
    if(p.state == UIGestureRecognizerStateChanged)
    {
        self.center = CGPointMake(panPoint.x, panPoint.y);
    }
    else if(p.state == UIGestureRecognizerStateEnded)
    {
        if(panPoint.x <= kScreenWidth/2)
        {
            if(panPoint.y <= 40+HEIGHT/2 && panPoint.x >= 20+WIDTH/2)
            {
                [UIView animateWithDuration:0.2 animations:^{
                    self.center = CGPointMake(panPoint.x, HEIGHT/2);
                }];
            }
            else if(panPoint.y >= kScreenHeight-HEIGHT/2-40 && panPoint.x >= 20+WIDTH/2)
            {
                [UIView animateWithDuration:0.2 animations:^{
                    self.center = CGPointMake(panPoint.x, kScreenHeight-HEIGHT/2);
                }];
            }
            else if (panPoint.x < WIDTH/2+15 && panPoint.y > kScreenHeight-HEIGHT/2)
            {
                [UIView animateWithDuration:0.2 animations:^{
                    self.center = CGPointMake(WIDTH/2, kScreenHeight-HEIGHT/2);
                }];
            }
            else
            {
                CGFloat pointy = panPoint.y < HEIGHT/2 ? HEIGHT/2 :panPoint.y;
                [UIView animateWithDuration:0.2 animations:^{
                    self.center = CGPointMake(WIDTH/2, pointy);
                }];
            }
        }
        else if(panPoint.x > kScreenWidth/2)
        {
            if(panPoint.y <= 40+HEIGHT/2 && panPoint.x < kScreenWidth-WIDTH/2-20 )
            {
                [UIView animateWithDuration:0.2 animations:^{
                    self.center = CGPointMake(panPoint.x, HEIGHT/2);
                }];
            }
            else if(panPoint.y >= kScreenHeight-40-HEIGHT/2 && panPoint.x < kScreenWidth-WIDTH/2-20)
            {
                [UIView animateWithDuration:0.2 animations:^{
                    self.center = CGPointMake(panPoint.x, 480-HEIGHT/2);
                }];
            }
            else if (panPoint.x > kScreenWidth-WIDTH/2-15 && panPoint.y < HEIGHT/2)
            {
                [UIView animateWithDuration:0.2 animations:^{
                    self.center = CGPointMake(kScreenWidth-WIDTH/2, HEIGHT/2);
                }];
            }
            else
            {
                CGFloat pointy = panPoint.y > kScreenHeight-HEIGHT/2 ? kScreenHeight-HEIGHT/2 :panPoint.y;
                [UIView animateWithDuration:0.2 animations:^{
                    self.center = CGPointMake(320-WIDTH/2, pointy);
                }];
            }
        }
    }
}

//点击事件
-(void)click:(UITapGestureRecognizer*)t
{
    _viewAnima.alpha = 0.8;
    [self performSelector:@selector(changeColor) withObject:nil afterDelay:4.0];
    if(_assistiveDelegate && [_assistiveDelegate respondsToSelector:@selector(assistiveTocuhs)])
    {
        [_assistiveDelegate assistiveTocuhs];
    }
}

- (void) changePos
{
    CGPoint curPos = _customLab.center;
   // NSLog(@"%f",self.customLab.center.x);
    // 当curPos的x坐标已经超过了屏幕的宽度
    if(curPos.x <  -100 )
    {
        CGFloat jianJu = _customLab.frame.size.width/2;
        // 控制蝴蝶再次从屏幕左侧开始移动
        _customLab.center = CGPointMake(self.frame.size.width + jianJu, 20);
        
    }
    else
    {
        // 通过修改iv的center属性来改变iv控件的位置
        _customLab.center = CGPointMake(curPos.x - 5, 20);
    }
    //其实蝴蝶的整个移动都是————靠iv.center来去设置的
}

-(void)changeColor
{
    [UIView animateWithDuration:2.0 animations:^{
        _viewAnima.alpha = 0.3;
    }];
}

@end
