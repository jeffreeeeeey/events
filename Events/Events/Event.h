//
//  Event.h
//  Events
//
//  Created by mac on 5/7/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject

@property (nonatomic, strong) NSNumber *topidID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subtitle;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) NSArray *activityTypes;
@property (nonatomic, strong) NSString *logoImageURLString;
@property (nonatomic, strong) NSNumber *plotID;
@property (nonatomic, strong) NSString *forumCode;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;
@property (nonatomic, strong) NSDate *applyEndDate;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSNumber *capacity;
@property (nonatomic, strong) NSNumber *costs;
@property (nonatomic, strong) NSDate *time;

@end
