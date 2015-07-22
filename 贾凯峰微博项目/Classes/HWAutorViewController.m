//
//  HWAutorViewController.m
//  贾凯峰微博项目
//
//  Created by jiakaifeng on 15/7/20.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import "HWAutorViewController.h"
#import "AFNetworking.h"
#import "HWNewfeatureViewController.h"
#import "HWTabBarViewController.h"
#import "HWAccount.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"
#import "HWTool.h"
@interface HWAutorViewController ()<UIWebViewDelegate>

@end

@implementation HWAutorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *webview=[[UIWebView alloc]init];
    webview.frame=self.view.bounds;
    webview.delegate=self;
    [self.view addSubview:webview];
    // App Key：
    // 1403737951
    //App Secret：
    //99638456ed430326f8e033635c437de6
    //获取登入页面
    NSURL* url=[NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=1403737951&redirect_uri=http://"];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [webview loadRequest:request];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [MBProgressHUD hideHUD];
}
-(void)webViewDidStartLoad:(UIWebView *)webView{

    [MBProgressHUD showMessage:@"正在登入中"];

}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{

    [MBProgressHUD hideHUD];

}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    //取出需要的code部分
    NSString *url=request.URL.absoluteString;
    NSRange range=[url rangeOfString:@"code="];
    if (range.length!=0) {
       NSInteger fromindex=range.location+range.length;
        NSString *code=[url substringFromIndex:fromindex];
        //将获取的code值接收
        [self accesswithcode:code];
        HWLog(@"ss--%@",code);
        return NO;
    }
    return YES;

}
//将获取数据打包传回新浪服务器
-(void)accesswithcode:(NSString *)code{
    
    AFHTTPRequestOperationManager *manger=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"client_id"]=@"1403737951";
    params[@"client_secret"]=@"99638456ed430326f8e033635c437de6";
    params[@"grant_type"]=@"authorization_code";
    params[@"redirect_uri"]=@"http://";
    params[@"code"]=code;
    [manger POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
        //沙盒路径
        NSString * doc =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString * path=[doc stringByAppendingPathComponent:@"account.archive"];
        //创建模型，存入沙盒
        HWAccount *Account=[HWAccount AccountwithDict:responseObject];
        //储存账号模型
        [HWTool saveaccount:Account];
        //自定义将对象储存进沙盒
        [NSKeyedArchiver archiveRootObject:Account toFile:path];
        //创建版本
        NSString *lastVersion= [[NSUserDefaults standardUserDefaults]objectForKey:@"CFBundleVersion"];
        //当前版本
        NSString *CurrentVersion=[NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
        //储存进沙盒
        UIWindow *window=[UIApplication sharedApplication].keyWindow;
        if ([CurrentVersion isEqualToString:lastVersion]) {
            window.rootViewController=[[HWTabBarViewController alloc]init];
        }else {
            
         window.rootViewController = [[HWNewfeatureViewController alloc] init];
            [[NSUserDefaults standardUserDefaults]setObject:CurrentVersion forKey:@"CFBundleVersion"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }

        HWLog(@"请求成功-%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUD];
        HWLog(@"请求失败-%@",error);
    }];
    
    
    
}



@end
