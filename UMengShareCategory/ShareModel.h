//
//  ShareModel.h
//  ShareDemo
//
//  Created by 冯洪建 on 15/8/25.
//  Copyright (c) 2015年 冯洪建. All rights reserved.
//

/*
***********************************************
***********************************************
*************                       ***********
*************根据自己的需要更换方法和内容***********
*************                       ***********
***********************************************
***********************************************
*/

#import <Foundation/Foundation.h>

#import "UMSocial.h"

typedef void(^SuccessUMBlock)(NSDictionary * requestDic);
typedef void(^failureUMBlock)(NSError *error);

@interface ShareModel : NSObject<UMSocialUIDelegate>


/*!
 *  @author fhj, 15-07-30 21:07:39
 *
 *  @brief  友盟默认分享页面
 *
 *  @param vc        控制器
 *  @param image     分享的图片
 *  @param detaileId 分享的 id
 *  @param title     分享的标题
 *  @param desc      分享的内容
 *  @param type      分享的类型（鸟网论坛：1  鸟网电商：2）
 */
+ (void)shareWithUMengWithVC:(UIViewController *)vc withImage:(UIImage *)image withID:(NSString *)detaileId  withTitle:(NSString *)title withDesc:(NSString *)desc withType:(NSInteger)type;

/*!
 *  @author fhj, 15-07-30 21:07:12
 *
 *  @brief  友盟自定义面分享昂
 *
 *  @param vc       控制器
 *  @param platform 分享的平台的  index
 *  @param title    分享的标题
 *  @param shareTxt 分享的文字
 *  @param image    分享的图片
 *  @param urlStr   分享的网址
 */
+ (void)shareUMengWithVC:(UIViewController *)vc withPlatform:(NSInteger )platform withTitle:(NSString *)title withShareTxt:(NSString *)shareTxt withImage:(UIImage *)image withUrl:(NSString *)urlStr;

/*!
 *  @author fhj, 15-07-31 15:07:24
 *
 *  @brief  第三方登陆  示例：  QQ登陆
 *
 *  @param vc      控制器
 *  @param success 授权登陆成功的回调
 *  @param failure 授权失败的回调
 */

+ (void)loginWitnUMengWithVC:(UIViewController *)vc success:(SuccessUMBlock)success failure:(failureUMBlock)failure;

/*!
 *  @author fhj, 15-07-31 16:07:48
 *
 *  @brief  取消授权 （替换平台内容）
 */
+ (void)deleteAuthSSO;
@end
