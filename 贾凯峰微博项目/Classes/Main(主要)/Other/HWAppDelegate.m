//
//  HWAppDelegate.m
//  贾凯峰微博项目
//
//  Created by apple on 14-10-7.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HWAppDelegate.h"
#import "HWTabBarViewController.h"
#import "HWNewfeatureViewController.h"
#import "HWAutorViewController.h"
#import "HWAccount.h"
#import "HWTool.h"

@implementation HWAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // 1.创建窗口
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
      //从沙盒中取出数据
    HWAccount *account=[HWTool account];
        
    if (account) {
            //沙盒中储存的版本
           NSString *lastVersion= [[NSUserDefaults standardUserDefaults]objectForKey:@"CFBundleVersion"];
            //当前版本
            NSString *CurrentVersion=[NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
           //储存进沙盒
        
            if ([CurrentVersion isEqualToString:lastVersion]) {
                self.window.rootViewController=[[HWTabBarViewController alloc]init];
            }else {
        
                self.window.rootViewController = [[HWNewfeatureViewController alloc] init];
                [[NSUserDefaults standardUserDefaults]setObject:CurrentVersion forKey:@"CFBundleVersion"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
        
    }else{
        self.window.rootViewController=[[HWAutorViewController alloc]init];
    
    
    }
    
    // 4.显示窗口
    [self.window makeKeyAndVisible];

    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
@end
