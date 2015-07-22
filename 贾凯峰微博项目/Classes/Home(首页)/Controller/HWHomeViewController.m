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
@interface HWHomeViewController ()<HWDropdownMenudelegate>
@property(nonatomic,strong)NSMutableArray *states;
@end

@implementation HWHomeViewController

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
       [MBProgressHUD hideHUD];


    
}
-(void)loadWeibo{
//    
//    必选	类型及范围	说明
//    access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
//    since_id	false	int64	若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
//    max_id	false	int64	若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
//    count	false	int	单页返回的记录条数，最大不超过100，默认为20。
//    page	false	int	返回结果的页码，默认为1。
//    base_app	false	int	是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
//    feature	false	int	过滤类型ID，0：全部、1：原创、2：图片、3：视频、4：音乐，默认为0。
//    trim_user	false	int	返回值中user字段开关，0：返回完整user字段、1：user字段仅返回user_id，默认为0。
    HWAccount * account=[HWTool account];
    AFHTTPRequestOperationManager *manger=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"access_token"]=account.access_token;
    
    [manger GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject) {
        HWLog(@"请求成功--%@",responseObject);
        NSArray *dictArry=responseObject[@"statuses"];
        for (NSDictionary *dic in dictArry) {
            HWWbstatus *status=[HWWbstatus objectWithKeyValues:dic];
            [self.states addObject:status];
        }
        [self.tableView reloadData];
 
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HWLog(@"请求失败--%@",error);
        
    }];



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
        // Return the number of rows in the section.
        return self.states.count;
    }
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID=@"status";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    HWWbstatus *status=self.states[indexPath.row];
    HWUserinfo *user=status.user;
    cell.detailTextLabel.text=status.text;
    cell.textLabel.text=user.name;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    return cell;
}
@end
