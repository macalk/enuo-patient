//
//  MyExperienceCardDetailCell.m
//  enuoS
//
//  Created by apple on 16/12/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MyExperienceCardDetailCell.h"

@implementation MyExperienceCardDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews {
    
    self.orderNumberLabel.text = self.model.cardno;
    self.illLabel.text = self.model.product;
    self.hosLabel.text = self.model.hos_name;
    
    self.statusButton.layer.borderWidth = 1;
    self.statusButton.layer.borderColor = [[UIColor whiteColor]CGColor];
    self.statusButton.layer.cornerRadius = 5;
    self.statusButton.clipsToBounds = YES;
    
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"beijing"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[self.model.end_time doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    self.dateLabel.text = dateString;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
