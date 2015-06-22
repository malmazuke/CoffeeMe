//
//  APIClient.m
//  CoffeeMe
//
//  Created by Mark Feaver on 20/06/15.
//  Copyright (c) 2015 Mark Feaver. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import <Mantle/Mantle.h>

#import "APIClient.h"
#import "User.h"
#import "UserDescriptor.h"

static NSString *const BaseURL = @"http://private-110fb-coffeeme.apiary-mock.com/";
static NSString *const UsersEndpoint = @"users/";
static NSString *const ImagesEndpoint = @"images/";

NSString *const FacebookGraphBaseURL = @"http://graph.facebook.com/";

@implementation APIClient

- (void)createUserWithUserDescriptor:(UserDescriptor *)userDescriptor success:(void (^)(User *user))success failure:(FailureBlock)failure {
    assert(userDescriptor);
    // FIXME: Not all of these will actually be required
    assert(userDescriptor.name);
    assert(userDescriptor.firstName);
    assert(userDescriptor.lastName);
    assert(userDescriptor.gender);
    assert(userDescriptor.updatedTime);
    
    // FIXME: Fix this endpoint in Apiary
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@", BaseURL, UsersEndpoint, @"1"];
    NSDictionary *params = @{@"name": userDescriptor.name,
                       @"first_name": userDescriptor.firstName,
                        @"last_name": userDescriptor.lastName,
                           @"gender": userDescriptor.gender,
                     @"updated_time": userDescriptor.updatedTime};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager POST:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error;
        User *user = [MTLJSONAdapter modelOfClass:[User class] fromJSONDictionary:responseObject error:&error];
        if (!error) success(user);
        else        failure(error);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

- (void)userWithId:(NSString *)userId success:(void (^)(User *user))success failure:(FailureBlock)failure {
    assert(userId.length);
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@", BaseURL, UsersEndpoint, userId];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error;
        User *user = [MTLJSONAdapter modelOfClass:[User class] fromJSONDictionary:responseObject error:&error];
        if (!error) success(user);
        else        failure(error);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

@end
