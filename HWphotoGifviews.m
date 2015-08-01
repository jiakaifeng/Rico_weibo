//
//  HWphotoGifviews.m
//  贾凯峰微博项目
//
//  Created by jiakaifeng on 15/7/31.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import "HWphotoGifviews.h"
#import "HWphoto.h"
#import "HWphotosview.h"
#import "UIImageView+WebCache.h"
@implementation HWphotoGifviews
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        UIImage *gif=[UIImage imageNamed:@"timeline_image_gif"];
        UIImageView *gifview=[[UIImageView alloc]initWithImage:gif];
        [self addSubview:gifview];
        self.gifview=gifview;
    }
    return self;
}
-(void)setPhoto:(HWphoto *)photo{
    _photo=photo;
[self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    if ([photo.thumbnail_pic hasSuffix:@"gif"]) {
        self.gifview.hidden=NO;
    }else{
        self.gifview.hidden=YES;
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
