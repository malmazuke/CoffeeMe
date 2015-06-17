//
//  DashboardViewController.m
//  CoffeeMe
//
//  Created by Mark Feaver on 15/06/15.
//  Copyright (c) 2015 Mark Feaver. All rights reserved.
//

#import <FBSDKCoreKit/FBSDKCoreKit.h>

#import "DashboardViewController.h"

@interface DashboardViewController ()

@property (strong, nonatomic) IBOutlet FBSDKProfilePictureView *profileImageView;
@property (strong, nonatomic) IBOutlet UILabel *welcomeLabel;

@end

@implementation DashboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mgf_fbProfileDidChange:)     name:FBSDKProfileDidChangeNotification     object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mgf_fbAccessTokenDidChange:) name:FBSDKAccessTokenDidChangeNotification object:nil];
    
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
        self.welcomeLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Welcome, %@", @"The dashboard welcome text for a specific user"), fbProfile.name];
    } else {
        self.welcomeLabel.text = NSLocalizedString(@"Welcome!", @"The default dashboard welcome text");
    }
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
