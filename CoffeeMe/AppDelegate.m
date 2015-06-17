//
//  AppDelegate.m
//  CoffeeMe
//
//  Created by Mark Feaver on 13/06/15.
//  Copyright (c) 2015 Mark Feaver. All rights reserved.
//

#import <FBSDKCoreKit/FBSDKCoreKit.h>

#import "AppDelegate.h"
#import "LoginViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // This needs to happen first, so we get a currentAccessToken
    [self mgf_setupFacebook];
    BOOL fbDidFinish = [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
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
        [self.window.rootViewController presentViewController:loginVC animated:YES completion:nil];
    });
}

- (void)mgf_initializeMainStoryboard {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    assert(storyboard);
    
    UIViewController *initVC = [storyboard instantiateInitialViewController];
    assert(initVC);
    
    self.window.rootViewController = initVC;
}

- (void)mgf_setupFacebook {
    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
}

@end
