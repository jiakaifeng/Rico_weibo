//
//  HWTabBarViewController.m
//  贾凯峰微博项目
//
//  Created by apple on 14-10-7.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HWTabBarViewController.h"
#import "HWHomeViewController.h"
#import "HWMessageCenterViewController.h"
#import "HWDiscoverViewController.h"
#import "HWProfileViewController.h"
#import "HWNavigationController.h"
#import "Hwtabbar.h"
#import "HWComposeViewController.h"
#import "TPCSpringMenu.h"
//#import "HWmeauViewController.h"

@interface HWTabBarViewController ()<HWTabBarDelegate,TPCSpringMenuDelegate,TPCSpringMenuDataSource>
@property (weak, nonatomic) TPCSpringMenu *menu;
@property(strong,nonatomic)UIPopoverController *popover;
@end

@implementation HWTabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.初始化子控制器
    HWHomeViewController *home = [[HWHomeViewController alloc] init];
    [self addChildVc:home title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    HWMessageCenterViewController *messageCenter = [[HWMessageCenterViewController alloc] init];
    [self addChildVc:messageCenter title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    

    HWDiscoverViewController *discover = [[HWDiscoverViewController alloc] init];
    [self addChildVc:discover title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];

    HWProfileViewController *profile = [[HWProfileViewController alloc] init];
    [self addChildVc:profile title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    
  Hwtabbar *tabBar = [[Hwtabbar alloc] init];
    [self setValue:tabBar forKeyPath:@"tabBar"];
    
}

/**
 *  添加一个子控制器
 *
 *  @param childVc       子控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中的图片
 */
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置子控制器的文字
    childVc.title = title; // 同时设置tabbar和navigationBar的文字
//    childVc.tabBarItem.title = title; // 设置tabbar的文字
//    childVc.navigationItem.title = title; // 设置navigationBar的文字

    // 设置子控制器的图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = HWColor(123, 123, 123);
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
//    childVc.view.backgroundColor = HWRandomColor;
    
    // 先给外面传进来的小控制器 包装 一个导航控制器
    HWNavigationController *nav = [[HWNavigationController alloc] initWithRootViewController:childVc];
    // 添加为子控制器
    [self addChildViewController:nav];
}
-(void)tabBarDidClickPlusButton:(Hwtabbar *)tabBar{

//    HWmeauViewController *meau=[[HWmeauViewController alloc]init];
    TPCItem *item1 = [TPCItem itemWithImage:[UIImage imageNamed:@"tabbar_compose_camera"] title:@"相机"];
    TPCItem *item2 = [TPCItem itemWithImage:[UIImage imageNamed:@"tabbar_compose_idea"] title:@"文字"];
    TPCItem *item3 = [TPCItem itemWithImage:[UIImage imageNamed:@"tabbar_compose_lbs"] title:@"签到"];
    TPCItem *item4 = [TPCItem itemWithImage:[UIImage imageNamed:@"tabbar_compose_more"] title:@"更多"];
    
    TPCItem *item5 = [TPCItem itemWithImage:[UIImage imageNamed:@"tabbar_compose_photo"] title:@"相册"];
    TPCItem *item6 = [TPCItem itemWithImage:[UIImage imageNamed:@"tabbar_compose_review"] title:@"点评"];
    NSArray *items = @[item1, item2, item3, item4, item5, item6];
     TPCSpringMenu *menu = [TPCSpringMenu menuWithItems:items];
    // 按钮文字颜色
    menu.buttonTitleColor = [UIColor blackColor];
    // 按钮行数
    menu.columns = 3;
    // 最后一个按钮与底部的距离
    menu.spaceToBottom = 100;
    // 按钮半径（只支持圆形图片，非圆形图片以宽度算）
    menu.buttonDiameter = 50;
    // 允许点击隐藏menu
    menu.enableTouchResignActive=YES;
    menu.dataSource =self;
    menu.delegate = self;
    [self.view addSubview:menu];
    _menu = menu;
    [_menu becomeActive];

}

- (UIButton *)buttonToChangeActiveForSpringMenu:(TPCSpringMenu *)menu
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, self.view.bounds.size.width, 40);
    btn.backgroundColor  = [UIColor whiteColor];
    [btn setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_close"] forState:UIControlStateNormal];
    return btn;
}
- (UIView *)backgroundViewOfSpringMenu:(TPCSpringMenu *)menu
{
    UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
    view.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"compose_slogan"]];
    imageView.bounds = CGRectMake(0, 0, 154, 48);
    imageView.center = CGPointMake(self.view.bounds.size.width * 0.5, 100);
    [view addSubview:imageView];
    
    return view;
}
- (void)springMenu:(TPCSpringMenu *)menu didClickBottomActiveButton:(UIButton *)button{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)springMenu:(TPCSpringMenu *)menu didClickButtonWithIndex:(NSInteger)index
{
    [menu removeFromSuperview];
    if(index==1){
        HWComposeViewController *vc=[[HWComposeViewController alloc]init];
        HWNavigationController *nav=[[HWNavigationController alloc]initWithRootViewController:vc];
        [self presentViewController:nav
                           animated:YES completion:nil];
    }
}
@end
