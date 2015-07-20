//
//  HWAutorViewController.m
//  贾凯峰微博项目
//
//  Created by jiakaifeng on 15/7/20.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import "HWAutorViewController.h"
#import "AFNetworking.h"

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
    NSURL* url=[NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=1403737951&redirect_uri=http://"];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [webview loadRequest:request];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{

    NSString *url=request.URL.absoluteString;
    NSRange range=[url rangeOfString:@"code="];
    if (range.length!=0) {
       NSInteger fromindex=range.location+range.length;
        NSString *code=[url substringFromIndex:fromindex];
        [self accesswithcode:code];
        
    }
    return YES;

}
//https://api.weibo.com/oauth2/access_token
//HTTP请求方式
//POST
//请求参数
//必选	类型及范围	说明
//client_id	true	string	申请应用时分配的AppKey。
//client_secret	true	string	申请应用时分配的AppSecret。
//grant_type	true	string	请求的类型，填写authorization_code
//
//grant_type为authorization_code时
//必选	类型及范围	说明
//code	true	string	调用authorize获得的code值。
//redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
-(void)accesswithcode:(NSString *)code{
    
    AFHTTPRequestOperationManager *manger=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"client_id"]=@"1403737951";
    params[@"client_secret"]=@"99638456ed430326f8e033635c437de6";
    params[@"grant_type"]=@"authorization_code";
    params[@"redirect_uri"]=@"http://";
    params[@"code"]=code;
    manger POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:<#^(AFHTTPRequestOperation *operation, id responseObject)success#> failure:<#^(AFHTTPRequestOperation *operation, NSError *error)failure#>
    
    
    
}



@end
