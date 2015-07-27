//
//  HWWbstatusFrame.h
//  贾凯峰微博项目
//
//  Created by jiakaifeng on 15/7/27.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>
// 昵称字体
#define HWStatusCellNameFont [UIFont systemFontOfSize:15]
// 时间字体
#define HWStatusCellTimeFont [UIFont systemFontOfSize:12]
// 来源字体
#define HWStatusCellSourceFont HWStatusCellTimeFont
// 正文字体
#define HWStatusCellContentFont [UIFont systemFontOfSize:14]

@class HWWbstatus;
@interface HWWbstatusFrame : NSObject
@property(nonatomic,strong)HWWbstatus *status;
@property(nonatomic,assign)CGRect baseonView;
@property(nonatomic,assign)CGRect  headview;
@property(nonatomic,assign)CGRect  photoview;
@property(nonatomic,assign)CGRect  vipview;
@property(nonatomic,assign)CGRect nameLable;
@property(nonatomic,assign)CGRect timeLable;
@property(nonatomic,assign)CGRect sourseLable;
@property(nonatomic,assign)CGRect weiboLable;
@property(nonatomic,assign)CGFloat cellheight;
@end
