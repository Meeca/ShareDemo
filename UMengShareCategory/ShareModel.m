//
//  ShareModel.m
//  ShareDemo
//
//  Created by 冯洪建 on 15/8/25.
//  Copyright (c) 2015年 冯洪建. All rights reserved.
//

#import "ShareModel.h"
#import "UIViewController+Umeng.h"
#import "UMSocialQQHandler.h"

// 友盟  key
#define UmengAppkey @"559f6bc667e58e7ef00038b5"



@implementation ShareModel



+ (void)shareWithUMengWithVC:(UIViewController *)vc withImage:(UIImage *)image withID:(NSString *)detaileId  withTitle:(NSString *)title withDesc:(NSString *)desc withType:(NSInteger)type{
    
    title = @"鸟网";
    
    NSString *shareTextUrl ;
    // 鸟网论坛
    if (type == 1) {
        shareTextUrl = [NSString stringWithFormat:@"http://www.XXXXX.cn/thread-%@-1-1.html",detaileId];//内嵌链接
    }else if (type == 2){
        //  鸟网电商
        shareTextUrl = [NSString stringWithFormat:@"%@api.php/Xy/buy?id=%@",@"",detaileId];//内嵌链接
    }
    
    // 配置各个平台的参数
    [UMSocialData defaultData].urlResource.url = shareTextUrl;
    [UMSocialData defaultData].extConfig.title =title;
    
    [UMSocialData defaultData].extConfig.wechatSessionData.title = title;
    [UMSocialData defaultData].extConfig.wechatSessionData.url = shareTextUrl;
    [UMSocialData defaultData].extConfig.wechatSessionData.shareText = shareTextUrl;

    
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = desc;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = shareTextUrl;
    [UMSocialData defaultData].extConfig.wechatSessionData.shareText = shareTextUrl;
    
    [UMSocialData defaultData].extConfig.sinaData.urlResource.url = shareTextUrl;
    [UMSocialData defaultData].extConfig.sinaData.shareText = shareTextUrl;

    [UMSocialData defaultData].extConfig.smsData.shareText = shareTextUrl;    //调用快速分享接口
    
    [UMSocialSnsService presentSnsIconSheetView:vc
                                         appKey:UmengAppkey
                                      shareText:desc
                                     shareImage:image
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToSms,nil]
                                       delegate:vc];
}

+ (void)shareUMengWithVC:(UIViewController *)vc withPlatform:(NSInteger)platform withTitle:(NSString *)title withShareTxt:(NSString *)shareTxt withImage:(UIImage *)image withUrl:(NSString *)urlStr {
    
    // 分享平台（根据index获取，分享界面 的index 要与 这个数组中的分享平台对应）
    NSArray * platformArray =@[UMShareToWechatTimeline,UMShareToWechatSession,UMShareToSms];

    NSString * url = [NSString stringWithFormat:@"%@/api.php/Share/index?id=%@",@"",@""];
    UIImage *img = [UIImage imageNamed:@"icon.png"];
    
    NSString *shareText = [NSString stringWithFormat:@"%@ %@",@"刚刚发现一个不错的app,快来下载试试吧!",url];//内嵌链接
    
    
    [UMSocialData defaultData].urlResource.url = url;
    [UMSocialData defaultData].extConfig.title = @"";

    // 微信朋友圈
    if (platform ==0) {
        [UMSocialData defaultData].extConfig.wechatTimelineData.title = url;
        [UMSocialData defaultData].extConfig.wechatTimelineData.url = url;
        [UMSocialData defaultData].extConfig.wechatTimelineData.shareText = url;
    }
    
    // 微信好友
    if (platform ==1) {
        [UMSocialData defaultData].extConfig.wechatSessionData.title = @"";
        [UMSocialData defaultData].extConfig.wechatSessionData.url = url;
        [UMSocialData defaultData].extConfig.wechatSessionData.shareText = url;
    }
    
    // 短信
    if (platform ==2) {
        [UMSocialData defaultData].extConfig.smsData.shareText = shareText;
    }

    [[UMSocialDataService defaultDataService] postSNSWithTypes:@[platformArray[platform]] content:shareText image:img location:nil urlResource:nil presentedController:vc completion:^(UMSocialResponseEntity* response) {
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            NSLog(@"share to sns name is %@  --  key",[[response.data allKeys] objectAtIndex:0]);

        }
    }];
    
}


+ (void)loginWitnUMengWithVC:(UIViewController *)vc
                     success:(SuccessUMBlock)success
                     failure:(failureUMBlock)failure{

    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    
    snsPlatform.loginClickHandler(vc,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response)
                                  {
                                      if (response.responseCode==UMSResponseCodeSuccess) {

                                          //          获取微博用户名、uid、token等
                                          // 先回调这里的内容，  去下面的回调内容会造成第一次登陆获取内容失败，所以应该取这里的内容
                                          
                                          success(response.data);

                                      }
                                      else{
                                          
                                          failure(response.error);

                                          NSLog(@"登录失败");
                                      }
                                  });
    
    //获取accestoken以及QQ用户信息，得到的数据在回调Block对象形参respone的data属性
    [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToQQ  completion:^(UMSocialResponseEntity *response){
        
        NSLog(@"SnsInformation十大神兽 is %@",response.data);
        
        /**  这里第一次会获取信息失败 */
        
//        if (response.responseCode==UMSResponseCodeSuccess) {
//            
//               success(response.data);
//        }
//        else{
//            //登录失败
//            failure(response.error);
//        }
    }];
}

+ (void)deleteAuthSSO{

//    删除授权调用下面的方法
    [[UMSocialDataService defaultDataService] requestUnOauthWithType:UMShareToSina  completion:^(UMSocialResponseEntity *response){
        NSLog(@"response is %@",response);
    }];
    
}


@end
