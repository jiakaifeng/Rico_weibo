//
//  HWUserinfo.m
//  贾凯峰微博项目
//
//  Created by jiakaifeng on 15/7/22.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import "HWUserinfo.h"

@implementation HWUserinfo

+(instancetype)userwithdDict:(NSDictionary *)dict{
    HWUserinfo *user=[[self alloc]init];
    user.idstr=dict[@"idstr"];
    user.profile_image_url=dict[@"profile_image_url"];
    user.name=dict[@"name"];
    return user;
}
@end
