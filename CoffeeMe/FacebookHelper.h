//
//  FacebookHelper.h
//  CoffeeMe
//
//  Created by Mark Feaver on 20/06/15.
//  Copyright (c) 2015 Mark Feaver. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FacebookHelper : NSObject

+ (nonnull NSURL *)profileImageURLForProfileId:(nonnull NSString *)profileId;

@end
