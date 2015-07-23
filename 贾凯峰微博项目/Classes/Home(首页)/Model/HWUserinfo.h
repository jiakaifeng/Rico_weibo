//
//  HWUserinfo.h
//  贾凯峰微博项目
//
//  Created by jiakaifeng on 15/7/22.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWUserinfo : NSObject
//idstr	string	字符串型的用户UID
@property(nonatomic,copy)NSString *idstr;
@property(nonatomic,copy)NSString *profile_image_url;
//name	string	友好显示名称;
@property(nonatomic,copy)NSString *name;

//profile_image_url	string	用户头像地址（中图），50×50像素
+(instancetype)userwithdDict:(NSDictionary *)dict;
@end
