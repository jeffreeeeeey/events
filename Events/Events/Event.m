//
//  Event.m
//  Events
//
//  Created by mac on 5/7/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//

#import "Event.h"


@implementation Event

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
#warning init Event
    
    return self;
}

+ (NSArray *)getKeys{
    NSArray *keys = [[NSArray alloc]initWithObjects:@"title", @"subtitle", @"content", @"img", @"tag", @"requirement", @"start_time", @"end_time", @"deadline", @"price", @"location", @"capacity", nil];
    
    return keys;
}

- (instancetype)init {
    self = [super init];
    //self.activityTypes = [NSArray arrayWithObjects:[NSNumber numberWithInteger:1], [NSNumber numberWithInteger:2],nil];
    _title = @"";
    _subtitle = @"";
    _content = @"";
    _logoImageURLString = @"";
    _requirements = [[NSString alloc]initWithFormat:@""];
    _startDate = [NSDate date];
    _endDate = [NSDate date];
    _applyEndDate = [NSDate date];
    _costs = 0;
    _address = @"";
    _capacity = 0;
    
    
    self.startDate = [[NSDate alloc]init];
    self.endDate = [[NSDate alloc]initWithTimeIntervalSinceNow:86400];
    self.applyEndDate = [[NSDate alloc]initWithTimeIntervalSinceNow:86400];
    
    return self;
}

- (NSDictionary *)getEventDic{
    
    NSMutableDictionary *eventDic = [[NSMutableDictionary alloc]init];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *startDateString = [formatter stringFromDate:_startDate];
    NSString *endDateString = [formatter stringFromDate:_endDate];
    NSString *applyEndDateString = [formatter stringFromDate:_applyEndDate];
    NSString *costsString = [NSString stringWithFormat:@"%ld", [_costs integerValue]];
    NSString *capacityString = [NSString stringWithFormat:@"%@", _capacity];
    
    [eventDic setValue:_title forKey:@"title"];
    [eventDic setValue:_subtitle forKey:@"subtitle"];
    [eventDic setValue:_content forKey:@"content"];
    [eventDic setValue:_logoImageURLString forKey:@"img"];
    [eventDic setValue:_requirements forKey:@"requirement"];
    [eventDic setValue:startDateString forKey:@"start_time"];
    [eventDic setValue:endDateString forKey:@"end_time"];
    [eventDic setValue:applyEndDateString forKey:@"deadline"];
    [eventDic setValue:costsString forKey:@"price"];
    [eventDic setValue:_address forKey:@"location"];
    [eventDic setValue:capacityString forKey:@"capacity"];
    
    NSLog(@"creating event dic:%@", eventDic);
    
    return eventDic;

}

#pragma mark - AFNetwork get events

+ (AFHTTPRequestOperation *)getEventsWithBlock:(void (^)(NSArray *events, NSError *error))block {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    return [manager GET:eventList parameters:nil success:^(AFHTTPRequestOperation * __unused operation, id responseObject) {
        
        if (block) {
            block([NSArray arrayWithObject:@"this"], nil);
            NSLog(@"AF json:%@", responseObject);
        }
    } failure:^(AFHTTPRequestOperation * __unused operation, NSError *error) {
        if (block) {
            block([NSArray array], error);
            NSLog(@"AF Error:%@",error);
        }
        
    }];
    
}

@end
