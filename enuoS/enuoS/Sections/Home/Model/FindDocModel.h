//
//  FindDocModel.h
//  enuoNew
//
//  Created by apple on 16/7/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FindDocModel : NSObject
@property (nonatomic,copy)NSString *dep_name;//科室
@property (nonatomic,copy)NSString *hos_name;//医院
@property (nonatomic,copy)NSString *cid;//id
@property (nonatomic,copy)NSString *ill;//
@property (nonatomic,copy)NSString *name;//名字
@property (nonatomic,copy)NSString *nuo;//诺
@property (nonatomic,copy)NSString *photo;//照片
@property (nonatomic,copy)NSString *professional;//主治医生
@property (nonatomic,copy)NSString *zhen;//已预约人数
@property (nonatomic,copy)NSString *treatment;//治疗领域
@property (nonatomic,assign)NSInteger guanzhu;//关注
@property (nonatomic,assign)NSInteger comment_num;//评论数


- (id)initWithDic:(NSDictionary *)dic;

+ (id)findDocModelInitWithDic:(NSDictionary *)dic;



@end
