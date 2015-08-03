//
//  HWwhritViewController.m
//  贾凯峰微博项目
//
//  Created by jiakaifeng on 15/8/3.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import "HWwhritViewController.h"

@interface HWwhritViewController ()

@end

@implementation HWwhritViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(cancelweibo)];
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(sendweibo)];
    self.navigationItem.rightBarButtonItem.enabled=NO;
    self.navigationItem.title=@"发微博";
    UITextView *text=[[UITextView alloc]init];
    text.frame=CGRectMake(0, 0, 300, 500);
    [self.view addSubview:text];
    
    
}
-(void)cancelweibo{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}
-(void)sendweibo{
    [self dismissViewControllerAnimated:YES completion:nil];

}


@end
