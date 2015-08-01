//
//  HWUserinfo.h
//  贾凯峰微博项目
//
//  Created by jiakaifeng on 15/7/22.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    HWUserVerifiedTypeNone = -1, // 没有任何认证
    HWUserVerifiedPersonal = 0,  // 个人认证
        HWUserVerifiedOrgEnterprice = 2, // 企业官方：CSDN、EOE、搜狐新闻客户端
    HWUserVerifiedOrgMedia = 3, // 媒体官方：程序员杂志、苹果汇
    HWUserVerifiedOrgWebsite = 5, // 网站官方：猫扑
        HWUserVerifiedDaren = 220 // 微博达人
} HWUserVerifiedType;
@interface HWUserinfo : NSObject
//idstr	string	字符串型的用户UID
@property(nonatomic,copy)NSString *idstr;
@property(nonatomic,copy)NSString *profile_image_url;
//name	string	友好显示名称;
@property(nonatomic,copy)NSString *name;

@property(nonatomic,assign)int mbtype;
@property(nonatomic,assign)int mbrank;
@property(nonatomic,assign,getter=isvip)BOOL vip;
@property (nonatomic, assign) HWUserVerifiedType verified_type;

//profile_image_url	string	用户头像地址（中图），50×50像素


@end
