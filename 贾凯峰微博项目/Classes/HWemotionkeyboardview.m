//
//  HWemotionkeyboardview.m
//  贾凯峰微博项目
//
//  Created by jiakaifeng on 15/8/6.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import "HWemotionkeyboardview.h"
#import "HWemotiontoolbar.h"
#import "HWemotionscrollview.h"
@interface HWemotionkeyboardview()

@property(nonatomic,weak)HWemotiontoolbar *toolbar;

@property(nonatomic,weak) HWemotionscrollview *scrollview;
@end
@implementation HWemotionkeyboardview
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        HWemotiontoolbar *toolbar=[[HWemotiontoolbar alloc]init];
        [self addSubview:toolbar];
        self.toolbar=toolbar;

        HWemotionscrollview *scrollview=[[HWemotionscrollview alloc]init];
        [self addSubview:scrollview];
        scrollview.backgroundColor=[UIColor blueColor];
        self.scrollview=scrollview;
    }
    return self;
}
-(void)layoutSubviews{
  [super layoutSubviews];
    //工具栏frame设在
    self.toolbar.height=44;
    self.toolbar.width=self.width;
    self.toolbar.y=self.height-self.toolbar.height;
    self.toolbar.x=0;
    //表情界面设置
    self.scrollview.x=self.scrollview.y=0;
    self.scrollview.height=self.toolbar.y;
    self.scrollview.width=self.width;
    
    


}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
