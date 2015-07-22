//
//  HWAccount.h
//  贾凯峰微博项目
//
//  Created by jiakaifeng on 15/7/21.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWAccount : NSObject<NSCoding>

//接收数据
@property (nonatomic, copy) NSString *uid;

@property (nonatomic, strong) NSNumber *expires_in;

@property (nonatomic, copy) NSString *access_token;
@property (nonatomic, copy) NSDate *creattime;



+(instancetype)AccountwithDict:(NSDictionary *)dict;

@end
