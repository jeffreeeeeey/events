//
//  User.m
//  Events
//
//  Created by mac on 5/12/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//

#import "User.h"

@implementation User

// add user to the array, and set login status to 1
+ (void)setUser:(NSDictionary *)userDic {
    
    [[NSUserDefaults standardUserDefaults]setObject:userDic forKey:@"currentUser"];
    
}


+ (NSDictionary *)getCurrentUser {
    NSDictionary *currentUser = [[NSUserDefaults standardUserDefaults]objectForKey:@"currentUser"];
    return currentUser;
}

+ (void)logoutCurrentUser {
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"currentUser"];
}

@end

