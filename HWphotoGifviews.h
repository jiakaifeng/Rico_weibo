//
//  HWphotoGifviews.h
//  贾凯峰微博项目
//
//  Created by jiakaifeng on 15/7/31.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HWphoto;
@interface HWphotoGifviews : UIImageView
@property(nonatomic,strong) HWphoto *photo;
@property(nonatomic,weak)UIImageView *gifview;
@end
