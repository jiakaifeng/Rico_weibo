//
//  HWWbstatus.h
//  贾凯峰微博项目
//
//  Created by jiakaifeng on 15/7/22.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HWUserinfo;
@interface HWWbstatus : NSObject
@property(nonatomic,copy)NSString *idstr;
@property(nonatomic,copy)NSString *text;
@property(nonatomic,retain)HWUserinfo * user;
@property (nonatomic, copy) NSString *created_at;

/**	string	微博来源*/
@property (nonatomic, copy) NSString *source;



@end
