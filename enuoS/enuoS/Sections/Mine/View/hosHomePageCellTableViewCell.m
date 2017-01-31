//
//  hosHomePageCellTableViewCell.m
//  enuoS
//
//  Created by apple on 16/11/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "hosHomePageCellTableViewCell.h"
#import "HosModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation hosHomePageCellTableViewCell

- (HosModel *)model {
    if (!_model) {
        _model = [[HosModel alloc]init];
    }return _model;
}

- (void)layoutSubviews {
    
    NSArray *serveArr = @[self.serveImage1,self.serveImage2,self.serveImage3,self.serveImage4,self.serveImage5];
    NSArray *environmentArr = @[self.environmentImage1,self.environmentImage2,self.environmentImage3,self.environmentImage4,self.environmentImage5];
    
    [self.userHeadImage sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"eeenuo"]];
    self.userNameLabel.text = self.model.user;
    
    NSInteger serve = [self.model.service integerValue];
    NSLog(@"%ld",serve);
    for (int i = 0; i<serveArr.count; i++) {
        UIImageView *imageView = serveArr[i];
        if (i<serve) {
            imageView.image = [UIImage imageNamed:@"黄星星"];
        }else {
            imageView.image = [UIImage imageNamed:@"灰星星"];
        }
    }
    
    NSInteger environment = [self.model.huanjing integerValue];
    for (int i = 0; i<environmentArr.count; i++) {
        UIImageView *imageView = environmentArr[i];
        if (i<environment) {
            imageView.image = [UIImage imageNamed:@"黄星星"];
        }else {
            imageView.image = [UIImage imageNamed:@"灰星星"];
        }
    }
    
    self.commentLabel.text = self.model.hos_content;
    
    
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"beijing"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    
    // 毫秒值转化为秒 
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[self.model.nowdate doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    self.dateLabel.text = dateString;

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
