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
- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.userID = [[attributes valueForKey:@"userID"] integerValue];
    self.userName = [attributes valueForKey:@"userName"];
    self.nickName = [attributes valueForKey:@"nickName"];
    self.avatarURLString = [attributes valueForKey:@"avatarURLString"];
    self.identity = [attributes valueForKey:@"identity"];
    
    return self;
}

- (void)setUserToDefault {
    NSUserDefaults *stdDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc]init];
    
    [mutableDic setObject:[NSNumber numberWithInteger:self.userID] forKey:@"userID"];
    [mutableDic setObject:self.userName forKey:@"userName"];
    [mutableDic setObject:self.nickName forKey:@"nickName"];
    if (self.avatarURLString) {
        [mutableDic setObject:self.avatarURLString forKey:@"avatarURLString"];
    }
    [mutableDic setObject:self.identity forKey:@"identity"];
    
    [stdDefaults setObject:mutableDic forKey:@"user"];
}


+ (User *)getCurrentUser {
    NSDictionary *attributes = [[NSUserDefaults standardUserDefaults]objectForKey:@"user"];
    if (attributes) {
        NSLog(@"get user from default");
        User *user = [[User alloc]initWithAttributes:attributes];
        
//        user.userID = [[attributes valueForKey:@"userID"] integerValue];
//        user.userName = [attributes valueForKey:@"userName"];
//        user.nickName = [attributes valueForKey:@"nickName"];
//        user.avatarURLString = [attributes valueForKey:@"avatarURLString"];
//        user.identity = [attributes valueForKey:@"identity"];
        
        return user;
    }else {
        NSLog(@"not get user from default");
        return nil;
    }
    
}

+ (void)logoutCurrentUser {
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"user"];
}

@end

