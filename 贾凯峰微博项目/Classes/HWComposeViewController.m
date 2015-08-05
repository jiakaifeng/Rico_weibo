
#import "HWComposeViewController.h"
#import "HWTool.h"
#import "HWAccount.h"
#import "PlaceholderTextView.h"
#import "MBProgressHUD+MJ.h"
#import "AFNetworking.h"
#import "HWHomeViewController.h"
#import"HWwriteweibotoolbar.h"
#import "UIView+KeyboardObserver.h"
#import "HWphotoalumb.h"

@interface HWComposeViewController ()<UITextViewDelegate,buttondelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
/** 输入控件 */
@property (nonatomic, weak) PlaceholderTextView *textView;
@property(nonatomic,weak)HWwriteweibotoolbar *toolbar;
@property(nonatomic,weak)HWphotoalumb *photoalumb;
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
    [self setupwbtoolbar];
    [self setupphoto];
     self.textView.delegate=self;
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.toolbar addKeyboardObserver];
    [self.toolbar becomeFirstResponder];

    
    
}
-(void)setupphoto{
    HWphotoalumb *photialumb=[[HWphotoalumb alloc]init];
      photialumb.width=self.view.width;
      photialumb.height=self.view.height;
       photialumb.y=100;
    photialumb.x=20;
    [self.textView addSubview:photialumb];
    self.photoalumb=photialumb;
}
-(void)setupwbtoolbar{
    HWwriteweibotoolbar *toolbar=[[HWwriteweibotoolbar alloc]init];
    toolbar.width=self.view.width;
    toolbar.height=40;
    toolbar.y=self.view.height-toolbar.height;
    toolbar.delegate=self;
    [self.view addSubview:toolbar];
    self.toolbar=toolbar;
//    [self.toolbar addKeyboardObserver];
    //self.textView.inputAccessoryView=toolbar;
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.textView endEditing:YES];

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
    textView.alwaysBounceVertical=YES;
    textView.PlaceholderLabel.text=@"分享新微博......";
    textView.PlaceholderLabel.frame = (CGRect){5,1,300,30};
    textView.font=[UIFont systemFontOfSize:15];
    textView.frame=self.view.bounds;
    [textView becomeFirstResponder];
    [self.view addSubview:textView];
    self.textView=textView;

//    // 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
  
}
#pragma mark - 监听方法
- (void)cancel {

    [self dismissViewControllerAnimated:YES completion:nil];
    [self.textView endEditing:YES];
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
-(void)toolbar:(HWwriteweibotoolbar *)toolbar clikbutton:(buttontype)buttontype{

    switch (buttontype) {
        case buttontypecamer:
            [self opencamera];
            break;
        case buttontypeemotion:
        
            break;
        case buttontypekeyboard:
            
            break;
        case buttontypeperson:
            
            break;
        case buttontypephoto:
           [ self openalumb];
            break;
    }



}

-(void)opencamera{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        return;
    UIImagePickerController *pickcontro=[[UIImagePickerController alloc]init];
    pickcontro.sourceType=UIImagePickerControllerSourceTypeCamera;
    pickcontro.delegate=self;
    [self presentViewController:pickcontro animated:YES completion:nil];
 }

-(void)openalumb{

    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        return;
    UIImagePickerController *pickcontro=[[UIImagePickerController alloc]init];
    pickcontro.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    pickcontro.delegate=self;
    [self presentViewController:pickcontro animated:YES completion:nil];
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *image=info[UIImagePickerControllerOriginalImage];
    
    [self.photoalumb addimage:image];


}
@end
