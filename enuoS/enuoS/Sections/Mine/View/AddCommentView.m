//
//  AddCommentView.m
//  enuoS
//
//  Created by apple on 16/12/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AddCommentView.h"
#import <UIImageView+WebCache.h>
#import <Masonry.h>
#import "Macros.h"
#import "UIColor+Extend.h"

@implementation AddCommentView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)createViewWithTextField:(UITextView *)textView withSendTextBtn:(UIButton *)sender{
    
    UILabel *typeLabel = [[UILabel alloc]init];
    typeLabel.text = @"评价医生:";
    typeLabel.font = [UIFont systemFontOfSize:15];
    typeLabel.textColor = [UIColor blackColor];
    [self addSubview:typeLabel];
    
    UIImageView *imageView = [[UIImageView alloc]init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:urlPicture,self.model.photo]] placeholderImage:nil];
    [self addSubview:imageView];
    
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.text = self.model.doc_name;
    nameLabel.textColor = [UIColor stringTOColor:@"#22ccc6"];
    nameLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:nameLabel];
    
    UILabel *deskLabel = [[UILabel alloc]init];
    deskLabel.textColor = [UIColor lightGrayColor];
    deskLabel.text = self.model.professional;
    deskLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:deskLabel];
    
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.text = self.model.content;
    contentLabel.font = [UIFont systemFontOfSize:13];
    contentLabel.textColor = [UIColor blackColor];
    contentLabel.numberOfLines = 0;
    [self addSubview:contentLabel];
    
    UILabel *attitudeLabel = [[UILabel alloc]init];
    attitudeLabel.text = @"态度: ";
    attitudeLabel.font = [UIFont systemFontOfSize:13];
    attitudeLabel.textColor = [UIColor blackColor];
    [self addSubview:attitudeLabel];
    
    UILabel *envOrSkillLabel = [[UILabel alloc]init];
    envOrSkillLabel.textColor = [UIColor blackColor];
    envOrSkillLabel.font = [UIFont systemFontOfSize:13];
    envOrSkillLabel.text = @"技术: ";
    [self addSubview:envOrSkillLabel];
    
    
    
    UILabel *lineOneLabel = [[UILabel alloc]init];
    lineOneLabel.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:lineOneLabel];
    
    UILabel *addCommentLable = [[UILabel alloc]init];
    addCommentLable.font = [UIFont systemFontOfSize:15];
    addCommentLable.textColor = [UIColor blackColor];
    addCommentLable.text = @"追加评价: ";
    [self addSubview:addCommentLable];
    
    
    self.textView = textView;
    self.textView.text = @"请对本次的约定医疗做出追加评价。";
    self.textView.textColor = [UIColor lightGrayColor];
    self.textView.font = [UIFont systemFontOfSize:13];
    [self addSubview:self.textView];
    
    UILabel *lineTwoLabel = [[UILabel alloc]init];
    lineTwoLabel.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:lineTwoLabel];
    
    
    sender.backgroundColor = [UIColor stringTOColor:@"#22ccc6"];
    [sender setTitleColor:[UIColor whiteColor] forState:normal];
    [sender setTitle:@"发表评价" forState:normal];
    [self addSubview:sender];
    
    //如果是医院VC加载
    if ([self.type isEqualToString:@"hospital"]) {
        typeLabel.text = @"评价医院:";
        envOrSkillLabel.text = @"环境: ";
        nameLabel.text = self.model.hos_name;
        deskLabel.text = self.model.rank;
    }
    
    [typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(20);
        make.left.equalTo(self).with.offset(20);
    }];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(typeLabel.mas_bottom).with.offset(8);
        make.left.equalTo(self).with.offset(20);
        make.size.mas_offset(CGSizeMake(52, 32));
    }];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(imageView);
        make.left.equalTo(imageView.mas_right).with.offset(10);
    }];
    [deskLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(nameLabel);
        make.left.equalTo(nameLabel.mas_right).with.offset(10);
    }];
    
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(20);
        make.top.equalTo(imageView.mas_bottom).with.offset(10);
        make.right.equalTo(self).with.offset(-20);
    }];
    
    [attitudeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(20);
        make.top.equalTo(contentLabel.mas_bottom).with.offset(12);
    }];
    
    [envOrSkillLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(attitudeLabel);
        make.right.equalTo(self.mas_right).with.offset(-105);
    }];
    
    [lineOneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(attitudeLabel.mas_bottom).with.offset(20);
        make.height.mas_offset(@10);
    }];
    
    [addCommentLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineOneLabel.mas_bottom).with.offset(20);
        make.left.equalTo(self).with.offset(20);
    }];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addCommentLable.mas_bottom).with.offset(20);
        make.left.equalTo(self).with.offset(20);
        make.right.equalTo(self).with.offset(-20);
        make.height.mas_offset(@100);
    }];
    
    [lineTwoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(textView.mas_bottom).with.offset(20);
        make.height.mas_offset(@10);
    }];
    
    [sender mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineTwoLabel.mas_bottom).with.offset(20);
        make.right.equalTo(self).with.offset(-20);
        make.width.mas_offset(@100);
    }];
    
    
    for (int i=0; i<5; i++) {
        UIImageView *attitudeImageView = [[UIImageView alloc]init];
        
        if (i<[self.model.service integerValue]) {
            attitudeImageView.image = [UIImage imageNamed:@"黄星星"];
        }else {
            attitudeImageView.image = [UIImage imageNamed:@"灰星星"];
        }
        [self addSubview:attitudeImageView];
        
        
        [attitudeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).with.offset(60+i*15);
            make.centerY.equalTo(attitudeLabel);
            make.size.mas_offset(CGSizeMake(10, 10));
        }];
    }
    
    
    for (int i=0; i<5; i++) {
        UIImageView *envOrSkillImageView = [[UIImageView alloc]init];
        
        //判断是医院进入
        NSInteger num;
        if ([self.type isEqualToString:@"hospital"]) {
            num = [self.model.huanjing integerValue];
        }else {
            num = [self.model.level integerValue];
        }
        
        if (i<num) {
            envOrSkillImageView.image = [UIImage imageNamed:@"黄星星"];
        }else {
            envOrSkillImageView.image = [UIImage imageNamed:@"灰星星"];
        }
        [self addSubview:envOrSkillImageView];
        
        [envOrSkillImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_left).with.offset(kScreenWidth-90+i*15);
            make.centerY.equalTo(attitudeLabel);
            make.size.mas_offset(CGSizeMake(10, 10));
        }];
        
    }
    
    

    
    
}

@end
