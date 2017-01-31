//
//  SearchillDocModel.h
//  enuoS
//
//  Created by apple on 16/8/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchillDocModel : NSObject

- (id)initWithDic:(NSDictionary *)dic;

+ (id)SearchillDocModelInitWithDic:(NSDictionary *)dic;

//@property (nonatomic,copy)NSString *photo;
//@property (nonatomic,strong)NSDictionary *hos;
//@property (nonatomic,strong)NSArray *doc;

@property (nonatomic,copy)NSString *ill;
@property (nonatomic,copy)NSString *treat;
@property (nonatomic,copy)NSString *lowprice;
@property (nonatomic,copy)NSString *heightprice;
@property (nonatomic,copy)NSString *cycle;
@property (nonatomic,copy)NSString *photo;
@property (nonatomic,copy)NSString *hos_name;


@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *nuo;
@property (nonatomic,copy)NSString *professional;//主治医生
@property (nonatomic,copy)NSString *zhen;
@property (nonatomic,copy)NSString *dep_name;//科室
@property (nonatomic,assign)int comment_num;
@property (nonatomic,assign)int guanzhu;


@property (nonatomic,copy)NSString *category;
@property (nonatomic,copy)NSString *hos_id;
@property (nonatomic,copy)NSString *ID;
@property (nonatomic,copy)NSString *PID;
@property (nonatomic,assign)int vip;







@end
