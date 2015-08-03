//
//  HWsendweibo.m
//  贾凯峰微博项目
//
//  Created by jiakaifeng on 15/8/3.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import "HWsendweibo.h"
#import "HWTool.h"
#import "HWAccount.h"
#import "AFNetworking.h"
#import "HWTool.h"
#import "MBProgressHUD+MJ.h"

@interface HWsendweibo ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *back;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *send;
@property (weak, nonatomic) IBOutlet PlaceholderTextView *test;

@end

@implementation HWsendweibo

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setuotestfoeld];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)setuotestfoeld{
PlaceholderTextView *test=[[PlaceholderTextView alloc]init];
    test.placeholder=@"分享新的微博....";
    test.placeholderColor=[UIColor grayColor];
    self.test=test;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buttonchange:) name:@"weibochage" object:test];
}



-(void)buttonchange:(NSString *)titile{
   self.send.enabled=self.test.hasText;
    NSLog(@"调用");

}
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sendweibo:(id)sender {
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [HWTool account].access_token;
    params[@"status"] = self.test.text;
    
    // 3.发送请求
    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
        NSLog(@"shuchu");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
    
    // 4.dismiss
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
