//
//  Event.m
//  Events
//
//  Created by mac on 5/7/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//

#import "Event.h"

@implementation Event

- (instancetype)init {
    self = [super init];
    self.activityTypes = [NSArray arrayWithObjects:[NSNumber numberWithInteger:1], [NSNumber numberWithInteger:2],nil];
    self.startDate = [[NSDate alloc]init];
    self.endDate = [[NSDate alloc]initWithTimeIntervalSinceNow:86400];
    self.applyEndDate = [[NSDate alloc]initWithTimeIntervalSinceNow:86400];
    
    return self;
}

@end
