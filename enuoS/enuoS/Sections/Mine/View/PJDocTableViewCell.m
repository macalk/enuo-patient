//
//  PJDocTableViewCell.m
//  enuoS
//
//  Created by apple on 16/8/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "PJDocTableViewCell.h"

@implementation PJDocTableViewCell

- (NSMutableArray *)arrOne {
    if (!_arrOne) {
        _arrOne = [NSMutableArray array];
        for (int i =0;i<5 ; i++) {
            UIImageView *imageViewOne = [self viewWithTag:10+i];
            [_arrOne addObject:imageViewOne];
        }
    }return _arrOne;
}
- (NSMutableArray *)arrTwo {
    if (!_arrTwo) {
        _arrTwo = [NSMutableArray array];
        for (int i =0;i<5 ; i++) {
            UIImageView *imageViewOne = [self viewWithTag:15+i];
            [_arrTwo addObject:imageViewOne];
        }
    }return _arrTwo;
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
