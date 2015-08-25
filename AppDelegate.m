//
//  AppDelegate.m
//  ShareDemo
//
//  Created by 冯洪建 on 15/8/25.
//  Copyright (c) 2015年 冯洪建. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+UMShare.h"
#import "ShareVC.h"
@interface AppDelegate ()
@end
@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    [self.window makeKeyAndVisible];
    

    // 初始化友盟
    [self initUMeng];
    
    self.window.rootViewController = [[ShareVC alloc]initWithNibName:@"ShareVC" bundle:nil];
    self.window.backgroundColor = [UIColor whiteColor];
    return YES;
}


#pragma mark -  当应用程序入活动状态执行
- (void)applicationDidBecomeActive:(UIApplication *)application {
    //  友盟
    [self UMengapplicationDidBecomeActive];
}

#pragma mark - 支付宝
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    BOOL result = [self UMengActionWithUrl:url];
    return result;
}


#pragma mark - 说明：当通过url执行
-  (BOOL)application:(UIApplication*)application handleOpenURL:(NSURL*)url{
    
    // 友盟
    return [self UMenghandleOpenURL:url];
}


@end
