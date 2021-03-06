//
//  AppDelegate.h
//  CoffeeMe
//
//  Created by Mark Feaver on 13/06/15.
//  Copyright (c) 2015 Mark Feaver. All rights reserved.
//

@import UIKit;

@class APIClient;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (AppDelegate *)sharedDelegate;
+ (BOOL)isFBAuthenticated;
- (void)showLoginScreen;

@end

