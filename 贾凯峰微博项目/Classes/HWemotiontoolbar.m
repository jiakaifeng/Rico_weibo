//
//  HWemotiontoolbar.m
//  贾凯峰微博项目
//
//  Created by jiakaifeng on 15/8/6.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import "HWemotiontoolbar.h"

@implementation HWemotiontoolbar

-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self swtupimage:@"compose_emotion_table_left_normal" highimage:@"compose_emotion_table_left_selected" buttontype:emotionrecent buttonname:@"最近"];
        [self swtupimage:@"compose_emotion_table_mid_normal" highimage:@"compose_emotion_table_mid_selected" buttontype:emotionmoren buttonname:@"默认"];
        [self swtupimage:@"compose_emotion_table_mid_normal" highimage:@"compose_emotion_table_mid_selected" buttontype:emotionEmoji buttonname:@"Emoji"];
        [self swtupimage:@"compose_emotion_table_right_normal" highimage:@"compose_emotion_table_right_selected" buttontype:emotionEmoji buttonname:@"浪小花"];
        

    }
    return self;
}



-(void)swtupimage:(NSString *)image highimage:(NSString *)highimage buttontype:(emotiontype)type buttonname:(NSString *)name{
    UIButton *button=[[UIButton alloc]init];
    [button setTitle:name forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highimage] forState:UIControlStateSelected];
    button.tag=type;
    [button addTarget:self action:@selector(emootionbuttonclick:) forControlEvents:UIControlEventAllTouchEvents];
    [self addSubview:button];
    
    }

-(void)emootionbuttonclick:(emotiontype)type{



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

    }}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
