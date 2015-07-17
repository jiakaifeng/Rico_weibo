//
//  HWHomeViewController.m
//  贾凯峰微博项目
//
//  Created by apple on 14-10-7.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HWHomeViewController.h"
#import "HWDropdownMenu.h"
#import "HWTitleMenuViewController.h"
#import "Hwtabbar.h"
@interface HWHomeViewController ()<HWDropdownMenudelegate>


@end

@implementation HWHomeViewController
- (void)viewDidLoad
{
        [super viewDidLoad];
        
        /* 设置导航栏上面的内容 */
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendSearch) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
        
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
        
        /* 中间的标题按钮 */
        UIButton *titleButton = [[UIButton alloc] init];
        titleButton.width = 150;
        titleButton.height = 30;
    
    
        // 设置图片和文字
        [titleButton setTitle:@"首页" forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        titleButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    
        titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, 70, 0, 0);
        titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40);
        
        // 监听标题点击
        [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        
        self.navigationItem.titleView = titleButton;
        // 如果图片的某个方向上不规则，比如有突起，那么这个方向就不能拉伸
     
    }
    
    /**
     *  标题点击
     */
    - (void)titleClick:(UIButton *)titleButton
    {
        // 1.创建下拉菜单
        HWDropdownMenu *menu = [HWDropdownMenu menu];
        
        // 2.设置内容
        HWTitleMenuViewController *vc = [[HWTitleMenuViewController alloc] init];
        vc.view.height = 150;
        vc.view.width = 150;
        menu.contentController = vc;
        menu.delegate=self;
        // 3.显示
        [menu showFrom:titleButton];
        [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        
        
    }
    
    - (void)friendSearch
    {
        NSLog(@"friendSearch");
    }
    
    - (void)pop
    {
        NSLog(@"pop");
    }
#pragma dropdown delegate

-(void)dropdownmenudismiss:(HWDropdownMenu *)menu{
    UIButton *titleButton=(UIButton*) self.navigationItem.titleView;
    
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];




}
#pragma mark - Table view data source
    
    - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
    {
#warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 0;
    }
    
    - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
    {
#warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 0;
    }

@end
