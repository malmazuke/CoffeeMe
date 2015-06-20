//
//  DashboardViewController.m
//  CoffeeMe
//
//  Created by Mark Feaver on 15/06/15.
//  Copyright (c) 2015 Mark Feaver. All rights reserved.
//

#import <AFNetworking/UIImageView+AFNetworking.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

#import "DashboardViewController.h"
#import "FacebookHelper.h"

@interface DashboardViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;
@property (strong, nonatomic) IBOutlet UILabel *welcomeLabel;

@end

@implementation DashboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mgf_fbProfileDidChange:)     name:FBSDKProfileDidChangeNotification     object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mgf_fbAccessTokenDidChange:) name:FBSDKAccessTokenDidChangeNotification object:nil];
    
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
        [self.profileImageView setImageWithURL:[FacebookHelper profileImageURLForProfileId:fbProfile.userID] placeholderImage:[UIImage imageNamed:@"default_profile"]];
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
