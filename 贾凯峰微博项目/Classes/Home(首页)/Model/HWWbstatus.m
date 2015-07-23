//
//  HWWbstatus.m
//  贾凯峰微博项目
//
//  Created by jiakaifeng on 15/7/22.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import "HWWbstatus.h"
#import "HWUserinfo.h"
@implementation HWWbstatus

+(instancetype)statwithDict:(NSDictionary *)dict{
    HWWbstatus *status=[[self alloc]init];
    status.idstr=dict[@"idstr"];
    status.text=dict[@"text"];
    status.user=[HWUserinfo userwithdDict:dict[@"user"]];
    return status;

}


@end
