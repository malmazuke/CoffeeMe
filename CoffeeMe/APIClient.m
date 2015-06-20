//
//  APIClient.m
//  CoffeeMe
//
//  Created by Mark Feaver on 20/06/15.
//  Copyright (c) 2015 Mark Feaver. All rights reserved.
//

#import "APIClient.h"

NSString *const FacebookGraphBaseURL = @"http://graph.facebook.com/";

@implementation APIClient

- (void)createUserWithUserDescriptor:(UserDescriptor *)userDescriptor success:(void (^)(User *user))success failure:(FailureBlock)failure
{
    // FIXME: Allow creation of users in API
}

@end
