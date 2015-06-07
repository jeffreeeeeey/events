//
//  AFAppDotNetAPIClient.m
//  Events
//
//  Created by mac on 6/7/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//

#import "Settings.h"
#import "AFLLZGEventsAPIClient.h"

static NSString * const AFAppDotNetAPIBaseURLString = BASE_URL;

@implementation AFLLZGEventsAPIClient

+ (instancetype)sharedClient {
    static AFLLZGEventsAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AFLLZGEventsAPIClient alloc] initWithBaseURL:[NSURL URLWithString:AFAppDotNetAPIBaseURLString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    return _sharedClient;
}

@end
