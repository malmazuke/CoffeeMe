//
//  UIViewController+DependencyInjection.h
//  CoffeeMe
//
//  Created by Mark Feaver on 27/06/15.
//  Copyright (c) 2015 Mark Feaver. All rights reserved.
//

@import UIKit;

@class APIClient;

/*
 * Based on code written by OneSadCookie - https://github.com/onesadcookie
 * 
 * An alternative way to provide setter injection to avoid global state of the API Client.
 * Eventually could be expanded to provide a bitfield which specifies only the properties that
 * the receiving VC is interested in, instead of requiring the entire API Client.
 */
@interface UIViewController (DependencyInjection)

@property (strong, nonatomic) APIClient* mgf_APIClient;

- (void)mgf_copyStateFrom:(UIViewController *)fromVC;

@end
