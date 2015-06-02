//
//  Services.h
//  Events
//
//  Created by mac on 6/2/15.
//  Copyright (c) 2015 LLZG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface Services : NSObject


+ (void)postInfo:(NSString *)urlString sendImage:(UIImage *)image sendParams:(NSDictionary *)params getblock:(void(^)(NSString *imageURLString, NSData *data))handler;

- (void)fetchData:(NSString *)urlString getData:(void(^)(NSData *data, NSError *error))handler;
@end
