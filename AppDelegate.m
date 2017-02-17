//
//  AppDelegate.m
//  Interesting
//
//  Created by kangzhiqiang on 16/10/9.
//  Copyright (c) 2016年 KZQ. All rights reserved.
//

#import "AppDelegate.h"

#import "TAdLaunchImageView.h"
#import "ViewController.h"
#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import <JSPatchPlatform/JSPatch.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSLog(@"---编号%@",NSHomeDirectory());
    
    [self netWorkStatus];
    
//    [JSPatch testScriptInBundle];
    [JSPatch startWithAppKey:@"2709b95c35296999"];
    [JSPatch sync];
    
    //友盟
    [UMSocialData setAppKey:@"57b432afe0f55a9832001a0a"];
    [UMSocialQQHandler setQQWithAppId:@"1105842438" appKey:@"rWOkbugwfJCh4Erx" url:@"http://weibo.com/u/3825233441"];
    [UMSocialWechatHandler setWXAppId:@"wx9042851e4b4a2858" appSecret:@"a04376739b98b68245d121005dff8307" url:@"http://weibo.com/u/3825233441"];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    ViewController *baseVC = [[ViewController alloc] init];
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:baseVC];

    self.window.rootViewController = nav;
    
    [self.window makeKeyAndVisible];
  
    return YES;
}

- (void)pushAdViewCntroller
{
    // 获取到navVC
    UITabBarController *tabbBarVC = (UITabBarController *)self.window.rootViewController;
    UINavigationController *navVC = tabbBarVC.viewControllers.firstObject;
    
    // 你要推出的VC
    UIViewController *VC = [[UIViewController alloc]init];
    VC.view.backgroundColor = [UIColor redColor];
    [navVC pushViewController:VC animated:YES];
}
- (void)netWorkStatus
{
    /**
     AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G
     AFNetworkReachabilityStatusReachableViaWiFi = 2,   // WiFi
     */
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        [GlobalClass sharedInstance].netStatus=status;
        
        NSLog(@"==============%ld",(long)status);
        
        if (status==0) {
//            SHOW_ALERT(@"网断了吧！！！");
        }else{
    
        }
    }];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
