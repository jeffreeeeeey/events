//
//  Tools.m
//  
//
//  Created by mac on 6/11/15.
//
//

#import "Tools.h"

@implementation Tools

+ (NSDateFormatter *)inVisiableFormatter {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    NSLocale *locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_us_POSIX"];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [formatter setLocale:locale];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss"];
    return formatter;
}

+ (NSDateFormatter *)visiableFormatter {
    NSDateFormatter *visiableDateFormatter = [[NSDateFormatter alloc]init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [visiableDateFormatter setTimeZone:timeZone];
    [visiableDateFormatter setDateFormat:@"yyyy'-'MM'-'dd HH':'mm"];
    return visiableDateFormatter;
}

@end
