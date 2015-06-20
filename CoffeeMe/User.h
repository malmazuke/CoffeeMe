//
//  User.h
//  CoffeeMe
//
//  Created by Mark Feaver on 20/06/15.
//  Copyright (c) 2015 Mark Feaver. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

typedef NS_ENUM(NSUInteger, UserGender) {
    UserGenderUnspecified,
    UserGenderFemale,
    UserGenderMale,
};

@interface User : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong, readonly) NSString  *userId;
@property (nonatomic, strong, readonly) NSString  *name;
@property (nonatomic, strong, readonly) NSString  *firstName;
@property (nonatomic, strong, readonly) NSString  *lastName;
@property (nonatomic, readonly)         UserGender gender;
@property (nonatomic, strong, readonly) NSDate    *updatedTime;

@end
