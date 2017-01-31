//
//  ZZSearchView.m
//  enuoS
//
//  Created by apple on 16/8/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZZSearchView.h"

@implementation ZZSearchView
-(void)awakeFromNib
{
    self.ZZBgView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navi"]];
   
    self.ZZSearch.leftView = [self leftView];
    self.ZZSearch.leftViewMode = UITextFieldViewModeAlways;
    
    self.ZZSearch.returnKeyType = UIReturnKeySearch;
    self.ZZSearch.clearsOnBeginEditing = YES;
    self.ZZSearch.keyboardType =  UIKeyboardTypeDefault;
}

+(instancetype)creatView
{
    return [[[NSBundle mainBundle]loadNibNamed:@"ZZSearchView" owner:nil options:nil]lastObject];
}

-(UIView *)leftView
{
//    UIView * leftView = [[UIView alloc]initWithFrame:CGRectMake(18, 8, 24, 24)];
//    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(8, 4, 16, 16);
//   // [button setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(searchTile) forControlEvents:UIControlEventTouchUpInside];
//    [leftView addSubview:button];
//    return leftView;
    
    
    return nil;
}

-(void)searchTile
{
    [self.ZZSearch resignFirstResponder];
    self.ZZGetTitle(self.ZZSearch.text);
}

- (IBAction)ZZCancel:(UIButton *)sender {
    
    
  [self.ZZSearch resignFirstResponder];
    self.ZZGetCancel();
}


@end
