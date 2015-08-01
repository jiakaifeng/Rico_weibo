//
//  HWphotosview.m
//  贾凯峰微博项目
//
//  Created by jiakaifeng on 15/7/30.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import "HWphotosview.h"
#import "HWphoto.h"
#import "HWWbstatus.h"
#import "HWphotoGifviews.h"
#define HWStatusPhotoWH 70
#define HWStatusPhotoMargin 10
#define HWStatusPhotoMaxCol(count) ((count==4)?2:3)

@implementation HWphotosview
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
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
-(void)setPhotos:(NSArray *)photos{
    NSLog(@"shuchuu");
    _photos=photos;
    int photocount=photos.count;
    
    while (self.subviews.count < photocount) {
        HWphotoGifviews *photoView = [[HWphotoGifviews alloc] init];
        [self addSubview:photoView];
    }
    
    // 遍历所有的图片控件，设置图片
    for (int i = 0; i<self.subviews.count; i++) {
        HWphotoGifviews *photoView = self.subviews[i];
        
        if (i < photocount) { // 显示
            photoView.photo=photos[i];
   
            photoView.hidden = NO;
        } else { // 隐藏
            photoView.hidden = YES;
        }
    }
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置图片的尺寸和位置
    int photosCount = self.photos.count;
    int maxCol = HWStatusPhotoMaxCol(photosCount);
    for (int i = 0; i<photosCount; i++) {
        HWphotoGifviews *photoView = self.subviews[i];
        
        int col = i % maxCol;
        photoView.x = col * (HWStatusPhotoWH + HWStatusPhotoMargin);
        
        int row = i / maxCol;
        photoView.y = row * (HWStatusPhotoWH + HWStatusPhotoMargin);
        photoView.width = HWStatusPhotoWH;
        photoView.height = HWStatusPhotoWH;
    }
}
@end
