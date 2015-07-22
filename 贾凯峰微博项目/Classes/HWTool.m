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

   
    account.creattime=[NSDate date];
    //创建模型
    //自定义将对象储存进沙盒
    [NSKeyedArchiver archiveRootObject:account toFile:HWAccountPath];

}
+(HWAccount *)account{

    //创建模型
    HWAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:HWAccountPath];
    
    long long expires_in=[account.expires_in longLongValue];
    NSDate *expressTime=[account.creattime dateByAddingTimeInterval:expires_in];
    NSDate *now=[NSDate date];
    //比较时间
    NSComparisonResult  result= [expressTime compare:now];
    if (result!=NSOrderedAscending) {
        return nil;
    }
    return account;
    HWLog(@"shijian -%@---%@",expressTime,now);



}
@end
