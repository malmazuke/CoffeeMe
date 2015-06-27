//
//  AppDelegate.m
//  CoffeeMe
//
//  Created by Mark Feaver on 13/06/15.
//  Copyright (c) 2015 Mark Feaver. All rights reserved.
//

#import <FBSDKCoreKit/FBSDKCoreKit.h>

#import "APIClient.h"
#import "AppDelegate.h"
#import "DashboardViewController.h"
#import "LoginViewController.h"
#import "UIViewController+DependencyInjection.h"

@interface AppDelegate ()

@property (strong, nonatomic) APIClient *APIclient;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // This needs to happen first, so that we get a currentAccessToken
    [self mgf_setupFacebook];
    BOOL fbDidFinish = [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    self.APIclient = [APIClient new];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    [self mgf_initializeMainStoryboard];
    if (![AppDelegate isFBAuthenticated]) {
        [self showLoginScreen];
    }

    [self.window makeKeyAndVisible];
    return fbDidFinish;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBSDKAppEvents activateApp];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}

+ (AppDelegate *)sharedDelegate {
    return [[UIApplication sharedApplication] delegate];
}

+ (BOOL)isFBAuthenticated {
    return [FBSDKAccessToken currentAccessToken];
}

- (void)showLoginScreen {
    dispatch_async(dispatch_get_main_queue(), ^{
        LoginViewController *loginVC = [LoginViewController new];
        assert(self.window.rootViewController.mgf_APIClient);
        [loginVC mgf_copyStateFrom:self.window.rootViewController];
        
        [self.window.rootViewController presentViewController:loginVC animated:YES completion:nil];
    });
}

- (void)mgf_initializeMainStoryboard {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    assert(storyboard);
    
    UINavigationController *navController = [storyboard instantiateInitialViewController];
    assert(navController && [navController isKindOfClass:[UINavigationController class]]);
    // FIXME: Can't use mgf_copyStateFrom: here, because obviously AppDelegate isn't a ViewController
    [navController setMgf_APIClient:self.APIclient];
    
    UIViewController *initVC = navController.topViewController;
    assert(initVC && [initVC isKindOfClass:[DashboardViewController class]]);
    [initVC mgf_copyStateFrom:navController];
    
    self.window.rootViewController = navController;
}

- (void)mgf_setupFacebook {
    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
}

@end
