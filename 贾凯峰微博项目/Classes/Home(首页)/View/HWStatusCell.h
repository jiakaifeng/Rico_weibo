//
//  HWStatusCell.h
//  贾凯峰微博项目
//
//  Created by jiakaifeng on 15/7/24.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HWWbstatusFrame;
@interface HWStatusCell : UITableViewCell
+(instancetype)cellwithtableview:(UITableView *)tableview;
@property(strong,nonatomic)HWWbstatusFrame* statusFrame;


@end
