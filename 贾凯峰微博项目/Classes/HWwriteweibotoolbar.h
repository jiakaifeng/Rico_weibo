//
//  HWwriteweibotoolbar.h
//  贾凯峰微博项目
//
//  Created by jiakaifeng on 15/8/4.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    buttontypecamer,
    buttontypephoto,
    buttontypeemotion,
    buttontypekeyboard,
    buttontypeperson,
}buttontype;
@class HWwriteweibotoolbar;
@protocol buttondelegate <NSObject>

@optional
-(void)toolbar:(HWwriteweibotoolbar *)toolbar clikbutton:(buttontype)buttontype;

@end
@interface HWwriteweibotoolbar : UIView
@property(nonatomic,weak)id<buttondelegate>delegate;
@end
