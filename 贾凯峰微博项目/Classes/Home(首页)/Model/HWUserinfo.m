//
//  HWUserinfo.m
//  贾凯峰微博项目
//
//  Created by jiakaifeng on 15/7/22.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import "HWUserinfo.h"

@implementation HWUserinfo

-(void)setMbtype:(int)mbtype{
    _mbtype=mbtype;
    self.vip=mbtype>2;
}

@end
