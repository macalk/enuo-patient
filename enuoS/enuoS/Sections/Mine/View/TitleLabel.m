//
//  TitleLabel.m
//  enuoS
//
//  Created by apple on 16/7/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "TitleLabel.h"

@implementation TitleLabel

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }return self;
}



- (void)setScale:(CGFloat)scale{
    
    self.textColor = [UIColor colorWithRed:scale green:0 blue:0 alpha:1];
    CGFloat transformScale = 1+scale*0.2;
    self.transform = CGAffineTransformMakeScale(transformScale, transformScale);
    
}





@end
