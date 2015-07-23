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
#import "AFNetworking.h"
#import "HWTool.h"
#import "HWAccount.h"
#import "MBProgressHUD+MJ.h"
#import "UIImageView+WebCache.h"
#import "HWWbstatus.h"
#import "HWUserinfo.h"
#import "MJExtension.h"
#import "HWFootreload.h"
@interface HWHomeViewController ()<HWDropdownMenudelegate>
@property(nonatomic,strong)NSMutableArray *states;
@end

@implementation HWHomeViewController
  //懒加载，当使用时加载
-(NSMutableArray *)states{


    if (!_states) {
        self.states=[NSMutableArray array];
    }
    return _states;

}

- (void)viewDidLoad{
    
        [super viewDidLoad];
        [MBProgressHUD showMessage:@"正在加载中"];
        [self setupnav];
        [self setupUserInfo];
       [self loadWeibo];
       [self setupRefresh];
    [self setupuprefresh];
    
}
-(void)setupuprefresh{

    self.tableView.tableFooterView=[HWFootreload footreload];


}
-(void)setupRefresh{
    UIRefreshControl *Refresh=[[UIRefreshControl alloc]init];
    [Refresh addTarget:self action:@selector(refreshchange:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:Refresh];

}
-(void)refreshchange:(UIRefreshControl *)Refresh{

    HWAccount * account=[HWTool account];
    //使用afnetworking，创建管理者
    AFHTTPRequestOperationManager *manger=[AFHTTPRequestOperationManager manager];
    //创建字典，接收数据
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"access_token"]=account.access_token;
    HWWbstatus *firststatus=[self.states firstObject];
    params[@"since_id"]=firststatus.idstr;
    //发送数据
    [manger GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject) {
        //将微博的字典转为微博模型数组
        NSArray *newStatus=[HWWbstatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        NSRange range=NSMakeRange(0, newStatus.count);
        NSIndexSet *set=[NSIndexSet indexSetWithIndexesInRange:range];
        [self.states insertObjects:newStatus atIndexes:set];
        //tableview 更新数据
        [self.tableView reloadData];
        [self showWeiboCount:newStatus.count];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HWLog(@"请求失败--%@",error);
        
    }];
    

    [Refresh endRefreshing];


}
-(void)showWeiboCount:(NSUInteger)count{
    UILabel *weibocount=[[UILabel alloc]init];
    weibocount.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    weibocount.width=[UIScreen mainScreen].bounds.size.width;
    weibocount.height=30;
    if (count==0) {
        weibocount.text=@"没有新微博";
        
    }else{
    weibocount.text=[NSString stringWithFormat:@"共有%lu条新微博",(unsigned long)count];
 
    }
    weibocount.textColor=[UIColor whiteColor];
    weibocount.textAlignment=NSTextAlignmentCenter;
    weibocount.font=[UIFont systemFontOfSize:16];
    weibocount.y=64-weibocount.height;
    
    [self.navigationController.view insertSubview:weibocount belowSubview:self.navigationController.navigationBar];
    [UIView animateWithDuration:1 animations:^{
        weibocount.transform=CGAffineTransformMakeTranslation(0, weibocount.height);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 delay:1 options:UIViewAnimationOptionCurveLinear animations:^{
            weibocount.transform=CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [weibocount removeFromSuperview];
        }];
    }];


}
 ///获取用户关注人的数据
-(void)loadWeibo{
    //调用工具类的方法，取出其中储存的access_token 的数据
    HWAccount * account=[HWTool account];
    //使用afnetworking，创建管理者
    AFHTTPRequestOperationManager *manger=[AFHTTPRequestOperationManager manager];
    //创建字典，接收数据
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"access_token"]=account.access_token;

    //发送数据
    [manger GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject) {
        //将微博的字典转为微博模型数组
        NSArray *newStatus=[HWWbstatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        //添加新数据
        [self.states addObjectsFromArray:newStatus];
         //tableview 更新数据
        [self.tableView reloadData];

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HWLog(@"请求失败--%@",error);
        
    }];

    [MBProgressHUD hideHUD];


}
-(void)setupUserInfo{
//https://api.weibo.com/2/users/show.json
//    access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
//    uid	false	int64	需要查询的用户ID。
//    screen_name	false	string	需要查询的用户昵称。
    HWAccount * account=[HWTool account];
    AFHTTPRequestOperationManager *manger=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"access_token"]=account.access_token;
    params[@"uid"]=account.uid;

    [manger GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject) {
        HWLog(@"请求成功--%@",responseObject);
        HWUserinfo *user=[HWUserinfo objectWithKeyValues:responseObject];
        UIButton *titlebutton=(UIButton *)self.navigationItem.titleView;
        [titlebutton setTitle:user.name forState:UIControlStateNormal];
        account.name=user.name;
        [HWTool saveaccount:account];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HWLog(@"请求失败--%@",error);
    }];


}

-(void)setupnav{

    HWAccount * account=[HWTool account];
    /* 设置导航栏上面的内容 */
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendSearch) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
    
    /* 中间的标题按钮 */
    UIButton *titleButton = [[UIButton alloc] init];
    titleButton.width = 150;
    titleButton.height = 30;
    // 设置图片和文字
    if (account) {
        [titleButton setTitle:account.name forState:UIControlStateNormal];

    }else{
    [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    }
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    titleButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, 90, 0, 0);
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
        [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
        
        
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
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
    {
        return self.states.count;
    }

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID=@"status";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    //所选微博数据
    HWWbstatus *status=self.states[indexPath.row];
    HWUserinfo *user=status.user;
    //cell 数据变化
    cell.detailTextLabel.text=status.text;
    cell.textLabel.text=user.name;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    return cell;
}
@end
