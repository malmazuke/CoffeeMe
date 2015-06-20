//
//  APIClient.h
//  CoffeeMe
//
//  Created by Mark Feaver on 20/06/15.
//  Copyright (c) 2015 Mark Feaver. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;
@class UserDescriptor;

typedef void (^FailureBlock)(NSError *error);

extern NSString *const FacebookGraphBaseURL;

@interface APIClient : NSObject

- (void)createUserWithUserDescriptor:(UserDescriptor *)userDescriptor success:(void (^)(User *user))success failure:(FailureBlock)failure;

@end
