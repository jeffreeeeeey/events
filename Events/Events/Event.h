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
@property (nonatomic, strong) NSNumber *plotID;
@property (nonatomic, strong) NSString *plotName;
@property (nonatomic, strong) NSDate *startTime;
@property (nonatomic, strong) NSDate *endTime;
@property (nonatomic, strong) NSDate *time;

@end
