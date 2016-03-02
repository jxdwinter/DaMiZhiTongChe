//
//  AppDelegate.m
//  DaMiZhiTongChe
//
//  Created by Xiaodong Jiang on 2/22/16.
//  Copyright © 2016 哈尔滨龙卫中新工贸有限责任公司. All rights reserved.
//

#import "AppDelegate.h"

#import <AFNetworking.h>
#import <GBVersionTracking.h>
#import <YTKNetworkConfig.h>

#import <KSCrash/KSCrashInstallationStandard.h>
#import "MTA.h"
#import "MTAConfig.h"

#import "BaseNavigationController.h"
#import "LoginViewController.h"

#import "MainViewController.h"
#import "CartViewController.h"
#import "MineViewController.h"

#import "Login_updateAnonymousTokenApi.h"

@interface AppDelegate () <UITabBarControllerDelegate>

@property (nonatomic, strong) BaseNavigationController* mainNavController;
@property (nonatomic, strong) BaseNavigationController* cartNavController;
@property (nonatomic, strong) BaseNavigationController* mineNavController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self config];
    [self configUI];
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
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken{
    NSString *pushToken = [[[[deviceToken description]
                             stringByReplacingOccurrencesOfString:@"<" withString:@""]
                            stringByReplacingOccurrencesOfString:@">" withString:@""]
                           stringByReplacingOccurrencesOfString:@" " withString:@""] ;
    NSLog(@"stringToken:%@",pushToken);
    if (pushToken && pushToken.length) {
        
    }else{
        pushToken = @"0";
    }
    [AccountHelper saveAccountTokenWithToken:pushToken];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self updateAnonymousToken];
    });
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Registfail%@",error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    // 处理推送消息
    NSLog(@"userinfo:%@",userInfo);
}

- (void)updateAnonymousToken {
    Login_updateAnonymousTokenApi *api = [[Login_updateAnonymousTokenApi alloc] init];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSDictionary *dic = [api responseDictionaryWithResponseString:request.responseString];
        if (dic) {
            if ([dic[@"result"] isEqualToString:@"0"]) {
                
            }else{
                
            }
        }
    } failure:^(YTKBaseRequest *request) {
        
    }];
}

#pragma mark - APP Config
#pragma mark -

- (void) config{
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    //跟踪版本
    [GBVersionTracking track];
    
    //注册网络改变通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkreachabilitystatuschanged:) name:@"NETWORKREACHABILITYSTATUSCHANGED" object:nil];
    
    //监控网络
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NETWORKREACHABILITYSTATUSCHANGED" object:[NSNumber numberWithInteger:status]];
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 开始推送通知
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0){
#ifdef __IPHONE_8_0
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings
                                                                             settingsForTypes:(UIUserNotificationTypeSound |
                                                                                               UIUserNotificationTypeAlert |
                                                                                               UIUserNotificationTypeBadge)
                                                                             categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
#endif
    }else{
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    }
    
    /*!
     *  设置图片缓存默认大小200M,图片缓存时间为7天
     */
    SDImageCache *imageCache = [SDImageCache sharedImageCache];
    [imageCache setMaxCacheSize:1024*1024*200];
    
    if (!ISSIMULATOR) {
        [MTA startWithAppkey:MTAAPPKEY];
        KSCrashInstallationStandard* installation = [KSCrashInstallationStandard sharedInstance];
        installation.url = [NSURL URLWithString:[NSString stringWithFormat:@"https://collector.bughd.com/kscrash?key=%@",BUGHDGENERALKEY]];
        [installation install];
        [installation sendAllReportsWithCompletion:nil];
    }
    
    /**
     *  初始化数据库
     */
    SharedDatabaseHelper *sharedDatabaseHelper = [SharedDatabaseHelper sharedDatabaseHelper];
    NSLog(@"%@",[sharedDatabaseHelper description]);
    
    YTKNetworkConfig *config = [YTKNetworkConfig sharedInstance];
    config.baseUrl = BASEURL;
    
}


