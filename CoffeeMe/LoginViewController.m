//
//  LoginViewController.m
//  CoffeeMe
//
//  Created by Mark Feaver on 13/06/15.
//  Copyright (c) 2015 Mark Feaver. All rights reserved.
//

#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <SVProgressHUD/SVProgressHUD.h>

#import "APIClient.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "User.h"
#import "UserDescriptor.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (IBAction)tappedLogin:(UIButton *)sender {
    [self mgf_loginWithFacebook];
}

- (void)mgf_loginWithFacebook {
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    FBSDKLoginManager *login = [FBSDKLoginManager new];
    [login logInWithReadPermissions:@[@"public_profile", @"email"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        [SVProgressHUD dismiss];
        if (error) {
            // TODO: Process error
            NSLog(@"Error logging into Facebook: %@", error);
        } else if (result.isCancelled) {
            // TODO: Handle cancellations
            NSLog(@"Facebook log in cancelled");
        } else {
            if ([result.grantedPermissions containsObject:@"email"]) {
                NSLog(@"Did log in with permissions: %@", result.grantedPermissions);
            }
            // TODO: Notify AWS Cognito of log in/creds
            [SVProgressHUD showWithStatus:@"Creating user..." maskType:SVProgressHUDMaskTypeBlack];
            [self mgf_createUserWithSuccess:^(User *user) {
                [SVProgressHUD dismiss];
                [self dismissViewControllerAnimated:YES completion:nil];
            } failure:^(NSError *error) {
                [SVProgressHUD dismiss];
                NSLog(@"Failed to create user with error: %@", error);
            }];
        }
    }];
}

- (void)mgf_createUserWithSuccess:(void (^)(User *user))success failure:(void (^)(NSError *error))failure {
    // TODO: This should probably be moved to a seperate class
    UserDescriptor *descriptor = [UserDescriptor new];
    // TODO: Let's just hardcode some stuff for now, shall we? 😉
    descriptor.name = @"Mark Feaver";
    descriptor.firstName = @"Mark";
    descriptor.lastName = @"Feaver";
    descriptor.gender = @"male";
    descriptor.updatedTime = @"2014-11-11T08:40:51.620Z";
    
    [[AppDelegate sharedDelegate].client createUserWithUserDescriptor:descriptor success:success failure:failure];
}

@end
