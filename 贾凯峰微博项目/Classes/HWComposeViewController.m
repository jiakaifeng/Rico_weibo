
#import "HWComposeViewController.h"
#import "HWTool.h"
#import "HWAccount.h"
#import "PlaceholderTextView.h"
#import "MBProgressHUD+MJ.h"
#import "AFNetworking.h"

@interface HWComposeViewController ()
/** 输入控件 */
@property (nonatomic, weak) PlaceholderTextView *textView;
@end

@implementation HWComposeViewController
#pragma mark - 系统方法
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置导航栏内容
    [self setupNav];
    
    // 添加输入控件
    [self setupTextView];
    
    // 默认是YES：当scrollView遇到UINavigationBar、UITabBar等控件时，默认会设置scrollView的contentInset
//    self.automaticallyAdjustsScrollViewInsets;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - 初始化方法
/**
 * 设置导航栏内容
 */
- (void)setupNav
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.navigationItem.title=@"发微博";
    
}

/**
 * 添加输入控件
 */
- (void)setupTextView
{
    PlaceholderTextView *textView = [[PlaceholderTextView alloc] init];

  textView.PlaceholderLabel.text=@"分享新微博......";
    textView.PlaceholderLabel.frame = (CGRect){0,0,300,30};
    textView.frame=self.view.bounds;
    [self.view addSubview:textView];
    self.textView=textView;

//    // 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
}



#pragma mark - 监听方法
- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)send {

    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [HWTool account].access_token;
    params[@"status"] = self.textView.text;
    
    // 3.发送请求
    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
    
    // 4.dismiss
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 * 监听文字改变
 */
- (void)textDidChange
{
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}
@end
