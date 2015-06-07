//
//  AFAppDotNetAPIClient.h
//  Events
//
//  Created by mac on 6/7/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@interface AFLLZGEventsAPIClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end
