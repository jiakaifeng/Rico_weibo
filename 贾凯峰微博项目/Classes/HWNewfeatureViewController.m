//
//  HWNewfeatureViewController.m
//  贾凯峰微博项目
//
//  Created by jiakaifeng on 15/7/17.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import "HWNewfeatureViewController.h"
#import "HWTabBarViewController.h"

@interface HWNewfeatureViewController ()<UIScrollViewDelegate>
@property(nonatomic,weak)UIPageControl *pageconrol;

@end

@implementation HWNewfeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIScrollView *scrollview=[[UIScrollView alloc]init];
    scrollview.frame=self.view.bounds;
    scrollview.contentSize=CGSizeMake(4*scrollview.width, 0);
    [self.view addSubview:scrollview];
  
    
    for (int i=0; i<4; i++) {
        UIImageView *imageview=[[UIImageView alloc]init];
        imageview.size=scrollview.size;
        imageview.y=0;
        imageview.x=i*imageview.width;
        NSString * name=[NSString stringWithFormat:@"new_feature_%d",i+1];
        [imageview setImage:[UIImage imageNamed:name]];
        [scrollview addSubview:imageview];
        if (i==3) {
            [self setuplastimageview:imageview];
        }
    }
    

    [scrollview setPagingEnabled:YES];
    scrollview.bounces=NO;
    scrollview.showsHorizontalScrollIndicator=NO;
    scrollview.delegate=self;
    
    //pagecontrol 设置
    UIPageControl *pageconrol=[[UIPageControl alloc]init];
    pageconrol.numberOfPages=4;
    pageconrol.width=100;
    pageconrol.height=50;
    pageconrol.centerX=scrollview.width*0.5;
    pageconrol.centerY=scrollview.height-50;
    pageconrol.userInteractionEnabled=NO;
    [pageconrol setPageIndicatorTintColor:[UIColor grayColor]];
    [pageconrol setCurrentPageIndicatorTintColor:[UIColor orangeColor]];
    [self.view addSubview:pageconrol];
    self.pageconrol=pageconrol;

}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    double page=scrollView.contentOffset.x/scrollView.width;
    self.pageconrol.currentPage=(int)(page+0.5);
    


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setuplastimageview:(UIImageView *)imageview{
//开启交互功能
    imageview.userInteractionEnabled=YES;
//分享按钮
    UIButton *share=[[UIButton alloc]init];
    [share setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [share setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    share.width=100;
    share.height=60;
    share.centerX=self.view.width*0.5;
    share.centerY=self.view.height-200;
    [share setTitle:@"分享" forState:UIControlStateNormal];
    [share setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [share addTarget:self action:@selector(shareclick:) forControlEvents:UIControlEventTouchUpInside];
    [imageview addSubview:share];
    
//进入按钮
    UIButton *entir=[[UIButton alloc]init];
    [entir setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [entir setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [entir setTitle:@"进入微博" forState:UIControlStateNormal];
    [entir setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    entir.width=100;
    entir.height=40;
    entir.centerX=self.view.width*0.5;
    entir.centerY=self.view.height-150;
    [entir addTarget:self action:@selector(entireVIew) forControlEvents:UIControlEventTouchUpInside];
    [imageview addSubview:entir];
    
   
}
-(void)shareclick:(UIButton *)share{
    share.selected=!share.isSelected;



}

-(void)entireVIew{
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    window.rootViewController=[[HWTabBarViewController alloc]init];


}
-(void)dealloc{

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
