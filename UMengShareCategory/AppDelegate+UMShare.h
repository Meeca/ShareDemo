//
//  AppDelegate+UMShare.h
//  ShareDemo
//
//  Created by 冯洪建 on 15/8/25.
//  Copyright (c) 2015年 冯洪建. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (UMShare)


/*!
 *  @author fhj, 15-07-31 10:07:50
 *
 *  @brief  初始化友盟
 */
- (void)initUMeng;



/**
 这里处理新浪微博SSO授权进入新浪微博客户端后进入后台，再返回原来应用
 
 - (void)applicationDidBecomeActive:(UIApplication *)application
 */

- (void)UMengapplicationDidBecomeActive;


/**
 
 - (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
 
 */
- (BOOL)UMenghandleOpenURL:(NSURL *)url;


/*!
 *  @author fhj, 15-07-31 10:07:59
 *
 *  @brief  友盟授权回调
 *
    这里处理新浪微博SSO授权之后跳转回来，和微信分享完成之后跳转回来
 - (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation

 */

- (BOOL)UMengActionWithUrl:(NSURL *)url;

@end
