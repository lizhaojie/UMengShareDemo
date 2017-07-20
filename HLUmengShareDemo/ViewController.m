//
//  ViewController.m
//  HLUmengShareDemo
//
//  Created by lizhaojie on 2017/7/19.
//  Copyright © 2017年 lizhaojie. All rights reserved.
//

#import "ViewController.h"
#import <UShareUI/UShareUI.h>
#import <UMSocialQQHandler.h>
#import <UMSocialWechatHandler.h>
#import "HLShareBoard.h"
@interface ViewController ()<UMSocialShareMenuViewDelegate>
{
    NSMutableArray *titlearray;
    NSMutableArray *imageArray;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame = CGRectMake(100, 200, 80, 40);
    shareBtn.backgroundColor = [UIColor greenColor];
    [shareBtn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareBtn];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)share:(id)sender{
    [self initBoardData];
    HLShareBoard *shareBoard = [[HLShareBoard alloc] initWithTitle:@"分享面板" subTitles:titlearray images:imageArray];
    shareBoard.boardStyle = defaultBoardStyleType;
    [shareBoard setBtnClick:^(NSString *platform) {
        
        if ([platform isEqualToString:@"微信"]) {//微信
            [self shareWithPlatform:UMSocialPlatformType_WechatSession];
            
        }else if ([platform isEqualToString:@"朋友圈"]){//朋友圈
            [self shareWithPlatform:UMSocialPlatformType_WechatTimeLine];

        }else if ([platform isEqualToString:@"QQ"]){//qq
            [self shareWithPlatform:UMSocialPlatformType_QQ];

        }else if ([platform isEqualToString:@"QQ空间"]){
            [self shareWithPlatform:UMSocialPlatformType_Qzone];

        }else{
            //将内容复制到剪贴板
            UIPasteboard *pastboad = [UIPasteboard generalPasteboard];
            pastboad.string = @"需要复制的网址 如：http://blog.csdn.net/chen_gp_x";
        }
    
        
    }];
    [[UIApplication sharedApplication].keyWindow addSubview:shareBoard];
}
- (void)shareWithPlatform:(UMSocialPlatformType)platformType{
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    messageObject.text = @"分享";
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    shareObject.thumbImage = [UIImage imageNamed:@""];
    [shareObject setShareImage:[UIImage imageNamed:@"icon"]];
    messageObject.shareObject = shareObject;
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"error == %@",error);
        }else{
            NSLog(@"success");
            
        }
    }];
}
- (void)initBoardData{
    titlearray = [NSMutableArray new];
    imageArray = [NSMutableArray new];
    if ([[UMSocialWechatHandler defaultManager] umSocial_isInstall]) {
        [titlearray addObject:@"微信"];
        [titlearray addObject:@"朋友圈"];
        [imageArray addObject:@"wechat"];
        [imageArray addObject:@"wechatquan"];
    }
    if ([[UMSocialQQHandler defaultManager] umSocial_isInstall]) {
        [titlearray addObject:@"QQ"];
        [titlearray addObject:@"QQ空间"];
        [imageArray addObject:@"tcentQQ"];
        [imageArray addObject:@"tcentkongjian"];
        
    }
    [titlearray addObject:@"复制链接"];
    [imageArray addObject:@"copyUrl"];
    [titlearray addObject:@"复制链接"];
    [imageArray addObject:@"copyUrl"];
}
#pragma - mark UMSocialShareMenuViewDelegate
- (void)UMSocialShareMenuViewDidAppear{
    
}
- (void)UMSocialShareMenuViewDidDisappear{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
