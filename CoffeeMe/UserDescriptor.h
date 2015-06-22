//
//  UserDescriptor.h
//  CoffeeMe
//
//  Created by Mark Feaver on 20/06/15.
//  Copyright (c) 2015 Mark Feaver. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDescriptor : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic)         NSString *gender;
// FIXME: Let's make this an NSDate
@property (nonatomic, strong) NSString *updatedTime;

@end
