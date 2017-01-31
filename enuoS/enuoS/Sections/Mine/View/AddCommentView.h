//
//  AddCommentView.h
//  enuoS
//
//  Created by apple on 16/12/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PjDocModel.h"


@interface AddCommentView : UIView

@property (nonatomic,strong)PjDocModel *model;

@property (nonatomic,copy)NSString *type;
@property (nonatomic,strong)UIButton *sendBtn;
@property (nonatomic,strong)UITextView *textView;

- (void)createViewWithTextField:(UITextView *)textView withSendTextBtn:(UIButton *)sender;

@end
