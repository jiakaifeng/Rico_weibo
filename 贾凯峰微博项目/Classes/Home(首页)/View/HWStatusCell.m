//
//  HWStatusCell.m
//  贾凯峰微博项目
//
//  Created by jiakaifeng on 15/7/24.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import "HWStatusCell.h"
#import "HWWbstatus.h"
#import "HWWbstatusFrame.h"
#import "HWUserinfo.h"
#import "UIImage+GIF.h"
#import "UIImageView+WebCache.h"
@interface HWStatusCell()
@property(nonatomic,weak)UIView *baseonView;
@property(nonatomic,weak)UIImageView * headview;
@property(nonatomic,weak)UIImageView * photoview;
@property(nonatomic,weak)UIImageView * vipview;
@property(nonatomic,weak)UILabel *nameLable;
@property(nonatomic,weak)UILabel *timeLable;
@property(nonatomic,weak)UILabel *sourseLable;
@property(nonatomic,weak)UILabel *weiboLable;

@end
@implementation HWStatusCell
+(instancetype)cellwithtableview:(UITableView *)tableview{

    static NSString *ID=@"status";
    HWStatusCell *cell=[tableview dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[HWStatusCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }

    return cell;


}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *baseonView=[[UIView alloc]init];
        [self.contentView addSubview:baseonView];
        self.baseonView=baseonView;
        
        UIImageView *headview=[[UIImageView alloc]init];
        [baseonView addSubview:headview];
        self.headview=headview;
        
        UIImageView *photoview=[[UIImageView alloc]init];
        [baseonView addSubview:photoview];;
        self.photoview=photoview;
        
        UIImageView *vipview=[[UIImageView alloc]init];
        [baseonView addSubview:vipview];
        self.vipview=vipview;
        
        UILabel *nameLable=[[UILabel alloc]init];
        nameLable.font=HWStatusCellNameFont;
        [baseonView addSubview:nameLable];
        self.nameLable=nameLable;
        
        UILabel *timeLable=[[UILabel alloc]init];
        timeLable.font=HWStatusCellTimeFont;
        [baseonView addSubview:timeLable];
        self.timeLable=timeLable;
        
        UILabel *sourseLable=[[UILabel alloc]init];
        [baseonView addSubview:sourseLable];
        sourseLable.font=HWStatusCellSourceFont;
        self.sourseLable=sourseLable;
        
        UILabel *weiboLable=[[UILabel alloc]init];
        [baseonView addSubview:weiboLable];
        self.weiboLable=weiboLable;
        weiboLable.font = HWStatusCellContentFont;
        weiboLable.numberOfLines = 0;
    }

    return self;





}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setStatusFrame:(HWWbstatusFrame *)statusFrame{

    _statusFrame=statusFrame;
    HWWbstatus *status=statusFrame.status;
    HWUserinfo *user=status.user;
    //原始页面
    self.baseonView.frame=statusFrame.baseonView;
    //头像
    self.headview.frame=statusFrame.headview;
    [self.headview sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_defaul_small"]];
    //vip
    self.vipview.frame=statusFrame.vipview;
    self.vipview.image=[UIImage imageNamed:@"common_icon_membership_level1"];
 
    //配图
    self.photoview.frame=statusFrame.photoview;
    self.photoview.backgroundColor=[UIColor redColor];
    //姓名
    
    self.nameLable.frame=statusFrame.nameLable;
    self.nameLable.text=user.name;
    //时间
    self.timeLable.frame=statusFrame.timeLable;
    self.timeLable.text=status.created_at;
    //微博来源
    self.sourseLable.frame=statusFrame.sourseLable;
    self.sourseLable.text=status.source;
    //正文内容
    self.weiboLable.frame=statusFrame.weiboLable;
    self.weiboLable.text=status.text;
 
}
@end
