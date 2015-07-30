//
//  HWphotosview.h
//  贾凯峰微博项目
//
//  Created by jiakaifeng on 15/7/30.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWphotosview : UIView
@property (nonatomic, strong) NSArray *photos;
/**
 *  根据图片个数计算相册的尺寸
 */
+ (CGSize)sizeWithCount:(int)count;

@end
