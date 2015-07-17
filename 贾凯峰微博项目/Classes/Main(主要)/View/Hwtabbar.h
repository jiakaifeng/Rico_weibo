//
//  Hwtabbar.h
//  贾凯峰微博项目
//
//  Created by jiakaifeng on 15/7/17.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Hwtabbar;

#warning 因为HWTabBar继承自UITabBar，所以称为HWTabBar的代理，也必须实现UITabBar的代理协议
@protocol HWTabBarDelegate <UITabBarDelegate>
@optional
- (void)tabBarDidClickPlusButton:(Hwtabbar *)tabBar;
@end

@interface Hwtabbar : UITabBar
@property (nonatomic, weak) id<HWTabBarDelegate> delegate;
@end


