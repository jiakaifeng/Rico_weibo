//
//  HWDropdownMenu.h
//  贾凯峰微博项目
//
//  Created by apple on 14-10-8.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HWDropdownMenu;
//创建dropdown代理
@protocol HWDropdownMenudelegate<NSObject>
@optional
-(void)dropdownmenudismiss:(HWDropdownMenu *)menu;
@end
@interface HWDropdownMenu : UIView
@property(nonatomic,weak)id<HWDropdownMenudelegate>delegate;

+ (instancetype)menu;

/**
 *  显示
 */
- (void)showFrom:(UIView *)from;
/**
 *  销毁
 */
- (void)dismiss;

/**
 *  内容
 */
@property (nonatomic, strong) UIView *content;
/**
 *  内容控制器
 */
@property (nonatomic, strong) UIViewController *contentController;
@end
