//
//  MyOrderInfoModel.m
//  enuoS
//
//  Created by apple on 16/11/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MyOrderInfoModel.h"


@implementation MyOrderInfoModel

- (id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
        
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in self.check_detail) {
            check_detailModel *model = [[check_detailModel alloc]initWithDic:dic];
            [array addObject:model];
            
        }
        self.check_detail = array;
        
        NSMutableArray *preferArr = [NSMutableArray array];
        for (NSDictionary *dic in self.prefer) {
            preferModel *model = [[preferModel alloc]initWithDic:dic];
            [preferArr addObject:model];
        }
        self.prefer = preferArr;
        
    }return self;
}


+ (id)myOrderModelInitWithDic:(NSDictionary *)dic{
    
    return [[MyOrderInfoModel alloc]initWithDic:dic];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        
    }
    
}


@end

/**************/
@implementation check_detailModel

- (id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }return self;
}

@end

/***************/
@implementation preferModel

- (id)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
    
}

@end


