//
//  HWwriteweibotoolbar.m
//  贾凯峰微博项目
//
//  Created by jiakaifeng on 15/8/4.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import "HWwriteweibotoolbar.h"
@interface HWwriteweibotoolbar()
//申明表情图标
@property(nonatomic,weak)UIButton *emotionbutton;
@end
@implementation HWwriteweibotoolbar

-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        [self swtupimage:@"compose_camerabutton_background" highimage:@"compose_camerabutton_background_highlighted" buttontype:buttontypecamer];
//        拿到表情图标
         self.emotionbutton= [self swtupimage:@"compose_emoticonbutton_background" highimage:@"compose_emoticonbutton_background_highlighted"buttontype:buttontypeemotion];
        [self swtupimage:@"compose_keyboardbutton_background" highimage:@"compose_keyboardbutton_background_highlighted"buttontype:buttontypekeyboard];
        [self swtupimage:@"compose_mentionbutton_background" highimage:@"compose_mentionbutton_background_highlighted"buttontype:buttontypeperson];

      [self swtupimage:@"compose_toolbar_picture" highimage:@"compose_toolbar_picture_highlighted"buttontype:buttontypephoto];
    }
    return self;
}
//设置keyborad的set方法，赋值
-(void)setKeyboardbuttonshow:(BOOL)keyboardbuttonshow{
    _keyboardbuttonshow=keyboardbuttonshow;
    if (keyboardbuttonshow) {
        [self.emotionbutton setImage:[UIImage imageNamed:@"compose_keyboardbutton_background"] forState:UIControlStateNormal];
        [self.emotionbutton setImage:[UIImage imageNamed:@"compose_keyboardbutton_background_highlighted"] forState:UIControlStateHighlighted];
    }else{
        [self.emotionbutton setImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] forState:UIControlStateNormal];
        [self.emotionbutton setImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] forState:UIControlStateHighlighted];
    
    
    }


}



-(UIButton *)swtupimage:(NSString *)image highimage:(NSString *)highimage buttontype:(buttontype)type{
    
    
    UIButton *button=[[UIButton alloc]init];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highimage] forState:UIControlStateHighlighted];
    button.tag=type;
    [button addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    return button;
    
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
//代理方法，响应button被点击
-(void)buttonclick:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(toolbar:clikbutton:)]) {
        [self.delegate toolbar:self clikbutton:button.tag];
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
