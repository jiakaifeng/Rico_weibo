//
//  HWtoobar.m
//  贾凯峰微博项目
//
//  Created by jiakaifeng on 15/7/29.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import "HWtoobar.h"
#import "HWWbstatus.h"
@implementation HWtoobar
+(instancetype)toolbar{
    
    
    return [[self alloc]init];


}
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
        UIButton *zhuanfa=[[UIButton alloc]init];
        [zhuanfa setImage:[UIImage imageNamed:@"timeline_icon_retweet"] forState:UIControlStateNormal];
        zhuanfa.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
        [zhuanfa setTitle:@"转发" forState:UIControlStateNormal];
        [zhuanfa setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        zhuanfa.titleLabel.font=[UIFont systemFontOfSize:13];
        [self addSubview:zhuanfa];
        
        UIButton *pinglun=[[UIButton alloc]init];
        [pinglun setImage:[UIImage imageNamed:@"timeline_icon_comment"] forState:UIControlStateNormal];
        pinglun.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
        [pinglun setTitle:@"评论" forState:UIControlStateNormal];
        [pinglun setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        pinglun.titleLabel.font=[UIFont systemFontOfSize:13];
        [self addSubview:pinglun];

        UIButton *dianzan=[[UIButton alloc]init];
        [dianzan setImage:[UIImage imageNamed:@"timeline_icon_unlike"] forState:UIControlStateNormal];
        [dianzan setTitle:@"点赞" forState:UIControlStateNormal];
        dianzan.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
        [dianzan setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        dianzan.titleLabel.font=[UIFont systemFontOfSize:13];
        [self addSubview:dianzan];
    }

    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    NSUInteger count=self.subviews.count;
    CGFloat width=self.width/count;
    for (int i=0; i<count; i++) {
        UIButton *btn=self.subviews[i];
        btn.y=0;
        btn.width=width;
        btn.x=i*width+6;
        btn.height=self.height;
    }

}
-(void)setStatus:(HWWbstatus *)status{
    _status=status;
   UIButton *zhuanfa=self.subviews[0];
   UIButton *pinglun=self.subviews[1];
   UIButton *dianzan=self.subviews[2];
    if (status.reposts_count) {
        NSString *zhuanfacount=[NSString stringWithFormat:@"%d",status.reposts_count];
        [zhuanfa setTitle:zhuanfacount forState:UIControlStateNormal];
    }else{
        [zhuanfa setTitle:@"转发" forState:UIControlStateNormal];
    }

    if (status.comments_count) {
        NSString *comments_count=[NSString stringWithFormat:@"%d",status.comments_count];
        [pinglun setTitle:comments_count forState:UIControlStateNormal];
    }else{
        [pinglun setTitle:@"评论" forState:UIControlStateNormal];
    }
    if (status.attitudes_count) {
        NSString *attitudes_count=[NSString stringWithFormat:@"%d",status.attitudes_count];
        [dianzan setTitle:attitudes_count forState:UIControlStateNormal];
    }else{
        [dianzan setTitle:@"点赞" forState:UIControlStateNormal];
    }

}
@end
