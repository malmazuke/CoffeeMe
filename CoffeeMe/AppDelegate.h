//
//  AppDelegate.h
//  CoffeeMe
//
//  Created by Mark Feaver on 13/06/15.
//  Copyright (c) 2015 Mark Feaver. All rights reserved.
//

#import <UIKit/UIKit.h>

@class APIClient;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

// FIXME: Not ideal, but it'll do for now
@property (strong, nonatomic) APIClient *client;
@property (strong, nonatomic) UIWindow *window;

+ (AppDelegate *)sharedDelegate;
+ (BOOL)isFBAuthenticated;
- (void)showLoginScreen;

@end

