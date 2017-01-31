//
//  PromiseDocViewCell.m
//  enuoNew
//
//  Created by apple on 16/7/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "PromiseDocViewCell.h"
#import "UIColor+Extend.h"

@implementation PromiseDocViewCell

- (void)awakeFromNib {
    // Initialization code
    
    [super awakeFromNib];
    self.photoImage.layer.borderWidth = 1;
    self.photoImage.layer.borderColor = [[UIColor stringTOColor:@"#cfcfd2"]CGColor];
    
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:self.illLabel.text];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:50.0];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [self.illLabel.text length])];
    [self.illLabel setAttributedText:attributedString1];
    //设置行间距后适配高度显示
    [self.illLabel sizeToFit];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
