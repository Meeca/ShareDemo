//
//  ShareVC.m
//  ShareDemo
//
//  Created by 冯洪建 on 15/8/25.
//  Copyright (c) 2015年 冯洪建. All rights reserved.
//

#import "ShareVC.h"
#import "ShareModel.h"
#import <TencentOpenAPI/TencentOAuthObject.h>
#import "UMSocialQQHandler.h"

@interface ShareVC ()

@end

@implementation ShareVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


// 友盟默认样式分享
- (IBAction)defaultShare:(id)sender {
    [ShareModel shareWithUMengWithVC:self withImage:[UIImage imageNamed:@"1"] withID:@"1" withTitle:@"分享" withDesc:@"这是默认分享" withType:0];
}

// 第三方登陆
- (IBAction)loginAction:(id)sender {
    //  是不是安装了 QQ  客户端
    BOOL isQQ = [QQApiInterface isQQInstalled];
    if (isQQ) {
        
        
        [ShareModel loginWitnUMengWithVC:self success:^(NSDictionary *requestDic) {
            
            NSLog(@"登陆--- %@",requestDic);
        } failure:^(NSError *error) {
            
        }];
    
    }else{
        UIAlertView * al =[[UIAlertView alloc]initWithTitle:@"没有安装QQ客户端" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [al show];
    }

}
// 自定义样式的分享
- (IBAction)heheShareAction:(UISegmentedControl *)sender {
    NSInteger index = sender.selectedSegmentIndex;
    if(index == 0) return;
    [ShareModel shareUMengWithVC:self withPlatform:index withTitle:@"分享" withShareTxt:@"这是一个分享" withImage:[UIImage imageNamed:@"1"] withUrl:@"http://www.baidu.com"];
}
    





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