#pragma mark - UI Config
#pragma mark -

- (void)configUI{
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [[UINavigationBar appearance] setTintColor:DEFAULTBROWNCOLOR];
    [[UINavigationBar appearance] setBarTintColor:DEFAULTCOLOR];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : DEFAULTBROWNCOLOR,
                                                           NSFontAttributeName : DEFAULNAVIGATIONBARFONT}];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : DEFAULTBROWNCOLOR } forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : DEFAULTGRAYCOLOR } forState:UIControlStateNormal];
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.delegate = self;
    self.tabBarController.tabBar.translucent = NO;
    
    self.mainNavController = [[BaseNavigationController alloc] initWithRootViewController:[[MainViewController alloc] init]];
    self.cartNavController = [[BaseNavigationController alloc] initWithRootViewController:[[CartViewController alloc] init]];
    self.mineNavController = [[BaseNavigationController alloc] initWithRootViewController:[[MineViewController alloc] init]];
    NSArray* controllers = @[self.mainNavController,self.cartNavController,self.mineNavController];
    self.tabBarController.viewControllers = controllers;
    
    UITabBar *tabBar = self.tabBarController.tabBar;
    UITabBarItem *tabBarItem0 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:2];
    
    tabBarItem0.title = @"首页";
    tabBarItem0.titlePositionAdjustment = UIOffsetMake(0.0, -2.0);
    tabBarItem0.image = [[UIImage imageNamed:@"tabbar_main_unselect"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem0.selectedImage = [[UIImage imageNamed:@"tabbar_main_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    
    tabBarItem1.title = @"购物车";
    tabBarItem1.titlePositionAdjustment = UIOffsetMake(0.0, -2.0);
    tabBarItem1.image = [[UIImage imageNamed:@"tabbar_cart_unselect"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem1.selectedImage = [[UIImage imageNamed:@"tabbar_cart_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    
    tabBarItem2.title = @"我的";
    tabBarItem2.titlePositionAdjustment = UIOffsetMake(0.0, -2.0);
    tabBarItem2.image = [[UIImage imageNamed:@"tabbar_mine_unselect"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem2.selectedImage = [[UIImage imageNamed:@"tabbar_mine_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    
    self.tabBarController.selectedIndex = 0;
    [self launchRootViewController];
    [self.window makeKeyAndVisible];
}

/**
 *  第一次启动客户端或者是某一个版本的第一次启动
 */
- (void)launchRootViewController{
    self.window.rootViewController = self.tabBarController;
    /*
    if ([GBVersionTracking isFirstLaunchEver] || [GBVersionTracking isFirstLaunchForVersion]) {
        //self.window.rootViewController = [[IntroViewController alloc] init];
    }else{
        self.window.rootViewController = self.tabBarController;
    }
     */
}

//网络情况改变通知
- (void)networkreachabilitystatuschanged:(NSNotification*)aNotification{
    AFNetworkReachabilityStatus status = [(NSNumber *)aNotification.object integerValue];
    NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
    switch (status) {
        case AFNetworkReachabilityStatusReachableViaWWAN:
            
            break;
        case AFNetworkReachabilityStatusReachableViaWiFi:
            
            break;
        case AFNetworkReachabilityStatusNotReachable:
            
            break;
        default:
            
            break;
    }
}

#pragma mark - UITabBarControllerDelegate
#pragma mark -

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if (viewController == self.mainNavController) {
        return YES;
    }else if (viewController == self.cartNavController) {
        if (![[AccountManager sharedAccountManager] getCurrentUser]) {
            [self presentLoginViewController];
            return NO;
        }else{
            return YES;
        }
    }else if (viewController == self.mineNavController) {
        if (![[AccountManager sharedAccountManager] getCurrentUser]) {
            [self presentLoginViewController];
            return NO;
        }else{
            return YES;
        }
    }
    return NO;
}

/*
 * 弹出登录页面
 */
- (void) presentLoginViewController {
    [self.mainNavController presentViewController:[[BaseNavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]] animated:YES completion:^{
    
    }];
}

@end
