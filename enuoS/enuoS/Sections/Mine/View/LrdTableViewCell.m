//
//  LrdTableViewCell.m
//  enuoS
//
//  Created by apple on 16/8/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LrdTableViewCell.h"
#import "LrdDateModel.h"
#import <Masonry.h>






@interface LrdTableViewCell ()


//@property (nonatomic, strong) UILabel *price;

@end







@implementation LrdTableViewCell

#pragma mark 重写model的set方法

- (void)setModel:(LrdDateModel *)model {
    _model = model;
    self.ill.text = model.ill;
    //self.price.text = [NSString stringWithFormat:@"￥ %@", self.model.price];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _ill = [[UILabel alloc] init];
        _ill.textColor = [UIColor blackColor];
        _ill.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_ill];
        
        //        _ill = [[UILabel alloc] init];
        //        _ill.textColor = [UIColor blackColor];
        //        _ill.font = [UIFont boldSystemFontOfSize:16];
        //        [self.contentView addSubview:_ill];
        
        //设置约束
        [_ill mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(10);
            make.height.mas_equalTo(40);
        }];
        
        //        [_price mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.right.equalTo(self.contentView.mas_right).offset(-40);
        //            make.top.equalTo(self.contentView.mas_top).offset(10);
        //        }];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
