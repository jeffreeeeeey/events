//
//  Event.h
//  Events
//
//  Created by mac on 5/7/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFLLZGEventsAPIClient.h"
#import "AFHTTPRequestOperationManager.h"
#import "Settings.h"
#import "UIAlertView+AFNetworking.h"


@interface Event : NSObject

@property (nonatomic, strong) NSNumber *eventID;
@property (nonatomic, strong) NSNumber *organizerID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subtitle;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) NSArray *activityTypes;
@property (nonatomic, strong) NSURL *logoImageURL;
@property (nonatomic, strong) NSNumber *plotID;
@property (nonatomic, strong) NSString *forumCode;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;
@property (nonatomic, strong) NSDate *deadline;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSNumber *capacity;
@property (nonatomic, strong) NSNumber *costs;
@property (nonatomic, copy) NSString *requirements;  // factors need to provide when apply.
@property (nonatomic, strong) NSDate *updateTime;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

+ (NSURLSessionDataTask *)getEventsWithBlock:(void (^)(NSArray *events, NSError *error))block;

+ (NSArray *)getKeys;

- (NSDictionary *)getEventDic;
@end
