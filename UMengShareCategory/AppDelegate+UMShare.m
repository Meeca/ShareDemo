//
//  AppDelegate+UMShare.m
//  ShareDemo
//
//  Created by 冯洪建 on 15/8/25.
//  Copyright (c) 2015年 冯洪建. All rights reserved.
//


#import "AppDelegate+UMShare.h"


// 友盟头文件
#import "MobClick.h"
#import "UMSocial.h"
#import "UMSocialSinaHandler.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"



// 友盟  key
#define UmengAppkey @"559f6bc667e58e7ef00038b5"
//  微信 key
#define weiXinAppId @"wxfc6ff356d566a53c"
#define weiXinAppSecret @"14ee39469fabb11074a2285a4f30fe2a"

// QQ 互联 （QQ登陆）
#define __TencentDemoAppid_  @"310552924"
#define __TencentDemoConnectappkey @"VGyOc5jJPXIL84w0"



@implementation AppDelegate (UMShare)

- (void)initUMeng{

    //打开调试log的开关
//    [UMSocialData openLog:NO];
    
    
    // 开启友盟错误捕捉，默认开启（不想使用， ： NO）
    [MobClick setCrashReportEnabled:YES];
    
    //友盟统计,请替换Appkey
    [MobClick startWithAppkey:UmengAppkey reportPolicy:SEND_INTERVAL   channelId:nil];
    
    //友盟社会化组件（分享、第三方登录）
    [UMSocialData setAppKey:UmengAppkey];
    //设置微信AppId，url地址传nil，将默认使用友盟的网址，需要#import "UMSocialWechatHandler.h"
    [UMSocialWechatHandler setWXAppId:weiXinAppId appSecret:weiXinAppSecret url:@"http://www.XXXXX.cn/"];
    
    
    
#if TARGET_IPHONE_SIMULATOR
    
    // 是模拟器
    
#elif TARGET_OS_IPHONE
    
    
    
    //  是不是安装了 QQ  客户端
    BOOL isQQ = [QQApiInterface isQQInstalled];
    if (isQQ) {
        //    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"   VGyOc5jJPXIL84w0
        [UMSocialQQHandler setQQWithAppId:__TencentDemoAppid_ appKey:__TencentDemoConnectappkey url:@"http://www.umeng.com/social"];
    }
#endif
    
    
    //设置支持没有客户端情况下使用SSO授权
    [UMSocialQQHandler setSupportWebView:YES];

    
    
    
    
    
    
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。
    [UMSocialSinaHandler openSSOWithRedirectURL:@"http://www.bird.com/sina2/callback"];
    
    
    
    //由于苹果审核政策需求，建议大家对未安装客户端平台进行隐藏，在设置QQ、微信AppID之后调用下面的方法，
    [UMSocialConfig showNotInstallPlatforms:@[UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline]];
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline]];

    
    // version标识
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    
}


/**
 这里处理新浪微博SSO授权进入新浪微博客户端后进入后台，再返回原来应用

- (void)applicationDidBecomeActive:(UIApplication *)application
  */

- (void)UMengapplicationDidBecomeActive{
    [UMSocialSnsService  applicationDidBecomeActive];

}

/**
 
 - (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{

 */
- (BOOL)UMenghandleOpenURL:(NSURL *)url{

    //  先注释掉友盟  的  测试 QQ 登陆
    //    return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
    return [TencentOAuth HandleOpenURL:url];
    
}

/**
 这里处理新浪微博SSO授权之后跳转回来，和微信分享完成之后跳转回来
 */
- (BOOL)UMengActionWithUrl:(NSURL *)url{

    return [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];

}



@end
