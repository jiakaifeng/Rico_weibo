//
//  HWwriteweibotoolbar.h
//  贾凯峰微博项目
//
//  Created by jiakaifeng on 15/8/4.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>
//枚举出工具栏点击按钮的类型
typedef enum {
    buttontypecamer,
    buttontypephoto,
    buttontypeemotion,
    buttontypekeyboard,
    buttontypeperson,
}buttontype;
@class HWwriteweibotoolbar;
//设置按钮点击方法
@protocol buttondelegate <NSObject>
@optional
-(void)toolbar:(HWwriteweibotoolbar *)toolbar clikbutton:(buttontype)buttontype;
@end
@interface HWwriteweibotoolbar : UIView
//申明代理
@property(nonatomic,weak)id<buttondelegate>delegate;
//设置键盘按钮改变属性
@property(nonatomic,assign)BOOL keyboardbuttonshow;
@end
