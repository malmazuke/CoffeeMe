//
//  LoginViewController.m
//  CoffeeMe
//
//  Created by Mark Feaver on 13/06/15.
//  Copyright (c) 2015 Mark Feaver. All rights reserved.
//

#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <SVProgressHUD/SVProgressHUD.h>

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tappedLogin:(UIButton *)sender {
    [self mgf_loginWithFacebook];
}

- (void)mgf_loginWithFacebook {
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    FBSDKLoginManager *login = [FBSDKLoginManager new];
    [login logInWithReadPermissions:@[@"email"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
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
            // TODO: Proceed to dashboard
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
