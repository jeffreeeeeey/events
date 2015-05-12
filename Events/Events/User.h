//
//  User.h
//  Events
//
//  Created by mac on 5/12/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic) NSNumber *userID;
@property (nonatomic) NSString *userName;
@property (nonatomic) NSNumber *phoneNumber;
@property (nonatomic) NSString *avatarURLString;

+ (void)setUser:(NSDictionary *)userDic;

+ (NSDictionary *)getCurrentUser;

+ (void)logoutCurrentUser;

@end
