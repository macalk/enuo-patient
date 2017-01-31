//
//  PellTableViewSelect.h
//  enuo2
//
//  Created by apple on 16/3/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PellTableViewSelect : UIView
/**
 *  创建一个弹出下拉控件
 *
 *  @param frame      尺寸
 *  @param selectData 选择控件的数据源
 *  @param action     点击回调方法
 *  @param animate    是否动画弹出
 */
@property (nonatomic,strong)NSString *url1;
@property (nonatomic,strong)NSString *url2;


+ (void)addPellTableViewSelectWithWindowFrame:(CGRect)frame
                                   selectData:(NSArray *)selectData
                                       images:(NSArray *)images
                                       action:(void(^)(NSInteger index))action animated:(BOOL)animated;

//手动隐藏
+ (void)hiden;




@end
