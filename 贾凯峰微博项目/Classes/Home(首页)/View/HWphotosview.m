//
//  HWphotosview.m
//  贾凯峰微博项目
//
//  Created by jiakaifeng on 15/7/30.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import "HWphotosview.h"

#define HWStatusPhotoWH 70
#define HWStatusPhotoMargin 10
#define HWStatusPhotoMaxCol(count) ((count==4)?2:3)

@implementation HWphotosview
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor blueColor];
    }
    return self;
}
+ (CGSize)sizeWithCount:(int)count{

    // 最大列数（一行最多有多少列）
    int maxCols = HWStatusPhotoMaxCol(count);
    
    int cols = (count >= maxCols)? maxCols : count;
    CGFloat photosW = cols * HWStatusPhotoWH + (cols - 1) * HWStatusPhotoMargin;
    
    // 行数
    int rows = (count + maxCols - 1) / maxCols;
    CGFloat photosH = rows * HWStatusPhotoWH + (rows - 1) * HWStatusPhotoMargin;
    
    return CGSizeMake(photosW, photosH);
}


@end
