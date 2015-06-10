//
//  Event.m
//  Events
//
//  Created by mac on 5/7/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//

#import "Event.h"

@interface Event ()



@end


@implementation Event

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }

    self.eventID = [[attributes valueForKey:@"id"] integerValue];
    self.organizerID = [[attributes valueForKey:@"organizer_id"] integerValue];
    self.title = [attributes valueForKey:@"title"];
    self.subtitle = [attributes valueForKey:@"subtitle"];
    self.logoImageURL = [NSURL URLWithString:[attributes valueForKey:@"img"]];
    self.address = [attributes valueForKey:@"location"];
    self.requirements = [attributes valueForKey:@"attributes"];
    self.capacity = [[attributes valueForKey:@"capacity"] integerValue];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    NSLocale *locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_us_POSIX"];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [formatter setLocale:locale];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss"];
    
    
    
    self.startDate = [formatter dateFromString:[attributes valueForKey:@"start_time"]];
    //NSLog(@"start time date:%@", self.startDate);
    self.endDate = [formatter dateFromString:[attributes valueForKey:@"end_time"]];
    self.deadline = [formatter dateFromString:[attributes valueForKey:@"start_time"]];
    self.costs = [[attributes valueForKey:@"price"] floatValue];
    self.content = [attributes valueForKey:@"content"];
    self.updateTime = [attributes valueForKey:@"update_time"];
    
    return self;
}

+ (NSArray *)getKeys{
    NSArray *keys = [[NSArray alloc]initWithObjects:@"title", @"subtitle", @"content", @"img", @"tag", @"requirement", @"start_time", @"end_time", @"deadline", @"price", @"location", @"capacity", nil];
    
    return keys;
}

- (instancetype)init {
    self = [super init];
    //self.activityTypes = [NSArray arrayWithObjects:[NSNumber numberWithInteger:1], [NSNumber numberWithInteger:2],nil];
    /*
    _title = @"";
    _subtitle = @"";
    _content = @"";
    _logoImageURL = nil;
    _requirements = [[NSString alloc]initWithFormat:@""];
    _startDate = [NSDate date];
    _endDate = [NSDate date];
    _deadline = [NSDate date];
    _costs = 0;
    _address = @"";
    _capacity = 0;
    
    
    self.startDate = [[NSDate alloc]init];
    self.endDate = [[NSDate alloc]initWithTimeIntervalSinceNow:86400];
    self.deadline = [[NSDate alloc]initWithTimeIntervalSinceNow:86400];
    */
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
    NSString *applyEndDateString = [formatter stringFromDate:_deadline];
    NSString *costsString = [NSString stringWithFormat:@"%.2f", _costs];
    NSString *capacityString = [NSString stringWithFormat:@"%lu", _capacity];
    
    [eventDic setValue:_title forKey:@"title"];
    [eventDic setValue:_subtitle forKey:@"subtitle"];
    [eventDic setValue:_content forKey:@"content"];
    [eventDic setValue:_logoImageURL forKey:@"img"];
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

+ (NSURLSessionDataTask *)getEventsWithBlock:(void (^)(NSArray *events, NSError *error))block {
    //Use NSURLSession
    
    AFLLZGEventsAPIClient *manager = [AFLLZGEventsAPIClient sharedClient];
    //manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", nil];
    return [manager GET:eventList parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (block) {
            NSArray *eventsArray = (NSArray *)responseObject;
            NSMutableArray *mutableEvents = [NSMutableArray array];
            for (NSDictionary *attributes in eventsArray) {
                //NSLog(@"attributes dic:%@", attributes);
                Event *event = [[Event alloc]initWithAttributes:attributes];
                [mutableEvents addObject:event];
            }
            
            block(mutableEvents, nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (block) {
            block([NSArray array], error);
            NSLog(@"failure: get events URL:%@",eventList);
        }
    }];
    
    
    /*
    //Use NSURLConnection
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
    */
}

@end
