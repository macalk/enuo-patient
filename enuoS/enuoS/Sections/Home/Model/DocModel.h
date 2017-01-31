//
//  DocModel.h
//  enuoS
//
//  Created by apple on 16/7/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DocModel : NSObject

@property (nonatomic,copy)NSString *username;
@property (nonatomic,copy)NSString *cid;
@property (nonatomic,copy)NSString *photo;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *professional;//主治医师
@property (nonatomic,copy)NSString *nuo;
@property (nonatomic,copy)NSString *hos_id;
@property (nonatomic,copy)NSString *treatment;//擅长领域
@property (nonatomic,copy)NSString *introduce;//医生简介
@property (nonatomic,copy)NSString *schedule;
@property (nonatomic,weak)NSArray *schedule_list;
@property (nonatomic,copy)NSString *hos_name;//医院名字
@property (nonatomic,copy)NSString *dep_name;//科室
@property (nonatomic,copy)NSString *ill;//约定病种
@property (nonatomic,assign)NSInteger guanzhu;//关注
@property (nonatomic,assign)NSInteger comment;//评论

@property (nonatomic,copy)NSString *chat_token;



- (id)initWihData:(NSDictionary *)dic;

+ (id)docModelInitWithData:(NSDictionary *)dic;


@end
