
#import "HWComposeViewController.h"
#import "HWTool.h"
#import "HWAccount.h"
#import "PlaceholderTextView.h"
#import "MBProgressHUD+MJ.h"
#import "AFNetworking.h"
#import "HWHomeViewController.h"
#import"HWwriteweibotoolbar.h"
//#import "UIView+KeyboardObserver.h"
#import "HWphotoalumb.h"
#import "HWemotionkeyboardview.h"

@interface HWComposeViewController ()<UITextViewDelegate,buttondelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
/** 输入控件 */
@property (nonatomic, weak) PlaceholderTextView *textView;
//申明工具栏
@property(nonatomic,weak)HWwriteweibotoolbar *toolbar;
//申明发送的图片
@property(nonatomic,weak)HWphotoalumb *photoalumb;
//是否在改变键盘
@property (nonatomic ,assign, getter=isChangingKeyboard) BOOL ChangingKeyboard;
//表情键盘
@property(nonatomic,strong)HWemotionkeyboardview *emotionview;
@end

@implementation HWComposeViewController

//表情键盘的懒加载
-(HWemotionkeyboardview *)emotionview{


    if (!_emotionview) {
       self.emotionview=[[HWemotionkeyboardview alloc]init];
    
    }
    return _emotionview;
}
#pragma mark - 系统方法

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // 设置导航栏内容
    [self setupNav];
        // 添加输入控件
    [self setupTextView];
    //添加工具栏
    [self setupwbtoolbar];
    //添加上传照片
    [self setupphoto];
    //设置代理
     self.textView.delegate=self;
    
}
//视图即将呈现
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.toolbar addKeyboardObserver];
    //成为第一响应弹出键盘
    [self.toolbar becomeFirstResponder];

    
    
}
//初始化图片选择，设置frame
-(void)setupphoto{
    HWphotoalumb *photialumb=[[HWphotoalumb alloc]init];
      photialumb.width=self.view.width;
      photialumb.height=self.view.height;
       photialumb.y=100;
    photialumb.x=20;
    //添加到主视图
    [self.textView addSubview:photialumb];
//赋值
    self.photoalumb=photialumb;
}
//设置工具条
-(void)setupwbtoolbar{
    HWwriteweibotoolbar *toolbar=[[HWwriteweibotoolbar alloc]init];
    toolbar.width=self.view.width;
    toolbar.height=40;
    toolbar.y=self.view.height-toolbar.height;
    toolbar.delegate=self;
    [self.view addSubview:toolbar];
    self.toolbar=toolbar;
//   监听键盘的变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    // 键盘即将隐藏, 就会发出UIKeyboardWillHideNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
//    [self.toolbar addKeyboardObserver];
    //self.textView.inputAccessoryView=toolbar;
    
}

- (void)keyboardWillHide:(NSNotification *)note
{
    //需要判断是否自定义切换的键盘
    if (self.ChangingKeyboard) return;
        // 1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformIdentity;//回复之前的位置
    }];
}

/**
 *  键盘即将弹出
 */
- (void)keyboardWillShow:(NSNotification *)note
{
    // 1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
        // 取出键盘高度
        CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat keyboardH = keyboardF.size.height;
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, - keyboardH);
        
    }];
}
//代理页面拖拽键盘取消
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
//   成为第一响应
    [textView becomeFirstResponder];
    [self.view addSubview:textView];
    self.textView=textView;
// 监听字体输入通知
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
//   判断这条微博是否带有图片
    if (self.photoalumb.addphotos.count) {
        [mgr POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//            取出储存的第一个图片
        UIImageView *image=[self.photoalumb.addphotos firstObject];
//            将图片压缩
            NSData* data=UIImageJPEGRepresentation(image, 1.0);
//            afnettworking 的图片上传
            [formData appendPartWithFileData:data name:@"pic" fileName:@"test.jpg" mimeType:@"image/jpeg"];
        } success:^(AFHTTPRequestOperation *operation, NSDictionary * responseObject) {
            [MBProgressHUD showSuccess:@"发送成功"];

        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [MBProgressHUD showError:@"发送失败"];
        }];
    }else {
    // 3.发送请求
    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [MBProgressHUD showError:@"发送失败"];
    }];
    }
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
//writeweibo的代理，成为他的代理需要使用它的方法，传入工具条和button点击的类型
-(void)toolbar:(HWwriteweibotoolbar *)toolbar clikbutton:(buttontype)buttontype{
//传入点击的响应button类型进行选择方法。
    switch (buttontype) {
        case buttontypecamer:
            [self opencamera];
            break;
        case buttontypeemotion:
            [self openemotion];
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
//打开表情键盘
-(void)openemotion{
//    如果为系统键盘，初始化表情键盘
    if (self.textView.inputView==nil) {
        HWemotionkeyboardview *emotionview=[[HWemotionkeyboardview alloc]init];
        emotionview.width=self.view.width;
        emotionview.height=220;
        self.textView.inputView=emotionview;
        self.emotionview=emotionview;
//        已经变成表情键盘，工具条图标需要变成keyboard
        self.toolbar.keyboardbuttonshow=YES;
    }else{
        self.textView.inputView=nil;
        self.toolbar.keyboardbuttonshow=NO;

    }
//    已经改变键盘
    self.ChangingKeyboard=YES;
    [self.textView endEditing:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
          [self.textView becomeFirstResponder];
            self.ChangingKeyboard=NO;
    });

}
//打开照相机
-(void)opencamera{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        return;
    UIImagePickerController *pickcontro=[[UIImagePickerController alloc]init];
    pickcontro.sourceType=UIImagePickerControllerSourceTypeCamera;
    pickcontro.delegate=self;
    [self presentViewController:pickcontro animated:YES completion:nil];
 }
//打开相册
-(void)openalumb{

    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        return;
    UIImagePickerController *pickcontro=[[UIImagePickerController alloc]init];
    pickcontro.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    pickcontro.delegate=self;
    [self presentViewController:pickcontro animated:YES completion:nil];
    
    
}

//监听图片已从相册中选去
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [self dismissViewControllerAnimated:YES completion:nil];
//将选取的图片保存
    UIImage *image=info[UIImagePickerControllerOriginalImage];
//    调用photoalumb中的方法，将照片存粗
        [self.photoalumb addimage:image];


}
@end
