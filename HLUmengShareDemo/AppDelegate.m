//
//  AppDelegate.m
//  HLUmengShareDemo
//
//  Created by lizhaojie on 2017/7/19.
//  Copyright © 2017年 lizhaojie. All rights reserved.
//

#import "AppDelegate.h"
#import <UMengUShare/UMSocialWechatHandler.h>
#import <UMSocialQQHandler.h>

static NSString *UMeng_Key = @"596749f0ae1bf8066d0014ed";
static NSString *UMeng_webChatKey = @"wx1e21b8022791f47e";

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[UMSocialManager defaultManager] openLog:YES];
    [[UMSocialManager defaultManager] setUmSocialAppkey:UMeng_webChatKey];
    [self confitUShareSettings];
    // Override point for customization after application launch.
    return YES;
}
- (void)confitUShareSettings{
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:UMeng_webChatKey appSecret:@"3baf1193c85774b3fd9d18447d76cab0" redirectURL:@"http://www.umeng.com/social"];
    [[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];//remove 微信收藏
    
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatTimeLine appKey:UMeng_webChatKey appSecret:@"3baf1193c85774b3fd9d18447d76cab0" redirectURL:@"http://www.umeng.com/social"];
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:UMeng_webChatKey appSecret:@"3baf1193c85774b3fd9d18447d76cab0" redirectURL:@"http://www.umeng.com/social"];
  
    
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
