//
//  HWTool.m
//  贾凯峰微博项目
//
//  Created by jiakaifeng on 15/7/21.
//  Copyright (c) 2015年 heima. All rights reserved.
//
#define HWAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]
#import "HWTool.h"
#import "HWAccount.h"

@implementation HWTool
+(void)saveaccount:(HWAccount *)account{

   
    //创建模型
    //自定义将对象储存进沙盒
    [NSKeyedArchiver archiveRootObject:account toFile:HWAccountPath];

}
+(HWAccount *)account{

    //
    HWAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:HWAccountPath];

 
    return account;



}
@end
