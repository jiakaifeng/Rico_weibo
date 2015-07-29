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
@property(nonatomic,strong)NSArray *pic_urls;

/**	string	微博来源*/
@property (nonatomic, copy) NSString *source;

//转发微博模型
@property(nonatomic,strong)HWWbstatus *retweeted_status;
@property(nonatomic,assign)int reposts_count;
@property(nonatomic,assign)int comments_count;
@property(nonatomic,assign)int attitudes_count;



@end
