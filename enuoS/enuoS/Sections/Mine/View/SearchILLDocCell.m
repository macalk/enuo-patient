//
//  SearchILLDocCell.m
//  enuoS
//
//  Created by apple on 16/11/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "SearchILLDocCell.h"
#import "Macros.h"
#import "SearchillDocModel.h"
#import <sdwebimage/UIImageView+WebCache.h>

@implementation SearchILLDocCell

- (SearchillDocModel *)model {
    if (!_model) {
        _model = [[SearchillDocModel alloc]init];
    }return _model;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews {
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:urlPicture,self.model.photo]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    self.nameLabel.text = self.model.name;
    self.professionalLabel.text = self.model.professional;
    self.deskLabel.text = self.model.dep_name;
    self.hosNameLabel.text = self.model.hos_name;
    self.peopleNumLabel.text = [NSString stringWithFormat:@"%@ 人",self.model.zhen];
    self.nuoLabel.text = self.model.nuo;
    self.commentNumLabel.text = [NSString stringWithFormat:@"%d",self.model.comment_num];
    
    if (self.model.guanzhu == 0) {
        [self.likeBtn setImage:[UIImage imageNamed:@"关注"] forState:normal];
    }else {
        [self.likeBtn setImage:[UIImage imageNamed:@"关注-s"] forState:normal];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
