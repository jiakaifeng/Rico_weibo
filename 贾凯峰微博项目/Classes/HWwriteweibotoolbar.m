//
//  HWwriteweibotoolbar.m
//  贾凯峰微博项目
//
//  Created by jiakaifeng on 15/8/4.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import "HWwriteweibotoolbar.h"

@implementation HWwriteweibotoolbar
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        [self swtupimage:@"compose_camerabutton_background" highimage:@"compose_camerabutton_background_highlighted"];
        [self swtupimage:@"compose_emoticonbutton_background" highimage:@"compose_emoticonbutton_background_highlighted"];
        [self swtupimage:@"compose_keyboardbutton_background" highimage:@"compose_keyboardbutton_background_highlighted"];
        [self swtupimage:@"compose_mentionbutton_background" highimage:@"compose_mentionbutton_background_highlighted"];
        [self swtupimage:@"compose_toolbar_picture" highimage:@"compose_toolbar_picture_highlighted"];
    }
    return self;
    
    

}
-(void)swtupimage:(NSString *)image highimage:(NSString *)highimage{
    
    
    UIButton *button=[[UIButton alloc]init];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highimage] forState:UIControlStateHighlighted];
    [self addSubview:button];

    
}
-(void)layoutSubviews{

    [super layoutSubviews];
    NSUInteger count=self.subviews.count;

    CGFloat buttonx=self.width/count;
    for (int i=0; i<count; i++) {
        UIButton *button=self.subviews[i];
        
        button.y=0;
        button.x=buttonx*i;
        button.width=buttonx;
        button.height=self.height;
    }



}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
