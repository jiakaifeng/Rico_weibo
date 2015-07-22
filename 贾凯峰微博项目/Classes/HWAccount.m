//
//  HWAccount.m
//  贾凯峰微博项目
//
//  Created by jiakaifeng on 15/7/21.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import "HWAccount.h"

@implementation HWAccount

+(instancetype)AccountwithDict:(NSDictionary *)dict
{
    HWAccount * account=[[self alloc]init];
    account.uid=dict[@"uid"];
    account.access_token=dict[@"access_token"];
    account.expires_in=dict[@"expires_in"];
    return account;
}
//归档，选择数据存入沙盒
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.name forKey:@"name"];


    

}
//从沙河中解当对象
-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super init]) {
        self.access_token=[aDecoder decodeObjectForKey:@"access_token"];
        self.uid=[aDecoder decodeObjectForKey:@"uid"];
        self.expires_in=[aDecoder decodeObjectForKey:@"expires_in"];
        self.name=[aDecoder decodeObjectForKey:@"name"];


    }
    return self;
}

@end
