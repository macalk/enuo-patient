//
//  ZXDTextView.h
//  enuoNew
//
//  Created by apple on 16/7/2.
//  Copyright © 2016年 apple. All rights reserved.
//










#import <UIKit/UIKit.h>








@interface ZXDIndexPath : NSObject

@property (nonatomic, assign) NSInteger row; //行
@property (nonatomic, assign) NSInteger column; //列
@property (nonatomic, assign) NSInteger item; //item

- (instancetype)initWithColumn:(NSInteger)column row:(NSInteger)row;

+ (instancetype)indexPathWithColumn:(NSInteger)column row:(NSInteger)row;
+ (instancetype)indexPathWithColumn:(NSInteger)column row:(NSInteger)row item:(NSInteger)item;

@end

@class ZXDTextView;

@protocol ZXDTextViewDataSource <NSObject>

@required
//每个column有多少行
- (NSInteger)menu:(ZXDTextView *)menu numberOfRowsInColumn:(NSInteger)column;
//每个column中每行的title
- (NSString *)menu:(ZXDTextView *)menu titleForRowAtIndexPath:(ZXDIndexPath *)indexPath;

@optional
//有多少个column，默认为1列
- (NSInteger)numberOfColumnsInMenu:(ZXDTextView *)menu;
//第column列，每行的image
- (NSString *)menu:(ZXDTextView *)menu imageNameForRowAtIndexPath:(ZXDIndexPath *)indexPath;
//detail text
- (NSString *)menu:(ZXDTextView *)menu detailTextForRowAtIndexPath:(ZXDIndexPath *)indexPath;
//某列的某行item的数量，如果有，则说明有二级菜单，反之亦然
- (NSInteger)menu:(ZXDTextView *)menu numberOfItemsInRow:(NSInteger)row inColumn:(NSInteger)column;
//如果有二级菜单，则实现下列协议
//二级菜单的标题
- (NSString *)menu:(ZXDTextView *)menu titleForItemsInRowAtIndexPath:(ZXDIndexPath *)indexPath;
//二级菜单的image
- (NSString *)menu:(ZXDTextView *)menu imageForItemsInRowAtIndexPath:(ZXDIndexPath *)indexPath;
//二级菜单的detail text
- (NSString *)menu:(ZXDTextView *)menu detailTextForItemsInRowAtIndexPath:(ZXDIndexPath *)indexPath;





@end

#pragma mark - delegate
@protocol ZXDTextViewDelegate <NSObject>

@optional
//点击
- (void)menu:(ZXDTextView *)menu didSelectRowAtIndexPath:(ZXDIndexPath *)indexPath;

@end





@interface ZXDTextView : UIView

@property (nonatomic, weak) id<ZXDTextViewDelegate> delegate;
@property (nonatomic, weak) id<ZXDTextViewDataSource> dataSource;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *selectedTextColor;
@property (nonatomic, strong) UIColor *detailTextColor;
@property (nonatomic, strong) UIColor *indicatorColor;
@property (nonatomic, strong) UIFont *detailTextFont;
@property (nonatomic, strong) UIColor *separatorColor;
@property (nonatomic, assign) NSInteger fontSize;
@property (nonatomic, strong) UITableView *leftTableView;  //一级列表
@property (nonatomic, strong) UITableView *rightTableView;  //二级列表
//当前选中的列
@property (nonatomic, strong) NSMutableArray *currentSelectedRows;
//当有二级列表的时候，是否调用点击代理方法
@property (nonatomic, assign) BOOL isClickHaveItemValid;

//获取title
- (NSString *)titleForRowAtIndexPath:(ZXDIndexPath *)indexPath;
//初始化方法
- (instancetype)initWithOrigin:(CGPoint)origin andHeight:(CGFloat)height;
//菜单切换，选中的indexPath
- (void)selectIndexPath:(ZXDIndexPath *)indexPath;
//默认选中
- (void)selectDeafultIndexPath;
//数据重载
- (void)reloadData;


@end
