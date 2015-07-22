//
//  HWTool.h
//  贾凯峰微博项目
//
//  Created by jiakaifeng on 15/7/21.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HWAccount;
@interface HWTool : NSObject
//存储账号信息
+(void)saveaccount:(HWAccount *)account;

+(HWAccount *)account;



@end
