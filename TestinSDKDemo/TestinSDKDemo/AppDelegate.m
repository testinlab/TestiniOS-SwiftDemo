//
//  AppDelegate.m
//  TestinSDKDemo
//
//  Created by maximli on 15/6/11.
//  Copyright (c) 2015年 Testin. All rights reserved.
//

#import "AppDelegate.h"
//导入SDK头文件
#import "TestinAgent/TestinAgent.h"

@interface AppDelegate () <TestinDelegate>

@end

@implementation AppDelegate

- (void)testinAgentReceivedCrashNotification
{
    NSLog(@"Application crash.");
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //使用默认设置
    
//    [TestinAgent init:@"your appkey" channel:@"channel ID" config:[TestinConfig defaultConfig]];
    //构建配置对象
    TestinConfig* config = [TestinConfig defaultConfig];
    config.printLogForDebug = YES;
    
    //初始化接口，appkey从网站新建应用获得，渠道号自行定义
    [TestinAgent init:@"your appkey" channel:@"channel ID" config:config];
    
    return YES;
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
    [TestinAgent terminate];
}

@end
