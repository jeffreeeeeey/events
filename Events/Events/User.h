//
//  User.h
//  Events
//
//  Created by mac on 5/12/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, assign) NSInteger userID;
@property (nonatomic) NSString *userName;
@property (nonatomic) NSString *nickName;
@property (nonatomic) NSNumber *phoneNumber;
@property (nonatomic) NSString *avatarURLString;
@property (nonatomic) NSString * identity; // Use identity to seperate user and manager.

- (void)setUserWithAttributes:(NSDictionary *)attributes;
- (void)setUserToDefault;

+ (User *)getCurrentUser;

+ (void)logoutCurrentUser;

@end
