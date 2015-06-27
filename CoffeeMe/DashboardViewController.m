//
//  DashboardViewController.m
//  CoffeeMe
//
//  Created by Mark Feaver on 15/06/15.
//  Copyright (c) 2015 Mark Feaver. All rights reserved.
//

#import <AFNetworking/UIImageView+AFNetworking.h>
#import <BlocksKit/UIAlertView+BlocksKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <SVProgressHUD/SVProgressHUD.h>

#import "APIClient.h"
#import "AppDelegate.h"
#import "DashboardViewController.h"
#import "UIViewController+DependencyInjection.h"
#import "User.h"

@interface DashboardViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;
@property (strong, nonatomic) IBOutlet UILabel *welcomeLabel;

@end

@implementation DashboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mgf_fbProfileDidChange:)     name:FBSDKProfileDidChangeNotification     object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mgf_fbAccessTokenDidChange:) name:FBSDKAccessTokenDidChangeNotification object:nil];
    
    // TODO: Wrap this up in somethin' nice
    CALayer *profileImageLayer = self.profileImageView.layer;
    [profileImageLayer setCornerRadius:profileImageLayer.bounds.size.height/2.0];
    [profileImageLayer setMasksToBounds:YES];
    
    [self mgf_refreshDashboard];
}

- (void)mgf_fbProfileDidChange:(NSNotification *)notification {
    [self mgf_refreshDashboard];
}

- (void)mgf_fbAccessTokenDidChange:(NSNotification *)notification {
    [self mgf_fbProfileDidChange:nil];
}

- (void)mgf_refreshDashboard {
    FBSDKProfile *fbProfile = [FBSDKProfile currentProfile];
    
    if (fbProfile) {
        assert(fbProfile.name);
        assert(fbProfile.userID);
        self.welcomeLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Welcome, %@", @"The dashboard welcome text for a specific user"), fbProfile.name];
        
        // TODO: Use FBSDKGraphRequest instead, and cache result
        NSString *imagePath = [fbProfile imagePathForPictureMode:FBSDKProfilePictureModeSquare size:self.profileImageView.bounds.size];
        assert(imagePath.length);
        NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", FacebookGraphBaseURL, imagePath]];
        [self.profileImageView setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"default_profile"]];
    } else {
        self.welcomeLabel.text = NSLocalizedString(@"Welcome!", @"The default dashboard welcome text");
    }
}

- (IBAction)mgf_testUserFetch:(id)sender {
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    assert(self.mgf_APIClient);
    [self.mgf_APIClient userWithId:@"10153532525146412" success:^(User *user) {
        [SVProgressHUD dismiss];
        NSLog(@"Yay, successfully fetched user: %@", user.name);
        [UIAlertView bk_showAlertViewWithTitle:@"User details" message:[NSString stringWithFormat:@"ID:%@\nName: %@", user.userId, user.name] cancelButtonTitle:@"Ok" otherButtonTitles:nil handler:nil];
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        NSLog(@"Error: %@", error);
    }];
}

@end
