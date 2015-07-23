//
//  HWFootreload.m
//  贾凯峰微博项目
//
//  Created by jiakaifeng on 15/7/23.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import "HWFootreload.h"

@implementation HWFootreload

+(instancetype)footreload{
    return [[[NSBundle mainBundle]loadNibNamed:@"HWFootreload" owner:nil options:nil]lastObject];


}

@end
