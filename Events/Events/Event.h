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
@property (nonatomic, strong) NSURL *activityImage;
@property (nonatomic, strong) NSNumber *plotID;
@property (nonatomic, strong) NSString *forumCode;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;
@property (nonatomic, strong) NSDate *applyEndDate;
@property (nonatomic, strong) NSString *activityAddress;
@property (nonatomic, strong) NSNumber *activitySpend;
@property (nonatomic, strong) NSDate *time;

@end
