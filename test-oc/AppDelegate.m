//
//  AppDelegate.m
//  test-oc
//
//  Created by 陈培爵 on 2022/4/28.
//

#import "AppDelegate.h"
#import <OrderPlaceSdkPrd/OrderPlaceSdkPrd-Swift.h>
#import "test_oc-Swift.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    WechatPayService.application(application, universalLink: "https://club100app.cafedecoral.com/wechatPay/",  didFinishLaunchingWithOptions: launchOptions)
    NSString *universalLink = @"";
    [WechatPayService application:application universalLink:universalLink didFinishLaunchingWithOptions:launchOptions];
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    [OrderPlace application:app open:url];
    [WechatPayService applicationOpenUrl:app url:url];
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    [OrderPlace application:application open:url];
    [WechatPayService applicationOpenUrl:application url:url];
    return YES;
}
//func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping   ([UIUserActivityRestoring]?) -> Void) -> Bool {
//
//      WechatPayService.wechatApplication(application, continue: userActivity)
//
//      return true
//  }

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler {
    [WechatPayService wechatApplication:application continue:userActivity];
    return YES;
}
#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
