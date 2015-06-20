//
//  FacebookHelper.m
//  CoffeeMe
//
//  Created by Mark Feaver on 20/06/15.
//  Copyright (c) 2015 Mark Feaver. All rights reserved.
//

#import "FacebookHelper.h"

static NSString *const baseURL = @"http://graph.facebook.com/";
static NSString *const picturesEndpoint = @"picture?type=large";

@implementation FacebookHelper

+ (nonnull NSURL *)profileImageURLForProfileId:(nonnull NSString *)profileId {
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@/%@", baseURL, profileId, picturesEndpoint]];
}

@end
