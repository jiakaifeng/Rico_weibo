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
#import "MJRefresh.h"
#import "UIView+Extension.h"
#import"HWStatusCell.h"
#import "HWWbstatusFrame.h"
@interface HWHomeViewController ()<HWDropdownMenudelegate>
@property(nonatomic,strong)NSMutableArray *statesFrame;
@property(nonatomic,assign)NSInteger currentPage;
@end

@implementation HWHomeViewController
  //懒加载，当使用时加载
-(NSMutableArray *)statesFrame{


    if (!_statesFrame) {
        self.statesFrame=[NSMutableArray array];
    }
    return _statesFrame;

}

- (void)viewDidLoad{
    
        [super viewDidLoad];
        [self setupnav];
        [self setupUserInfo];
        //[self loadWeibo];
        [self setupRefresh];
    self.tableView.backgroundColor=HWColor(211, 211, 211);
        [self.tableView addFooterWithTarget:self action:@selector(loadmorweibo)];
        NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(setupremindweibo) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
    
}
-(void)setupremindweibo{

    HWAccount * account=[HWTool account];
    //使用afnetworking，创建管理者
    AFHTTPRequestOperationManager *manger=[AFHTTPRequestOperationManager manager];
    //创建字典，接收数据
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"access_token"]=account.access_token;
    params[@"uid"]=account.uid;

    //发送数据
    [manger GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject) {
        NSString*status =[responseObject[@"status"] description];
        if ([status isEqualToString:@"0"]) {
            self.tabBarItem.badgeValue=nil;
            [UIApplication sharedApplication].applicationIconBadgeNumber=0;
        }else{
            self.tabBarItem.badgeValue=status;
            [UIApplication sharedApplication].applicationIconBadgeNumber=status.intValue;

        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HWLog(@"请求失败--%@",error);
        
    }];
    


}
-(void)loadmorweibo{
    HWAccount * account=[HWTool account];
    //使用afnetworking，创建管理者
    AFHTTPRequestOperationManager *manger=[AFHTTPRequestOperationManager manager];
    //创建字典，接收数据
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"access_token"]=account.access_token;
    HWWbstatusFrame *laststatus=[self.statesFrame lastObject];
    if (laststatus) {
        // 若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
        // id这种数据一般都是比较大的，一般转成整数的话，最好是long long类型
        long long maxId = laststatus.status.idstr.longLongValue - 1;
        params[@"max_id"] = @(maxId);
    }
    //发送数据
    [manger GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject) {
        //将微博的字典转为微博模型数组
        NSArray *newStatuses = [HWWbstatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        NSArray *newFrames=[self statusframewithstatus:newStatuses];

        [self.statesFrame addObjectsFromArray:newFrames];
        //tableview 更新数据
        [self.tableView reloadData];
        [self.tableView footerEndRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HWLog(@"请求失败--%@",error);
        
    }];
    



}

-(NSArray *)statusframewithstatus:(NSArray *)Status{
    NSMutableArray *Frames=[NSMutableArray array];
    for (HWWbstatus *status in Status) {
        HWWbstatusFrame *statesframe=[[HWWbstatusFrame alloc]init];
        statesframe.status=status;
        [Frames addObject:statesframe];
    }
    return Frames;
}

-(void)setupuprefresh{



}
-(void)setupRefresh{
    UIRefreshControl *Refresh=[[UIRefreshControl alloc]init];
    [Refresh addTarget:self action:@selector(refreshchange:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:Refresh];
    
    // 2.马上进入刷新状态(仅仅是显示刷新状态，并不会触发UIControlEventValueChanged事件)
    [Refresh beginRefreshing];
    [self refreshchange:Refresh];
    

}
-(void)refreshchange:(UIRefreshControl *)Refresh{

    HWAccount * account=[HWTool account];
    //使用afnetworking，创建管理者
    AFHTTPRequestOperationManager *manger=[AFHTTPRequestOperationManager manager];
    //创建字典，接收数据
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"access_token"]=account.access_token;
    HWWbstatusFrame*firststatus=[self.statesFrame firstObject];
    if (firststatus) {
          params[@"since_id"]=firststatus.status.idstr;
    }
    //发送数据
    [manger GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject) {
        //将微博的字典转为微博模型数组
        NSArray *newStatus=[HWWbstatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        HWLog(@"%@",newStatus);
        NSArray *newFrames=[self statusframewithstatus:newStatus];
        NSRange range=NSMakeRange(0, newFrames.count);
        NSIndexSet *set=[NSIndexSet indexSetWithIndexesInRange:range];
        [self.statesFrame insertObjects:newFrames atIndexes:set];
        //tableview 更新数据
        [self.tableView reloadData];
        [Refresh endRefreshing];
        [self showWeiboCount:newStatus.count];
        
        self.tabBarItem.badgeValue=nil;
        [UIApplication sharedApplication].applicationIconBadgeNumber=0;
    
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
        return self.statesFrame.count;
    }

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HWStatusCell *cell=[HWStatusCell cellwithtableview:tableView];
    //所选微博数据
    cell.statusFrame=self.statesFrame[indexPath.row];
   // HWWbstatus *status=self.states[indexPath.row];
  //  HWUserinfo *user=status.user;
    //cell 数据变化
//    cell.detailTextLabel.text=status.text;
//    cell.textLabel.text=user.name;
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    HWWbstatusFrame *statusFrame=self.statesFrame[indexPath.row];
   
    return statusFrame.cellheight;



}
@end
