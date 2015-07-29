//
//  HWtoobar.h
//  贾凯峰微博项目
//
//  Created by jiakaifeng on 15/7/29.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HWWbstatus;
@interface HWtoobar : UIView
+(instancetype)toolbar;
@property(nonatomic,strong)HWWbstatus *status;


@end
