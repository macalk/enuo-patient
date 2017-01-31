//
//  ZZCoredata.h
//  enuoS
//
//  Created by apple on 16/8/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZCoredata : NSObject




+(ZZCoredata *)shareCoreData;

/**
 *  生成 在用户跟目录下的文件路径信息
 *
 *  @param relativePath 相对路径 eg: test.plist or game/test.plist
 *
 *  @return 绝对路径
 */
-(NSString *)userResPath:(NSString *)relativePath;



@end
