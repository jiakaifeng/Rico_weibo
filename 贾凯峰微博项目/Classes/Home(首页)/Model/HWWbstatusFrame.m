//
//  HWWbstatusFrame.m
//  贾凯峰微博项目
//
//  Created by jiakaifeng on 15/7/27.
//  Copyright (c) 2015年 heima. All rights reserved.
//
IB_DESIGNABLE
#import "HWWbstatusFrame.h"
#import "HWWbstatus.h"
#import "HWUserinfo.h"
#define HWStatusCellBorderW 10

@implementation HWWbstatusFrame

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font
{
    return [self sizeWithText:text font:font maxW:MAXFLOAT];
}


-(void)setStatus:(HWWbstatus *)status{

    _status=status;
    HWUserinfo *user=status.user;
//CGrect headview=
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    /* 原创微博 */
    
    /** 头像 */
    CGFloat iconWH = 35;
    CGFloat iconX = HWStatusCellBorderW;
    CGFloat iconY = HWStatusCellBorderW;
    self.headview = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    /** 昵称 */
    CGFloat nameX = CGRectGetMaxX(self.headview) + HWStatusCellBorderW;
    CGFloat nameY = iconY;
    CGSize nameSize = [self sizeWithText:user.name font:HWStatusCellNameFont];
    self.nameLable = (CGRect){{nameX, nameY}, nameSize};
    
    /** 会员图标 */
    if (user.isvip) {
        CGFloat vipX = CGRectGetMaxX(self.nameLable) + HWStatusCellBorderW;
        CGFloat vipY = nameY;
        CGFloat vipH = nameSize.height;
        CGFloat vipW = 14;
        self.vipview = CGRectMake(vipX, vipY, vipW, vipH);
    }
    
    /** 时间 */
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameLable) + HWStatusCellBorderW;
    CGSize timeSize = [self sizeWithText:status.created_at font:HWStatusCellTimeFont];
    self.timeLable = (CGRect){{timeX, timeY}, timeSize};
    
    /** 来源 */
    CGFloat sourceX = CGRectGetMaxX(self.timeLable) + HWStatusCellBorderW;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [self sizeWithText:status.source font:HWStatusCellSourceFont];
    self.sourseLable = (CGRect){{sourceX, sourceY}, sourceSize};
    
    /** 正文 */
    CGFloat contentX = iconX;
    CGFloat contentY = MAX(CGRectGetMaxY(self.headview), CGRectGetMaxY(self.timeLable)) + HWStatusCellBorderW;
    CGFloat maxW = cellW - 2 * contentX;
    CGSize weiboLable = [self sizeWithText:status.text font:HWStatusCellContentFont maxW:maxW];
    self.weiboLable = (CGRect){{contentX, contentY}, weiboLable};
    
    
    /** 配图 */
    
    /** 原创微博整体 */
    CGFloat originalX = 0;
    CGFloat originalY = 0;
    CGFloat originalW = cellW;
    CGFloat originalH = CGRectGetMaxY(self.weiboLable) + HWStatusCellBorderW;
    self.baseonView = CGRectMake(originalX, originalY, originalW, originalH);
    
    
    self.cellheight = CGRectGetMaxY(self.baseonView);

}

@end
