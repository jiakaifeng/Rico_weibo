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
#import "HWphoto.h"
#import "UIImageView+WebCache.h"
#import "HWtoobar.h"
#define HWColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@interface HWStatusCell()
@property(nonatomic,weak)UIView *baseonView;
@property(nonatomic,weak)UIImageView * headview;
@property(nonatomic,weak)UIImageView * photoview;
@property(nonatomic,weak)UIImageView * vipview;
@property(nonatomic,weak)UILabel *nameLable;
@property(nonatomic,weak)UILabel *timeLable;
@property(nonatomic,weak)UILabel *sourseLable;
@property(nonatomic,weak)UILabel *weiboLable;
//repost weibo
@property(nonatomic,weak)UIView *repostView;
@property(nonatomic,weak)UIImageView * repostphoto;
@property(nonatomic,weak)UILabel *repostweibo;

@property(nonatomic,weak)HWtoobar *toolbar;




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
        self.backgroundColor=[UIColor clearColor];
        self.selectionStyle=UITableViewScrollPositionNone;
        [self setupweibo];
        [self setuprepostweibo];
        [self setuptoolbar];
        
       
    }

    return self;

}

-(void)setuptoolbar{

    HWtoobar *toolbar=[[HWtoobar alloc]init];
    [self.contentView addSubview:toolbar];
    self.toolbar=toolbar;






}
//转发微博创建
-(void)setuprepostweibo{

    UIView *repostView=[[UIView alloc]init];
    repostView.backgroundColor=HWColor(246, 246, 246);
    [self.contentView addSubview:repostView];
    self.repostView=repostView;
    
    UIImageView *repostimage=[[UIImageView alloc]init];
    [repostView addSubview:repostimage];
    self.repostphoto=repostimage;
    
    UILabel *repostweibo=[[UILabel alloc]init];
    repostweibo.numberOfLines=0;
    repostweibo.font=HWStatusCellRetweetContentFont;
    [repostView addSubview:repostweibo];
    self.repostweibo=repostweibo;


}
//原创微博的创建
-(void)setupweibo{

    UIView *baseonView=[[UIView alloc]init];
    baseonView.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:baseonView];
    self.baseonView=baseonView;
    
    UIImageView *headview=[[UIImageView alloc]init];
    [baseonView addSubview:headview];
    self.headview=headview;
    
    UIImageView *photoview=[[UIImageView alloc]init];
    [baseonView addSubview:photoview];
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
    if (status.pic_urls.count) {
        self.photoview.frame=statusFrame.photoview;
        HWphoto *imageurl=[status.pic_urls firstObject];
        [self.photoview sd_setImageWithURL:[NSURL URLWithString:imageurl.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        self.photoview.hidden=NO;
    }else{
            self.photoview.hidden=YES;
    }
    
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
    //转发微博
        if (status.retweeted_status) {
        HWWbstatus *retweeted_status=status.retweeted_status;
        HWUserinfo *retweeted_status_user=status.retweeted_status.user;
        NSString *repostweibo=[NSString stringWithFormat:@"@%@ : %@",retweeted_status_user.name,retweeted_status.text];
        self.repostView.hidden=NO;
        self.repostView.frame=statusFrame.repostView;
        
        self.repostweibo.text=repostweibo;
        self.repostweibo.frame=statusFrame.repostweibo;
        
        if (retweeted_status.pic_urls.count) {
            self.repostphoto.frame=statusFrame.repostphoto;
            HWphoto *imageurl=[retweeted_status.pic_urls firstObject];
            [self.repostphoto sd_setImageWithURL:[NSURL URLWithString:imageurl.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
            self.repostphoto.hidden=NO;
        }else{
            self.repostphoto.hidden=YES;
        }
    }else{
    
        self.repostView.hidden=YES;
    }
 
    self.toolbar.frame=statusFrame.toolbar;
    self.toolbar.status=status;
}
@end
