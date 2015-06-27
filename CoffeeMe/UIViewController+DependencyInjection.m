//
//  UIViewController+DependencyInjection.m
//  CoffeeMe
//
//  Created by Mark Feaver on 27/06/15.
//  Copyright (c) 2015 Mark Feaver. All rights reserved.
//

@import ObjectiveC.runtime;

#import "UIViewController+DependencyInjection.h"

@implementation UIViewController (DependencyInjection)
@dynamic mgf_APIClient;

- (void)setMgf_APIClient:(APIClient *)mgf_APIClient {
    objc_setAssociatedObject(self, @selector(mgf_APIClient), mgf_APIClient, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (APIClient *)mgf_APIClient {
    return objc_getAssociatedObject(self, @selector(mgf_APIClient));
}

- (void)mgf_copyStateFrom:(UIViewController *)fromVC {
    self.mgf_APIClient = fromVC.mgf_APIClient;
}

@end
